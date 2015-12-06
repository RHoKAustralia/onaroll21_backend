@section('sidenav')
<div class="col-md-3 col-sm-3">
<div class="sidebar">
    <ul id="nav" style="">
        <!-- Main menu with font awesome icon -->
        @if($groups = Auth::user()->getGroups())
        @foreach($groups as $group)
           @if($groupusers=$group->getUserList())
                @foreach($groupusers as $user)
                @if(Auth::user()->id != $user->id)
                <li>
                    <a href="/messages/message/{{ $user->id }}">
                        <img class="img img-circle" {{ $user->getPictureSrc('35x35') }} width="35px" height="35px" />
                        {{ $user->getDisplayName() }}
                    </a>
                </li>
                @endif
                @endforeach
           @endif
        @endforeach
        @endif
    </ul>
</div>
</div>
@stop

@section('content')
<div class="col-md-9 col-sm-9">
<!-- Widget -->
<div class="widget">
    <!-- Widget title -->
    <div class="widget-head">
        <div class="pull-left">{{ $touser->getDisplayName() }}</div>
        <div class="widget-icons pull-right">
            <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
            <a href="#" class="wclose"><i class="icon-remove"></i></a>
        </div>  
        <div class="clearfix"></div>
    </div>
    <div class="widget-content">
        <!-- Widget content -->
        <div class="padd">

            <ul class="chats">
                
                @foreach($messages as $message)
                    @if($message->from == $fromuser->id)
                    <!-- Chat by us. Use the class "by-me". -->
                    <li class="by-me">
                        <!-- Use the class "pull-left" in avatar -->
                        <div class="avatar pull-left">
                            <img {{ $fromuser->getPictureSrc('50x50') }} alt="" width="50px" height="50px" />
                        </div>

                        <div class="chat-content">
                            <!-- In meta area, first include "name" and then "time" -->
                            <div class="chat-meta">{{ $fromuser->getDisplayName() }} <span class="pull-right">{{ $message->created_at->subMinutes(2)->diffForHumans(); }}</span></div>
                            {{ $message->message }}
                            <div class="clearfix"></div>
                        </div>
                    </li>
                    @elseif($message->from == $touser->id)
                    <!-- Chat by other. Use the class "by-other". -->
                    <li class="by-other">
                        <!-- Use the class "pull-right" in avatar -->
                        <div class="avatar pull-right">
                            <img {{ $touser->getPictureSrc('50x50') }} alt="" width="50px" height="50px" />
                        </div>

                        <div class="chat-content">
                            <!-- In the chat meta, first include "time" then "name" -->
                            <div class="chat-meta">{{ $message->created_at->subMinutes(2)->diffForHumans(); }} <span class="pull-right">{{ $touser->getDisplayName() }}</span></div>
                            {{ $message->message }}
                            <div class="clearfix"></div>
                        </div>
                    </li>   
                    @endif
                @endforeach
            </ul>
        </div>
        <!-- Widget footer -->
        <div class="widget-foot">
            {{ Form::open(['url'=>'/messages/message','class'=>'form-inline']) }}
            {{ Form::hidden('fromuser',$fromuser->id) }}
            {{ Form::hidden('touser',$touser->id) }}
            {{ FormField::custom(['type'=>'text','name'=>'message','label'=>'','placeholder'=>'Type your message here']) }}
            {{ Form::submit('Send',['class'=>'btn btn-default']) }}
            {{ Form::close() }}
        </div>
    </div>


</div> 
</div>
@stop