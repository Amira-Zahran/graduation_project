<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class InternalOperationsController extends Controller
{

    public function getCounterOrder(Request $request)
    {
        $getOrders = DB::table('order')
            ->select('id','order_id','status','created_at','type')
            ->where('target_location','=',$request->user()->branch)
            ->whereRaw("status = 'Preparing' or status = 'Finished'")
            ->get();
        foreach ($getOrders as $key => $value){
            $getItems = DB::table('order_items')
                ->select('order_items.item_id as item_id','order_items.id as id','order_items.quantity as quantity','order_items.comment as comment','order_items.status as status','menu_items.item_name as item_name')
                ->join('menu_items','menu_items.id','=','order_items.item_id')
                ->where('order_id','=',$value->id)
                ->get();
            foreach ($getItems as $ke => $val){
                $photo = DB::table('menu_items')
                    ->select('item_photo')
                    ->where('id','=',$val->item_id)
                    ->first()
                    ->item_photo;
                $val->photo = !empty($photo) ? $request->root()."/uploads/".$photo:$request->root()."/uploads/logo.png";
            }
            $value->items = $getItems;
        }
        return response([
            'orders' => $getOrders
        ],200);
    }

    public function getKitchenOrder(Request $request)
    {
        $getOrders = DB::table('order')
            ->select('id','order_id','status','created_at','type')
            ->where('target_location','=',$request->user()->branch)
            ->where("status", "=",'Preparing')
            ->get();
        $results = [];
        foreach ($getOrders as $key => $value){
            $getItems = DB::table('order_items')
                ->select('order_items.id as id','order_items.quantity as quantity','order_items.comment as comment','order_items.status as status','menu_items.item_name as item_name','menu_items.item_photo as photo')
                ->join('menu_items','menu_items.id','=','order_items.item_id')
                ->where('order_id','=',$value->id)
                ->where('status','=','Preparing')
                ->get();
            if(count($getItems) != 0 ){
                foreach ($getItems as $ke => $val){
                    $val->photo = !empty($val->photo) ? $request->root()."/uploads/".$val->photo:$request->root()."/uploads/logo.png";
                }
                $value->items = $getItems;
                $results[] = $value;
            }
        }
        return response([
            'orders' => $results
        ],200);
    }

    public function updateItemStatus(Request $request){
        DB::table('order_items')->where('id','=',$request->id)->update([
            'status' => $request->status
        ]);
    }
}
