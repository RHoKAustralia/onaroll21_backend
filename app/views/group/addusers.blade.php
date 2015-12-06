@section('content')
<h3>Add users to: {{ $group->name }}</h3>
<table class="table table-striped table-bordered">
    <thead>
        <tr>
            <th>#</th>
            <th>{{ trans('master.name') }}</th>
            <th>{{ trans('master.organisation')}}</th>
            <th>{{ trans('master.email') }}</th>
            <th>{{ trans('master.action') }}</th>
        </tr>
    </thead>
    <tbody>
        @if($users=User::all())
    @foreach($users as $user)
    <tr>
        <td>{{ $user->id }}</td>
        <td>{{ $user->firstname.' '.$user->lastname }}</td>
        <td>{{ $user->organisation }}</td>
        <td>{{ $user->email }}</td>
        <td>
            {{ Form::open(array('url' => 'group/users')) }}
            {{ Form::hidden('userid',$user->id) }}
            {{ Form::hidden('id',$group->id) }}
            
            @if($user->hasGroup($group->id))
            {{ Form::submit(trans('master.removebtn'),array('class'=>'btn btn-xs btn-danger','name'=>'removeuser')) }}
            @else
                @if($group->getUserCount() >= Settings::getValue('maxgroupmembers'))
                {{ Form::submit(trans('master.addbtn'),array('class'=>'btn btn-xs btn-success','name'=>'adduser','disabled'=>'disabled')) }}
                @else
                {{ Form::submit(trans('master.addbtn'),array('class'=>'btn btn-xs btn-success','name'=>'adduser')) }}
                @endif
            @endif
            {{ Form::close() }}
        </td>
    </tr>
    @endforeach
    @endif
    </tbody>
</table>
@stop