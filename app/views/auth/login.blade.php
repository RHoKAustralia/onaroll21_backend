@extends('layouts.login')

@section('content')
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-8">
                <div class="loginpanel">
                    <h5>{{ strtoupper(trans('master.login')) }}</h5>
                    @if($successmessage=Session::get('successmessage') and !empty($successmessage))
                    <div class="alert alert-success">{{ $successmessage }}</div>
                    @endif
                    @if(isset($message) and !empty($message))
                    <div class="alert alert-danger">{{ $message }}</div>
                    @endif
                    {{ Form::open(['url'=>'/login','id'=>'login-form']) }}
                        {{ FormField::username(['name'=>'username','label'=>trans('master.loginusername')]) }}
                        {{ FormField::password(['name'=>'password','label'=>trans('master.loginpassword')]) }}
                        {{ HTML::link('password/remind',trans('master.forgotpassword')) }}
                        <br /><br/>
                        {{ Form::submit(trans('master.loginbtn'),['class'=>'btn btn-warning btn-sm']) }}
                    {{ Form::close() }}
                    <br />
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="signuppanel"> 
                    {{ trans('master.noaccount') }}
                    <br />
                    {{-- HTML::link('/register',trans('master.createaccount'),array('class'=>'')) --}}
                </div>
                <div class="moreinfo-panel">
                    {{ trans('master.wanttolearnmore') }}
                    <br />
                    {{ HTML::link('/register',trans('master.seehow'),array('class'=>'')) }}
                </div>
            </div>
        </div>
    </div>
@stop