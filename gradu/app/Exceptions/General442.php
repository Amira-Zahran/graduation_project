<?php

namespace App\Exceptions;

use Exception;

class General442 extends Exception
{
    public function render($message){
        return response(['message'=>$this->message],442);
    }
}
