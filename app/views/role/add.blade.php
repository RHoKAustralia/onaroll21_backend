@section('content')
{{ Form::open(['action'=>'RoleController@addRole']) }}
{{ FormField::custom(['type'=>'text','name'=>'shortname','label'=>'Role short name']) }}
{{ FormField::custom(['type'=>'text','name'=>'fullname','label'=>'Role full name']) }}
{{ FormField::description(['name'=>'description','label'=>'Description','rows'=>3]) }}
{{ Form::submit(trans('master.addrole'),['class'=>'btn btn-success']) }}
{{ Form::close() }}
@stop
