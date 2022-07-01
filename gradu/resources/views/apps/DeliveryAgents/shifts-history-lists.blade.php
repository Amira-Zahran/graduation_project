@extends('layouts.master')
@section('before-css')
    <link rel="stylesheet" href="{{asset('assets/styles/vendor/pickadate/classic.css')}}">
    <link rel="stylesheet" href="{{asset('assets/styles/vendor/pickadate/classic.date.css')}}">
@section('page-css')
    <link rel="stylesheet" href="{{ asset('assets/styles/vendor/datatables.min.css') }}">

@endsection

@section('main-content')
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
    <div class="breadcrumb">
        <h1>Dashboard</h1>
        <ul>
            <li><a href="">Delivery Agents</a></li>
            <li>Shifts History</li>
        </ul>
    </div>
    <div class="separator-breadcrumb border-top"></div>


    <section class="contact-list">
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card text-left">
                    <form method="GET" action="{{route('delivery-agents-shifts-history')}}">
                        @csrf
                        <div class="row">
                            @csrf

                            <div class="col-sm-5">
                                <div class="col-md-6 form-group mb-3">
                                    <label for="picker1">Creator</label>
                                    <select class="form-control form-control-rounded" id="user" name="user">
                                        <option value="">Select User</option>
                                        @foreach($agents as $user)
                                            <option
                                                value="{{$user->id}}" <?php if (!empty($_GET['user']) && $_GET['user'] == $user->id) {
                                                echo 'selected';
                                            }?>>{{$user->name}}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-5 form-group mb-3">
                                <label for="picker2">Created at</label>
                                <div class="input-group">
                                    <input id="picker2" class="form-control form-control-rounded"
                                           placeholder="yyyy-mm-dd" name="created_at"
                                           value="{{$_GET['created_at'] ?? ''}}">
                                    <div class="input-group-append">
                                        <button class="btn btn-secondary btn-rounded" type="button">
                                            <i class="icon-regular i-Calendar-4"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>


                        </div>
                        {{--                            <div class="row">--}}
                        <div class="card-header text-right bg-transparent">
                            <button type="submit" class="btn btn-primary btn-md m-1"><i
                                    class="i-Cash-register-2 text-white mr-2"></i>Apply Filter
                            </button>
                        </div>
                        {{--                            </div>--}}
                    </form>
                    <div class="card-body">

                        <div class="table-responsive">
                            <table id="ul-contact-list" class="display table " style="width:100%">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Shift</th>
                                    <th>Shift ID</th>
                                    <th>User</th>
                                    <th>Status</th>
                                    <th>Created At</th>
                                    <th>Closed At</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                @foreach($shifts as $shift)
                                    <tr>

                                        <td>{{$shift->id}}</td>
                                        <td>{{$shift->shift}}</td>
                                        <td>{{$shift->shift_id}}</td>
                                        <td>{{$shift->user}}</td>
                                        @if($shift->status == 'Active')
                                            <td>
                                                <a href="#" class="badge badge-primary m-2 p-2">{{$shift->status}}</a>
                                            </td>

                                        @else
                                            <td>
                                                <a href="#" class="badge badge-danger m-2 p-2">{{$shift->status}}</a>
                                            </td>
                                        @endif
                                        <td>{{$shift->created_at}}</td>
                                        <td>{{$shift->closing_date}}</td>
                                        <td>
                                            <a href="" class="ul-link-action text-success" data-toggle="modal"
                                               data-target=".bd-example-modal-{{$shift->id}}" data-placement="top"
                                               title="Activate User">
                                                <i class="i-Receipt-4"></i>
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
    <script src="{{asset('assets/js/vendor/pickadate/picker.js')}}"></script>
    <script src="{{asset('assets/js/vendor/pickadate/picker.date.js')}}"></script>
    <script src="{{ asset('assets/js/vendor/datatables.min.js') }}"></script>
    <!-- page script -->
    <script src="{{ asset('assets/js/tooltip.script.js') }}"></script>

    <script>
        $('#ul-contact-list').DataTable();
    </script>
@endsection
@section('bottom-js')
    <script src="{{asset('assets/js/form.basic.script.js')}}"></script>


@endsection
