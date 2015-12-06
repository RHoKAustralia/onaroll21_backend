@extends('layouts.master')
@section('content')
<h3>Password reset: Create new password</h3>
@if($errors->any())
    <div class="alert alert-danger">
        <a class="close" href="#" data-dismiss="alert">x</a>
      <ul>
        {{ implode('', $errors->all('<li>:message</li>'))}}
      </ul>
    </div>
    @endif
{{ Form::open(['action'=>'RemindersController@postReset']) }}
    {{ Form::hidden('token',$token ) }}
    {{ FormField::email(['name'=>'email']) }}
    {{ FormField::password(['name'=>'password']) }}
    {{ FormField::password(['name'=>'password_confirmation']) }}
    {{ Form::submit(trans('master.resetpassword'), array('class'=>'btn btn-warning btn-sm')) }}
{{ Form::close() }}
@stop
