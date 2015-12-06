<div class="likebtncontainer">
    {{ Form::hidden('type','unlike') }}
<button id="unlikeBtn" class="btn btn-xs btn-default unlikeBtn" 
        type="submit" name="unlikeBtn">
    <span class="glyphicon glyphicon-star orange"> </span> 
    {{ trans('master.unlike') }} @if($likeCount=$post->getLikeCount())
    ({{ $likeCount }})
    @endif
</button>
</div>
