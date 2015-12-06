@extends('layouts.status')
<script>
    var current = <?php echo json_encode($current); ?>;
</script>

{{-- Declare variables --}}
<?php
$currentDay = (time()-$group->timestart)/86400;
$postmessage = Session::has('postmessage') ? Session::get('postmessage') : '';
Session::forget('postmessage');
?>
@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-4 roll-area">
            <div class="roll-head">
                <h3>{{ trans('master.play') }}</h3>
                {{ t('master.clicktoroll') }}
            </div>
            <br />

            <div class="dice-container">
                @include('play.samepagedice')
            </div>
            <div class="user-task-track">
                @include('play.tasktrack')
            </div>
        </div>

        <div class="col-md-8">
            <div class="user-welcome">
                <div class="image">
                    <span class="statuspagewelcome">{{ trans('master.statuspagewelcome',['name'=>$user->firstname]) }}</span>
                </div>
            </div>
            <?php
                $userCurrentTask = $user->getPendingTask($group->id, $group->outcome);
                if (!empty($userCurrentTask))
                    $currentTask = Task::find($userCurrentTask[0]->task_id);
                else
                    $currentTask=0;
                if($currentTask) {
                    $hasPosted = $user->hasPosted($group->id,$currentTask->id);
                }
            ?>
            @include('plugins.rolledTask')
            <div class="status-page-instr">
            </div>
            <div class="status-container">
                @if($errors->any())
                <div class="alert alert-danger">
                    <a class="close" href="#" data-dismiss="alert">x</a>
                  <ul>
                    {{ implode('', $errors->all('<li>:message</li>'))}}
                  </ul>
                </div>
                @endif
                @include('plugins.new_status')
                <div id="postStatus" class="postStatus clearfix hidden"></div>
                <div id="container">
                    {{-- This is where we will run the loop --}}
                    @if(!empty($posts))
                    @foreach($posts as $post)
                    @if($status_user=User::find($post->user_id))@endif
                    <div class="post-container">
                        <div class="row post">
                            <div class="col-md-2 user-image">
                                <a href="{{ url('/') }}/user/profile/view/{{ $status_user->id }}">
                                    <img class="status-user-image" {{ $status_user->getPictureSrc('75x75') }} alt="{{ $status_user->getDisplayName() }}" width="75px" height="75px" />
                                </a>
                            </div>
                            <div class="col-md-9 user-status">
                                <a class="user-name" href="{{ url('/') }}/user/profile/view/{{ $status_user->id }}">{{ $status_user->getDisplayName() }} </a>
                                    @if((Auth::user()->id == $status_user->id) || Auth::user()->hasRole('admin'))
                                    {{ Form::open(['url'=>'/post/delete','class'=>'deletePost']) }}
                                    {{ Form::hidden('postid',$post->id) }}
                                    {{ Form::hidden('groupid',$group->id) }}
                                    <button type="submit" class="close">&times;</button>
                                    {{ Form::close() }}
                                    @endif
                                @if($post->statustype == 'image')
                                <div class="post-text">
                                    {{-- unserialize($post->status)['text'] --}}
                                    {{ $post->filterStatus() }}
                                </div>
                                <div class="post-image">
                                    {{ $post->displayMedia() }}
                                </div>
                                @else
                                <div class="post-text">
                                    {{ $post->filterStatus() }}
                                </div>
                                @endif

                                <span class="statustime localtime" data-timestamp="{{ $post->created_at->toRFC2822String() }}">{{ $post->created_at->subMinutes(2)->diffForHumans(); }}</span>

                                <span class="status-options">
                                    {{ Form::open(['url'=>'/play/status/update','class'=>'likeunlikeform']) }}
                                    {{ Form::hidden('userid',$user->id); }}
                                    {{ Form::hidden('groupid',$group->id); }}
                                    {{ Form::hidden('postid',$post->id); }}
                                <div class="likebtncontainer">
                                    @if($user->hasLike($post->id))
                                    {{ Form::hidden('type','unlike') }}
                                    <button id="unlikeBtn" class="btn btn-xs btn-default unlikeBtn" 
                                            type="submit" name="unlikeBtn">
                                        <span class="glyphicon glyphicon-star orange"> </span> 
                                        {{ trans('master.unlike') }} @if($likeCount=$post->getLikeCount())
                                        ({{ $likeCount }})
                                        @endif
                                    </button>
                                    @else
                                    {{ Form::hidden('type','like') }}
                                    <button id="likeBtn" class="btn btn-xs btn-default likeBtn" 
                                            type="submit" name="likeBtn" >
                                        <span class="glyphicon glyphicon-star-empty orange"> </span> 
                                        {{ trans('master.like') }} @if($likeCount=$post->getLikeCount())
                                        ({{ $likeCount }})
                                        @endif</button>
                                    @endif
                                </div>
                                    {{ Form::close() }}
                                </span>
                                <div class="row comments">
                                    <div class="comment-container">
                                        @if($post->comments)
                                        @foreach($post->comments as $comment)
                                        <div class="row">
                                            <div class="col-md-2 col-sm-2 col-xs-2">

                                                <img class="status-user-image" {{ $comment->user->getPictureSrc('35x35') }} alt="{{ $comment->user->getDisplayName() }}" width="35px" height="35px" />

                                            </div>
                                            <div class="col-md-10 col-sm-10 col-xs-10">
                                                <div class="user-name">
                                                    <a href="/user/profile/view/{{ $comment->user->id }}">{{ $comment->user->getDisplayName() }}</a> <span class="localtime">{{ $comment->created_at->subMinutes(2)->diffForHumans(); }}</span>
                                                </div>
                                                <div class="comment-text">
                                                    @if(Auth::user()->id == $comment->user->id)
                                                    {{ Form::open(['url'=>'/comment/delete','class'=>'deleteComment']) }}
                                                    {{ Form::hidden('commentid',$comment->id) }}
                                                    {{ Form::hidden('groupid',$group->id) }}
                                                    <button type="submit" class="close">&times;</button>
                                                    {{ Form::close() }}
                                                    @endif
                                                    
                                                    {{ $comment->comment }}
                                                </div>
                                            </div>
                                        </div>
                                        @endforeach
                                        @endif
                                        <div class="row addcomment">
                                            <div class="col-md-2">
                                                <img class="status-user-image" {{ $user->getPictureSrc('35x35') }} alt="{{ $user->getDisplayName() }}" width="35px" height="35px" />
                                            </div>
                                            <div class="col-md-10">
                                                {{ Form::open(['action'=>'PlayController@updateStatus','class'=>'addComment']) }}
                                                {{ Form::hidden('userid',$user->id); }}
                                                {{ Form::hidden('groupid',$group->id); }}
                                                {{ Form::hidden('postid',$post->id); }}
                                                {{ FormField::custom(['type'=>'textarea','name'=>'comment','rows'=>1,'placeholder'=>trans('master.commentboxplaceholder'),'label'=>'']) }}
                                                {{ Form::submit(trans('master.comment'),['name'=>'postcomment','class'=>'btn btn-primary btn-xs commentbtn pull-right']) }}  
                                                {{ Form::close() }}
                                                <div class="clearfix"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    @endforeach
                    @endif
                    {{-- END of loop --}}
                </div>
               <!-- This where loading image was initially placed-->
            </div>
            <div class="animation_image" style="display:none" align="center">
                <img src="/images/loading.gif" width="50px" height="40px">
                </div>
        </div>
    </div>
