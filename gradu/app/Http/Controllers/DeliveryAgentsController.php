<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DeliveryAgentsController extends Controller
{
    public function index(Request $request){
        $getDeliveryAgents = DB::table('delivery_agents')
            ->select('*')
            ->where('branch','=',$request->user()->branch)
//            ->where('status','=','Active')
            ->get();
        return view('apps.DeliveryAgents.lists',['agents'=>$getDeliveryAgents]);
    }

    public function suspend(Request $request){
        DB::table('delivery_agents')
            ->where('id','=',$request->id)
            ->update(['status'=>'Suspended']);
        return redirect()->route('delivery-agents-lists')->with('success','Delivery Agent Suspended Successfully');
    }

    public function activate(Request $request){
        DB::table('delivery_agents')
            ->where('id','=',$request->id)
            ->update(['status'=>'Active']);
        return redirect()->route('delivery-agents-lists')->with('success','Delivery Agent Activate Successfully');
    }

    public function newAgent(Request $request){
        $checkPreviousPhone = DB::table('delivery_agents')
            ->select('*')
            ->where('phone_number','=',$request->phone_number)
            ->first();
        if(empty($checkPreviousPhone)) {
            $insertNewRow = DB::table('delivery_agents')
                ->insertGetId([
                    'name' => $request->name,
                    'phone_number' => $request->phone_number,
                    'branch' => $request->branch,
                ]);
            return redirect()->route('delivery-agents-lists')->with('success', 'Delivery Agent Created Successfully With ID: ' . $insertNewRow);
        }else{
            return redirect()->route('delivery-agents-lists')->with('error', 'Delivery Agent Already Exist with same phone number');
        }
    }

    public function updateAgent(Request $request){

            $insertNewRow = DB::table('delivery_agents')
                ->where('id','=',$request->id)
                ->update([
                    'name' => $request->name,
                    'phone_number' => $request->phone_number,
                    'branch' => $request->branch,
                ]);
            return redirect()->route('delivery-agents-lists')->with('success', 'Delivery Agent Update Successfully With ID: ' . $insertNewRow);
    }

    public function shiftsHistory(Request $request){
        $getShiftsHistory = DB::table('delivery_shifts')
            ->select('*');
        if(isset($_GET['user'])&&strlen($_GET['user'])>0){
            $getShiftsHistory = $getShiftsHistory->where('user','=', $_GET['user']);
        }
        if(isset($_GET['created_at'])&&strlen($_GET['created_at'])>3){
            $getShiftsHistory = $getShiftsHistory->where('created_at','like', (new DateTime($_GET['created_at']))->format('Y-m-d').'%');
        }
        $getShiftsHistory=$getShiftsHistory->get();
        foreach ($getShiftsHistory as $key => $value) {
            $value->user = DB::table('delivery_agents')
                ->select('*')
                ->where('id', '=', $value->user)
                ->first()->name;
        }
        $getDeliveryAgents = DB::table('delivery_agents')
            ->select('*')
            ->where('branch','=',$request->user()->branch)
//            ->where('status','=','Active')
            ->get();
        return view('apps.DeliveryAgents.shifts-history-lists',['shifts'=>$getShiftsHistory,'agents'=>$getDeliveryAgents]);
    }

    public function getNewOrders(Request $request){
        $getAgent = DB::table('delivery_agents')
            ->select('*')
            ->where('firebase_token','=',$request->firebase_token)
            ->first();
        $getNewOrders = DB::table('delivery_operations')->select('*')->where('agent','=',$getAgent->id)->where('status','!=','Done')->get();
        $getOrders = DB::table('order')
            ->select('*')
            ->whereIn('id',$getNewOrders->pluck('order'))
            ->get();
        $result = [];
        foreach ($getOrders as $key => $value) {
            $getCustomer = DB::table('customers_base')
                ->select('*')
                ->where('id', '=', $value->customer)
                ->first();
            $getPhone = DB::table('customer_phones')
                ->select('phone_number')
                ->where('customer_id', '=', $value->customer)
                ->get();
            $getAddress = DB::table('customer_addresses')
                ->select('*')
                ->where('id', '=', $value->address)->first();
            $getItems = DB::table('order_items')
                ->select('*')
                ->where('order_id', '=', $value->id)
                ->get();
            foreach ($getItems as $ke => $val) {
//                echo DB::table('menu_items')->select('item_name')->where('id','=',$val->id)->first()->item_name;
                $val->item_name = DB::table('menu_items')->select('item_name')->where('id', '=', $val->item_id)->first()->item_name;
            }
            $result[] = [
                "address" => $getAddress,
                'status' => $getNewOrders->where('order','=',$value->id)->first()->status,
                'op_id' => $getNewOrders->where('order','=',$value->id)->first()->id,
                'created_at' => $value->created_at,
                'updated_at' => $value->update_at,
                "id" => $value->id,
                'is_updated' => $value->is_updated,
                "order_id" => $value->order_id,
                'type' => $value->type,
                'items' => $getItems,
                'total' => $value->total,
                'subtotal' => $value->sub_total,
                "customer" => [
                    'name' => $getCustomer->name,
                    'Phones' => $getPhone
                ]
            ];
        }
        return response()->json(['orders' => $result]);
    }

    public function getHistory(Request $request){
        $getAgent = DB::table('delivery_agents')
            ->select('*')
            ->where('firebase_token','=',$request->firebase_token)
            ->first();
        $getNewOrders = DB::table('delivery_operations')->select('*')->where('agent','=',$getAgent->id)->where('status','=','Done')->get();
        $getOrders = DB::table('order')
            ->select('*')
            ->whereIn('id',$getNewOrders->pluck('order'))
            ->get();
        $result = [];
        foreach ($getOrders as $key => $value) {
            $getCustomer = DB::table('customers_base')
                ->select('*')
                ->where('id', '=', $value->customer)
                ->first();
            $getPhone = DB::table('customer_phones')
                ->select('phone_number')
                ->where('customer_id', '=', $value->customer)
                ->get();
            $getAddress = DB::table('customer_addresses')
                ->select('*')
                ->where('id', '=', $value->address)->first();
            $getItems = DB::table('order_items')
                ->select('*')
                ->where('order_id', '=', $value->id)
                ->get();
            foreach ($getItems as $ke => $val) {
//                echo DB::table('menu_items')->select('item_name')->where('id','=',$val->id)->first()->item_name;
                $val->item_name = DB::table('menu_items')->select('item_name')->where('id', '=', $val->item_id)->first()->item_name;
            }
            $result[] = [
                "address" => $getAddress,
                'status' => $value->status,
                'created_at' => $value->created_at,
                'updated_at' => $value->update_at,
                "id" => $value->id,
                'is_updated' => $value->is_updated,
                "order_id" => $value->order_id,
                'type' => $value->type,
                'items' => $getItems,
                'total' => $value->total,
                'subtotal' => $value->sub_total,
                "customer" => [
                    'name' => $getCustomer->name,
                    'Phones' => $getPhone
                ]
            ];
        }
        return response()->json(['orders' => $result]);
    }
    public function updateOperationStatus(Request $request){
        DB::table('delivery_operations')
            ->where('id','=',$request->id)
            ->update(['status'=>$request->status]);
    }
}
