<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ShiftController extends Controller
{
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
            ->where('status','=','Active')
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
}
