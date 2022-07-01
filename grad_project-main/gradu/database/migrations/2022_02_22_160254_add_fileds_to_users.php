<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->unsignedBigInteger('branch');
//            $table->foreign('branch')->references('id')->on('branches');
            $table->string('card_id');
            $table->enum('type',['Dispatcher','MasterAdmin','Admin','Cashier','Counter','KitchenUser','User'])->default('User');
            $table->json('Permissions')->default('[]');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('users', function (Blueprint $table) {
            //
        });
    }
};
