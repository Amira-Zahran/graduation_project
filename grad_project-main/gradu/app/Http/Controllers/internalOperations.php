<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

//class internalOperationsController extends Controller
//{
//	public function getCounterOrders(Request $request){
//		$getOrders = DB::table('order')->select('*')->where('status','=','Preparing')->orWhere('status','=','Finished')->get();
//		return response(['orders'=>$getOrders],200);
//	}
//}
