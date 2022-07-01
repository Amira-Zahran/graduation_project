<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeliveryAgent extends Model
{
    use HasFactory;
    protected $table = 'delivery_agents';
    protected $fillable = [
        'name',
        'phone_number',
        'branch',
    ];

}
