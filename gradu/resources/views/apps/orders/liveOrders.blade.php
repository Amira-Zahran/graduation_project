<script src="https://unpkg.com/vue@2.1.6/dist/vue.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="{{ asset('js') }}/liveOrders.js"></script>
@extends('layouts.master')
@section('before-css')


@endsection

@section('main-content')
    <div class="breadcrumb">
        <h1>Dashboard</h1>

        <ul>
            <li><a href="">Orders</a></li>
            <li>Live Orders</li>
        </ul>
    </div>

    <div class="separator-breadcrumb border-top"></div>

    <!-- begin::Widgets content -->
    <section class="widgets-content">
        <div class="" id="liveorders">
            <!-- start second section -->
            <div class="row">
                <div class="col-md-6 col-lg-6 col-xl-4 mt-4 mb-4">
                    <div class="card ">
                        <div class="card-body">
                            <!-- begin::widget-stats-1 -->
                            <div class="ul-widget1">
                                <div class="ul-widget__item">
                                    <div class="ul-widget__info">
                                        <h3 class="ul-widget1__title">Total Delayed Orders</h3>
                                        <span class="ul-widget__desc text-mute">Total Number of Orders</span>
                                    </div>
                                    <span class="ul-widget__number text-primary">@{{ delayed }}</span>
                                </div>
                                <div class="ul-widget__item">
                                    <div class="ul-widget__info">
                                        <h3 class="ul-widget1__title">Total Not Accepted Orders</h3>
                                        <span class="ul-widget__desc text-mute">Total Number of Orders</span>
                                    </div>
                                    <span class="ul-widget__number text-danger">@{{ notAccepted }}</span>
                                </div>
                                <div class="ul-widget__item">
                                    <div class="ul-widget__info">
                                        <h3 class="ul-widget1__title">Total Finished Orders</h3>
                                        <span class="ul-widget__desc text-mute">Total Number of Orders</span>
                                    </div>
                                    <span class="ul-widget__number text-success">@{{ doned }}</span>
                                </div>
                            </div>
                            <!-- end::widget-stats-1 -->
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6 col-xl-4 mt-4 mb-4">
                    <div class="card">
                        <div class="card-body">
                            <!-- begin::widget-stats-1 -->
                            <div class="ul-widget1">
                                <div class="ul-widget__item">
                                    <div class="ul-widget__info">
                                        <h3 class="ul-widget1__title">Total Shift Orders</h3>
                                        <span class="ul-widget__desc text-mute">Total Number of Orders</span>
                                    </div>
                                    <span class="ul-widget__number text-primary">@{{ total }}</span>
                                </div>
                                <div class="ul-widget__item">
                                    <div class="ul-widget__info">
                                        <h3 class="ul-widget1__title">Total Din-in Orders Sales</h3>
                                        <span class="ul-widget__desc text-mute">Total Sales</span>
                                    </div>
                                    <span class="ul-widget__number text-danger">@{{ floorTotal }}</span>
                                </div>
                                <div class="ul-widget__item">
                                    <div class="ul-widget__info">
                                        <h3 class="ul-widget1__title">Total Delivery Orders Sales</h3>
                                        <span class="ul-widget__desc text-mute">Total Sales</span>
                                    </div>
                                    <span class="ul-widget__number text-success">@{{ deliveryTotal }}</span>
                                </div>
                            </div>
                            <!-- end::widget-stats-1 -->
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6 col-xl-4 mt-4 mb-4">
                    <div class="card">
                        <div class="card-body">
                            <!-- begin::widget-stats-1 -->
                            <div class="ul-widget1">
                                <div class="ul-widget__item">
                                    <div class="ul-widget__info">
                                        <h3 class="ul-widget1__title">Total Take-Away Orders Sales</h3>
                                        <span class="ul-widget__desc text-mute">Total Sales</span>
                                    </div>
                                    <span class="ul-widget__number text-primary">@{{ takeAwayTotal }}</span>
                                </div>
{{--                                <div class="ul-widget__item">--}}
{{--                                    <div class="ul-widget__info">--}}
{{--                                        <h3 class="ul-widget1__title">Orders</h3>--}}
{{--                                        <span class="ul-widget__desc text-mute">Average Weekly Orders</span>--}}
{{--                                    </div>--}}
{{--                                    <span class="ul-widget__number text-danger">+15%</span>--}}
{{--                                </div>--}}
{{--                                <div class="ul-widget__item">--}}
{{--                                    <div class="ul-widget__info">--}}
{{--                                        <h3 class="ul-widget1__title">Revenue</h3>--}}
{{--                                        <span class="ul-widget__desc text-mute">Overall Revenue Increase</span>--}}
{{--                                    </div>--}}
{{--                                    <span class="ul-widget__number text-success">+60%</span>--}}
{{--                                </div>--}}
                            </div>
                            <!-- end::widget-stats-1 -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- end second section -->

            <!-- begin::5th section -->
            <div class="row mt-4">
                <!-- begin::sales stats -->
                <div class="col-xl-4 col-lg-4 mb-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="ul-widget__head __g-support v-margin">
                                <div class="ul-widget__head-label">
                                    <h3 class="ul-widget__head-title">
                                        New Orders
                                    </h3>
                                </div>
{{--                                <button type="button" class="btn bg-white _r_btn border-0" data-toggle="dropdown"--}}
{{--                                        aria-haspopup="true" aria-expanded="false">--}}
{{--                                    <span class="_dot _inline-dot bg-primary"></span>--}}
{{--                                    <span class="_dot _inline-dot bg-primary"></span>--}}
{{--                                    <span class="_dot _inline-dot bg-primary"></span>--}}
{{--                                </button>--}}
{{--                                <div class="dropdown-menu" x-placement="bottom-start"--}}
{{--                                     style="position: absolute; transform: translate3d(0px, 33px, 0px); top: 0px; left: 0px; will-change: transform;">--}}
{{--                                    <a class="dropdown-item" href="#">Action</a>--}}
{{--                                    <a class="dropdown-item" href="#">Another action</a>--}}
{{--                                    <a class="dropdown-item" href="#">Something else here</a>--}}
{{--                                    <div class="dropdown-divider"></div>--}}
{{--                                    <a class="dropdown-item" href="#">Separated link</a>--}}
{{--                                </div>--}}
                            </div>
                            <div class="ul-widget__body">
                                <div class="ul-widget6">
                                    <div class="ul-widget6__head">
                                        <div class="ul-widget6__item">
                                            <span>#</span>
                                            <span>Time</span>
                                            {{--                                            <span>Type</span>--}}
                                            <span>Amount</span>
                                        </div>
                                    </div>
                                    <div v-for="item in neworders" class="ul-widget6__body">

                                        <div class="ul-widget6__item">
                                            <span>@{{ item.id }}</span>
                                            <span>@{{ item.time }}</span>
                                            {{--                                            <span>@{{ item.type }}</span>--}}
                                            <span class="t-font-boldest text-success">@{{ item.total }}</span>
                                        </div>
                                    </div>
                                    {{--                                    <div class="ul-widget6-footer">--}}
                                    {{--                                        <button type="button" class="btn btn-outline-danger m-1">--}}
                                    {{--                                            Follow--}}
                                    {{--                                        </button>--}}
                                    {{--                                    </div>--}}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end::sales stats -->

                <!-- user progress -->
                <div class="col-xl-4 col-lg-4 mb-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="ul-widget__head __g-support v-margin">
                                <div class="ul-widget__head-label">
                                    <h3 class="ul-widget__head-title">
                                        Accepted Orders
                                    </h3>
                                </div>
{{--                                <button type="button" class="btn bg-white _r_btn border-0" data-toggle="dropdown"--}}
{{--                                        aria-haspopup="true" aria-expanded="false">--}}
{{--                                    <span class="_dot _inline-dot bg-primary"></span>--}}
{{--                                    <span class="_dot _inline-dot bg-primary"></span>--}}
{{--                                    <span class="_dot _inline-dot bg-primary"></span>--}}
{{--                                </button>--}}
{{--                                <div class="dropdown-menu" x-placement="bottom-start"--}}
{{--                                     style="position: absolute; transform: translate3d(0px, 33px, 0px); top: 0px; left: 0px; will-change: transform;">--}}
{{--                                    <a class="dropdown-item" href="#">Action</a>--}}
{{--                                    <a class="dropdown-item" href="#">Another action</a>--}}
{{--                                    <a class="dropdown-item" href="#">Something else here</a>--}}
{{--                                    <div class="dropdown-divider"></div>--}}
{{--                                    <a class="dropdown-item" href="#">Separated link</a>--}}
{{--                                </div>--}}
                            </div>
                            <div class="ul-widget__body">
                                <div class="ul-widget6">
                                    <div class="ul-widget6__head">
                                        <div class="ul-widget6__item">
                                            <span>#</span>
                                            <span>Time</span>
{{--                                            <span>Type</span>--}}
                                            <span>Amount</span>
                                        </div>
                                    </div>
                                    <div v-for="item in accepted" class="ul-widget6__body">

                                        <div class="ul-widget6__item">
                                            <span>@{{ item.id }}</span>
                                            <span>@{{ item.time }}</span>
{{--                                            <span>@{{ item.type }}</span>--}}
                                            <span class="t-font-boldest text-success">@{{ item.total }}</span>
                                        </div>
                                    </div>
{{--                                    <div class="ul-widget6-footer">--}}
{{--                                        <button type="button" class="btn btn-outline-danger m-1">--}}
{{--                                            Follow--}}
{{--                                        </button>--}}
{{--                                    </div>--}}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end::user progress -->

                <div class="col-xl-4 col-lg-4 mb-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="ul-widget__head __g-support v-margin">
                                <div class="ul-widget__head-label">
                                    <h3 class="ul-widget__head-title">
                                        Finished Orders
                                    </h3>
                                </div>
{{--                                <button type="button" class="btn bg-white _r_btn border-0" data-toggle="dropdown"--}}
{{--                                        aria-haspopup="true" aria-expanded="false">--}}
{{--                                    <span class="_dot _inline-dot bg-primary"></span>--}}
{{--                                    <span class="_dot _inline-dot bg-primary"></span>--}}
{{--                                    <span class="_dot _inline-dot bg-primary"></span>--}}
{{--                                </button>--}}
{{--                                <div class="dropdown-menu" x-placement="bottom-start"--}}
{{--                                     style="position: absolute; transform: translate3d(0px, 33px, 0px); top: 0px; left: 0px; will-change: transform;">--}}
{{--                                    <a class="dropdown-item" href="#">Action</a>--}}
{{--                                    <a class="dropdown-item" href="#">Another action</a>--}}
{{--                                    <a class="dropdown-item" href="#">Something else here</a>--}}
{{--                                    <div class="dropdown-divider"></div>--}}
{{--                                    <a class="dropdown-item" href="#">Separated link</a>--}}
{{--                                </div>--}}
                            </div>
                            <div class="ul-widget__body">
                                <div class="ul-widget6">
                                    <div class="ul-widget6__head">
                                        <div class="ul-widget6__item">
                                            <span>#</span>
                                            <span>Time</span>
                                            {{--                                            <span>Type</span>--}}
                                            <span>Amount</span>
                                        </div>
                                    </div>
                                    <div v-for="item in done" class="ul-widget6__body">

                                        <div class="ul-widget6__item">
                                            <span>@{{ item.id }}</span>
                                            <span>@{{ item.time }}</span>
                                            {{--                                            <span>@{{ item.type }}</span>--}}
                                            <span class="t-font-boldest text-success">@{{ item.total }}</span>
                                        </div>
                                    </div>
                                    {{--                                    <div class="ul-widget6-footer">--}}
                                    {{--                                        <button type="button" class="btn btn-outline-danger m-1">--}}
                                    {{--                                            Follow--}}
                                    {{--                                        </button>--}}
                                    {{--                                    </div>--}}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end::5th section -->

        </div>
    </section>
    <!-- end::widgets content -->

@endsection

@section('page-js')
    <script src="{{asset('assets/js/vendor/apexcharts.min.js')}}"></script>

    <script src="{{asset('assets/js/es5/widget-list.min.js')}}"></script>

    <script src="{{asset('assets/js/tooltip.script.js')}}"></script>



@endsection

@section('bottom-js')




@endsection
