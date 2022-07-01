<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Contracts\Auth\Guard;
use Illuminate\Http\Request;

class AdminMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    protected $auth;

    public function __construct(Guard $auth)
    {
        $this->auth = $auth;
    }

    public function handle(Request $request, Closure $next)
    {
        if (!str_contains($this->auth->getUser()->status, 'Active') || !str_contains($this->auth->getUser()->type, 'Admin')) {
            abort(403, 'Unauthorized action.');
        }
        session(['layout' => 'vertical']);
//        echo $this->auth->getUser()->status;
        return $next($request);
    }
}
