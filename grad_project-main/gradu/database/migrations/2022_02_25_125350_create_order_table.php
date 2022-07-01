<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/*
 * CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) DEFAULT NULL,
  `order_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `discountRate` decimal(10,2) DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `customer` bigint(20) unsigned DEFAULT NULL,
  `address` bigint(20) unsigned DEFAULT NULL,
  `bill_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `accepted_at` timestamp NULL DEFAULT NULL,
  `shift` bigint(20) unsigned DEFAULT NULL,
  `dispatcher_shift` bigint(20) unsigned DEFAULT NULL,
  `creation_location` int(10) unsigned DEFAULT NULL,
  `target_location` int(10) unsigned DEFAULT NULL,
  `type` enum('FloorTakeAway','Delivery','Floor','DeliveryTakeAway') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Added','Preparing','Ready','Finished','OnWay','Canceled','Done') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Added',
  `rate_status` enum('new','rated') COLLATE utf8mb4_unicode_ci DEFAULT 'new',
  `is_updated` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `orders_customer_foreign` (`customer`),
  KEY `orders_address_foreign` (`address`),
  KEY `orders_creator_foreign` (`creator`),
  KEY `orders_shift_foreign` (`shift`),
  KEY `orders_dispatcher_shift_foreign` (`dispatcher_shift`),
  KEY `orders_creation_location_foreign` (`creation_location`),
  KEY `orders_target_location_foreign` (`target_location`),
  CONSTRAINT `orders_address_foreign` FOREIGN KEY (`address`) REFERENCES `customer_address` (`id`),
  CONSTRAINT `orders_creation_location_foreign` FOREIGN KEY (`creation_location`) REFERENCES `branches` (`id`),
  CONSTRAINT `orders_creator_foreign` FOREIGN KEY (`creator`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_customer_foreign` FOREIGN KEY (`customer`) REFERENCES `customers` (`id`),
  CONSTRAINT `orders_dispatcher_shift_foreign` FOREIGN KEY (`dispatcher_shift`) REFERENCES `shifts` (`id`),
  CONSTRAINT `orders_shift_foreign` FOREIGN KEY (`shift`) REFERENCES `shifts` (`id`),
  CONSTRAINT `orders_target_location_foreign` FOREIGN KEY (`target_location`) REFERENCES `branches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62317 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
 */

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('order', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('order_id');
//            $table->string('order_number')->nullable();
            $table->string('order_number')
                ->virtualAs("concat(substr(cast(`type` as char(10) charset utf8mb4),1,1),cast(substr(extract(year from `created_at`),3) as char(3) charset utf8mb4),cast(extract(month from `created_at`) as char(3) charset utf8mb4),cast(dayofmonth(`created_at`) as char(2) charset utf8mb4),cast(`target_location` as char(10) charset utf8mb4),cast(`creator` as char(10) charset utf8mb4),'.',cast(`order_id` as char(10) charset utf8mb4))");
            $table->string('bill_number')->nullable();
            $table->decimal('total',10,2);
            $table->decimal('sub_total',10,2);
            $table->decimal('taxes',10,2);

            $table->unsignedBigInteger('customer')->nullable();
            $table->foreign('customer')->references('id')->on('customers_base');
            $table->unsignedBigInteger('address')->nullable();
            $table->foreign('address')->references('id')->on('customer_addresses');

            $table->unsignedBigInteger('creator');
            $table->foreign('creator')->references('id')->on('users');

            $table->unsignedBigInteger('shift');
            $table->foreign('shift')->references('id')->on('shift');

            $table->unsignedBigInteger('dispatcher_shift')->nullable();
            $table->foreign('dispatcher_shift')->references('id')->on('shift');

            $table->unsignedBigInteger('creation_location')->nullable();
            $table->foreign('creation_location')->references('id')->on('branches');

            $table->unsignedBigInteger('target_location')->nullable();
            $table->foreign('target_location')->references('id')->on('branches');

            $table->enum('type',['FloorTakeAway','Delivery','Floor','DeliveryTakeAway'])->nullable();

            $table->enum('status',['Added','Preparing','Ready','Finished','OnWay','Canceled','Done'])->default('Added');

            $table->tinyInteger('is_updated')->default('0');

            $table->dateTime('created_at')->useCurrent();
            $table->dateTime('update_at')->useCurrentOnUpdate()->nullable();
            $table->dateTime('accepted_at')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('order');
    }
};
