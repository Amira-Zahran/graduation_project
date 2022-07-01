@extends('layouts.master')
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
        <li>Agents List</li>
    </ul>
</div>
<div class="separator-breadcrumb border-top"></div>


<section class="contact-list">
    <div class="row">
            <div class="col-md-12 mb-4">
                    <div class="card text-left">
                        <div class="card-header text-right bg-transparent">
                            <button type="button" data-toggle="modal" data-target=".bd-example-modal-lg" class="btn btn-primary btn-md m-1"><i class="i-Add-User text-white mr-2"></i> Add Agent</button>
                        </div>
                        <!-- begin::modal -->
                        <div class="ul-card-list__modal">
                            <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            <form method="POST" action="{{route('delivery-agents-new-agent')}}">
                                                @csrf
                                                <div class="form-group row">
                                                    <label for="name" class="col-sm-2 col-form-label">Name</label>
                                                    <div class="col-sm-10">
                                                        <input type="text" class="form-control" id="name" name="name" placeholder="Name" required>
                                                    </div>
                                                </div>

                                                <div class="form-group row">
                                                    <label for="phone_number" class="col-sm-2 col-form-label">Phone Number</label>
                                                    <div class="col-sm-10">
                                                        <input type="number" class="form-control" id="phone_number" name="phone_number" placeholder="Phone Number" required>
                                                    </div>
                                                </div>

                                                <div class="form-group row">
                                                    <label for="branch" class="col-sm-2 col-form-label">Branch</label>
                                                    <div class="col-sm-10">
                                                        <select class="form-control" id="branch" name="branch" required>
                                                            <option value="">Select Branch</option>
                                                            @foreach(DB::table('branches')->get() as $branch)
                                                                <option value="{{$branch->id}}" >{{$branch->name}}</option>
                                                            @endforeach
                                                        </select>
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


                            <div class="table-responsive">
                                <table id="ul-contact-list" class="display table " style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Name</th>
                                            <th>Phone Number</th>
                                            <th>Branch</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach($agents as $agent)
                                            <div class="ul-card-list__modal">
                                                <div class="modal fade bd-example-modal-{{$agent->id}}" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-lg">
                                                        <div class="modal-content">
                                                            <div class="modal-body">
                                                                <form method="POST" action="{{route('delivery-agents-update-agent',['id'=>$agent->id])}}">
                                                                    @csrf
                                                                    <div class="form-group row">
                                                                        <label for="name" class="col-sm-2 col-form-label">Name</label>
                                                                        <div class="col-sm-10">
                                                                            <input type="text" class="form-control" id="name" name="name" placeholder="Name" value="{{$agent->name}}" required>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group row">
                                                                        <label for="phone_number" class="col-sm-2 col-form-label">Phone Number</label>
                                                                        <div class="col-sm-10">
                                                                            <input type="number" class="form-control" id="phone_number" name="phone_number" placeholder="Phone Number" value="{{$agent->phone_number}}" required>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group row">
                                                                        <label for="branch" class="col-sm-2 col-form-label">Branch</label>
                                                                        <div class="col-sm-10">
                                                                            <select class="form-control" id="branch" name="branch" required>
                                                                                <option value="">Select Branch</option>
                                                                                @foreach(DB::table('branches')->get() as $branch)
                                                                                    <option value="{{$branch->id}}" <?php if($agent->branch == $branch->id){ echo "selected";} ?> >{{$branch->name}}</option>
                                                                                @endforeach
                                                                            </select>
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
                                            <tr>

                                            <td>{{$agent->id}}</td>
                                            <td>{{$agent->name}}</td>
                                            <td>{{$agent->phone_number}}</td>
                                            <td>{{$agent->branch}}</td>
                                                @if($agent->status == 'Active')
                                            <td><a href="#" class="badge badge-primary m-2 p-2">{{$agent->status}}</a></td>
                                                    <td>
                                                        <a href="" class="ul-link-action text-success"  data-toggle="modal" data-target=".bd-example-modal-{{$agent->id}}" data-placement="top" title="Activate User">
                                                            <i class="i-Edit"></i>
                                                        </a>
                                                        <a href="{{route('delivery-agents-suspend',['id'=>$agent->id])}}" class="ul-link-action text-danger mr-1"  data-toggle="tooltip" data-placement="top" title="Want To Suspend Agent !!!">
                                                            <i class="i-Pause-2"></i>
                                                        </a>
                                                    </td>
                                                @else
                                            <td><a href="#" class="badge badge-danger m-2 p-2">{{$agent->status}}</a></td>
                                                    <td>
                                                        <a href="" class="ul-link-action text-success"  data-toggle="modal" data-target=".bd-example-modal-{{$agent->id}}" data-placement="top" title="Activate User">
                                                            <i class="i-Edit"></i>
                                                        </a>
                                                        <a href="{{route('delivery-agents-activate',['id'=>$agent->id])}}" class="ul-link-action text-success"  data-toggle="tooltip" data-placement="top" title="Activate User">
                                                            <i class="i-Play-Music"></i>
                                                        </a>
                                                    </td>
                                                @endif

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
