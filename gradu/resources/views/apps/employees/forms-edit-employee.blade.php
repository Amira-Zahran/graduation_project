@extends('layouts.master')
@section('before-css')
 <link rel="stylesheet" href="{{asset('assets/styles/vendor/pickadate/classic.css')}}">
 <link rel="stylesheet" href="{{asset('assets/styles/vendor/pickadate/classic.date.css')}}">


@endsection

@section('main-content')
   <div class="breadcrumb">
                <h1>Dashboard</h1>
                <ul>
                    <li><a href="{{route('employees-lists')}}">Employees</a></li>
                    <li>Edit {{$user->name}}</li>
                </ul>
            </div>

            <div class="separator-breadcrumb border-top"></div>

            <div class="row">

                <div class="col-md-12">
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="card-title mb-3">Basic Info</div>
                            <form action="{{route('employee-update',['id'=>$user->id])}}" method="POST">
                                @if(session('error'))
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        {{ session('error') }}
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                @endif
                                @csrf
                                <div class="row">
                                    <div class="col-md-6 form-group mb-3">
                                        <label for="fullName">Full name</label>
                                        <input type="text" class="form-control form-control-rounded" value="{{$user->name}}" id="fullName" name="fullName" placeholder="Enter Employee Full name" required>
                                    </div>

                                    <div class="col-md-6 form-group mb-3">
                                        <label for="email">Email address/User Name</label>
                                        <input type="text" class="form-control form-control-rounded" value="{{$user->email}}" id="email" name="email" placeholder="Enter email or User Name" valid required>
                                    </div>

                                    <div class="col-md-6 form-group mb-3">
                                        <label for="cardID">Employee RFID Card Number</label>
                                        <input class="form-control form-control-rounded" value="{{$user->card_id}}" id="cardID" name="cardID" placeholder="Enter RFID Card Number" required>
                                    </div>

                                    <div class="col-md-6 form-group mb-3">
                                        <label for="password">Password</label>
                                        <input type='password' class="form-control form-control-rounded" id="password" name="password" placeholder="Password">
                                    </div>

                                    <div class="col-md-6 form-group mb-3">
                                        <label for="picker1">User Role</label>
                                        <select class="form-control form-control-rounded" id="type" name="type" required>
                                            <option >Select User Role</option>
                                            <option value="MasterAdmin" <?php if ($user->type == "MasterAdmin") {
                                                echo 'selected';
                                            } ?> >Master Admin</option>
                                            <option value="Admin" <?php if ($user->type == "Admin") {
                                                echo 'selected';
                                            } ?>>Admin</option>
                                            <option value="CallCenterAgent" <?php if( $user->type == "CallCenterAgent") {
                                                echo 'selected';
                                            } ?>>Call Center Agent</option>
                                            <option value="Cashier" <?php if ($user->type == "Cashier")  {
                                                echo 'selected';
                                            } ?>>Cashier</option>
                                            <option value="Dispatcher" <?php if ($user->type == "Dispatcher")  {
                                                echo 'selected';
                                            } ?>>Dispatcher</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6 form-group mb-3">
                                        <label for="picker1">Branch</label>
                                        <select class="form-control form-control-rounded" id="branch" name="branch" required>
                                            <option disabled>Select Branch</option>
                                            @foreach(DB::table('branches')->select('*')->get() as $branch)
                                                <option value="{{$branch->id}}" <?php if ($user->branch == $branch->id) {
                                                    echo 'selected';
                                                } ?> >{{$branch->name}}</option>
                                            @endforeach
                                        </select>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="card mb-4">
                                            <div class="card-body">
                                                <div class="card-title">Permissions</div>
                                                <label class="switch switch-primary mr-3">
                                                    <span>Print Reports</span>
                                                    <input type="checkbox" id="Reports" name="Reports" <?php if(!empty($user->Reports)){ echo "checked";} ?>>
                                                    <span class="slider"></span>
                                                </label>
                                                <label class="switch switch-danger mr-3">
                                                    <span>Delete Orders</span>
                                                    <input type="checkbox" id="Delete" name="Delete" <?php if(!empty($user->Delete)){ echo "checked";} ?>>
                                                    <span class="slider"></span>
                                                </label>
                                                <label class="switch switch-success mr-3">
                                                    <span>Edit Orders</span>
                                                    <input type="checkbox" id="Edit" name="Edit" <?php if(!empty($user->Edit)){ echo "checked";} ?>>
                                                    <span class="slider"></span>
                                                </label>
{{--                                                <label class="switch switch-warning mr-3">--}}
{{--                                                    <span>Create Users</span>--}}
{{--                                                    <input type="checkbox" checked>--}}
{{--                                                    <span class="slider"></span>--}}
{{--                                                </label>--}}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                         <button class="btn btn-primary">Submit</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>


            </div>


@endsection

@section('page-js')
<script src="{{asset('assets/js/vendor/pickadate/picker.js')}}"></script>
<script src="{{asset('assets/js/vendor/pickadate/picker.date.js')}}"></script>



@endsection

@section('bottom-js')
<script src="{{asset('assets/js/form.basic.script.js')}}"></script>


@endsection
