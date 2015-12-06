@extends('layouts.master')

@section('main_menu')
    @parent
@stop

@section('content')
<br /><br /><br />
@if($errors->any())
    <div class="alert alert-danger">
        <a class="close" href="#" data-dismiss="alert">x</a>
      <ul>
        {{ implode('', $errors->all('<li>:message</li>'))}}
      </ul>
    </div>
    @endif
    <h2>{{ t('master.editprofile') }}</h2>
    {{ Form::open(array('url' => 'user/profile/update','files'=>true)) }}
        {{ Form::hidden('id',$user->id)}}
        {{ FormField::username(['label'=>trans('master.username'),'value'=>$user->username,'disabled'=>'disabled']) }}
        {{ FormField::password(['label'=>trans('master.password')]) }}
        {{ FormField::email(['label'=>trans('master.email'),'name'=>'email','value'=>$user->email]) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.rollername'),
                                'name'=>'screenhandle',
                                'value'=>$user->screenhandle]) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.firstname'),
                                'name'=>'firstname',
                                'value'=>$user->firstname]) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.lastname'),
                                'name'=>'lastname',
                                'value'=>$user->lastname]) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.city'),
                                'name'=>'city',
                                'value'=>$user->city]) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.country'),
                                'name'=>'country',
                                'value'=>$user->country]) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.organisation'),
                                'name'=>'organisation',
                                'value'=>$user->organisation]) }}
        {{ FormField::description(['label'=>trans('master.description'),
                                'name'=>'description','rows'=>3,
                                'value'=>$user->description]) }}
        {{ Form::label('picture',trans('master.userpicture'))}}
        {{ Form::file('picture',array('id'=>'picture')) }}
        <br /><br />
        {{ Form::submit(t('master.updateuser'),array('class'=>'btn btn-success btn-sm','name'=>'update'))}}
    {{ Form::close() }}
@stop