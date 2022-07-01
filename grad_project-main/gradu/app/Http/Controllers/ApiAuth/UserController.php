<?php

namespace App\Http\Controllers\ApiAuth;

use App\Http\Controllers\Controller;
use App\Models\Branch;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

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
            if ($user) {
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
}
