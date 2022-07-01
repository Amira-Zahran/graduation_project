<?php

namespace App\Exceptions;

use Exception;

class NotFoundException extends Exception
{
    public function render(String $message){
        return response(['message'=>'Customer not found'],422);
    }
}
