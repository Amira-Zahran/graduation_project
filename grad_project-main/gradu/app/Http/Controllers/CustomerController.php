<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CustomerController extends Controller
{

    public function getCustomerData(Request $request)
    {
        $searchPhoneNumber = DB::table('customer_phones')->select('customer_id')->where('phone_number', '=', $request->phone_number)->first();
        if ($searchPhoneNumber) {
            $customerBase = DB::table('customers_base')->select('*')->where('id','=',$searchPhoneNumber->customer_id)->first();
            $customerPhones = DB::table('customer_phones')->select('id','phone_number')->where('customer_id','=',$searchPhoneNumber->customer_id)->get();
            $customerAddress = DB::table('customer_addresses')->select('*')->where('customer_id','=',$searchPhoneNumber->customer_id)->get();
            return response([
                'id' => $customerBase->id,
                'name' => $customerBase->name,
                'notes' => $customerBase->notes,
                'comments' => $customerBase->comments,
                'phones' => $customerPhones,
                'addresses' => $customerAddress
            ], 200);
        } else {
            return response([
                'message' => "Customer Doesn't Exist"
            ], 422);
        }
    }

    public function newCustomer(Request $request)
    {
        $validate = DB::table('customer_phones')
            ->select('*')
            ->where('phone_number','=',$request->phone_number)
            ->first();
        if(!$validate) {
            $insertBase = $this->insertCustomerBase($request);
            $request['csID'] = $insertBase;
            $this->insertPhoneNumber($request);
            $this->insertAddress($request);
            return response($this->getCustomerData($request)->original, 200);
        } else return response(['message' => "Customer Exist"], 422);
    }

    public function insertCustomerBase(Request $request)
    {
        $insertOperation = DB::table('customers_base')->insertGetId([
            'name' => $request->name,
            'notes' => '',
            'comments' => ''
        ]);
        return $insertOperation;
    }

    public function insertPhoneNumber(Request $request)
    {
        $validate = DB::table('customer_phones')
            ->select('*')
            ->where('phone_number','=',$request->phone_number)
            ->first();
        if(!$validate) {
            $insertOperation = DB::table('customer_phones')->insertGetId([
                'phone_number' => $request->phone_number,
                'customer_id' => $request->csID
            ]);
            return response(['message' => 'Added'],200);
        } else return response(['message' => "Number Exist"],422);
    }

    public function insertAddress(Request $request)
    {
        $insertOperation = DB::table('customer_addresses')->insertGetId([
            'address'=> $request->address,
            'area'=> $request->area,
            'building'=> $request->building,
            'floor'=> $request->floor,
            'apart_num'=> $request->apart_num,
            'customer_id'=> $request->csID,
        ]);
        $customerAddress = DB::table('customer_addresses')->select('*')->where('id','=',$insertOperation)->first();
        return response(['address'=>$customerAddress],200);
    }

    public function updateCustomerBase(Request $request)
    {
        $updateOperation = DB::table('customers_base')->where('id','=',$request->id)->update([
            'name' => $request->name,
            'notes' => '',
            'comments' => $request->comments
        ]);
        return response(['message' =>  $updateOperation]);
    }

    public function updatePhoneNumber(Request $request)
    {
        $updateOperation = DB::table('customer_phones')->where('id','=',$request->id)->update([
            'phone_number' => $request->phone_number,
        ]);
        return response(['message' =>  $updateOperation]);
    }

    public function updateAddress(Request $request)
    {
        $updateOperation = DB::table('customer_addresses')->where('id','=',$request->id)->update([
            'address'=> $request->address,
            'area'=> $request->area,
            'building'=> $request->building,
            'floor'=> $request->floor,
            'apart_num'=> $request->apart_num,
//            'customer_id'=> $request->csID,
        ]);
        return response(['message' => $updateOperation],200);
    }

}
