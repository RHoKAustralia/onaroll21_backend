@extends('layouts.homepage')

@section('content')
<div class="banner">
    <img src="{{ asset('images/home_page_banner_opt.jpg') }}" alt="banner" />
    <div class="container-fluid">
    <div class="row intro">
        <div class="col-md-4"></div>
        <div class="front-page-intro col-md-4">
            <span class="intro-frame intro-top">
                {{ trans('master.homepageintrotop') }}
            </span>
            <span class="intro-frame intro-bottom">
                <i>
                    {{ trans('master.homepageintrobottom') }}
                </i>
            </span>
        </div>
    </div>
    </div>
    <div class="clearfix"></div>
</div>
@stop
