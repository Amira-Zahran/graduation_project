<?php

namespace App\Http\Controllers;


use App\Models\User;
use PDF;
use DateTime;
use DateTimeZone;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ShiftController extends Controller
{

    public function index(Request $request)
    {
        $getActiveUsers = DB::table('users')
            ->select('id','name','type','branch')
            ->whereRaw("type = 'Cashier' or type = 'CallCenterAgent' or type = 'Dispatcher'")
            ->where('branch','=',$request->user()->branch)
            ->where('status','=','Active')
            ->get();
        $users = [];
        foreach ($getActiveUsers as $key => $value) {
            $getActiveShift =  DB::table('shift')->select('*')->where('user','=',$value->id)->where('status','=','Active')->first();
            if(empty($getActiveShift)){
                $users[] = $value;
            }
        }
        $getActiveShifts = DB::table('shift')
            ->select('*')
            ->where('location','=',$request->user()->branch)
            ->where('status','=','Active')
            ->get();
        foreach ($getActiveShifts as $key => $value) {
            $value->user = User::where('id','=',$value->user)->first()->name;
            $value->creator = User::where('id','=',$value->creator)->first()->name;
        }
//        return $getActiveUsers;
        return view('apps.shiftManagment.lists',[
            'users' => $users,'shifts' => $getActiveShifts]);
    }

    public function history(Request $request){

        $getActiveShifts = DB::table('shift')
            ->select('*')
            ->where('location','=',$request->user()->branch)
            ->where('status','=','Closed');
        if(isset($_GET['created_at'])&&strlen($_GET['created_at'])>3){
            $getActiveShifts = $getActiveShifts->where('created_at','like', (new DateTime($_GET['created_at']))->format('Y-m-d').'%');
//            return;
        }
        echo '';
        if(isset($_GET['user'])&&strlen($_GET['user'])>0){
            $getActiveShifts = $getActiveShifts->where('user','=', $_GET['user']);
//            return $_GET['user'];
        }
        if(isset($_GET['creator'])&&strlen($_GET['creator'])>0){
            $getActiveShifts = $getActiveShifts->where('creator','=', $_GET['creator']);
//            return $_GET['user'];
        }
        $getActiveShifts = $getActiveShifts->get();
        $getActiveUsers = DB::table('users')
            ->select('id','name','type','branch')
            ->whereRaw("type = 'Cashier' or type = 'CallCenterAgent' or type = 'Dispatcher'")
            ->where('branch','=',$request->user()->branch)
            ->where('status','=','Active')
            ->get();
        foreach ($getActiveShifts as $key => $value) {
            $value->user = User::where('id','=',$value->user)->first()->name;
            $value->creator = User::where('id','=',$value->creator)->first()->name;
        }
        return view('apps.shiftManagment.history-lists',[
            'shifts' => $getActiveShifts,'users' => $getActiveUsers]);
    }

    public function openShift(Request $request)
    {
        if(empty(DB::table('shift')->select('*')->where('user','=',$request->post('user'))->where('status','=','Active')->latest()->first())) {
            $dateTime = new DateTime('now', new DateTimeZone('Africa/Cairo'));
            $shift = DB::table('shift')->insertGetId([
                "location" => $request->user()->branch,
                "user" => $request->user,
                "creator" => $request->user()->id,
                'shift' => $dateTime->format("A"),
            ]);
            return redirect()->route('shifts-lists')->with('success',"shift opened successfully With ID : ".$shift);
        } else {
            return redirect()->route('shifts-lists')->with('error',"User already has an active shift");
        }
    }

    public function closeShift(Request $request)
    {
        $closeShift = DB::table('shift')
            ->where('id','=',$request->id)
            ->update([
                'status' => 'Closed',
            ]);
        if($closeShift) {
            return redirect()->route('shifts-lists')->with('success',"Shift Closed Successfully");
        }
        else{
            return redirect()->route('shifts-lists')->with('error',"Something went wrong");
        }
    }

    public function locationActiveShifts($location): array
    {
//        echo $location;
        $locationShifts = DB::table('shift')
            ->select('id')
            ->where('location','=',$location)
            ->where('status','=','Active')
            ->get();
        $shifts = [];
        foreach ($locationShifts as $key => $value){
            array_push($shifts,$value->id);
        }
//        echo $shifts[1];
        return $shifts;
    }

    public function locationActiveCashierShifts($location): array
    {
//        echo $location;
        $locationShifts = DB::table('shift')
            ->select('shift.id as id')
            ->where('location','=',$location)
            ->where('shift.status','=','Active')
            ->join('users','users.id','=','shift.user')
            ->where('users.type','=','Cashier')
            ->get();
        $shifts = [];
        foreach ($locationShifts as $key => $value){
            array_push($shifts,$value->id);
        }
//        echo $shifts[1];
        return $shifts;
    }

    protected function generate_ShiftReportData(Request $request){
        $shift = DB::table('shift')->select('*')->where('id','=',$request->id)->first();
        $user = DB::table('users')->select('id','name','type')->where('id','=',$shift->user)->first();
        if($user->type == "Dispatcher") {
            $getOrders = DB::table('order')->select('*')->where('dispatcher_shift','=',$shift->id)->get();
            $getOrdersItems = DB::table('order_items')->selectRaw('item_id ,sum(total_price) as total_price, sum(quantity) as quantity,menu_items.item_name')->join('menu_items','menu_items.id','=','order_items.item_id')->whereIn('order_id',$getOrders->pluck('id'))->groupBy('item_id')->get();
            $totalItemsSales = $getOrdersItems->sum('total_price');
            $getOrdersItems[] = (object)[
                'item_id' => '#',
                'item_name' => 'Total Take-Away Orders',
                'total_price' => $getOrders->where('type','=','DeliveryTakeAway')->sum('total'),
                'quantity' => $getOrders->where('type','=','DeliveryTakeAway')->count('id')
            ];
            $getOrdersItems[] = (object)[
                'item_id' => '#',
                'item_name' => 'Total Delivery Orders',
                'total_price' => $getOrders->where('type','=','Delivery')->sum('total'),
                'quantity' => $getOrders->where('type','=','Delivery')->count('id')
            ];
        }
        else{
            $getOrders = DB::table('order')->select('*')->where('shift','=',$shift->id)->get();
            $getOrdersItems = DB::table('order_items')->selectRaw('item_id ,sum(total_price) as total_price, sum(quantity) as quantity,menu_items.item_name')->join('menu_items','menu_items.id','=','order_items.item_id')->whereIn('order_id',$getOrders->pluck('id'))->groupBy('item_id')->get();
            $totalItemsSales = $getOrdersItems->sum('total_price');
            if($user->type == "CallCenterAgent"){
                $getOrdersItems[] = (object)[
                    'item_id' => '#',
                    'item_name' => 'Total Take-Away Orders',
                    'total_price' => $getOrders->where('type','=','DeliveryTakeAway')->sum('total'),
                    'quantity' => $getOrders->where('type','=','DeliveryTakeAway')->count('id')
                ];
                $getOrdersItems[] = (object)[
                    'item_id' => '#',
                    'item_name' => 'Total Delivery Orders',
                    'total_price' => $getOrders->where('type','=','Delivery')->sum('total'),
                    'quantity' => $getOrders->where('type','=','Delivery')->count('id')
                ];
            }
            else {
                $getOrdersItems[] = (object)[
                    'item_id' => '#',
                    'item_name' => 'Total Din-in Orders',
                    'total_price' => $getOrders->where('type', '=', 'Floor')->sum('total'),
                    'quantity' => $getOrders->where('type', '=', 'Floor')->count('id')
                ];
                $getOrdersItems[] = (object)[
                    'item_id' => '#',
                    'item_name' => 'Total TakeAway Orders',
                    'total_price' => $getOrders->where('type', '=', 'FloorTakeAway')->sum('total'),
                    'quantity' => $getOrders->where('type', '=', 'FloorTakeAway')->count('id')
                ];
            }
        }


        return [
            'type' => $user->type == 'Dispatcher' ? "Dispatcher" : 'Cashier',
            'items' => $getOrdersItems,
            'user' => $user,
            'totalItemsSales' => $totalItemsSales,
            'totalOrdersSales' => $getOrders->sum('total'),
            'shift' => $shift
        ];
    }

    public function shiftReportView(Request $request){
        $shiftData = $this->generate_ShiftReportData($request);
        return view('apps.shiftManagment.report',compact('shiftData'));
    }



}
