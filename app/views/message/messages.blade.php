@section('sidenav')
<div class="col-md-3">
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
Please select a user from the list to start/open a conversation
@stop