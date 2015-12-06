@section('content')
<h3>{{ trans('master.assigncapabilities') }}</h3>
    @if(!empty($capabilities))
    <table class="table table-striped table-condensed">
        <tr>
            <th>#</th>
            <th>Capability</th>
            <th>Description</th>
            @if($roles=Role::all())
                @foreach($roles as $role)
                    <th>{{ trans($role->name) }}</th>
                @endforeach
            @endif
        </tr>
        @foreach($capabilities as $capability)
        <tr>
            <td>{{ $capability->id }}</td>
            <td>{{ $capability->name }}</td>
            <td>{{ trans($capability->name) }}</td>
            @foreach($roles as $role)
                <td>
                    {{ Form::open(['url'=>'/roles/capability/update']) }}
                    {{ Form::hidden('capid',$capability->id) }}
                    {{ Form::hidden('roleid',$role->id) }}
                    @if($role->hasCapability($capability->id))
                    {{ Form::submit(trans('master.deletebtn'),
                                    [
                                        'class'=>'btn btn-xs btn-danger',
                                        'name'=>'delete'
                                    ]) }}
                    @else
                    {{ Form::submit(trans('master.addbtn'),
                                    [
                                        'class'=>'btn btn-xs btn-success',
                                        'name'=>'add'
                                    ]) }}
                    @endif
                    {{ Form::close()}}
                </td>
            @endforeach
        </tr>
        @endforeach
    </table>
    @else
        <h3>There are no capabilities on the system</h3>
    @endif
   
@stop