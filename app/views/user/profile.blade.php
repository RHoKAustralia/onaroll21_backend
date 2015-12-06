@section('content')
<div class="profile-container container">
    <div class="row">
        <div class="user-image-container col-sm-6 col-md-3 col-lg-3 col-xs-12">
                <img {{ $user->getPictureSrc('200x200') }} 
                       class="user-image" height="" width="100%" alt="..."/>
            <br />
        </div>
        <div class="name-container col-sm-9 col-md-9 col-lg-9">
            <h2>{{ $user->getDisplayName() }}</h2>
            <p>{{ t('master.joined').': ' }}{{ $user->created_at->subMinutes(2)->diffForHumans() }}</p>
             <div class="user-options">
                @if(Auth::user()->id == $user->id)
                <a href="/user/profile/edit"><i class="glyphicon glyphicon-pencil"></i> </a>
                <a href="/messages"><i class="glyphicon glyphicon-envelope"></i> </a>
                @else
                <a href="/messages/message/{{ $user->id }}"><i class="glyphicon glyphicon-envelope"></i> </a>
                @endif
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3">
            <div class="details-container">
                <p><b>{{ trans('profile.team') }} </b>@if(isset($user->groups()->first()->name)){{ $user->groups()->first()->name }}@else {{ '' }}@endif </p>
                
                @if(Auth::user()->hasRole('admin') || Auth::user()->id==$user->id)
                <p><span class="details-divider"></span></p>
                <p><b>{{ trans('profile.email') }} </b>{{ $user->email }}</p>
                @endif
                <p><span class="details-divider"></span></p>
                <p><b>{{ trans('profile.messages') }} </b>{{ $user->getMessageCount() }}</p>
                <p><b>{{ trans('profile.taskscompleted') }} </b>{{ $user->completedTaskCount() }}</p>
            </div>
        </div>
        <div class="col-sm-9 col-md-9 col-lg-9">
            @if(Auth::user()->id == $user->id || Auth::user()->hasRole('admin'))
            <div class="user-details-container">
                <ul class="nav nav-tabs">
                  <li class="active"><a href="#wbgraph" data-toggle="tab">{{ trans('master.wellbeinghistory') }}</a></li>
                  <li><a href="#words" data-toggle="tab">Word CLoud</a></li>
                  <li><a href="#photos" data-toggle="tab">Photo Montage</a></li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                  <div class="tab-pane active" id="wbgraph">
                      <h3>{{ trans('master.wellbeinghistory') }}</h3>
                        <div id="wellbeing-tracker">
                        </div>
                  </div>
                  <div class="tab-pane" id="words">
                        @if($user->postSurveyCompleted($user->groups()->first()->id))
                        <!-- Word cloud -->
                        <div id="wordcloud2" class="wordcloud">
                            <?php $words=$user->getWords(); ?>
                            @foreach($words as $key => $freq)
                            <span data-weight="{{ ($freq*10)+10 }}">{{ $key }}</span>
                            @endforeach
                        </div>
                        @else
                        <h2>Please complete the post survey to reveal the word cloud.</h2>
                        @endif
                  </div>
                  <div class="tab-pane" id="photos">
                      @if($user->postSurveyCompleted($user->groups()->first()->id))
                      <div style="width:100%;height:400px;overflow-y:scroll; margin:40px auto;">
                      <div class="am-container" id="am-container">
                          @foreach($user->groups as $group)
                          {{ $group->getImages(); }}
                          @endforeach
                    </div>
                      </div>
                      @else
                      <h2>Please complete the post survey to reveal the photo montage.</h2>
                      @endif
                  </div>
                </div>
                
               
            </div>
            @endif
        </div>
    </div>
    </div>
<!-- Profile Container-->
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">{{ $user->firstname.' '.$user->lastname }}</h4>
      </div>
      <div class="modal-body">
        {{ Form::open(['url'=>'message/send']) }}
        {{ FormField::custom(['type'=>'textarea','name'=>'message']) }}
        {{ Form::close() }}
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-send"></span></button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
@stop

@section('extrafootercontent')
<script src="/js/profile/excanvas.min.js"></script>
<script src="/js/profile/jquery.flot.js"></script>
<script src="/js/profile/jquery.flot.resize.js"></script>
<script>
    var data=[
        @for($i=0;$i<=21;$i++)
            @if(!empty($wellbeing))
                @foreach($wellbeing as $track)
                    @if($track->day == $i)
                        {{ '['.$track->day.',"'.($track->mood).'"],' }}
                    @endif
                @endforeach
            @endif
        @endfor
    ];
    var options={
        series: {
            lines: { show: true,fill:false },
            stack: true,
            points: { show: true }
        },
        yaxis: {
            ticks: [
                [1,'{{ trans("profile.terrible") }}'],
                [2,'{{ trans("profile.notgreat") }}'],
                [3,'{{ trans("profile.neutral") }}'],
                [4,'{{ trans("profile.prettygood") }}'],
                [5,'{{ trans("profile.fantastic") }}']
            ],
            tickSize: 1,
            min: 0,
            max: 6
          },
          xaxis: {
         
     ticks: [
                0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
            ],
              tickSize: 1,
              min: 0,
              max: 21
          },
          colors: ["#f79420"]
    };
    var placeholder = $('#wellbeing-tracker');
    //var plot = $("#wellbeing-tracker").plot(data, options).data("plot");
    var plot = $.plot(placeholder, [data], options);
</script>
<script>
    $("#wordcloud2").awesomeCloud({
            "size" : {
                    "grid" : 9,
                    "factor" : 1
            },
            "options" : {
                    "color" : "random-light",
                    "rotationRatio" : 0.35
            },
            "font" : "'Times New Roman', Times, serif",
            "shape" : "circle"
    });
</script>
<script>
    var $container 	= $('#am-container'),
            $imgs		= $container.find('img').hide(),
            totalImgs	= $imgs.length,
            cnt			= 0;

    $imgs.each(function(i) {
            var $img	= $(this);
            $('<img/>').load(function() {
                    ++cnt;
                    if( cnt === totalImgs ) {
                            $imgs.show();
                            $container.montage({
                                    fillLastRow	: true,
                                            alternateHeight	: true,
                                            alternateHeightRange : {
                                                    min	: 90,
                                                    max	: 240
                                            },
                                            margin : 2
                            });

                            /* 
                             * just for this demo:
                             */
                            $('#overlay').fadeIn(500);
                    }
            }).attr('src',$img.attr('src'));
    });		
</script>
@stop