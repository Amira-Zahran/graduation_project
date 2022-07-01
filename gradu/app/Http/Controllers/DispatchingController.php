<?php

namespace App\Http\Controllers;

use App\Exceptions\General442;
use DateTimeZone;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class DispatchingController extends Controller
{

    public function getCurrentDispatcherShiftID(Request $request)
    {
        $shift = DB::table('shift')->select('id')->where('user', '=', $request->user()->id)->where('status', '=', 'Active')->first();
        return $shift;
    }

    public function getOrders(Request $request)
    {

        $getOrders = DB::table('order')
            ->select('*')
            ->whereRaw('target_location = ' . $request->user()->branch . ' and (type Like \'%Delivery%\') and ( status != \'Canceled\' and status!= \'Done\')')
            ->get();
        $getCanceled = DB::table('order')->select('*')
            ->whereRaw('target_location = ' . $request->user()->branch . ' and (type like \'%Delivery%\') and ( status = \'Canceled\') and (update_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 MINUTE) and NOW())')
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
                ->select('address', 'area')
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
        foreach ($getCanceled as $ref => $v) {
            $getCustomer = DB::table('customers')
                ->select('*')
                ->where('id', '=', $v->customer)
                ->first();
            $getPhone = DB::table('customers_phones')
                ->select('phone_number')
                ->where('customer', '=', $v->customer)
                ->get();
            $getAddress = DB::table('customer_address')
                ->select('*')
                ->where('id', '=', $v->address)->first();
            $getItems = DB::table('order_items')
                ->select('*')
                ->where('order_id', '=', $v->id)
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
        return response()->json(['orders' => $result]);
    }

    public function acceptOrder(Request $request)
    {
        $dateTime = new DateTime('now', new DateTimeZone('Africa/Cairo'));
        $shift = $this->getCurrentDispatcherShiftID($request);
        $request->status = 'Preparing';
        $update = (new OrderController())->updateOrderStatus($request);
        if ($shift && $update) {
            DB::table('order')->where('id', '=', $request->id)->lockForUpdate()->update(
                [
                    'accepted_at' => $dateTime->format('Y-m-d H:i:s'),
                    'dispatcher_shift' => $shift->id
                ]
            );
            return response(['messages' => 'Order Accepted'], 200);
        } else return response(['message' => "User doesn't have an active shift"], 422);
    }

    public function getDeliveryAgents(Request $request)
    {
        $getAgents = DB::table('delivery_agents')->select('*')->where('branch', '=', $request->user()->branch)->get();
        $agents = [];
        foreach ($getAgents as $key => $value) {
            if(DB::table('delivery_shifts')->select('*')->where('user', '=', $value->id)->where('status', '=', 'Active')->first()){
                $agents[] = $value;
            }
        }
        return response()->json(['agents' => $agents]);
    }

    public function createDeliveryOperation(Request $request)
    {
        $checkIfExist =
            DB::table('delivery_operations')
                ->select('id')
                ->where('order', '=', $request->order)
                ->first();


        $shift =
            DB::table('shift')
                ->select('*')
                ->where('user', '=', $request->user()->id)
                ->where('status', '=', 'Active')
                ->latest()
                ->first() ?? Throw new General442('User doesn\'t have an active shift');

        $getActiveShift =
            DB::table('delivery_shifts')
                ->select('id')
                ->where('user', '=', $request->agent)
                ->where('status', '=', 'Active')
                ->first();

        if (!empty($getActiveShift) && empty($checkIfExist)) {
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
                    ->where('id', '=', $request->order)
                    ->update([
                            'status' => 'OnWay',
                        ]
                    );
                $this->sendFCMNotification($request->order,$request->agent);
                DB::commit();
                return response(
                    [
                        'message' => 'Delivery Operation Created With ID ' . $crOrd
                    ], 200);
            } catch (\Exception $e) {
                DB::rollBack();
                return response(['message' => $e->getMessage()], 422);
            }
        } else {
            return response([
                'message' => 'Dispatching Operation Already Exist or Delivery Agent has no active shift'
            ], 422);
        }
    }

    public function destroyDeliveryOperation(Request $request)
    {
        (new ReportsController)->logEvents('User ' . $request->user()->id . ' tried to destroy delivery operation for order ' . $request->order, $request->user()->id);
        $destroy = DB::table('delivery_operations')->where('order', '=', $request->id)->delete();
        if ($destroy) {
            return response(['message' => 'Operation Destroyed'], 200);
        } else {
            return response(['message' => 'Cannot Destroy'], 200);
        }
    }

    public function getDeliveryAgentActiveShift(Request $request)
    {
        $user = DB::table('delivery_agents')->select('*')->where('firebase_token', '=', $request->headers->get('token'))->first();
        $getShift = DB::table('delivery_shifts')
            ->select('*')
            ->where('user', '=', $user->id)
            ->where('status', '=', 'Active')
            ->first();
        return $getShift;
    }

//    public function getDeliveryAgentOrders(Request $request){
//        $getDeliveryOrders = DB::table('delivery_operations')->select('*')->where('shift','=',$this->getDeliveryAgentActiveShift($request)->id)->get();
//        $getOrders = DB::table('order')
//            ->select('*')
//            ->whereIn('id',$getDeliveryOrders->pluck('order'))
//            ->get();
//        $result = [];
//        foreach ($getOrders as $key => $value) {
//            $getCustomer = DB::table('customers_base')
//                ->select('*')
//                ->where('id', '=', $value->customer)
//                ->first();
//            $getPhone = DB::table('customer_phones')
//                ->select('phone_number')
//                ->where('customer_id', '=', $value->customer)
//                ->get();
//            $getAddress = DB::table('customer_addresses')
//                ->select('*')
//                ->where('id', '=', $value->address)->first();
//            $getItems = DB::table('order_items')
//                ->select('*')
//                ->where('order_id', '=', $value->id)
//                ->get();
//            foreach ($getItems as $ke => $val) {
////                echo DB::table('menu_items')->select('item_name')->where('id','=',$val->id)->first()->item_name;
//                $val->item_name = DB::table('menu_items')->select('item_name')->where('id', '=', $val->item_id)->first()->item_name;
//            }
//            $result[] = [
//                "id" => $value->id,
//                "order_id" => $value->order_id,
//                "customer" => [
//                    'name' => $getCustomer->name,
//                    'Phones' => $getPhone
//                ],
//                "address" => $getAddress,
//                'status' => $value->status,
//                'created_at' => $value->created_at,
//                'updated_at' => $value->update_at,
//
//                'is_updated' => $value->is_updated,
//
//                'type' => $value->type,
//                'total' => $value->total,
//                'subtotal' => $value->sub_total,
//            ];
//        }
//        return response()->json(['orders' => $result]);
//    }

    private function sendFCMNotification( $bill,$agent)
    {
        $url = 'https://fcm.googleapis.com/fcm/send';
        $FcmToken = DB::table('delivery_agents')->select('firebase_token')->where('id', '=', $agent)->first();
        $orderData = DB::table('order')->select('order_id','customer')->where('id', '=', $bill)->first();
        $customer_data = DB::table('customers_base')->select('name')->where('id', '=', $orderData->customer)->first();

        $serverKey = 'AAAAn0jjF4k:APA91bFuJ6Zv8uahzQzLSK-P8StidIJeLNrjOWSvc46tpNjO9AW8Yw72nyKIGiMGf1W7bvRBb3EllMFREgL_H2Dx42Xe3UGY2GmvK_pt4uc9DvpeTj6BcT4Ktr9DE8O0tfNX8LNuzT1M';

        $data = [
            "to" => $FcmToken->firebase_token,
            "data" => [
                "order_id" => $bill
            ],
            "android" => [
                "priority" => "high"
            ],
            "notification" => [
                "title" => "New Order Assigned to You",
                "body" => "Customer: $customer_data->name\nid: $orderData->order_id",
                "sound" => "default",

//                "image" => "https://png.pngtree.com/png-vector/20210525/ourlarge/pngtree-the-delivery-man-icon-rides-a-motorbike-png-image_3343631.jpg"
            ]
        ];
        $encodedData = json_encode($data);

        $headers = [
            'Authorization'=> 'Bearer AAAAn0jjF4k:APA91bFuJ6Zv8uahzQzLSK-P8StidIJeLNrjOWSvc46tpNjO9AW8Yw72nyKIGiMGf1W7bvRBb3EllMFREgL_H2Dx42Xe3UGY2GmvK_pt4uc9DvpeTj6BcT4Ktr9DE8O0tfNX8LNuzT1M',
            'Content-Type'=> 'application/json',
        ];

        $request = HTTP::withHeaders($headers)->post($url, $data);
        return $request;

    }
}
