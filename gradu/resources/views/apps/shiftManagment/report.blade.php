<html dir='ltr'>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<head>

</head>

<style>

    @font-face {
        font-family: Tajawal-Light;
        src: url('{{ Request()->root().'/fonts/tajawal/Tajawal-Light.ttf' }}');
    }

    @font-face {
        font-family: Tajawal-Medium;
        src: url('{{ Request()->root().'/fonts/tajawal/Tajawal-Medium.ttf' }}');
    }

    #invoice-POS{

        position: relative;
        background: #FFF;}
    body{
        position: relative;
    }
    h1{
        font-size: 1.5em;
        color: #222;
    }
    h2{font-size: .9em;}
    h3{
        font-size: 1.2em;
        font-weight: 300;
        line-height: 2em;
    }
    p{
        font-size: .7em;
        color: #000000;
        line-height: 1.2em;
    }

    #top, #mid,#bot{ /* Targets all id with 'col-' */
        border-bottom: 1px solid #EEE;
    }

    //#top{min-height: 100px;}
    //#mid{min-height: 80px;}
    //#bot{ min-height: 50px;}

    #top .logo{
    //float: left;
        height: 120px;
        width: 200px;
        background: url({{ config('global.site_logo') }}) no-repeat;
        background-size: 200px 120px;

    }
    #top .hotLine{
    //float: left;
        height: 70px;
        width: 200px;
        background: url({{ config('global.hotLine') }}) no-repeat;
        background-size: 200px 55px;

    }
    .info{
        display: block;
        direction: ltr;
        /*//float:right;*/
        font-size: 1.5em;
        font-weight: 600;
        color: #000000;
        margin-left: 0;
    }
    .title{
        float: right;
    }
    .title p{text-align: right;}
    table{
        width: 100%;
        border-collapse: collapse;
    }
    td{
    //padding: 5px 0 5px 15px;
    //border: 1px solid #EEE
    }
    .tabletitle{
    //padding: 5px;
        font-size: .8em;
        background: #EEE;
    }
    .service{border-bottom: 1px solid #EEE;}
    .item{width: 24mm;}
    .itemtext{font-size: .95em;color: #222}

    #legalcopy{
        margin-top: 5mm;
    }

    #___________bh {
        /*position: absolute;*/
        /*left: 72px;*/
        /*top: 653px;*/
        /*overflow: visible;*/
        /*width: 99px;*/
        /*white-space: nowrap;*/
        text-align: center;
        font-family: Tajawal-Medium;
        font-style: normal;
        font-weight: normal;
        font-size: 25px;
        color: rgba(0,0,0,1);
    }

    #ID15096 {
        /*position: absolute;*/
        /*left: 105px;*/
        /*top: 685px;*/
        /*overflow: visible;*/
        /*width: 63px;*/
        white-space: nowrap;
        text-align: center;
        font-family: Tajawal-Medium;
        font-style: normal;
        font-weight: normal;
        font-size: 25px;
        color: rgba(0,0,0,1);
    }

    #copy {
        position: absolute;
        width: 170px;
        height: 422px;
        font-family: Tajawal-Light;
        left: 51px;
        top: 205px;
        overflow: visible;
    }
    #copy_h {
        position: absolute;
        left: 63px;
        top: 349px;
        font-family: Tajawal-Light;
        overflow: visible;
        width: 46px;
        white-space: nowrap;
        line-height: 399px;
        margin-top: -189.5px;
        text-align: center;

        font-style: normal;
        font-weight: bold;
        font-size: 20px;
        color: rgba(0, 0, 0, 0.5);
    }
    #ID2 {
        position: center;
        /*left: 0px;*/
        /*top: 0px;*/
        /*overflow: visible;*/
        /*width: 171px;*/
        white-space: nowrap;
        /*line-height: 399px;*/
        /*margin-top: -41px;*/
        text-align: center;
        font-family: Segoe UI;
        font-style: normal;
        font-weight: normal;
        font-size: 200px;
        color: rgba(219,219,219,1);
    }

    p {
        margin-top: 0em;
        margin-bottom: 0em;

    }
    .shadow {
        background-color: #bcbcbc;
    }

    .bigger-font{
        font-size: 1.05rem;
        font-weight: bolder;
    }
    .space-between{
        justify-content: space-between
    }


    body { font-family: DejaVu Sans, sans-serif; }

