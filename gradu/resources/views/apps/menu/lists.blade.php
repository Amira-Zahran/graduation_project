@extends('layouts.master')
@section('page-css')
<link rel="stylesheet" href="{{ asset('assets/styles/vendor/datatables.min.css') }}">

@endsection


@section('main-content')

<div class="breadcrumb">
    <h1>Dashboard</h1>
    <ul>
        <li><a href="">Menu</a></li>
        <li>Categories</li>
    </ul>
</div>
<div class="separator-breadcrumb border-top"></div>


<section class="contact-list">
    <div class="row">
            <div class="col-md-12 mb-4">
                    <div class="card text-left">
                        <div class="card-header text-right bg-transparent">
                            <button type="button" data-toggle="modal" data-target=".bd-example-modal-lg" class="btn btn-primary btn-md m-1"><i class="i-Tag-2 text-white mr-2"></i> Add Category</button>
                        </div>
                        <!-- begin::modal -->
                        <div class="ul-card-list__modal">
                                <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                          <div class="modal-content">
                                                <div class="modal-body">
                                                        <form method="POST" action="{{route('menu-category-create')}}">
                                                            @csrf
                                                                <div class="form-group row">
                                                                    <label for="inputName" class="col-sm-2 col-form-label">Name</label>
                                                                    <div class="col-sm-10">
                                                                        <input type="text" class="form-control" id="category_title" name="category_title" placeholder="Name">
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
                                            <th scope="col">#</th>
                                            <th scope="col">Category Title</th>


                                            <th scope="col">Total Items</th>
{{--                                            <th scope="col">Status</th>--}}
                                            <th scope="col">Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        @foreach($categories as $category)
                                            <tr>
                                                <th scope="row">{{$category->id}}</th>
                                                <td>{{$category->category_title}}</td>

                                                <td>{{$category->items}}</td>
                                                {{--                                            <td><span class="badge badge-success">Delivered</span></td>--}}

                                                <td>
                                                    <div class="ul-card-list__modal">
                                                        <div class="modal fade bd-example-modal-{{$category->id}}" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-lg">
                                                                <div class="modal-content">
                                                                    <div class="modal-body">
                                                                        <form method="POST" action="{{route('menu-category-update',['id'=>$category->id])}}">
                                                                            @csrf
                                                                            <div class="form-group row">
                                                                                <label for="inputName" class="col-sm-2 col-form-label">Category Name</label>
                                                                                <div class="col-sm-10">
                                                                                    <input type="text" class="form-control" id="category_title" name="category_title" value="{{$category->category_title}}" placeholder="Name">
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
                                                    <a href='' data-toggle="modal" data-target=".bd-example-modal-{{$category->id}}" data-value="{{$category}}" class="text-success mr-2">
                                                        <i class="nav-icon i-Pen-2 font-weight-bold"></i>
                                                    </a>
                                                    <a href="{{route('dropCategory',['id'=>$category->id])}}" class="text-danger mr-2">
                                                        <i class="nav-icon i-Close-Window font-weight-bold"></i>
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
