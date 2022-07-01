<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ApiAuth\UserController;
use App\Http\Controllers\MenuController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\DispatchingController;
use \App\Http\Controllers\InternalOperationsController;
use \App\Http\Controllers\FollowupController;
use \App\Http\Controllers\ShiftController;
use \App\Http\Controllers\PrintingController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware('auth:api')->group(function (){
    Route::get('menu',[MenuController::class , 'MenuJSON']);


    Route::prefix('Customer')->group(function (){
        Route::post('getAllCustomer',[CustomerController::class,'getAllCustomerData']);
        Route::post('getCustomer',[CustomerController::class,'getCustomerData']);
        Route::post('new',[CustomerController::class,'newCustomer'])->name('customer-new');
        Route::post('updateAddress',[CustomerController::class,'updateAddress']);
        Route::post('updateCustomerBase',[CustomerController::class,'updateCustomerBase']);
        Route::post('insertAddress',[CustomerController::class,'insertAddress']);
        Route::post('updatePhoneNumber',[CustomerController::class,'updatePhoneNumber']);
    });

    Route::prefix('Order')->group(function (){
        Route::post('create',[OrderController::class,'create']);
        Route::post('update',[OrderController::class,'update']);
        Route::post('delete',[OrderController::class,'deleteOrder']);
        Route::post('updateStatus',[OrderController::class,'updateOrderStatus']);
        Route::post('history',[FollowupController::class,'getPOSHistory']);
        Route::post('getOrder', [OrderController::class, 'getOrderDetails']);
        Route::post('createPDF', [PrintingController::class, 'createOrderReceiptPDF']);

    });

    Route::prefix('Followup')->group(function(){
        Route::post('hallOrders',[FollowupController::class,'hallOrders']);
    });

    Route::prefix('Dispatching')->group(function (){
        Route::post('getOrders',[DispatchingController::class,'getOrders']);
        Route::post('acceptOrder',[DispatchingController::class,'acceptOrder']);
        Route::post('getDeliveryAgents',[DispatchingController::class,'getDeliveryAgents']);
        Route::post('createDeliveryOperation',[DispatchingController::class,'createDeliveryOperation']);
        Route::post('history',[FollowupController::class,'getDeliveryHistory']);
    });

    Route::post('locationActiveCashierShifts',[ShiftController::class,'locationActiveCashierShifts']);

    Route::prefix('BackOperations')->group(function (){
        Route::post('getCounterOrders',[InternalOperationsController::class,'getCounterOrder']);
        Route::post('createLabelPDF',[PrintingController::class,'createLabelPDF']);
        Route::post('getKitchenOrder',[InternalOperationsController::class,'getKitchenOrder']);
        Route::post('updateItemStatus',[InternalOperationsController::class,'updateItemStatus']);
    });

    Route::prefix('DeliveryAgent')->group(function (){
        Route::post('Orders',[\App\Http\Controllers\DeliveryAgentsController::class,'getNewOrders']);
        Route::post('History',[\App\Http\Controllers\DeliveryAgentsController::class,'getHistory']);
        Route::post('updatedStatus',[\App\Http\Controllers\DeliveryAgentsController::class,'updateOperationStatus']);
    });

});



Route::group(['middleware' => ['throttle:100000,50']],function (){
    Route::any('login',[UserController::class , 'login']);
    Route::post('agentLogin',[UserController::class , 'agentLogin']);
    Route::post('agentOTPValidate',[UserController::class , 'agentOTPValidate']);
    Route::any('register',[UserController::class , 'Register']);
//    Route::any('getAllUsers',[UserController::class , 'getAllUsers']);
});
