@section('content')
    <h3>Existing users in role: {{ $role->name }}</h3>
    
    <table class="table table-responsive table-striped table-bordered">
        <thead>
            <tr>
                <th>#</th>
                <th>{{ trans('master.username') }}</th>
                <th>{{ trans('master.name') }}</th>
                <th>{{ trans('master.email') }}</th>
                <th>{{ trans('master.action') }}</th>
            </tr>
        </thead>
        <tbody>
            @if($users=User::all())
            @foreach($users as $user)
            <tr>
                <td>{{ $user->id }}</td>
                <td>{{ $user->username }}</td>
                <td>{{ $user->firstname }} {{ $user->lastname }}</td>
                <td>{{ $user->email }}</td>
                <td>
                    {{ Form::open(array('url' => 'role/update')) }}
                    {{ Form::hidden('roleid',$role->id) }}
                    {{ Form::hidden('userid',$user->id) }}
                    @if($role->hasUser($user->id))
                    {{ Form::submit(trans('master.deletebtn'),array('class'=>'btn btn-xs btn-danger','name'=>'removeuser')) }}
                    @else
                    {{ Form::submit(trans('master.adduserbtn'),array('class'=>'btn btn-xs btn-success','name'=>'adduser')) }}
                    @endif
                    {{ Form::close() }}
                </td>
            </tr>
            @endforeach
            @endif
        </tbody>
    </table>
@stop