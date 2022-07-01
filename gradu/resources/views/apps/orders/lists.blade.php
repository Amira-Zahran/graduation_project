@extends('layouts.master')
@section('before-css')
    <link rel="stylesheet" href="{{asset('assets/styles/vendor/pickadate/classic.css')}}">
    <link rel="stylesheet" href="{{asset('assets/styles/vendor/pickadate/classic.date.css')}}">
@endsection
@section('page-css')
<link rel="stylesheet" href="{{ asset('assets/styles/vendor/datatables.min.css') }}">

@endsection

@section('main-content')

<div class="breadcrumb">
    <h1>Dashboard</h1>
    <ul>
        <li><a href="">Orders</a></li>
        <li>History</li>
    </ul>
</div>
<div class="separator-breadcrumb border-top"></div>


<section class="contact-list">
    <div class="row">
            <div class="col-md-12 mb-4">
                    <div class="card text-left">
{{--                        <div class="card-header text-right bg-transparent">--}}
                            <form method="GET" action="{{route('orders-lists')}}">
                                @csrf
                                <div class="row">
                                    @csrf

                                    <div class="col-sm-5">
                                        <div class="col-md-6 form-group mb-3">
                                            <label for="picker1">Creator</label>
                                            <select class="form-control form-control-rounded" id="user" name="user">
                                                <option value="">Select User</option>
                                                @foreach($users as $user)
                                                    <option value="{{$user->id}}" <?php if(!empty($_GET['user']) && $_GET['user'] == $user->id){echo 'selected';}?>>{{$user->name}}</option>
                                                @endforeach
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-sm-5">
                                        <div class="col-md-6 form-group mb-3">
                                            <label for="picker1">Order Type</label>
                                            <select class="form-control form-control-rounded" id="type" name="type">
                                                <option value="">Select Type</option>
                                                <option value="Floor" <?php if(!empty($_GET['type']) && $_GET['type'] == "Floor"){echo 'selected';}?> >Din-In</option>
                                                <option value="TakeAway" <?php if(!empty($_GET['type']) && $_GET['type'] == "TakeAway"){echo 'selected';}?> >Take-Away</option>
                                                <option value="Delivery" <?php if(!empty($_GET['type']) && $_GET['type'] == "Delivery"){echo 'selected';}?>>Delivery</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-sm-5">
                                        <div class="col-md-6 form-group mb-3">
                                            <label for="fullName">Customer Phone Number</label>
                                            <input type="text" class="form-control form-control-rounded" value="{{$_GET['customer'] ?? ''}}" id="customer" name="customer" placeholder="Enter Customer Phone Number">
                                        </div>
                                    </div>

                                    <div class="col-md-5 form-group mb-3">
                                        <label for="picker2">Created at</label>
                                        <div class="input-group">
                                            <input id="picker2" class="form-control form-control-rounded" placeholder="yyyy-mm-dd" name="created_at" value="{{$_GET['created_at'] ?? ''}}">
                                            <div class="input-group-append">
                                                <button class="btn btn-secondary btn-rounded"  type="button">
                                                    <i class="icon-regular i-Calendar-4"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>


                                </div>
                                {{--                            <div class="row">--}}
                                <div class="card-header text-right bg-transparent">
                                    <button type="submit" class="btn btn-primary btn-md m-1"><i class="i-Cash-register-2 text-white mr-2"></i>Apply Filter</button>
                                </div>
                                {{--                            </div>--}}
                            </form>
{{--                        </div>--}}
                        <div class="card-body">

                            <div class="table-responsive">
                                <table id="ul-contact-list" class="display table " style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Shift Order ID</th>
                                            <th>Bill Number</th>
                                            <th>Type</th>
                                            <th>Status</th>
                                            <th>Sub-total</th>
                                            <th>Taxes</th>
                                            <th>Creation Time</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    @foreach($orders as $order)
                                        <tr>
                                            <td>
                                                <a href="">
                                                    <div class="ul-widget-app__profile-pic">
                                                        {{--                                                        <img class="profile-picture avatar-sm mb-2 rounded-circle img-fluid" src="{{ asset('assets/images/faces/1.jpg') }}" alt="">--}}
                                                        {{$order->id}}
                                                    </div>

                                                </a>
                                            </td>
                                            <td>{{$order->order_id}}</td>
                                            <td>{{$order->bill_number}}</td>
                                            @if($order->type == "Delivery")

                                            <td><a href="#" class="badge badge-primary m-2 p-2">Delivery</a></td>
                                            @elseif($order->type == "Floor")
                                                <td><a href="#" class="badge badge-warning m-2 p-2">Floor</a></td>
                                            @elseif(str_contains($order->type, "TakeAway"))
                                                <td><a href="#" class="badge badge-success m-2 p-2">Take-Away</a></td>
                                            @endif
                                            <td>{{$order->status}}</td>
                                            <td>{{$order->sub_total}}</td>
                                            <td>{{$order->taxes}}</td>
                                            <td>{{$order->created_at}}</td>
                                            <td>
                                                <a href="{{route('createPDF',['id'=>$order->id])}}" class="ul-link-action text-success"  data-toggle="tooltip" data-placement="top" title="Receipt">
                                                    <i class="i-Receipt-4"></i>
                                                </a>
{{--                                                <a href="" class="ul-link-action text-danger mr-1"  data-toggle="tooltip" data-placement="top" title="Want To Delete !!!">--}}
{{--                                                    <i class="i-Eraser-2"></i>--}}
{{--                                                </a>--}}
                                            </td>
                                        </tr>

                                    @endforeach

                                    </tbody>

                                </table>
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination">
{{--                                        <li class="page-item">--}}
{{--                                            <a class="page-link" href="#" tabindex="-1">Previous</a>--}}
{{--                                        </li>--}}
                                        {{$orders->links("pagination::bootstrap-4")   }}
{{--                                        @foreach($orders->links as $link)--}}
{{--                                            <li class="page-item"><a class="page-link" href="#">1</a></li>--}}

{{--                                        @endforeach--}}

{{--                                        <li class="page-item active">--}}
{{--                                            <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>--}}
{{--                                        </li>--}}

{{--                                        <li class="page-item">--}}
{{--                                            <a class="page-link" href="#">Next</a>--}}
{{--                                        </li>--}}
                                    </ul>
                                </nav>
                            </div>

                        </div>
                    </div>
                </div>
    </div>
</section>



@endsection

@section('page-js')
    <script src="{{asset('assets/js/vendor/pickadate/picker.js')}}"></script>
    <script src="{{asset('assets/js/vendor/pickadate/picker.date.js')}}"></script>

<script src="{{ asset('assets/js/vendor/datatables.min.js') }}"></script>
<!-- page script -->
<script src="{{ asset('assets/js/tooltip.script.js') }}"></script>

<script>
// $('#ul-contact-list').DataTable();
// console.log($('#ul-contact-list').DataTable().iDisplayLength)
</script>
@endsection

@section('bottom-js')
    <script src="{{asset('assets/js/form.basic.script.js')}}"></script>
@endsection