</style>

<div id="invoice-POS">

    <center id="top">
        <div class="logo"></div>
        <div class="info">

        </div><!--End Info-->
    </center><!--End InvoiceTop-->

    <div id="mid">
        <div class="info">
            <h2>Report</h2>
            {{--            <p>--}}
{{--            <p class="shadow "> # :    {{$order['id'] }}</p>--}}
            <p class="shadow ">Shift ID :    {{$shiftData['shift']->id}}</p>
            <p>Shift Serial : {{$shiftData['shift']->shift_id}}</p>
            <p class="shadow ">type : {{$shiftData['type']}}</p>
            <p >Created At : {{$shiftData['shift']->created_at}}</p>
            <p class="shadow ">Closed At : {{$shiftData['shift']->closing_date}}</p>
            <p >Agent : {{$shiftData['user']->name}}</p>
        </div>
    </div><!--End Invoice Mid-->
    <div>
        <br>
    </div>
    <div id="bot">

        <div id="table">
            <table>
                <tr class="tabletitle">
                    <td class="item"><h2>#</h2></td>
                    <td class="Hours"><h2>item</h2></td>
                    <td class="item"><h2>quantity</h2></td>
                    <td class="Rate"><h2>total price</h2></td>
                </tr>
                @foreach($shiftData['items'] as $item)
                    <tr class="service">
                        <td class="tableitem"><p class="itemtext">{{$item->item_id}}</p></td>
                        <td class="tableitem"><p class="itemtext">{{$item->item_name}}</p></td>
                        <td class="tableitem"><p class="itemtext">{{$item->quantity}}</p></td>
                        <td class="tableitem"><p class="itemtext">{{$item->total_price}}</p></td>
                    </tr>
                @endforeach



                <tr class="tabletitle">
                    <td></td>
                    <td class="Rate"><h2>Total Items Sales</h2></td>
                    <td class="Rate"><h2></h2></td>
                    <td class="payment"><h2>{{$shiftData['totalItemsSales']}}</h2></td>
                </tr>

                {{--                                <tr class="tabletitle" dir="ltr">--}}
                {{--                                    <td></td>--}}
                {{--                                    <td class="Rate"><h2>الخصم</h2></td>--}}
                {{--                                    <td class="payment" dir="ltr"><h2>{{$order['discount']}}</h2></td>--}}
                {{--                                </tr>--}}

                {{--                <tr class="tabletitle">--}}
                {{--                    <td></td>--}}
                {{--                    <td class="Rate"><h2>خدمة التوصيل</h2></td>--}}
                {{--                    <td class="payment"><h2>{{$order['delivery']}}</h2></td>--}}
                {{--                </tr>--}}

{{--                <tr class="tabletitle" dir="ltr">--}}
{{--                    <td></td>--}}
{{--                    <td class="Rate"><h2>taxes</h2></td>--}}
{{--                    <td class="payment" dir="ltr"><h2>{{$order['taxes']}}</h2></td>--}}
{{--                </tr>                <tr class="tabletitle" dir="ltr">--}}
                    <td></td>
                    <td class="Rate"><h2>Total Orders Sales</h2></td>
                    <td class="Rate"><h2></h2></td>
                    <td class="payment" dir="ltr"><h2>{{$shiftData['totalOrdersSales']}}</h2></td>
                </tr>

            </table>
        </div><!--End Table-->

{{--        <div id="legalcopy">--}}
{{--            <center id="top">--}}
{{--                <div class="hotLine"></div>--}}
{{--                <div class="info">--}}

{{--                </div><!--End Info-->--}}
{{--            </center>--}}

{{--            <div style="text-align: center;" id="legal">--}}
{{--                <strong >{{config('global.settings')->facebook}}</strong>--}}

{{--                <img  style="margin-bottom: -7px;" src="https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-clipart-image-black-facebook-logo-png-transparentpng-13.png" width="25" height="25" alt="">--}}


{{--            </div>--}}


{{--            <div id="copy_h">--}}
{{--                <span>{{$order['prints']}}</span>--}}
{{--            </div>--}}

        </div>

    </div><!--End InvoiceBot-->

</div><!--End Invoice-->

</html>
