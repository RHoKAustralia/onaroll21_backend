@section('content')
<h3>All surveys on the system</h3>
@if($surveys->count() > 0)
<table class="table striped highlight table-striped table-bordered">
    <thead>
        <tr>
            <th>#</th>
            <th>Name</th>
           
            <th style="text-align: right;">Action</th>
        </tr>
    </thead>
    <tbody>
        @foreach($surveys as $survey)
        <tr>
            <td>{{ $survey->id }}</td>
            <td>{{ $survey->name }}</td>
           
            <td style="text-align: right;">
                {{ Form::open(array('url' => 'survey/update')) }}
                {{ Form::hidden('id',$survey->id) }}
                {{ Form::submit(trans('master.editbtn'),array('class'=>'btn btn-xs btn-warning','name'=>'edit')) }}
                {{ Form::submit(trans('master.addfieldsbtn'),array('class'=>'btn btn-xs btn-success','name'=>'addremovefields')) }}
                {{-- Form::submit(trans('master.addmessagesbtn'),array('class'=>'btn btn-xs btn-primary','name'=>'addmessages')) --}}
                {{ Form::close() }}
            </td>
        </tr>
        @endforeach
    </tbody>
</table>
@else
<p>{{ trans('master.nosurveys') }}</p>
@endif
<br />
{{ HTML::link('survey/add',trans('master.addnewsurvey')) }}
@stop