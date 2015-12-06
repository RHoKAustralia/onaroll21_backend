@extends('layouts.master')

@section('content')
<div class="groups-container">
    <h3><i class="fa fa-users"> </i> Teams</h3>
    {{ trans('master.groupsintro',array('name'=>Auth::user()->firstname)) }}
    <div class="row">
        @foreach($groups as $group)
        <?php
        $outcome = Outcome::find($group->outcome);
        ?>
        @if(($outcome->getTaskCount() >= 21 && $outcome->type==0) || Auth::user()->hasRole('admin') || Auth::user()->hasGroup($group->id))
        <div class="col-md-6 col-sm-12 group-tile">
            <div class="row">
                <div class="col-md-5 col-sm-5 col-xs-5">
                    <img {{ $group->getThumbnailSrc('150x150') }} alt="..." class="group-picture" width="150px" height="150px" />
                </div>

                <div class="col-md-7 col-sm-7 col-xs-7">
                    <div class="group-intro">
                        <h5 class="group-name">{{ $group->name }}</h5>
                        <span class="group-members-count">{{ HTML::link('/group/members/'.$group->id,$group->getUserCount().' '.t('master.members')) }}</span>
                    </div>
                    
                    <div class="group-options">
                        {{ Form::open(['url'=>'group/join']) }}
                        {{ Form::hidden('id',$group->id)}}
                        @if(Auth::user()->hasGroup($group->id))
                        {{ Form::submit(trans('master.leavegroup'),['name'=>'leave','class'=>'btn btn-default btn-xs leave-group'])}}
                        @else
                        @if((Auth::user()->getGroupCount() == 1 && !Auth::user()->hasRole('admin')) || (!Auth::user()->hasRole('admin') && $group->getUserCount() >= 12))
                        {{ Form::submit(trans('master.joingroup'),['name'=>'join','class'=>'btn btn-success btn-xs','disabled'=>'disabled'])}}
                        @else
                        {{ Form::submit(trans('master.joingroup'),['name'=>'join','class'=>'btn btn-default btn-xs join-group'])}}
                        @endif
                        @endif
                        {{ Form::close() }}

                    @if(Auth::user()->hasRole('potty'))
                    {{ Form::open(['url'=>'group/update']) }}
                    {{ Form::hidden('id',$group->id)}}
                    {{ Form::submit(trans('master.managegroup'),['name'=>'edit','class'=>'btn btn-primary btn-xs'])}}
                    {{ Form::close() }}
                    @endif
                </div>
            </div>
            </div>
        </div>
        @endif
        @endforeach
    </div>
</div>
@stop
