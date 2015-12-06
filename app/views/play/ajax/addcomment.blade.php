<div class="row">
    <div class="col-md-2 col-sm-2 col-xs-2">

        <img class="status-user-image" {{ $new_comment->user->getPictureSrc('35x35') }} alt="{{ $new_comment->user->getDisplayName() }}" width="35px" height="35px" />

    </div>
    <div class="col-md-10 col-sm-10 col-xs-10">
        <div class="user-name">
            <a href="/user/profile/view/{{ $new_comment->user->id }}">{{ $new_comment->user->getDisplayName() }}</a> <span class="localtime">{{ $new_comment->created_at->subMinutes(2)->diffForHumans(); }}</span>
        </div>
        <div class="comment-text">
             @if(Auth::user()->id == $new_comment->user->id)
            {{ Form::open(['url'=>'/comment/delete']) }}
            {{ Form::hidden('commentid',$new_comment->id) }}
            {{ Form::hidden('groupid',$group->id) }}
            <button type="submit" class="close">&times;</button>
            {{ Form::close() }}
            @endif

            {{ $new_comment->comment }}
        </div>
    </div>
</div>
