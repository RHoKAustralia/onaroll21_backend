@extends('layouts.master')

@section('content')
<br /><br />
<h3><i class="glyphicon glyphicon-check"></i>{{ trans('master.addtask') }}</h3>
    {{ Form::open(array('url' => 'task/add')) }}
        {{ FormField::text(['name'=>'name','label'=>trans('master.taskname'),'placeholder'=>trans('master.tasknameholder')]) }}
        {{ $errors->first('name','<span class="alert alert-danger">:message</span><br /><br />') }}
        {{ FormField::description(['label'=>trans('master.taskdescription'),'name'=>'description','rows'=>3,'placeholder'=>'Task description','class'=>'form-control ckeditor']) }}
        {{ $errors->first('description','<span class="alert alert-danger">:message</span><br /><br />') }}
        {{ FormField::custom(['type'=>'textarea','label'=>trans('master.didyouknow'),'name'=>'didyouknow','rows'=>3,'placeholder'=>'Did you know','class'=>'form-control ckeditor']) }}
        {{ $errors->first('didyouknow','<span class="alert alert-danger">:message</span><br /><br />') }}
        {{ FormField::custom(['type'=>'textarea','label'=>trans('master.reference'),'name'=>'reference','rows'=>3,'placeholder'=>'Reference (if any)','class'=>'form-control ckeditor']) }}
        {{ $errors->first('reference','<span class="alert alert-danger">:message</span><br /><br />') }}
        {{ FormField::custom(['type'=>'select','label'=>trans('master.taskauthor'),'name'=>'taskauthor','value'=>array(1=>'User 1',2=>'User 2')])}}
        {{ $errors->first('author','<span class="alert alert-danger">:message</span><br /><br />') }}
        {{ Form::submit(trans('master.addtask'),['name'=>'add','class'=>'btn btn-success btn-sm']) }}
    {{ Form::close() }}
@stop
