    
<div class="row new-status-container">
    <div class="col-md-2">
        <img class="image" {{ $user->getPictureSrc('75x75') }} width="75px" height="75px" />
    </div>
    <div class="col-md-9 status-box">
        <div class="panel panel-default new-status">
            @if(empty($currentTask))
            <div class="disabler">
                <p>{{ t('master.statusareadisabler') }}</p>
            </div>
            @endif
            <div class="panel-heading">
                <b><i class="fa fa-quote-right"> </i> {{ trans('Update status') }}</b>
                <span class="loading-img" style="display:none">
                    {{ trans('master.loading') }}
                    <img src="{{ asset('images/loading.gif') }}" alt="{{ trans('master.loading') }}" height="40px" width="50px">
                </span>
            </div>
            <div class="panel-content">
                {{ Form::open(['url'=>'play/status/post','id'=>'addPost','files'=>true]) }}
                {{ Form::hidden('statustype','text') }}
                {{ Form::hidden('userid',$user->id) }}
                {{ Form::hidden('groupid',$group->id) }}
                {{ Form::hidden('taskid',$task->id) }}
                {{ FormField::custom(['type'=>'textarea','name'=>'status_text','label'=>'','id'=>'status_box','placeholder'=>trans('master.howdidyouroll'),'rows'=>'3']) }}
                <div class="selector-wrapper"></div>
                <div class="tab-content">
                    <div class="tab-pane active" id="text">
                        {{-- FormField::custom(['type'=>'textarea','name'=>'status','label'=>'','id'=>'status_box','placeholder'=>trans('master.howdidyouroll'),'rows'=>'3']) --}}
                    </div>
                    <div class="tab-pane" id="image">
                        <img id="status-img-thumbnail" src="#" alt="your image" style="display:none" width="75px" />
                        {{ Form::file('status_image',['id'=>'status_image','title'=>'upload image','accept'=>'image/*,video/*,audio/*']) }}
                    </div>
                </div>
                <!-- URL - Attachment content -->
                <div id="attach_content" style="display:none">
                    <div id="atc_images"></div>
                    <div id="atc_info">

                        <label id="atc_title"></label>
                        <label id="atc_url"></label>
                        <br clear="all" />
                        <label id="atc_desc"></label>
                        <br clear="all" />
                    </div>
                    <div id="atc_total_image_nav" >
                        <a href="#" id="prev"><img src="prev.png"  alt="Prev" border="0" /></a><a href="#" id="next"><img src="next.png" alt="Next" border="0" /></a>
                    </div>

                    <div id="atc_total_images_info" >
                        Showing <span id="cur_image_num">1</span> of <span id="atc_total_images">1</span> images
                    </div>
                    <br clear="all" />
                </div>
                <!-- END - URL - Attachment content -->
            </div>
            @include('plugins.options')
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
