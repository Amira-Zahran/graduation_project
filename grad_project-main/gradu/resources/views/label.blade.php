<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<head>
</head>
<style id="applicationStylesheet" type="text/css">
    .mediaViewInfo {
        --web-view-name: custom – 1;
        --web-view-id: custom___1;
        --web-scale-on-resize: true;
        --web-enable-deep-linking: true;
    }
    :root {
        --web-view-ids: custom___1;
    }
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        border: none;
    }

    @font-face {
        font-family: Tajawal;
        src: url('{{ Request()->root().'/fonts/tajawal/Tajawal-Medium.ttf' }}');
    }

    #custom___1 {
        position: absolute;
        width: 180.842px;
        height: 103.49px;
        background-color: rgba(255,255,255,1);
        overflow: hidden;
        --web-view-name: custom – 1;
        --web-view-id: custom___1;
        --web-scale-on-resize: true;
        --web-enable-deep-linking: true;
    }
    #Date {
        position: absolute;
        left: 5px;
        top: 2px;
        overflow: visible;
        width: 102px;
        white-space: nowrap;
        text-align: left;
        font-family: Segoe UI;
        font-style: normal;
        font-weight: bold;
        font-size: 13px;
        color: rgba(0,0,0,1);
    }
    #Order_ID {
        position: absolute;
        left: 5px;
        top: 25px;
        overflow: visible;
        width: 46px;
        white-space: nowrap;
        text-align: left;
        font-family: Tajawal;
        font-style: normal;
        font-weight: bold;
        font-size: 13px;
        color: rgba(0,0,0,1);
    }
    #type {
        position: absolute;
        left: 79px;
        top: 25px;
        overflow: visible;
        width: 28px;
        white-space: nowrap;
        text-align: left;
        font-family: Tajawal;
        font-style: normal;
        font-weight: bold;
        font-size: 13px;
        color: rgba(0,0,0,1);
    }
    #title {
        position: absolute;
        left: 10px;
        top: 47px;
        overflow: visible;
    //width: 75px;
    //white-space: nowrap;
    //text-align: right;
        font-family: Tajawal;
        font-style: normal;
        font-weight: bold;
        font-size: 13px;
        color: rgba(0,0,0,1);
    }
    #comment {
        position: absolute;
        left: 10px;
        top: 65px;
        overflow: visible;
    //width: 140px;
    //white-space: nowrap;
        text-align: right;
        font-family: Tajawal;
        font-style: normal;
        font-weight: bold;
        font-size: 13px;
        color: rgba(0,0,0,1);
    }
    #logo {
        opacity: 0.05;
        filter: drop-shadow(0px 3px 6px rgba(0, 0, 0, 0.161));
        position: absolute;
        width: 97px;
        height: 38px;
        left: 33px;
        top: 28px;
        overflow: visible;
    }
</style>
<body>

<div id="custom___1">
    {{--    <img id="logo" src="{{config('global.site_logo')}}" srcset="logo.png 1x, logo@2x.png 2x">--}}
    <div id="Date">
        <span>{{$item->created_at}}</span>
    </div>
    <div id="Order_ID">
        <span>اوردر: {{ $item->order_id }}</span>
    </div>
    <div id="type">
        <span>{{$item->type}}</span>
    </div>
    <div id="title">
        <span>{{$item->title}}</span>
    </div>
    <div id="comment">
        <span>{{$item->comment}}</span>
    </div>
</div>

</body>
</html>