</div>
@include('plugins.post_template')
{{-- Hidden modal for Pre/Post Survey --}}
<?php
$surveySkipped = Session::get('surveyskipped', false);
$statusPosted = Session::get('statusposted', false);
$postSurveyCompleted=$user->postSurveyCompleted($group->id);
$preSurveyCompleted=$user->preSurveyCompleted($group->id);
?>
@if(!$surveySkipped && !$preSurveyCompleted && !empty($group->survey))
<div class="modal fade bs-modal-sm" id="preSurvey" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
<!--                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>-->
                <h4 class="modal-title" id="myModalLabel">Pre Survey</h4>
            </div>
            <div class="modal-body">
                {{ trans('master.nopresurvey') }}
            </div>
            <div class="modal-footer">
                {{ Form::open(['url'=>'/survey/pre']) }}
                {{ Form::hidden('groupid',$group->id) }}
                {{ Form::hidden('userid',$user->id) }}
<!--                <button type="button" class="btn btn-default btn-xs" data-dismiss="modal">Skip</button>-->
                <button type="submit" class="btn btn-primary btn-xs">Start</button>
                {{ Form::close() }}
            </div>
        </div>
    </div>
</div>
<?php
Session::put('surveyskipped', true);
?>
@endif
@if($currentDay>=21 && !$postSurveyCompleted && !empty($group->postsurvey))
<div class="modal fade bs-modal-sm" id="postSurvey" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
<!--                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>-->
                <h4 class="modal-title" id="myModalLabel">{{ trans('master.postsurvey') }}</h4>
            </div>
            <div class="modal-body">
                {{ trans('master.postsurveypopupintro') }}
            </div>
            <div class="modal-footer">
                {{ Form::open(['url'=>'/survey/post']) }}
                {{ Form::hidden('groupid',$group->id) }}
                {{ Form::hidden('userid',$user->id) }}
