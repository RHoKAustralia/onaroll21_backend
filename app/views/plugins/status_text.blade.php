<div class="tab-pane active" id="text">
    <div class="row">
        <div class="col-md-2">
            <img class="image" {{ $user->getPictureSrc('75x75') }} width="75px" height="75px" />
        </div>
        <div class="col-md-9 status-box">
            <div class="panel panel-default new-status">
                <div class="panel-heading">
                    <b><i class="fa fa-quote-right"> </i> {{ trans('Update status') }}</b>
                </div>
                <div class="panel-content">
                    {{ Form::open(['url'=>'play/status/post']) }}
                    {{ Form::hidden('statustype','text') }}
                    {{ Form::hidden('userid',$user->id) }}
                    {{ Form::hidden('groupid',$group->id) }}
                    {{ Form::hidden('taskid',$task->id) }}
                    {{ FormField::custom(['type'=>'textarea','name'=>'status','label'=>'','id'=>'status_box','placeholder'=>trans('master.howdidyouroll'),'rows'=>'3']) }}
                </div>
                <div class="panel-footer">
                    <div class="pull-right">
                        {{ Form::submit(trans('master.sharebtn'),['class'=>'btn btn-xs btn-primary']) }}
                        {{ Form::close() }}
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
</div>