@extends('layouts.login')
@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-8">
            <div class="signup-form">
                <h3>Forgot your password?</h3>
                @if($errors->any())
                <div class="alert alert-danger">
                    <a class="close" href="#" data-dismiss="alert">x</a>
                  <ul>
                    {{ implode('', $errors->all('<li>:message</li>'))}}
                  </ul>
                </div>
                @endif
                @if($successmessage=Session::get('successmessage') and !empty($successmessage))
                    <div class="alert alert-success">{{ $successmessage }}</div>
                    @endif
                <p>{{ trans('master.forgotpasswordtext') }}</p>
                {{ Form::open(['action'=>'RemindersController@postRemind']) }}
                    {{ FormField::email(['label'=>trans('master.email'),'name'=>'email']) }}
                    {{ Form::submit(trans('master.sendreminder'),array('class'=>'btn btn-warning btn-sm')) }}
                {{ Form::close() }}
            </div>
            </div>
        
        <div class="col-md-4">
                <div class="moreinfo-panel">
                    {{ trans('master.wanttolearnmore') }}
                    <br />
                    {{ HTML::link('/register',trans('master.seehow'),array('class'=>'')) }}
                </div>
            </div>
        </div>
    </div>
@stop