@extends('layouts.survey')
@section('content')
<h1>{{ t('survey.prepostmessageheading') }}</h1>
{{ Form::open(['url'=>'survey/update']) }}
{{ Form::hidden('id',$survey->id) }}
{{ FormField::description(['name'=>'premessage','label'=>t('survey.surveyintro'),'class'=>'form-control ckeditor','value'=>$survey->getPreMessage()]) }}
{{ FormField::description(['name'=>'postmessage','label'=>t('survey.surveyconclusion'),'class'=>'form-control ckeditor','value'=>$survey->getPostMessage()]) }}
{{ Form::submit(t('survey.savemsgbtn'),['class'=>'btn btn-success btn-sm','name'=>'savemessages']) }}
{{ Form::close() }}
@stop