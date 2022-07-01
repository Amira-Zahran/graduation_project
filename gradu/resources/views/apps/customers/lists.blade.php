@extends('layouts.master')
@section('page-css')
<link rel="stylesheet" href="{{ asset('assets/styles/vendor/datatables.min.css') }}">

@endsection

@section('main-content')

<div class="breadcrumb">
    <h1>Dashboard</h1>
    <ul>
        <li><a href="">Customers</a></li>
        <li>All Customers</li>
    </ul>
</div>
<div class="separator-breadcrumb border-top"></div>


<section class="contact-list">
    <div class="row">
            <div class="col-md-12 mb-4">
                    <div class="card text-left">
                        <div class="card-header text-right bg-transparent">
                            <button type="button" data-toggle="modal" data-target=".bd-example-modal-lg" class="btn btn-primary btn-md m-1"><i class="i-Add-User text-white mr-2"></i> Add Contact</button>
                        </div>
                        <!-- begin::modal -->
                        <div class="ul-card-list__modal">
                                <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                          <div class="modal-content">
                                                <div class="modal-body">
                                                        <form method="POST" action="{{route('customer-new')}}">
                                                            @csrf
                                                                <div class="form-group row">
                                                                    <label for="inputName" class="col-sm-2 col-form-label">Name</label>
                                                                    <div class="col-sm-10">
                                                                        <input type="text" class="form-control" id="inputName" name="name" placeholder="Name">
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label for="" class="col-sm-2 col-form-label">Phone</label>
                                                                    <div class="col-sm-10">
                                                                        <input type="number" class="form-control" id="" name="phone_number" placeholder="number....">
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label for="" class="col-sm-2 col-form-label">Address</label>
                                                                    <div class="col-sm-10">
                                                                        <input type="text" class="form-control" id="" name="address" placeholder="number....">
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label for="" class="col-sm-2 col-form-label">Area</label>
                                                                    <div class="col-sm-10">
                                                                        <input type="text" class="form-control" id="" name="area" placeholder="number....">
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label for="" class="col-sm-2 col-form-label">Building</label>
                                                                    <div class="col-sm-10">
                                                                        <input type="text" class="form-control" id="" name="building" placeholder="number....">
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label for="" class="col-sm-2 col-form-label">Floor</label>
                                                                    <div class="col-sm-10">
                                                                        <input type="number" class="form-control" id="" name="floor" placeholder="number....">
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label for="" class="col-sm-2 col-form-label">Apartment Number</label>
                                                                    <div class="col-sm-10">
                                                                        <input type="number" class="form-control" id="" name="apart_num" placeholder="number....">
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <div class="col-sm-10">

                                                                        <button type="submit" class="btn btn-success">Submit</button>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                </div>
                                          </div>
                                        </div>
                                      </div>
                        </div>
                        <!-- end::modal -->

                        <div class="card-body">
                            @if(session('success'))
                                <div class="alert alert-card alert-success" role="alert">
                                    <strong class="text-capitalize">Success!</strong> {{session('success')}}.
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            @elseif(session('error'))
                                <div class="alert alert-card alert-danger" role="alert">
                                    <strong class="text-capitalize">Error!</strong> {{session('error')}}.
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            @endif
                            <div class="table-responsive">
                                <table id="ul-contact-list" class="display table " style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Phone</th>


                                            <th>Joining Date</th>
                                            <th>Total Orders</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    @foreach($customer_info as $customer)
                                        <tr>
                                            <td>
{{--                                                <a href="">--}}
{{--                                                    <div class="ul-widget-app__profile-pic">--}}
{{--                                                        <img class="profile-picture avatar-sm mb-2 rounded-circle img-fluid" src="{{ asset('assets/images/faces/1.jpg') }}" alt="">--}}
                                                        {{ $customer['name'] }}
{{--                                                    </div>--}}

{{--                                                </a>--}}
                                            </td>

                                            <td>{{$customer['phones'][0]->phone_number}}</td>


                                            <td>{{$customer['created_at']}}</td>
                                            <td>{{$customer['total_orders']}}</td>
                                            <td>
                                                <a href="" class="ul-link-action text-success"  data-toggle="tooltip" data-placement="top" title="Edit">
                                                    <i class="i-Information"></i>
                                                </a>
                                                <a href="{{route('customer-delete',['id'=>$customer['id']])}}" class="ul-link-action text-danger mr-1"  data-toggle="tooltip" data-placement="top" title="Want To Delete !!!">
                                                    <i class="i-Eraser-2"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    @endforeach

                                    </tbody>

                                </table>
                            </div>

                        </div>
                    </div>
                </div>
    </div>
</section>



@endsection

@section('page-js')


<script src="{{ asset('assets/js/vendor/datatables.min.js') }}"></script>
<!-- page script -->
<script src="{{ asset('assets/js/tooltip.script.js') }}"></script>

<script>
$('#ul-contact-list').DataTable();
</script>
@endsection
