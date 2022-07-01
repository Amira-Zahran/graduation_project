<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware(['auth','admin']);
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index(Request $request)
    {
        $users = DB::table('customers_base')->select('id')->count();

        $sales = DB::table('order')->select('total','sub_total','type')->where('created_at','like','%'.Carbon::now()->year.'-'.'0'.Carbon::now()->month.'%')->get();
        $salesLastMonth = DB::table('order')->select('total','sub_total')->where('created_at','like','%'.Carbon::now()->year.'-'.'0'.Carbon::now()->subMonth()->month.'%')->get();
        $salesLastMonthDays = DB::table('order')->selectRaw('DAY(created_at) as name, sum(sub_total) as value')->where('created_at','like','%'.Carbon::now()->year.'-'.'0'.Carbon::now()->subMonth()->month.'%')->groupBy('name')->get();

        $salesLastWeek = DB::table('order')->select('total','sub_total')->whereBetween('created_at',[Carbon::now()->year.'-'.'0'.Carbon::now()->month.'-'.Carbon::now()->subWeek()->day,Carbon::now()->year.'-'.'0'.Carbon::now()->month.'-'.Carbon::now()->day])->get();
        $salesLastWeekDays = DB::table('order')->selectRaw('DAY(created_at) as name, sum(sub_total) as value')->whereBetween('created_at',[Carbon::now()->year.'-'.'0'.Carbon::now()->month.'-'.Carbon::now()->subWeek()->day,Carbon::now()->year.'-'.'0'.Carbon::now()->month.'-'.Carbon::now()->day])->groupBy('name')->get();

        $salesByType = DB::table('order')->selectRaw("type as name, count(id) as value")->where('created_at','like','%'.Carbon::now()->year.'-'.'0'.Carbon::now()->month.'%')->groupBy('name')->get()->toArray();
        $topSellingProducts = DB::table('order_items')->selectRaw('order_items.item_id as id, sum(order_items.total_price) as total, menu_items.item_name as item_name, menu_items.item_price as item_price , menu_items.item_photo as item_photo')->join('menu_items','menu_items.id','=','order_items.item_id')->groupBy('order_items.item_id')->orderBy('total','desc')->limit(5)->get();

        $months = ['01','02','03','04','05','06','07','08','09','10','11','12'];

        $salesYear = [];
        $salesLast20Days = DB::table('order')->selectRaw("sum(total) as total, concat(YEAR(created_at),'-',MONTH(created_at),'-',DAY(created_at)) as day")->where( 'created_at', '<', date('Y-m-d', strtotime("-20 days")))->groupBy('day')->get();
        foreach ($months as $month){
            $callCenter = DB::table('order')->selectRaw('sum(total) as total')->where('created_at','like',Carbon::now()->year.'-'.$month.'%')->where('type','like','Delivery%')->first();
            $floor = DB::table('order')->selectRaw('sum(total) as total')->where('created_at','like',Carbon::now()->year.'-'.$month.'%')->where('type','like','Floor%')->first();
           $salesYear[] = (object)[
               'month' => $month,
               'callCenter' => $callCenter->total??0,
               'floor' => $floor->total??0
           ];
//            echo 'Sumation'.$callCenter->total;

        }
//        return $salesLast20Days;

        foreach ($topSellingProducts as $key => $value) {
            $value->item_photo = !empty($value->item_photo) ? $request->root()."/uploads/".$value->item_photo : $request->root()."/uploads/logo.png";
        }

        $latestUsers = DB::table('customers_base')->select('customers_base.id as id','customers_base.name as name','customer_phones.phone_number as phone')->join('customer_phones','customer_phones.customer_id','=','customers_base.id')->orderBy('id','desc')->limit(5)->get();
        session(['layout' => 'vertical']);
//        return $latestUsers;
        $homeData = [
            'users' => $users,
            'sales' => $sales,
            'salesType' => $salesByType,
            'salesLastMonth' => $salesLastMonth,
            'salesLastMonthDays' => $salesLastMonthDays,
            'salesLastWeek' => $salesLastWeek,
            'salesLastWeekDays' => $salesLastWeekDays,
            'topSellingProducts' => $topSellingProducts,
            'latestUsers' => $latestUsers,
            'totalMonthSales' => $salesYear,
            'salesLast20Days' => $salesLast20Days
        ];
        return view('dashboard.dashboardv1',compact('homeData'));
    }
}
