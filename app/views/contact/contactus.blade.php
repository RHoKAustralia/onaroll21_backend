@extends('layouts.master')

@section('content')
<div class="contact-us form-container">
    <h1>{{ t('master.contact') }}</h1>
    @if(isset($thanks) && !empty($thanks))
    <div class="alert alert-success alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        {{ t('master.contactthanks') }}
    </div>
    @endif
    @if($errors->any())
    <div class="alert alert-danger">
        <a class="close" href="#" data-dismiss="alert">x</a>
      <ul>
        {{ implode('', $errors->all('<li>:message</li>'))}}
      </ul>
    </div>
    @endif
    {{ Form::open(['url'=>'/contact']) }}
    {{ FormField::custom(['type'=>'text','name'=>'name','placeholder'=>'Full name',
                                                'value'=>Input::old('name')]) }}
    {{ FormField::email(['name'=>'email','placeholder'=>'Email address',
                                                'value'=>Input::old('email')]) }}
    {{ FormField::custom(['type'=>'text','name'=>'subject','placeholder'=>'Subject',
                                                'value'=>Input::old('subject')]) }}
    {{ FormField::custom(['type'=>'textarea','name'=>'text','placeholder'=>'Message',
                                                'value'=>Input::old('text')]) }}
    {{ Form::captcha() }}
    <br /><br />
    {{ Form::submit(t('master.sendmessage'),['class'=>'btn btn-warning btn-sm']) }}
    {{ Form::close() }}
</div>
@stop