<!--                <button type="button" class="btn btn-default btn-xs" data-dismiss="modal">Skip</button>-->
                <button type="submit" class="btn btn-primary btn-xs">Start</button>
                {{ Form::close() }}
            </div>
        </div>
    </div>
</div>
<?php
Session::put('surveyskipped', true);
?>
@endif
@if($postmessage != '')
@include('plugins.surveysuccess')
@endif
@if($statusPosted)
<div class="modal fade bs-modal-sm" id="preSurvey" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
<!--                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>-->
                <h4 class="modal-title" id="myModalLabel">{{ trans('master.howareyoufeeling') }}</h4>
                <p>{{ t('master.mood_sel_message') }}</p>
            </div>
            <div class="modal-body">
                {{ Form::open(['url'=>'wellbeing/update']) }}
                {{ Form::hidden('userid',$user->id) }}
                {{ Form::hidden('groupid',$group->id) }}
                @if(isset($task) && $task->id != 0)
                {{ Form::hidden('taskid',$task->id) }}
                @endif
                {{ Form::submit(t('master.mood_terrible'),['name'=>'mood','class'=>'mood terrible']) }}
                {{ Form::submit(t('master.mood_notgreat'),['name'=>'mood','class'=>'mood not-great']) }}
                {{ Form::submit(t('master.mood_neutral'),['name'=>'mood','class'=>'mood neutral']) }}
                {{ Form::submit(t('master.mood_prettygood'),['name'=>'mood','class'=>'mood pretty-good']) }}
                {{ Form::submit(t('master.mood_fantastic'),['name'=>'mood','class'=>'mood fantastic']) }}
                {{ Form::close() }}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-xs" data-dismiss="modal">Skip</button>
            </div>
        </div>
    </div>
</div>
@endif
<script>
    /////////////// START //////////////////
    /**
     * This is for page load
     * @returns {undefined}
     */
    var track_load = 0; //total loaded record group(s)
    var loading  = false; //to prevent multipal ajax loads
    var total_groups = {{ ceil($postcount/5) }};
    var group_id = {{ $group->id }};
    var total_posts = {{ $postcount }};
</script>
<script>(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d=a.target;while(!f.test(d.nodeName))d=d.parentNode;"href"in d&&(d.href.indexOf("http")||~d.href.indexOf(e.host))&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone")</script>

@stop
