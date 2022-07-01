@extends('layouts.master')
@section('page-css')
    <link rel="stylesheet" href="{{ asset('assets/styles/vendor/datatables.min.css') }}">

@endsection

@section('main-content')

    <div class="breadcrumb">
        <h1>Dashboard</h1>
        <ul>
            <li><a href="">Employees</a></li>
            <li>All Employees</li>
        </ul>
    </div>
    <div class="separator-breadcrumb border-top"></div>


    <section class="contact-list">
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card text-left">
                    <div class="card-header text-right bg-transparent">
                        {{--                            <button type="button" data-toggle="modal" data-target=".bd-example-modal-lg" class="btn btn-primary btn-md m-1"><i class="i-Add-User text-white mr-2"></i>Add Employee</button>--}}
                        <button type="button" href="{{route('employee-create')}}"
                                onclick="window.location='{{route('employee-create')}}'"
                                class="btn btn-primary btn-md m-1"><i class="i-Add-User text-white mr-2"></i>Add
                            Employee
                        </button>
                    </div>
                    <!-- begin::modal -->
                    <div class="ul-card-list__modal">
                        <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog"
                             aria-labelledby="myLargeModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-body">
                                        <form>
                                            <div class="form-group row">
                                                <label for="inputName" class="col-sm-2 col-form-label">Name</label>
                                                <div class="col-sm-10">
                                                    <input type="email" class="form-control" id="inputName"
                                                           placeholder="Name">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="inputEmail3" class="col-sm-2 col-form-label">Email</label>
                                                <div class="col-sm-10">
                                                    <input type="email" class="form-control" id="inputEmail3"
                                                           placeholder="Email">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="" class="col-sm-2 col-form-label">Phone</label>
                                                <div class="col-sm-10">
                                                    <input type="number" class="form-control" id=""
                                                           placeholder="number....">
                                                </div>
                                            </div>
                                            <fieldset class="form-group">
                                                <div class="row">
                                                    <div class="col-form-label col-sm-2 pt-0">Radios</div>
                                                    <div class="col-sm-10">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio"
                                                                   name="gridRadios" id="gridRadios1" value="option1"
                                                                   checked="">
                                                            <label class="form-check-label ml-3" for="gridRadios1">
                                                                First radio
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio"
                                                                   name="gridRadios" id="gridRadios2" value="option2">
                                                            <label class="form-check-label ml-3" for="gridRadios2">
                                                                Second radio
                                                            </label>
                                                        </div>
                                                        <div class="form-check disabled ">
                                                            <input class="form-check-input" type="radio"
                                                                   name="gridRadios" id="gridRadios3" value="option3"
                                                                   disabled="">
                                                            <label class="form-check-label ml-3" for="gridRadios3">
                                                                Third disabled radio
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>
                                            <div class="form-group row">
                                                <div class="col-sm-2">Checkbox</div>
                                                <div class="col-sm-10">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" id="gridCheck1">
                                                        <label class="form-check-label ml-3" for="gridCheck1">
                                                            Example checkbox
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="col-sm-10">

                                                    <button type="submit" class="btn btn-success">Update</button>
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
                        @endif
                        <div class="table-responsive">
                            <table id="ul-contact-list" class="display table " style="width:100%">
                                <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Branch</th>
                                    <th>Role</th>
                                    <th>Card ID</th>
                                    <th>Employee ID</th>
                                    <th>Joining Date</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                @foreach($allUsers as $user)
                                    <tr>
                                        <td>
                                            <a href="">
                                                <div class="ul-widget-app__profile-pic">
                                                    <img class="profile-picture avatar-sm mb-2 rounded-circle img-fluid"
                                                         src="{{ asset('assets/images/faces/10.jpg') }}" alt="">
                                                    {{$user->name}}
                                                </div>

                                            </a>
                                        </td>
                                        <td>{{$user->email}}</td>
                                        <td>{{$user->branch}}</td>
                                        @if($user->type == 'CallCenterAgent')
                                            <td><a href="#" class="badge badge-primary m-2 p-2">{{$user->type}}</a></td>
                                        @elseif($user->type == 'Cashier')
                                            <td><a href="#" class="badge badge-warning m-2 p-2">{{$user->type}}</a></td>
                                        @elseif(str_contains($user->type, 'Admin'))
                                            <td><a href="#" class="badge badge-danger m-2 p-2">{{$user->type}}</a></td>
                                        @elseif($user->type == 'Dispatcher')
                                            <td><a href="#" class="badge badge-success m-2 p-2">{{$user->type}}</a></td>
                                        @else
                                            <td><a href="#" class="badge badge-info m-2 p-2">{{$user->type}}</a></td>
                                        @endif
                                        <td>{{$user->card_id}}</td>
                                        <td>{{$user->id}}</td>
                                        <td>{{$user->created_at}}</td>
                                        <td>
                                            <a href="{{route('employee-edit',['id'=>$user->id])}}}" class="ul-link-action text-success" data-toggle="tooltip"
                                               data-placement="top" title="Edit">
                                                <i class="i-Edit"></i>
                                            </a>
                                            @if($user->status == 'Active')
                                                <a href="{{route('changeStatus',['status'=>'Disabled','id'=>$user->id])}}"
                                                   class="ul-link-action text-danger mr-1" data-toggle="tooltip"
                                                   data-placement="top" title="Want To Disable !!!">
                                                    <i class="i-Security-Block"></i>
                                                </a>
                                            @else
                                                <a href="{{route('changeStatus',['status'=>'Active','id'=>$user->id])}}"
                                                   class="ul-link-action text-success mr-1" data-toggle="tooltip"
                                                   data-placement="top" title="Want To Enable !!!">
                                                    <i class="i-Start-2"></i>
                                                </a>
                                            @endif

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
