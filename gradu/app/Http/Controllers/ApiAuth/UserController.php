<?php

namespace App\Http\Controllers\ApiAuth;

use App\Exceptions\UserAuthError;
use App\Http\Controllers\Controller;
use App\Models\Branch;
use App\Models\DeliveryAgent;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Str;
use mysql_xdevapi\Exception;
use Ramsey\Uuid\Rfc4122\UuidV5;
use function PHPUnit\Framework\throwException;

class UserController extends Controller
{
    protected function generateData($user){
        $token = $user->createToken($user->name);
        $branch = Branch::where('id',$user->branch)->first();
        return response([
            'token' => $token->accessToken,
            'name' => $user->name,
            'type' => $user->type,
            'email' => $user->email,
            'branch' => $branch,
            'permissions' => $user->Permissions
        ],200);
    }

    public function login(Request $request){
        if(empty($request['card_id'])) {
            $user = User::where('email', $request->email)->first();
            if ($user && $user->status == 'Active') {
                if (Hash::check($request->password, $user->password)) {
                    return $this->generateData($user);
                } else {
                    return response(['message' => 'Password is incorrect'], 422);
                }
            }
            else {
                return response(["message' => 'Username Doesn't Exist"], 422);
            }
        }
        else{
            $user = User::where('card_id',$request->card_id)->first();
//            echo Hash::make($request['card_id']);
            if($user){
                return $this->generateData($user);
            }
            else {
                return response(["message" => "Invalid ID"], 422);
            }
        }
    }

    public function Register(Request $request){
        if(User::where('email',$request->email)->first()){
            return response(
                [
                    'message' => 'User Exists'
                ]
                ,422);
        }else {
            $request['password'] = Hash::make($request['password']);
//            $request['card_id'] = Hash::make($request['card_id']);
            $request['remember_token'] = Str::random(10);
            User::create($request->toArray());
            $getUser = User::where('email', $request['email'])->first();
            $token = $getUser->createToken($getUser->name);
            return response(
                [
                    'token' => $token->accessToken,
                    'name' => $getUser->name,
                    'type' => $getUser->type,
                    'email' => $getUser->email,
                    'branch' => Branch::where('id',$getUser->branch)->first()
                ],
                200);
        }
    }

    /**
     * @throws UserAuthError
     */
    public function agentLogin(Request $request){

        $agent = DeliveryAgent::where('phone_number',$request->phone_number)->first() ?? throw new UserAuthError("Wrong Phone Number");

        $agent->id == $request->id ? null : throw new UserAuthError("ID dismatch");
        $otp_request_id = $this->generateOTP();
        $this->sendOTP_SMS($otp_request_id->otp,$agent->phone_number);
        return response(
            [
                'otp_request_id' => $otp_request_id->req_id,]);
//        echo $otp_request_id;
    }

    public function agentOTPValidate(Request $request){
        if($this->validateOTP($request->otp,$request->req_id)){
            DB::table('delivery_agents')->where('id',$request->id)->update(['firebase_token' => $request->firebase_token]);
            $user = User::where('email','deliverUser')->first() ?? throw new UserAuthError("User Doesn't Exist");

            return $this->generateData($user);
        }
    }

    private function validateOTP($otp,$req_id){
        $getOTP_auth_row = DB::table('auth_requestes')->select('*')->where('auth_req_id','=',$req_id)->first() ?? throw new UserAuthError("There is no such request");
        Hash::check($otp,$getOTP_auth_row->otp) ? null : throw new UserAuthError('Wrong OTP');
        $getOTP_auth_row->expiring_at >= Carbon::now() ? null : throw new UserAuthError('Expired OTP');
        return true;
    }

    private function generateOTP(){

        /**
         * to ensure that the user will not get the same OTP twice
         */

        $otp = rand(1000, 9999);
        $requser_id = UuidV5::uuid4();
        DB::table('auth_requestes')->insert([
            'otp' => Hash::make($otp),
            'auth_req_id' => $requser_id,
            'expiring_at' => Carbon::now()->addMinutes(5),
        ]);
//        echo $otp;
        return (object)['otp' => $otp, 'req_id' => $requser_id];
    }

