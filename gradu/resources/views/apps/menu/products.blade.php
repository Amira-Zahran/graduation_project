@extends('layouts.master')
@section('page-css')


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
        <li><a href="">Menu</a></li>
        <li>Items</li>
    </ul>
</div>

<div class="separator-breadcrumb border-top"></div>


<div class="card-header text-right bg-transparent">
    <button type="button" data-toggle="modal" data-target=".bd-example-modal-lg" class="btn btn-primary btn-md m-1"><i class="i-Shop-2 text-white mr-2"></i> Add Item</button>
</div>

<section class="product-cart">
    <div class="row list-grid">

        <div class="ul-card-list__modal">
            <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-body">
                            <form method="POST" action="{{route('menu-item-create')}}" enctype="multipart/form-data">
                                @csrf
                                <div class="form-group row">
                                    <label for="inputName" class="col-sm-2 col-form-label">Item Name</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="item_name" name="item_name" placeholder="Name">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="inputName" class="col-sm-2 col-form-label">Item Price</label>
                                    <div class="col-sm-10">
                                        <input type="number" class="form-control" id="item_price" name="item_price"  placeholder="item price">
                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label for="inputName" class="col-sm-2 col-form-label">Category</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" id="category" name="category" required>
                                            <option disabled>Select Category</option>
                                            @foreach($items['categories'] as $category)
                                                <option value="{{$category->id}}" >{{$category->category_title}}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="inputName" class="col-sm-2 col-form-label">Ready By Default</label>
                                    <div class="col-sm-10">
                                        <label class="checkbox checkbox-primary">
                                            <input name="readyState" type="checkbox"  >
                                            {{--                                                                <span>Ready By Default</span>--}}
                                            <span class="checkmark"></span>
                                        </label>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="inputName" class="col-sm-2 col-form-label">Show in Menu</label>
                                    <div class="col-sm-10">
                                        <label class="checkbox checkbox-primary">
                                            <input name="active" type="checkbox" checked>
                                            {{--                                                                <span>Ready By Default</span>--}}
                                            <span class="checkmark"></span>
                                        </label>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="inputName" class="col-sm-2 col-form-label">Item Image</label>
                                    <div class="col-sm-10">
                                        {{--                                                            <button id="button-select" class="btn btn-primary mb-1">select files</button>--}}
                                        <input name="item_image" type="file" accept="image/*" />
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

        @foreach($items['items'] as $item)
            <div class="ul-card-list__modal">
                <div class="modal fade bd-example-modal-{{$item->id}}" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-body">
                                <form method="POST" action="{{route('menu-item-update',['id'=>$item->id])}}" enctype="multipart/form-data">
                                    @csrf
                                    <div class="form-group row">
                                        <label for="inputName" class="col-sm-2 col-form-label">Item Name</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="item_name" name="item_name" value="{{$item->item_name}}" placeholder="Name">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="inputName" class="col-sm-2 col-form-label">Item Price</label>
                                        <div class="col-sm-10">
                                            <input type="number" class="form-control" id="item_price" name="item_price" value="{{$item->item_price}}" placeholder="item price">
                                        </div>
                                    </div>


                                    <div class="form-group row">
                                        <label for="inputName" class="col-sm-2 col-form-label">Category</label>
                                        <div class="col-sm-10">
                                            <select class="form-control" id="category" name="category" required>
                                                <option disabled>Select Category</option>
                                                @foreach($items['categories'] as $category)
                                                    <option value="{{$category->id}}" <?php if ($item->category->id == $category->id) {
                                                        echo 'selected';
                                                    } ?> >{{$category->category_title}}</option>
                                                @endforeach
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="inputName" class="col-sm-2 col-form-label">Ready By Default</label>
                                        <div class="col-sm-10">
                                            <label class="checkbox checkbox-primary">
                                                <input name="readyState" type="checkbox" <?php if($item->readyState == 1){ echo "checked";}?> >
                                                {{--                                                                <span>Ready By Default</span>--}}
                                                <span class="checkmark"></span>
                                            </label>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="inputName" class="col-sm-2 col-form-label">Show in Menu</label>
                                        <div class="col-sm-10">
                                            <label class="checkbox checkbox-primary">
                                                <input name="active" type="checkbox" <?php if($item->active == 1){ echo "checked";}?> >
                                                {{--                                                                <span>Ready By Default</span>--}}
                                                <span class="checkmark"></span>
                                            </label>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="inputName" class="col-sm-2 col-form-label">Item Image</label>

{{--                                        <div class="list-thumb ">--}}
{{--                                            <img alt="" src="{{ $item->item_photo }}" />--}}
{{--                                        </div>--}}
                                        <div class="col-sm-10">
                                            {{--                                                            <button id="button-select" class="btn btn-primary mb-1">select files</button>--}}
                                            <input name="item_image" type="file" accept="image/*" />
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

            <div class="list-item col-md-3">
                <div class="card o-hidden mb-4 d-flex flex-column">
                    <div class="list-thumb d-flex">
                        <img alt="" src="{{ $item->item_photo }}" data-toggle="modal" data-target=".bd-example-modal-{{$item->id}}" href="" />
                    </div>
                    <div class="flex-grow-1 d-bock">
                        <div
                            class="card-body align-self-center d-flex flex-column justify-content-between align-items-lg-center">







                            <a class="w-40 w-sm-100" data-toggle="modal" data-target=".bd-example-modal-{{$item->id}}" href="">

                                <div class="item-title">
                                    {{$item->item_name }}
                                </div>
                            </a>
                            <p class="m-0 text-muted text-small w-15 w-sm-100">
                                @if($item->active == 1)
                                    Item is Show-able in POS Menu
                                @else
                                    Item is NOT Show-able in POS Menu
                                @endif
                            </p>
                            <p class="m-0 text-muted text-small w-15 w-sm-100">
                                E£{{$item->item_price }}
{{--                                <del class="text-secondary">$54.00</del>--}}
                            </p>
                            <p class="m-0 text-muted text-small w-15 w-sm-100 d-none d-lg-block item-badges">
                                <span class="badge badge-info">{{$item->category->category_title}}</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        @endforeach


{{--        <div class="col-md-12 mt-3  ">--}}
{{--            <nav aria-label="Page navigation example">--}}
{{--                <ul class="pagination">--}}
{{--                    <li class="page-item">--}}
{{--                        <a class="page-link" href="#">Previous</a>--}}
{{--                    </li>--}}
{{--                    <li class="page-item">--}}
{{--                        <a class="page-link" href="#">1</a>--}}
{{--                    </li>--}}
{{--                    <li class="page-item">--}}
{{--                        <a class="page-link" href="#">2</a>--}}
{{--                    </li>--}}
{{--                    <li class="page-item">--}}
{{--                        <a class="page-link" href="#">3</a>--}}
{{--                    </li>--}}
{{--                    <li class="page-item">--}}
{{--                        <a class="page-link" href="#">Next</a>--}}
{{--                    </li>--}}
{{--                </ul>--}}
{{--            </nav>--}}
{{--        </div>--}}
    </div>
</section>




@endsection

@section('page-js')



@endsection
