@extends('layouts.master')

@section('content')
    <h3><i class="fa fa-group"></i> {{ trans('master.addagroup') }}</h3>
    {{ Form::open(array('url' => 'group/add','files'=>true)) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.groupname'),
                                'name'=>'name']) }}
                                
         <label for="keycode">Keycode</label>                       
         <input class="form-control" type="text" name="keycode" id="keycode" >
         <div class="input-field col s12">
                          <textarea id="description" name="description" class="materialize-textarea"></textarea>
                          <label for="description">Team Description</label>
                        </div>
        {{ FormField::custom(['type'=>'date',
                                'label'=>trans('master.groupstartdate'),
                                'name'=>'timestart']) }}
        <div class="file-field input-field">
                            <div class="btn">
                              <span>File</span>
                              <input type="file" name="thumbnail">
                            </div>
                            <div class="file-path-wrapper">
                              <input class="file-path validate" name="thumbnail" type="text">
                            </div>
                          </div>
        {{ FormField::custom(['type'=>'select',
                                'label'=>trans('master.groupoutcome'),
                                'name'=>'outcome',
                                'value'=>$outcomes,
                                'class'=>'form-control']) }}
        {{ FormField::custom(['type'=>'select',
                                'label'=>trans('master.groupsurvey'),
                                'name'=>'survey',
                                'value'=>$surveys,
                                'class'=>'form-control']) }}
        {{ FormField::custom(['type'=>'select',
                                'label'=>trans('master.grouppostsurvey'),
                                'name'=>'postsurvey',
                                'value'=>$surveys,
                                'class'=>'form-control']) }}
        {{ Form::submit(trans('master.addgroup'),['name'=>'add','class'=>'btn btn-success btn-sm']) }}
    {{ Form::close() }}
@stop