<?php

namespace App\Http\Controllers;

use DateTime;
use DateTimeZone;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PDF;

class PrintingController extends Controller
{
    private function createOrderReceiptView(Request $request){
        $getOrderData = DB::table('order')->select('*')->where('id','=',$request->id)->first();
        if(!empty($getOrderData)) {
            $getOrderItems = DB::table('order_items')
                ->select('order_items.comment as comment', 'order_items.quantity as quantity', 'order_items.total_price as total_price', 'menu_items.item_name as item_name')
                ->where('order_items.order_id', '=', $request->id)
                ->join('menu_items', 'menu_items.id', '=', 'order_items.item_id')
                ->get();
            if(str_contains($getOrderData->type,'Delivery')){
                $customerBase = DB::table('customers_base')->select('*')->where('id','=',$getOrderData->customer)->first();
                $customerPhones = DB::table('customer_phones')->select('id','phone_number')->where('customer_id','=',$getOrderData->customer)->get();
                $getOrderData->customer = [
                    'name' => $customerBase->name,
                    'notes' => $customerBase->notes,
                    'comments' => $customerBase->comments,
                    'phones' => $customerPhones,
                ];
                $address = DB::table('customer_addresses')->select('*')->where('id','=',$getOrderData->address)->first();
                $getOrderData->customer['address'] = $address->apart_num.','.$address->floor.','.$address->building.','.$address->area.','.$address->address;
            }
            $order = [
                'num' =>$getOrderData->order_number,
                'id' =>$getOrderData->id,
                'bill' =>$getOrderData->bill_number,
                'type' => $getOrderData->type,
                'total' => $getOrderData->total,
                'taxes' => $getOrderData->taxes,
                'subtotal' => $getOrderData->sub_total,
                'en_type' => str_contains($getOrderData->type,'TakeAway') ? 'TakeAway' : $getOrderData->type,
                'agent' => DB::table('users')->select('name')->where('id','=',$getOrderData->creator)->first()->name,
//                'prints' =>!empty(\auth('api')->user()->id)? (new OrderController)->printingCounter($request->order, \auth('api')->user()->id,'Delivery') :' ',
                'items' => $getOrderItems,
                'customer' => $getOrderData->customer,
                'date' => date('Y-m-d h:i A',strtotime($getOrderData->created_at)),
                'logo' => config('uploads').'logo.png'
            ];
        }
        return view('receipt',compact('order'))->render();
    }

    private function createItemLabel(Request $request){
        $item = DB::table('order_items')
            ->select('*')
            ->where('id','=',$request->id)
            ->first();
        $item->title = DB::table('menu_items')->select('item_name')->where('id','=',$item->item_id)->first()->item_name;
        $item->type = $this->getStringTranslated(DB::table('order')->select('type')->where('id','=',$item->order_id)->first()->type);
        $dateTime = new DateTime($item->created_at, new DateTimeZone('Africa/Cairo'));
        $item->created_at = $dateTime->format('Y/m/d h:i');
        return view('label',compact('item'))->render();
    }

    public function createOrderReceiptPDF(Request $request){
        $pdf = PDF::loadHTML($this->createOrderReceiptView($request))
            ->setOption('page-width', '72mm')
            ->setOption('page-height','297mm')
            ->setOption('disable-smart-shrinking', false)
            ->setOption('enable-local-file-access', true)
            ->setOption('lowquality', false)
            ->setOption('margin-top', 0)
            ->setOption('margin-right', 0)
            ->setOption('margin-bottom', 0)
            ->setOption('margin-left', 0)
            ->inline('ord'.$request->input('order').'.pdf');
        return $pdf;
    }

    public function createLabelPDF(Request $request){
        $pdf = PDF::loadHTML($this->createItemLabel($request))
            ->setOption('page-width', '37')->setOption('page-height','25')
            ->setOption('page-width', '37')->setOption('page-height','25')
            ->setOption('disable-smart-shrinking', false)
            ->setOption('lowquality', false)
            ->setOption('margin-top', 0)
            ->setOption('margin-right', 0.5)
            ->setOption('margin-bottom', 0)
            ->setOption('margin-left', 0.5)
            ->inline('ord.pdf');
        return $pdf;
    }

    public function getStringTranslated($string): string{
        switch ($string){
            case 'Floor':
                return 'صاله';
            case 'FloorTakeAway':
            case 'DeliveryTakeAway':
                return 'تيك اواي';
            case 'Delivery':
                return 'دليفري';
        }
    }
}
