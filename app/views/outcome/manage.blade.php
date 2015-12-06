@section('content')
<h3>All Outcomes on system</h3>
<table class="table table-striped table-bordered">
    <thead>
        <tr>
            <th>#</th>
            <th>Name</th>
            <th>Description</th>
            <th>Type</th>
            <th>Tasks</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        @foreach($outcomes as $outcome)
        <tr>
            <td>{{ $outcome->id }}</td>
            <td>{{ $outcome->name }}</td>
            <td>{{ $outcome->description }}</td>
            @if($outcome->type == 0)
            <td>Public</td>
            @else
            <td>Private</td>
            @endif
            <td>{{ $outcome->getTaskCount() }}</td>
            <td>
            {{ Form::open(array('url' => 'outcome/update')) }}
                {{ Form::hidden('id',$outcome->id) }}
                {{ Form::submit(trans('master.editbtn'),array('class'=>'btn btn-xs btn-success','name'=>'edit')) }}
                @if($outcome->suspended)
                    {{ Form::submit(trans('master.suspendbtn'),array('class'=>'btn btn-xs btn-warning','name'=>'suspend','disabled'=>'disabled')) }}
                    {{ Form::submit(trans('master.activatebtn'),array('class'=>'btn btn-xs btn-success','name'=>'activate')) }}
                @else
                {{ Form::submit(trans('master.suspendbtn'),array('class'=>'btn btn-xs btn-warning','name'=>'suspend')) }}
                @endif
                {{ Form::submit(trans('master.deletebtn'),array('class'=>'btn btn-xs btn-danger','name'=>'delete')) }}
                {{ Form::submit(trans('master.addtask'),array('class'=>'btn btn-xs btn-success','name'=>'addtask')) }}
            {{ Form::close() }}
            </td>
        </tr>
        @endforeach
    </tbody>
</table>
@stop