@section('content')
<div class="groups-container">
    <h3><i class="fa fa-users"> </i> {{ trans('master.members') }}</h3>
    {{ trans('master.membersintro',array('name'=>Auth::user()->firstname)) }}
    <div class="row">
        @foreach($members as $member)
        @if($member->id != Auth::user()->id)
        <div class="col-md-6 col-sm-12 member-tile">
                <div class="row">
                <div class="col-md-5 col-sm-12">
                    <img {{ $member->getPictureSrc('150x150') }} alt="..." class="img user-picture" width="150px" height="150px" />
                </div>

                <div class="col-md-7 col-sm-12">
                    <div class="group-intro">
                        <h5 class="group-name">{{ HTML::link('/user/profile/view/'.$member->id,$member->getDisplayName()) }}</h5>
                        <span class="group-members-count">{{ trans('master.datejoined').' '.$member->created_at }}</span>
                    </div>
                    
                    <div class="group-options">
                    <p>
                        {{ HTML::link('/user/profile/view/'.$member->id, trans('master.viewprofile'),['class'=>'btn btn-default btn-xs join-group']) }}
                    </p>
                    <p>
                        {{ HTML::link('/messages/message/'.$member->id, trans('master.message'),['class'=>'btn btn-default btn-xs']) }}
                    </p>
                    
                </div>
            </div>
            </div>
        </div>
        @endif
        @endforeach
    </div>
</div>

@stop