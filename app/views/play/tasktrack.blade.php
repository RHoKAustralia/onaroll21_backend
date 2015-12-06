<?php 
// Get the total accepted tasks
$accepted_tasks = DB::table('user_tasks')
                        ->where('user_id',$user->id)
                        ->where('group_id',$group->id)
                        ->get();
//Get the total completed tasks
?>
<div class="track-container">
    <div class="group-details">
        <span class="name">
            {{ $group->name }}
        </span><br />
        <span class="currentday">
            {{ trans('master.day').': <span class="detail">'.floor($currentDay+1).'</span>' }}
        </span><br />
        <span class="daysleft">
            {{ trans('master.daysleft').': <span class="detail">'.(21-floor($currentDay+1)).'</span>' }}
        </span><br />
        <span class="accepted-tasks">
            {{ trans('master.acceptedtasks').': <span class="detail">'.count($accepted_tasks).'</span>' }}
        </span>
    </div>
    <div class="container-fluid">
        <div class="row">
        @for($i=0;$i<21;$i++)
        @if($i%7==0)
        </div>
        <div class="row">
        @endif
            <div class="col-md-1 col-sm-1 col-xs-1">
                <span class="fa-stack">
                    <i class="fa fa-square fa-stack-1x"></i>
                    @if($i<count($accepted_tasks))
                    <i class="fa fa-square fa-stack-1x text-success"></i>
                    <i class="fa fa-times fa-stack-1x fa-inverse"></i>
                    @endif
                </span>
            </div>
            @endfor
        </div>
    </div>

</div>
