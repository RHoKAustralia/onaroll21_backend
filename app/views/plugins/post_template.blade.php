<div id="postTemplate" class="hidden">
    <div class="row post">
        <div class="col-md-1">
        <a href="">
            <img class="user-status-img img-circle" src="#SRC" data-src="/holder.js/75x75" alt="User pcture" />
        </a>
    </div>
    <div class="col-md-10">
        <a href="#">#NAME </a><span class="localtime">#TIME</span>
        <div class="status">#STATUS</div>
        <span class="status-options">
            {{ Form::open(['url'=>'status/update']) }}
            {{ Form::hidden('userid',$user->id); }}
            {{ Form::hidden('groupid',$group->id); }}
            {{ Form::hidden('taskid',$task->id); }}
                <a id="likeBtn" class="btn btn-xs btn-default"><span class="glyphicon glyphicon-heart"> </span> Like</a>
                <a id="commentBtn" class="btn btn-xs btn-default"><span class="glyphicon glyphicon-comment"> </span> Comment</a>
                <a id="shareBtn" class="btn btn-xs btn-default"><span class="glyphicon glyphicon-share"> </span> Share</a>
            {{ Form::close() }}
        </span>
    </div>
    </div>
</div>