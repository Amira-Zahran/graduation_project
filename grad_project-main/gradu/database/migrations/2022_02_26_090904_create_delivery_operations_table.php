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
        Schema::create('delivery_operations', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('agent');
            $table->foreign('agent')->references('id')->on('delivery_agents')->cascadeOnDelete();
            $table->unsignedBigInteger('order');
            $table->foreign('order')->references('id')->on('order')->cascadeOnDelete();
            $table->unsignedBigInteger('shift');
            $table->foreign('shift')->references('id')->on('delivery_shifts');
            $table->unsignedBigInteger('dispatcher_shift');
            $table->foreign('dispatcher_shift')->references('id')->on('shift');
            $table->unsignedBigInteger('dispatcher');
            $table->foreign('dispatcher')->references('id')->on('users');
            $table->timestamp('created_at')->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('delivery_operations');
    }
};
