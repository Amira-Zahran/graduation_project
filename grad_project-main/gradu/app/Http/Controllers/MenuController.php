<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\MenuItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MenuController extends Controller
{
    public function MenuJSON(Request $request){
        $menuItems = DB::table('menu_items')->select('*')->where('active','=','1')->get();
        $categories = Category::all();
        foreach ($menuItems as $key => $value){
            $value->category = Category::where('id',$value->category)->first();
            $value->item_photo = !empty($value->item_photo) ? $request->root()."/uploads/".$value->item_photo : $request->root()."/uploads/logo.png";
        }
        return response(
            [
                'items' => $menuItems,
                'categories' => $categories
            ],
            200
        );
    }
}
