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
        foreach ($categories as $key => $value) {
            $value->items = DB::table('menu_items')->select('id')->where('category','=',$value->id)->get()->count();
        }
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

    public function MenuData(Request $request){
        $menuItems = DB::table('menu_items')->select('*')->get();
        $categories = Category::all();
        foreach ($categories as $key => $value) {
            $value->items = DB::table('menu_items')->select('id')->where('category','=',$value->id)->get()->count();
        }
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

    public function dropCategory(Request $request){
        DB::table('menu_categories')->where('id','=',$request->id)->delete();
        return redirect()->route('menu-categories-lists')->with('success',"Category Deleted Successfully");
    }

    public function updateCategory(Request $request){
        $category = Category::where('id',$request->id)->first();
        $category->category_title = $request->category_title;
        $category->save();
        return redirect()->route('menu-categories-lists')->with('success',"Category Updated Successfully");
    }

    public function addCategory(Request $request){
        $category = new Category();
        $category->category_title = $request->category_title;
        $category->save();
        return redirect()->route('menu-categories-lists')->with('success',"Category Added Successfully");
    }

    public function updateItem(Request $request){
        if($request->has('item_image') || !empty($request->file('item_image'))){
            $fileName = time().'.'.$request->file('item_image')->extension();
            $request->file('item_image')->move(public_path('uploads/items'), $fileName);
            $path = 'items'.'/'.$fileName;
        } else {
            $path = '';
        }
        $item = MenuItem::where('id',$request->id)->first();
        $item->item_name = $request->item_name;
        $item->item_price = $request->item_price;
        !empty($path) ? $item->item_photo = $path : null;
        $item->category = $request->category;
        $item->readyState = $request->readyState =='on' ? 1 : 0;
        $item->active = $request->active =='on' ? 1 : 0;
        $item->save();
//        return response($path,200);
        return redirect()->route('menu-items-list')->with('success',"Item Updated Successfully");
    }

    public function createItem(Request $request){
        if($request->has('item_image') || !empty($request->file('item_image'))){
            $fileName = time().'.'.$request->file('item_image')->extension();
            $request->file('item_image')->move(public_path('uploads/items'), $fileName);
            $path = 'items'.'/'.$fileName;
        } else {
            $path = '';
        }
        $item = new MenuItem();
        $item->item_name = $request->item_name;
        $item->item_price = $request->item_price;
        !empty($path) ? $item->item_photo = $path : null;
        $item->category = $request->category;
        $item->readyState = $request->readyState =='on' ? 1 : 0;
        $item->active = $request->active =='on' ? 1 : 0;
        $item->inventory_ingredients = '[]';
        $item->save();
//        return response($path,200);
        return redirect()->route('menu-items-list')->with('success',"Item Created Successfully");
    }
}
