<div class="likebtncontainer">
    {{ Form::hidden('type','like') }}
<button id="likeBtn" class="btn btn-xs btn-default likeBtn" 
        type="submit" name="likeBtn" >
    <span class="glyphicon glyphicon-star-empty orange"> </span> 
    {{ trans('master.like') }} @if($likeCount=$post->getLikeCount())
    ({{ $likeCount }})
    @endif
</button>
</div>