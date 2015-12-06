<div class="row post">
    <div class="col-md-2 user-image">
        <a href="">
            <img class="status-user-image" {{ $status_user->getPictureSrc('75x75') }} alt="{{ $status_user->getDisplayName() }}" width="75px" height="75px" />
        </a>
    </div>
    <div class="col-md-9 user-status">
        <a class="user-name" href="/user/profile/view/{{ $status_user->id }}">{{ $status_user->getDisplayName() }} </a>
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
            @if($imagesrc=unserialize($post->status))
            @if(isset($imagesrc['image']))
            <a data-toggle="lightbox" href="{{ base64_decode($imagesrc['image']) }}" class="thumbnail swipebox" class="swipebox" title="">
                <image src="{{ base64_decode($imagesrc['image']) }}" />
            </a>
            @endif
            @endif
        </div>
        @else
        <div class="post-text">
            {{ $post->filterStatus() }}
        </div>
        @endif

        <span class="statustime localtime" data-timestamp="{{ $post->created_at->toRFC2822String() }}">{{ $post->created_at->subMinutes(2)->diffForHumans(); }}</span>

        <span class="status-options">
            {{ Form::open(['action'=>'PlayController@updateStatus']) }}
            {{ Form::hidden('userid',$user->id); }}
            {{ Form::hidden('groupid',$group->id); }}
            {{ Form::hidden('postid',$post->id); }}
            @if($user->hasLike($post->id))
            <button id="unlikeBtn" class="btn btn-xs btn-default" 
                    type="submit" name="unlikeBtn">
                <span class="glyphicon glyphicon-star orange"> </span> 
                {{ trans('master.unlike') }} @if($likeCount=$post->getLikeCount())
                ({{ $likeCount }})
                @endif
            </button>
            @else
            <button id="likeBtn" class="btn btn-xs btn-default" 
                    type="submit" name="likeBtn">
                <span class="glyphicon glyphicon-star-empty orange"> </span> 
                {{ trans('master.like') }} @if($likeCount=$post->getLikeCount())
                ({{ $likeCount }})
                @endif</button>
            @endif
<!--                                    <button id="shareBtn" class="btn btn-xs btn-default" type="submit" name="likeBtn"><span class="glyphicon glyphicon-share"> </span> Share</button>-->
            {{ Form::close() }}
        </span>
        <div class="row comments">
            <div class="">
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
                            {{ Form::open(['url'=>'/comment/delete']) }}
                            {{ Form::hidden('commentid',$comment->id) }}
                            {{ Form::hidden('groupid',$group->id) }}
                            <button type="submit" class="close">&times;</button>
                            {{ Form::close() }}

                            {{ $comment->comment }}
                        </div>
                    </div>
                </div>
                @endforeach
                @endif
                <div class="row">
                    <div class="col-md-2">

                        <img class="status-user-image" {{ $user->getPictureSrc('35x35') }} alt="{{ $user->getDisplayName() }}" width="35px" height="35px" />

                    </div>
                    <div class="col-md-10">
                        {{ Form::open(['action'=>'PlayController@updateStatus']) }}
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