    private function sendOTP_SMS($otp,$phone_number){
        //send sms
        $TWILIO_ACCOUNT_SID = env('TWILIO_ACCOUNT_SID');
        $TWILIO_AUTH_TOKEN = env('TWILIO_AUTH_TOKEN');

        $credntials = base64_encode("xxx:xxxx");
        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => "https://api.twilio.com/2010-04-01/Accounts/xxxxx/Messages.json",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => array('Body' => "Your OTP is $otp valid for 5 minuets",'From' => 'Deus','To' => "+2$phone_number"),
            CURLOPT_HTTPHEADER => array(
                "Authorization: Basic $credntials"
            ),
        ));

        $response = curl_exec($curl);

        curl_close($curl);
        return $response;
    }

    public function getAllUsers(Request $request){
        $allUsers = User::all();
        foreach ($allUsers as $key => $user){
            $user->branch = Branch::where('id',$user->branch)->first()->name;
        }
        return view('apps.employees.lists',compact('allUsers'));
    }

    public function changeStatus(Request $request){
        $user = User::where('id',$request->id)->first();
        $user->status = $request->status;
        $user->save();
        return redirect()->route('employees-lists')->with('success','User Status Changed to '.$request->status);
    }

    public function store(Request $request){
        if(User::where('email',$request->email)->first() || User::where('card_id',$request->cardID)->first()){
            return redirect()->back()->with('error','User with same email or RFID Exists')->withInput($request->input());
        }
        else{
            $request['password'] = Hash::make($request['password']);
            $Permissions = [];
            foreach ($request->keys() as $key){
                $request[$key] == 'on' ? array_push($Permissions,$key) : null;
            }
            $storeUser = DB::table('users')->insertGetId([
                'name' => $request->fullName,
                'email' => $request->email,
                'password' => $request->password,
                'card_id' => $request->cardID,
                'type' => $request->type,
                'branch' => $request->branch,
                'permissions' => json_encode($Permissions),
            ]);
            return redirect()->route('employees-lists')->with('success',"Employee Created With ID $storeUser");
        }

    }

    public function show(Request $request){
        $user = User::where('id',$request->id)->first();
//        echo $user->Permissions;
        foreach (json_decode($user->Permissions) as $key => $value){
            $user[$value] = 'on';
        }
//        $user->branch = Branch::where('id',$user->branch)->first()->name;
        return view('apps.employees.forms-edit-employee',compact('user'));
    }

    public function update(Request $request){
//            $request['password'] = Hash::make($request['password']);
        $Permissions = [];
        foreach ($request->keys() as $key){
            $request[$key] == 'on' ? array_push($Permissions,$key) : null;
        }
        $data = [
            'name' => $request->fullName,
            'email' => $request->email,
            'card_id' => $request->cardID,
            'type' => $request->type,
            'branch' => $request->branch,
            'permissions' => json_encode($Permissions),
        ];
        !empty($request['password']) ? $data['password'] = Hash::make($request['password']) : null;
        DB::table('users')->where('id','=',$request->id)->update($data);
        return redirect()->route('employees-lists')->with('success',"Employee ".$request->fullName." Updated");
    }

    /** we need to authenticate a non system-user to act as a system user
     * we have a firebase token linked with this user
     * we have a phone number linked to this user
     * we need to generate an auth. token to this user to do a critical irreversible actions,
     * so, we need to do the following steps
     * use phone number to check if the agent exist on our delivery_agents table
     * if phone number exists, then we need to select this row; get row id and compare with the id in POST request
     * if the data identical, correctly passed the first auth. level
     * then elevate to the second auth. level ; we need to generate an OTP code with length of 6 digits
     * send this OTP in sms, send back an auth req. id to client-device
     * user must enter an otp code, client device must send back to the server an otp alongside with auth. req. id and firebase token
     * if auth req and otp is identical; then elevate to the third level of auth.
     * third level will update firebase_token in the agent row with the new firebase token from the last POST Request.
     * as a final stage will select a general system-user to generate a system-token and send it back to the device to use it.
     **/
}
