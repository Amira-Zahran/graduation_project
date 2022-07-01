<?php

namespace App\Exceptions;

use Exception;
use Illuminate\Http\Request;

class UserAuthError extends Exception
{
    public function render($message){
        return response(['message'=>$this->message],403);
    }
}
