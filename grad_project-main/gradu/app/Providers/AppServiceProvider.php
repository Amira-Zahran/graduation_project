<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Http\Request;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot(Request $request)
    {
        $url = $request->root();
        $uploadsFolder =  $url.'/uploads/';
        config([
            'global.site_logo' => $uploadsFolder.'logo.png'
        ]);
    }
}
