<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;
    protected $table = 'menu_categories';
    protected $fillable = [
        'category_title',
        'category_icon'
    ];
}
