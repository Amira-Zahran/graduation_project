<?php

namespace App\Http\Controllers;

use DateTimeZone;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DispatchingController extends Controller
{

    public function getCurrentDispatcherShiftID(Request $request){
        $shift = DB::table('shift')->select('id')->where('user','=',$request->user()->id)->where('status','=','Active')->first();
        return $shift;
    }

    public function getOrders(Request $request){
//        $getOrders = DB::table('orders')
//            ->select('*')->where('type','like','%Delivery%')
//            ->where('status','!=','Canceled')
//            ->where('status','!=','Done')
//            ->where('target_location','=',$request->user()->assoc_branch)
//            ->get();

        $getOrders = DB::table('order')
            ->select('*')
            ->whereRaw('target_location = '.$request->user()->branch.' and (type Like \'%Delivery%\') and ( status != \'Canceled\' and status!= \'Done\')')
            ->get();
        $getCanceled = DB::table('order')->select('*')
            ->whereRaw('target_location = '.$request->user()->branch.' and (type like \'%Delivery%\') and ( status = \'Canceled\') and (update_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 MINUTE) and NOW())')
            ->get();
        $result = [];
        foreach ($getOrders as $key => $value)
        {
            $getCustomer = DB::table('customers_base')
                ->select('*')
                ->where('id','=',$value->customer)
                ->first();
            $getPhone = DB::table('customer_phones')
                ->select('phone_number')
                ->where('customer_id','=',$value->customer)
                ->get();
            $getAddress = DB::table('customer_addresses')
                ->select('address','area')
                ->where('id','=',$value->address)->first();
            $getItems = DB::table('order_items')
                ->select('*')
                ->where('order_id','=',$value->id)
                ->get();
            foreach ($getItems as $ke => $val){
//                echo DB::table('menu_items')->select('item_name')->where('id','=',$val->id)->first()->item_name;
                $val->item_name = DB::table('menu_items')->select('item_name')->where('id','=',$val->item_id)->first()->item_name;
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
        foreach ($getCanceled as $ref => $v)
        {
            $getCustomer = DB::table('customers')
                ->select('*')
                ->where('id','=',$v->customer)
                ->first();
            $getPhone = DB::table('customers_phones')
                ->select('phone_number')
                ->where('customer','=',$v->customer)
                ->get();
            $getAddress = DB::table('customer_address')
                ->select('*')
                ->where('id','=',$v->address)->first();
            $getItems = DB::table('order_items')
                ->select('*')
                ->where('order_id','=',$v->id)
                ->get();
            $result[] = [
                "address" => DB::table('areas')->select('area_name')->where('id', '=', $getAddress->area)->first()->area_name . '-' . $getAddress->address,
                'status' => $v->status,
                'date' => $v->created_at,
                "id" => $v->id,
                'is_updated' => $v->is_updated,
                "order_id" => $v->order_id,
                'type' => $v->type,
                'items' => $getItems,
                'total' => $v->total,
                'subtotal' => $v->sub_total,
                "customer" => [
                    'name' => $getCustomer->name,
                    'Phones' => $getPhone
                ]
            ];
        }
        return response()->json(['orders'=>$result]);
    }

    public function acceptOrder(Request $request){
        $dateTime = new DateTime('now', new DateTimeZone('Africa/Cairo'));
        $shift = $this->getCurrentDispatcherShiftID($request);
        $request->status = 'Preparing';
        $update = (new OrderController())->updateOrderStatus($request);
        if($shift && $update){
            DB::table('order')->where('id','=',$request->id)->lockForUpdate()->update(
                [
                    'accepted_at' => $dateTime->format('Y-m-d H:i:s'),
                    'dispatcher_shift' => $shift->id
                ]
            );
            return response(['messages' => 'Order Accepted'],200);
        }else return response(['message' => "User doesn't have an active shift"],422);
    }

    public function getDeliveryAgents(Request $request)
    {
        $getAgents = DB::table('delivery_agents')->select('*')->where('branch','=',$request->user()->branch)->get();
        return response()->json(['agents' => $getAgents]);
    }

    public function createDeliveryOperation(Request $request){
        $checkIfExist =
            DB::table('delivery_operations')
                ->select('id')
                ->where('order','=',$request->order)
                ->first();


        $shift =
            DB::table('shift')
                ->select('*')
                ->where('user','=',$request->user()->id)
                ->where('status','=','Active')
                ->latest()
                ->first();

        $getActiveShift =
            DB::table('delivery_shifts')
                ->select('id')
                ->where('user', '=', $request->agent)
                ->where('status', '=', 'Active')
                ->first();

        if(!empty($getActiveShift) && empty($checkIfExist)){
            DB::beginTransaction();
            try {
                $crOrd = DB::table('delivery_operations')->insertGetId(
                    [
                        'agent' => $request->agent,
                        'order' => $request->order,
                        'dispatcher_shift' => $shift->id,
                        'shift' => $getActiveShift
                            ->id,
                        'dispatcher' => $request->user()->id
                    ]
                );
                DB::table('order')
                    ->where('id','=',$request->order)
                    ->update([
                            'status' => 'OnWay',
                        ]
                    );
                DB::commit();
                return response(
                    [
                        'message' => 'Delivery Operation Created With ID ' . $crOrd
                    ], 200);
            } catch (\Exception $e) {
                DB::rollBack();
                return response(['message' => $e], 422);
            }
        } else{
            return response([
                'message' => 'Dispatching Operation Already Exist or Delivery Agent has no active shift'
            ],422);
        }
    }

    public function destroyDeliveryOperation(Request $request){
        (new ReportsController)->logEvents('User '.$request->user()->id.' tried to destroy delivery operation for order '.$request->order,$request->user()->id);
        $destroy = DB::table('delivery_operations')->where('order','=',$request->id)->delete();
        if($destroy){
            return response(['message' => 'Operation Destroyed'],200);
        } else{
            return response(['message' => 'Cannot Destroy'],200);
        }
    }



}
