@if(!empty($currentTask))
<div class="panel panel-default current-task">
    <div class="panel-heading">
        {{ t('master.currenttask') }}
    </div>
    <div class="panel-body">
        <div class="rolled-task-description">{{ $currentTask->description }}</div><br />
        <div><b>Did you know: </b><a href="#" class="opendyk">Read more</a></div><br />
        <div class="dyk">{{ $currentTask->didyouknow }}</div><br />
        <div><b>Reference:</b> <a href="#" class="openref">Read more</a></div><br />
        <div class="ref">{{ $currentTask->reference }}</div><br />
    </div>
</div>
@else
<div class="panel panel-default current-task" id="rolled-task" style="display:none;">
    <div class="panel-heading" id="rolled-task-header">
        {{ t('master.yourolled') }}
    </div>
    <div class="panel-body" id="rolled-task-body">
        <div class="rolled-task-description" id="rolled-task-description"></div><br />
        <div><b>Did you know: </b><a href="#" class="opendyk">Read more</a></div>
        <div class="dyk" id="dyk"></div><br />
        <div><b>Reference:</b> <a href="#" class="openref">Read more</a></div>
        <div class="ref" id="ref"></div><br />
    </div>
    <div class="panel-footer" id="rolled-task-footer">
        <div class="pull-right" id="rolled-task-footer-content">
            
        </div>
        <div class="clearfix"></div>
    </div>
</div>
@endif