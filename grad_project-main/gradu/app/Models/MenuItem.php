<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MenuItem extends Model
{
    use HasFactory;
    protected $table = 'menu_items';
    protected $fillable = [
        'item_name',
        'item_price',
        'item_photo',
        'category',
        'inventory_ingredients',
        'readyState',
        'active',
    ];
}
