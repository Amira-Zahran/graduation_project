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
        Schema::create('shift', function (Blueprint $table) {
            $table->id();
            $table->string('shift');
            $table->timestamp('created_at')->useCurrent();
            $table->unsignedInteger('location');
            $table->unsignedBigInteger('user');
            $table->foreign('user')->references('id')->on('users');
            $table->unsignedBigInteger('creator');
            $table->foreign('creator')->references('id')->on('users');
            $table->string('shift_id')->virtualAs('concat(substr(cast(`shift` as char(10) charset utf8mb4),1,1),cast(substr(extract(year from `created_at`),3) as char(3) charset utf8mb4),cast(extract(month from `created_at`) as char(3) charset utf8mb4),cast(dayofmonth(`created_at`) as char(2) charset utf8mb4),cast(`location` as char(10) charset utf8mb4),cast(`user` as char(10) charset utf8mb4))');
            $table->enum('status',['Active','Closed']);
            $table->dateTime('closing_date')->default(DB::raw('NULL ON UPDATE CURRENT_TIMESTAMP'))->nullable();
//            $table->foreign('location')->references('id')->on('branches');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('shift');
    }
};
