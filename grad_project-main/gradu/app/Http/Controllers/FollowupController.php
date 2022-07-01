<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class FollowupController extends Controller
{
    public function getDeliveryHistory(Request $request)
    {
        if(Auth::guard()->user()->type == 'Dispatcher'){
            $getOrders = DB::table('order')
                ->select('*')
                ->where('type','like','%Delivery%')
                ->where('dispatcher_shift','=',(new DispatchingController())->getCurrentDispatcherShiftID($request))
//                ->orderByDesc('id')
                ->get();

        }
        else{
            $getOrders = DB::table('order')
                ->select('*')
                ->where('type','like','%Delivery%')
                ->where('dispatcher_shift','=',(new DispatchingController())->getCurrentDispatcherShiftID($request))
//                ->orderByDesc('id')
                ->get();
        }
        $result = [];

        foreach ($getOrders as $key => $value){
//                echo $value->id;
            $getCustomerName = DB::table('customers_base')
                ->select('name')
                ->where('id','=',$value->customer)
                ->first();
            $getDeliveryOperation = DB::table('delivery_operations')
                ->select('*')
                ->where('order','=',$value->id)->first();
            $result[] = [
                'accepting_date' => !empty($value->accepted_at) ? $value->accepted_at : " ",
                'adding_time' => $value->created_at,
                'agent_name' => !empty($getDeliveryOperation)
                    ? DB::table('delivery_agents')
                        ->select('name')
                        ->where('id', '=', $getDeliveryOperation->agent)->first()->name
                    : " "
                ,
                'order_type' => $value->type,
                'custoemr_name' => $getCustomerName->name ?? '',
                'last_update' => $value->update_at,
                'cc_name' => DB::table('users')->select('name')->where('id', '=', $value->creator)->first()->name,
                'operation_id' => !empty($getDeliveryOperation) ? '\'' . $getDeliveryOperation->id . '\'' : " ",
                'order_id' => $value->order_id,
                'id' => $value->id,
                'is_updated' => $value->is_updated,
                'type' => $value->type,
                'status' => $value->status
            ];
        }
        return response()->json(['operations' => $result]);
    }

    public function getPOSHistory(Request $request)
    {

        $shift = DB::table('shift')->select('*')->where('user', '=', $request->user()->id)->where('status', '=', 'Active')->latest()->first();
        $shifts_first = (new ShiftController)->locationActiveCashierShifts($request->user()->branch);

//        echo (new ShiftController())->locationActiveShifts($request->user()->branch);
            $getOrders = DB::table('order')
                ->select('*')
//                ->where('type','like',$request->user()->type == 'Cashier' ? '%Floor%' : '%Delivery%')
                ->whereRaw($request->user()->type == 'Cashier' ?"type like '%Floor%' or type = 'DeliveryTakeAway'":"type like '%Delivery%'")
                ->whereIn('shift',(new ShiftController())->locationActiveShifts($request->user()->branch))
//                ->orderByDesc('id')
                ->get();

        $result = [];

        foreach ($getOrders as $key => $value){
//                echo $value->id;
            $getCustomerName = DB::table('customers_base')
                ->select('name')
                ->where('id','=',$value->customer)
                ->first();
            $getDeliveryOperation = DB::table('delivery_operations')
                ->select('*')
                ->where('order','=',$value->id)->first();
            $result[] = [
                'accepting_date' => !empty($value->accepted_at) ? $value->accepted_at : " ",
                'adding_time' => $value->created_at,
                'agent_name' => !empty($getDeliveryOperation)
                    ? DB::table('delivery_agents')
                        ->select('name')
                        ->where('id', '=', $getDeliveryOperation->agent)->first()->name
                    : " "
                ,
                'order_type' => $value->type,
                'custoemr_name' => $getCustomerName->name ?? '',
                'last_update' => $value->update_at,
                'cc_name' => DB::table('users')->select('name')->where('id', '=', $value->creator)->first()->name,
                'operation_id' => !empty($getDeliveryOperation) ? '\'' . $getDeliveryOperation->id . '\'' : " ",
                'order_id' => $value->order_id,
                'id' => $value->id,
                'is_updated' => $value->is_updated,
                'type' => $value->type,
                'status' => $value->status
            ];
        }

        return response()->json(['orders' => $result]);
    }

    public function hallOrders(Request $request){
        $getOrders = DB::table('order')
            ->select('id','order_id','status','type')
            ->whereIn('type',['DeliveryTakeAway','FloorTakeAway','Floor'])
            ->whereIn('status',['Preparing','Ready','Finished'])
            ->where('target_location','=',$request->branch)
            ->get();
        return response(['orders' => $getOrders],200);
    }

}
