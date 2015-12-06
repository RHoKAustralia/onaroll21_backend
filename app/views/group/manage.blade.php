

@section('content')
<br /><br />
    <h3>All groups on the system</h3>
    <table class="table table-striped striped table-bordered">
    <thead>
        <tr>
            <th>#</th>
            <th>Name</th>
            <th>Description</th>
            
            <th>Start date</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
    @foreach($groups as $group)
    <tr>
        <td>{{ $group->id }}</td>
        <td>{{ $group->name }}</td>
        <td>{{ $group->description }}</td>
        
        <td>{{ date('d-m-Y',$group->timestart) }}</td>
        <td>
            {{ Form::open(array('url' => 'group/update')) }}
            {{ Form::hidden('id',$group->id) }}
            {{ Form::submit(trans('master.editbtn'),array('class'=>'btn btn-xs btn-default','name'=>'edit')) }}
            {{ Form::submit(trans('master.addremoveusers'),array('class'=>'btn btn-xs btn-default','name'=>'addremusers')) }}
            {{ Form::submit(trans('master.deletebtn'),array('class'=>'btn btn-xs btn-danger','name'=>'delete')) }}
            {{ Form::close() }}
        </td>
    </tr>
    @endforeach
    </tbody>
</table>
    {{ HTML::link('group/add',trans('master.addgroup')) }}
@stop