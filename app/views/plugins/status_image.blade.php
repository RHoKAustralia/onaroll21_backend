<div class="tab-pane active" id="image">
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
                    {{ Form::open(['url'=>'/play/status/post','id'=>'img-status','files'=>true]) }}
                    {{ Form::hidden('statustype','image') }}
                    {{ Form::hidden('userid',$user->id) }}
                    {{ Form::hidden('groupid',$group->id) }}
                    {{ Form::hidden('taskid',$task->id) }}
                    {{ FormField::custom(['type'=>'textarea','name'=>'status','label'=>'','id'=>'status_box','placeholder'=>'Write your status here','rows'=>'3']) }}
                    <img id="status-img-thumbnail" src="#" alt="your image" style="display:none" width="75px" />
                    {{ Form::file('status_image',['id'=>'status_image','title'=>'upload image']) }}
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
@section('extrafootercontent')
<script>
       function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('#status-img-thumbnail').attr('src', e.target.result);
                $('#status-img-thumbnail').show('slow');
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    $("#status_image").change(function(){
        console.log('calling this function');
        readURL(this);
    });
</script>
<script type="text/javascript">
jQuery(function($) {
	$(".swipebox").swipebox();
});
</script>
@stop