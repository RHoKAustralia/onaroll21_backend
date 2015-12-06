@section('content')
<h3>Add tasks to: {{ $outcome->name }}</h3>
<table class="table table-striped striped table-bordered">
    <thead>
        <tr>
            <th>#</th>
            <th>Name</th>
           
            
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        @if($tasks=Task::all())
    @foreach($tasks as $task)
    @if($task->id != 0)
    <tr>
        <td>{{ $task->id }}</td>
        <td>{{ $task->name }}
        {{ Form::open(array('url' => 'task/update')) }}
            {{ Form::hidden('id',$task->id) }}
            <input class="btn btn-xs btn-success" name="edit" value="Edit Mission" type="submit">
            
            {{ Form::close() }}
        </td>
        
        
        <td style="float:right;">
            
            {{ Form::open(array('url' => 'outcome/addtask')) }}
            {{ Form::hidden('outcomeid',$outcome->id) }}
            {{ Form::hidden('id',$task->id) }}
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            @if($outcome->hasTask($task->id))
            {{-- Form::submit(trans('master.removebtn'),array('class'=>'btn btn-xs btn-danger','name'=>'remove')) --}}
            <p>
                <input type="checkbox" class="filled-in" name="taskid-{{$task->id}}"  id="taskid-{{$task->id}}" onclick="changeMission({{$outcome->id}}, {{$task->id}});" checked="checked" />
                <label for="taskid-{{$task->id}}"></label>
              </p>
            @else
            <p>
                
                <input type="checkbox" name="taskid-{{$task->id}}" class="filled-in" id="taskid-{{$task->id}}" onclick="changeMission({{$outcome->id}},{{$task->id}});" />
                <label for="taskid-{{$task->id}}"></label>
              </p>
            @endif
            {{-- Form::submit(trans('master.upbtn'),array('class'=>'btn btn-xs btn-primary','name'=>'up')) --}}
            {{-- Form::submit(trans('master.dwnbtn'),array('class'=>'btn btn-xs btn-primary','name'=>'down')) --}}
            @if($finalTask = $outcome->getFinalTask())
                @if($finalTask == $task->id)
                    {{ Form::submit(trans('master.removefinal'),array('class'=>'btn btn-xs btn-warning','name'=>'removefinal')) }}
                @endif
            @else
                {{ Form::submit(trans('master.markfinalbtn'),array('class'=>'btn btn-xs btn-primary','name'=>'markfinal')) }}
            @endif
            {{ Form::close() }}
        </td>
    </tr>
    @endif
    @endforeach
    @endif
    </tbody>
</table>
@stop