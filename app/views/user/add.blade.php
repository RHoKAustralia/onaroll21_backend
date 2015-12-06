{{-- This is the view file for adding a new user --}}
@extends('layouts.master')

@section('main_menu')
    @parent
@stop

@section('content')
 @if($errors->any())
    <div class="alert alert-danger">
        <a class="close" href="#" data-dismiss="alert">x</a>
      <ul>
        {{ implode('', $errors->all('<li>:message</li>'))}}
      </ul>
    </div>
    @endif
    <h2>{{ t('master.addanewuser') }}</h2>
    {{ Form::open(array('url' => 'user/add','files'=>true)) }}
        {{ FormField::username(['label'=>trans('master.username')]) }}
        {{ FormField::password(['label'=>trans('master.password')]) }}
        {{ FormField::email(['label'=>trans('master.email')]) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.rollername'),
                                'name'=>'screenhandle']) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.firstname'),
                                'name'=>'firstname']) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.lastname'),
                                'name'=>'lastname']) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.city'),
                                'name'=>'city']) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.country'),
                                'name'=>'country']) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.organisation'),
                                'name'=>'organisation']) }}
        
              <div class="input-field col s12">
                          <textarea id="description" name="description" class="materialize-textarea"></textarea>
                          <label for="description">Site Description</label>
                        </div>                  
                                
        <div class="file-field input-field">
                            <div class="btn">
                              <span>File</span>
                              <input type="file">
                            </div>
                            <div class="file-path-wrapper">
                              <input class="file-path validate" name="picture" type="text">
                            </div>
                          </div>
        <br /><br />
        {{ Form::submit(t('master.addanewuser'),array('class'=>'btn btn-success'))}}
    {{ Form::close() }}
@stop