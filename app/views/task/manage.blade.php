@extends('layouts.master')

@section('content')
    <h3>All tasks on the system</h3>
    <table class="table table-striped striped table-bordered">
    <thead>
        <tr>
            <th>#</th>
            <th>{{ t('master.taskname') }}</th>
            
            
            <th  style="text-align: right;">{{ t('master.action') }}</th>
        </tr>
    </thead>
    <tbody>
    @foreach($tasks as $task)
    @if($task->id != 0)
    <tr>
        <td>{{ $task->id }}</td>
        <td>{{ $task->name }}</td>
        
       
        <td  style="text-align: right;">
            {{ Form::open(array('url' => 'task/update')) }}
            {{ Form::hidden('id',$task->id) }}
            {{ Form::submit(trans('master.editbtn'),array('class'=>'btn btn-xs btn-success','name'=>'edit')) }}
            {{-- Form::submit(trans('master.suspendbtn'),array('class'=>'btn btn-xs btn-warning','name'=>'suspend')) --}}
            {{ Form::submit(trans('master.deletebtn'),array('class'=>'btn btn-xs btn-danger','name'=>'delete')) }}
            {{ Form::close() }}
        </td>
    </tr>
    @endif
    @endforeach
    </tbody>
</table>
    {{ HTML::link('task/add',trans('master.addnewtask')) }}
@stop