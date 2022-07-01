<?php

namespace App\Http\Controllers;

use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class OrderController extends Controller
{

    public function index(Request $request){
        $getActiveUsers = DB::table('users')
            ->select('id','name','type','branch')
            ->whereRaw("type = 'Cashier' or type = 'CallCenterAgent' or type = 'Dispatcher'")
            ->where('branch','=',$request->user()->branch)
            ->where('status','=','Active')
            ->get();
        $orders = DB::table('order');

        if(isset($_GET['user'])&&strlen($_GET['user'])>0){
            $orders = $orders->where('creator','=', $_GET['user']);
//            return $_GET['user'];
        }
        if(isset($_GET['type'])&&strlen($_GET['type'])>3){
            $orders = $orders->where('type','like', '%'.$_GET['type'].'%');
//            return $_GET['type'];
        }
        if(isset($_GET['created_at'])&&strlen($_GET['created_at'])>3){
            $orders = $orders->where('created_at','like', (new DateTime($_GET['created_at']))->format('Y-m-d').'%');
        }
        if(isset($_GET['customer'])&&strlen($_GET['customer'])>5){
            $searchPhoneNumber = DB::table('customer_phones')->select('customer_id')->where('phone_number', '=', $request->customer)->first();
            if(!empty($searchPhoneNumber)){
                $orders = $orders->where('customer','=', $searchPhoneNumber->customer_id);
            }
        }

        $orders = $orders->paginate(20);

        return view('apps.orders.lists', ['orders' => $orders,'users' => $getActiveUsers]);
    }

    public function liveapi(Request $request)
    {

        $datetime1=new DateTime("now");

        $activeDispatcherShift =DB::table('shift')
            ->select('id')
            ->where('location','=',auth()->user()->branch)
            ->where('status','=','Active')
            ->get();

        $Orders = DB::table('order')
            ->whereIn('shift',$activeDispatcherShift->pluck('id'))
            ->orWhereIn('dispatcher_shift',$activeDispatcherShift->pluck('id'))
            ->get()->sortDesc();

        $addedOrders = DB::table('order')
            ->where('status','=','Added')
            ->where('target_location','=',auth()->user()->branch)
            ->get()->sortDesc();
//        echo $addedOrders->pluck('id');
        $newOrders = [];
        $acceptedOrders = [];
        $doneOrders = [];
        $floorTotal = 0;
        $deliveryTotal = 0;
        $takeAwayTotal = 0;
        $delayed = 0;
        $notAccepted = 0 ;
        $done = 0 ;

        foreach ($Orders as $key => $item){
            $datetime2=date_create($item->created_at);
            $diff=date_diff($datetime1, $datetime2);
//            $item->link = route('orders.show',$item->id );
            $item->time =' ';
            $item->time = $diff->d > 0 ? $item->time . $diff->d . ' days' : $item->time . '';
            $item->time =  $item->time . ($diff->h > 0 ? '  '.$diff->h . ' hours': '') ;
            $item->time =  $item->time . ($diff->i > 0 ? ' , '.$diff->i . ' minuets': '');
            $item->time =  $item->time . ' ago';
            $item->logo =  str_contains($item->type,'Delivery') ? config('global.hotLine') : config('global.site_logo');
//            $item->type = $this->setOrderIdentifier($item->type);
            $minutes = $diff->days * 24 * 60;
            $minutes += $diff->h * 60;
            $minutes += $diff->i;
            $item->timeAgo =  $minutes;
            if($item->type == 'Delivery'){
                $deliveryTotal += $item->total;
            }
            else if(str_contains($item->type,'TakeAway')){
                $takeAwayTotal += $item->total;
            }
            else{
                $floorTotal += $item->total;
            }
            $item->total = (\Cknow\Money\Money::EGP($item->total*100))->format();
            if($item->status == 'Preparing' || $item->status =='Ready' || $item->status =='Finished'){
                if($minutes >= '45'){
                    $item->pulse='blob red';
                    $delayed++;
                }else if($minutes >= '25'){
                    $item->pulse='blob orange';
                    $delayed++;
                }
                else{
                    $item->pulse='blob green';
                }
                array_push($acceptedOrders,$item);
            }
            else if($item->status == 'Done' || $item->status == 'OnWay'){

                $item->pulse='blob green';
                $done++;
                array_push($doneOrders,$item);
            }

        }

        foreach ($addedOrders as $key => $item){
            $datetime2=date_create($item->created_at);
            $diff=date_diff($datetime1, $datetime2);

            $item->time =' ';
            $item->time = $diff->d > 0 ? $item->time . $diff->d . ' days' : $item->time . '';
            $item->time =  $item->time . ($diff->h > 0 ? ' , '.$diff->h . ' hours': '') ;
            $item->time =  $item->time . ($diff->i > 0 ? ' , '.$diff->i . ' minuets': '');
            $item->time =  $item->time . ' ago';
            $minutes = $diff->days * 24 * 60;
            $minutes += $diff->h * 60;
            $minutes += $diff->i;
            $item->timeAgo =  $minutes;

//            $item->logo =  str_contains($item->type,'Delivery') ? config('global.hotLine') : config('global.site_logo');
//            $item->type = $this->setOrderIdentifier($item->type);
            if($minutes >= '45'){
                $item->pulse='blob red';
                $notAccepted++;
            }else if($minutes >= '25'){
                $item->pulse='blob orange';
                $notAccepted++;
            }
            else{
                $item->pulse='blob green';
            }
            $item->total = (\Cknow\Money\Money::EGP($item->total*100))->format();
            array_push($newOrders,$item);

        }

        return response()->json([
            'neworders' => $newOrders,
            'accepted' => $acceptedOrders,
            'done' => $doneOrders,
            'total' => $Orders->count('id'),
            'deliveryTotal' => (\Cknow\Money\Money::EGP($deliveryTotal*100))->format(),
            'takeAwayTotal' => (\Cknow\Money\Money::EGP($takeAwayTotal*100))->format(),
            'floorTotal' => (\Cknow\Money\Money::EGP($floorTotal*100))->format(),
            'notAccepted' => $notAccepted,
            'delayed' => $delayed,
            'doned' => $done,

        ]);
    }

    public function create(Request $request)
    {
        $shift = DB::table('shift')->select('*')->where('user', '=', $request->user()->id)->where('status', '=', 'Active')->latest()->first();

        if (!empty($shift)) {
            DB::beginTransaction();

            try {
                if (str_contains($request->order_type, 'TakeAway')) {
                    $lastOrderID = $this->takeawayID_Generator(request: $request);
                } else {
                    $lastOrderID = DB::table('order')
                        ->select('order_id')
                        ->whereIn('shift', (new ShiftController)->locationActiveShifts($request->user()->branch))
                        ->where('target_location', '=', !empty($request->branch) ? $request->branch : $request->user()->branch)
                        ->where('type', '=', $request->order_type)
                        ->orderByDesc('id')
                        ->lock()
                        ->first();
                }

                $createOrder = DB::table('order')
                    ->lock()
                    ->insertGetId([
                        'order_id' => !empty($lastOrderID) ? $lastOrderID->order_id + 1 : 1,
                        'total' => $request->order_total,
                        'sub_total' => $request->order_sub_total,
                        'taxes' => $request->taxes,
                        'customer' => $request->customer_id,
                        'creator' => $request->user()->id,
                        'type' => $request->order_type,
                        'address' => $request->address,
                        'creation_location' => $request->user()->branch,
                        'target_location' => !empty($request->branch) ? $request->branch : $request->user()->branch,
                        'shift' => $shift->id,
                        'status' => strpos($request->order_type, 'Floor') !== false ? 'Preparing' : 'Added'
                    ]);

                DB::table('order')->where('id', '=', $createOrder)
                    ->update(['bill_number' => $shift->shift_id . '.' . $createOrder]);

                if (!empty($createOrder)) {
                    $json = str_replace(array("\t", "\n"), "", $request->items);
                    $orderItems = json_decode($json, true);
                    foreach ($orderItems as $i) {

                        DB::table('order_items')->insert(
                            [
                                'order_id' => $createOrder,
                                'item_id' => $i['item_id'],
                                'quantity' => $i['item_quantity'],
                                'total_price' => $i['item_total_price'],
                                'shift' => $shift->id,
//                                'item_price' => DB::table('menu_items')->select('price')->where('id', '=', $i['item_id'])->first()->price,
                                'comment' => $i['comment'],
                                'status' =>
                                    DB::table('menu_items')
                                        ->select('readyState')
                                        ->where('id', '=', $i['item_id'])
                                        ->first()
                                        ->readyState == 1 ? 'Prepared' : 'Preparing'
                            ]
                        );
                    }
                    DB::commit();
                }
                return response(
                    [
                        'order_id' => !empty($lastOrderID) ? $lastOrderID->order_id + 1 : 1,
                        'id' => $createOrder
                    ], 200
                );
            } catch (\Exception $e) {
                DB::rollback();
                return response([
                    "message" => $e->getMessage()
                ], 422);
            } catch (\Throwable $e) {
                DB::rollback();
                throw $e;
            }
        } else {
            return response([
                'message' => 'this user has no Associated Active Shift Number'
            ], 422);
        }
    }

    public function takeawayID_Generator(Request &$request, )
    {
        $shift = DB::table('shift')->select('*')->where('user', '=', $request->user()->id)->where('status', '=', 'Active')->latest()->first();
        $shifts_first = (new ShiftController)->locationActiveCashierShifts($request->user()->branch);

        $lastOrderID = DB::table('takeaway_log')
            ->select('order_id')
            ->whereIn('cash_shift', $shifts_first)
            ->whereJsonContains('cash_shifts', $shifts_first[0]);

        if (array_count_values($shifts_first) > 1) {
            foreach ($shifts_first as $shift_in) {
                $lastOrderID = $lastOrderID->orWhereJsonContains('cash_shifts', $shift_in);
            }
        }
        $lastOrderID = $lastOrderID->lockForUpdate()->orderByDesc('order_id')->first();

        DB::table('takeaway_log')->lockForUpdate()->insertGetId([
            'order_id' => !empty($lastOrderID) ? $lastOrderID->order_id + 1 : 1,
            'cash_shift' => $shift->id,
            'cash_shifts' => json_encode($shifts_first)
        ]);
        return $lastOrderID;
    }

    public function update(Request $request)
    {
        $shift = DB::table('shift')->select('*')->where('user', '=', $request->user()->id)->where('status', '=', 'Active')->latest()->first();
        DB::beginTransaction();
        try {
            if (DB::table('order')->select('type')->where('id', '=', $request->id)->first()->type == $request->order_type) {
                DB::table('order')->where('id', '=', $request->id)->lockForUpdate()->update([
                    'total' => $request->order_total,
                    'sub_total' => $request->order_sub_total,
                    'taxes' => $request->taxes,
                    'address' => $request->address ?? null,
                    'is_updated' => '1'
                ]);
            } else {
                if (str_contains($request->order_type, 'TakeAway')) {
                    $lastOrderID = $this->takeawayID_Generator(request: $request);
                } else {
                    $lastOrderID = DB::table('order')
                        ->select('order_id')
                        ->whereIn('shift', (new ShiftController)->locationActiveShifts($request->user()->branch))
                        ->where('target_location', '=', !empty($request->branch) ? $request->branch : $request->user()->branch)
                        ->where('type', '=', $request->order_type)
                        ->orderByDesc('id')
                        ->lock()
                        ->first();
                }
                DB::table('order')->where('id', '=', $request->id)->lockForUpdate()->update([
                    'order_id' => !empty($lastOrderID) ? $lastOrderID->order_id + 1 : 1,
                    'total' => $request->order_total,
                    'sub_total' => $request->order_sub_total,
                    'taxes' => $request->taxes,
                    'type' => $request->order_type,
                    'address' => $request->address ?? null,
                    'is_updated' => '1'
                ]);
            }
            $json = str_replace(array("\t", "\n"), "", $request->items);
            $json2 = str_replace(array("\t", "\n"), "", $request->toBeDeleted);
            $orderItems = json_decode($json, true);
            $toBeDeleted = json_decode($json2, true);

            foreach ($orderItems as $item) {
                if (!empty(DB::table('order_items')->where('id', '=', $item['id'])->first())) {
                    DB::table('order_items')
                        ->where('id', '=', $item['id'])
                        ->lockForUpdate()
                        ->update(
                            [
                                'order_id' => $request->id,
                                'item_id' => $item['item_id'],
                                'quantity' => $item['item_quantity'],
                                'total_price' => $item['item_total_price'],
//                                'shift' => $shift->id,
//                                'item_price' => DB::table('menu_items')->select('price')->where('id', '=', $i['item_id'])->first()->price,
                                'comment' => $item['comment'],
                                'status' =>
                                    DB::table('menu_items')
                                        ->select('readyState')
                                        ->where('id', '=', $item['item_id'])
                                        ->first()
                                        ->readyState == 1 ? 'Prepared' : 'Preparing'
                            ]
                        );
                } else {
                    DB::table('order_items')->insert(
                        [
                            'order_id' => $request->id,
                            'item_id' => $item['item_id'],
                            'quantity' => $item['item_quantity'],
                            'total_price' => $item['item_total_price'],
                            'shift' => $shift->id,
//                                'item_price' => DB::table('menu_items')->select('price')->where('id', '=', $i['item_id'])->first()->price,
                            'comment' => $item['comment'],
                            'status' =>
                                DB::table('menu_items')
                                    ->select('readyState')
                                    ->where('id', '=', $item['item_id'])
                                    ->first()
                                    ->readyState == 1 ? 'Prepared' : 'Preparing'
                        ]
                    );
                }
            }

            foreach ($toBeDeleted as $i){
                DB::table('order_items')->where('id', '=', $i)->delete();
            }
            DB::commit();
            return response()->json(['success' => 'Order updated successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }

    public function deleteOrder(Request $request)
    {

        if (str_contains(auth()->user()->Permissions, 'Delete')) {
            DB::beginTransaction();
            try {
                $delete = DB::table('order')->where('id', '=', $request->id)->update(['status' => 'Canceled']);
                if ($delete) {
                    DB::table('delivery_operations')->where('order', '=', $request->id)->delete();
                    DB::table('order_items')->where('order_id', '=', $request->id)->update(['status' => 'Canceled']);
                    DB::commit();
                    return response(['message' => 'Order Deleted Successfully'], 200);
                } else {
                    return response(['message' => 'error'], 422);
                }
            } catch (\Exception $e) {
                DB::rollback();
                return response([
                    "message" => $e
                ], 422);
            } catch (\Throwable $e) {
                DB::rollback();
                throw $e;
            }

        } else {
            return response([
                'message' => 'لا يمكن الغاء الطلب، تعدي الوقت المسموح للتعديل'
            ], 422);
        }
    }

    public function updateOrderStatus(Request $request)
    {
        $updateStatus = DB::table('order')->where('id', '=', $request->id)->lockForUpdate()->update(
            [
                'status' => $request->status
            ]
        );
        return response(['message' => $updateStatus]);
    }

    public function getOrderDetails(Request $request)
    {
        $orderDetails = DB::table('order')->select('*')->where('id', '=', $request->id)->first();
        $Items = DB::table('order_items')->select('*')->where('order_id', '=', $request->id)->get();
        $request->phone_number = !empty($orderDetails->customer) ? DB::table('customer_phones')->select('*')->where('customer_id', '=', $orderDetails->customer)->first()->phone_number : null;
        $orderDetails->customer = !empty($orderDetails->customer) ? (new CustomerController)->getCustomerData($request)->original : null;
        $orderDetails->items = $Items;
        return $orderDetails;
    }
}
