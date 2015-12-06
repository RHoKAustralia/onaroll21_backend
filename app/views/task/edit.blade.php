@extends('layouts.master')

@section('content')
    {{ Form::open(array('url' => 'task/update')) }}
        {{ Form::hidden('id',$task->id) }}
        {{ FormField::text(['name'=>'name','label'=>trans('master.taskname'),'placeholder'=>trans('master.tasknameholder'),'value'=>$task->name]) }}
        {{ FormField::description(['label'=>trans('master.taskdescription'),'name'=>'description','rows'=>3,'value'=>$task->description,'class'=>'form-control ckeditor']) }}
        {{ FormField::custom(['type'=>'textarea','label'=>trans('master.didyouknow'),'name'=>'didyouknow','rows'=>3,'value'=>$task->didyouknow,'class'=>'form-control ckeditor']) }}
        {{ FormField::custom(['type'=>'textarea','label'=>trans('master.reference'),'name'=>'reference','rows'=>3,'value'=>$task->reference,'class'=>'form-control ckeditor']) }}
        {{ FormField::custom(['type'=>'select','label'=>trans('master.taskauthor'),'name'=>'taskauthor','value'=>array('author1','author2'),'default'=>$task->author])}}
        {{ Form::submit(trans('master.updatetask'),['name'=>'update','class'=>'btn btn-success btn-sm']) }}
    {{ Form::close() }}
@stop

