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
        Schema::create('order_items', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('order_id');
            $table->foreign('order_id')->references('id')->on('order')->cascadeOnDelete();
            $table->unsignedBigInteger('item_id');
            $table->foreign('item_id')->references('id')->on('menu_items')->onDelete('NO ACTION');
            $table->integer('quantity');
            $table->decimal('total_price',10,2);
            $table->unsignedBigInteger('shift');
            $table->foreign('shift')->references('id')->on('shift')->onDelete('NO ACTION');
            $table->longText('comment')->nullable();
            $table->enum('status',['Preparing','Prepared','Done','Canceled'])->default('Preparing');
            $table->dateTime('created_at')->useCurrent();
            $table->dateTime('updated_at')->useCurrentOnUpdate()->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('order_items');
    }
};
