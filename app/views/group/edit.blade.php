@extends('layouts.master')

@section('content')
    <h3>Update group</h3>
    {{ Form::open(array('url' => 'group/update','files'=>true)) }}
        {{ Form::hidden('id',$group->id) }}
        {{ FormField::custom(['type'=>'text',
                                'label'=>trans('master.groupname'),
                                'name'=>'name',
                                'class'=>'form-control',
                                'value'=>$group->name]) }}
         <label for="keycode">Keycode</label>                       
         <input class="form-control" type="text" name="keycode" value="{{ $group->keycode }}" id="keycode" >
        <div class="input-field col s12">
                          <textarea id="description" name="description" class="materialize-textarea">{{$group->description}}</textarea>
                          <label for="description">Team Description</label>
                        </div>
        {{ FormField::custom(['type'=>'date',
                                'label'=>trans('master.groupstartdate'),
                                'name'=>'timestart',
                                'class'=>'form-control',
                                'value'=>date('Y-m-d',$group->timestart)]) }}
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
                                'class'=>'form-control',
                                'value'=>$outcomes,
                                'default'=>$group->outcome]) }}
        {{ FormField::custom(['type'=>'select',
                                'label'=>trans('master.groupsurvey'),
                                'name'=>'survey',
                                'class'=>'form-control',
                                'value'=>$surveys,
                                'default'=>$group->survey]) }}
        {{ FormField::custom(['type'=>'select',
                                'label'=>trans('master.grouppostsurvey'),
                                'name'=>'postsurvey',
                                'value'=>$surveys,
                                'default'=>$group->postsurvey,
                                'class'=>'form-control']) }}
        {{ Form::submit(trans('master.updategroup'),['name'=>'update','class'=>'btn btn-success btn-sm']) }}
    {{ Form::close() }}
@stop