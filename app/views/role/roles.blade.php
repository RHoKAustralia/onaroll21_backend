@section('content')
    <h3>All roles on system</h3>
    <table class="table table-striped table-bordered">
    <thead>
        <tr>
            <th>#</th>
            <th>Short name</th>
            <th>Full name</th>
            <th>Description</th>
            <th>Users</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
    @foreach($roles as $role)
    <tr>
        <td>{{ $role->id }}</td>
        <td>{{ $role->name }}</td>
        <td>{{ $role->fullname }}</td>
        <td>{{ $role->description }}</td>
        <td>{{ $role->getUserCount() }}</td>
        <td>
            {{ Form::open(array('url' => 'role/update')) }}
            {{ Form::hidden('id',$role->id) }}
            {{ Form::submit(trans('master.editbtn'),array('class'=>'btn btn-xs btn-success','name'=>'edit')) }}
            {{ Form::submit(trans('master.addremoveusers'),array('class'=>'btn btn-xs btn-success','name'=>'addremoveusers')) }}
            {{ Form::submit(trans('master.deletebtn'),array('class'=>'btn btn-xs btn-danger','name'=>'delete')) }}
            {{ Form::close() }}
        </td>
    </tr>
    @endforeach
    </tbody>
</table>
    {{ HTML::link('role/add',trans('master.addnewrole')) }}
@stop