@section('content')
{{ Form::open(['action'=>'RoleController@updateRole']) }}
{{ Form::hidden('roleid',$role->id) }}
{{ FormField::custom([
                        'type'=>'text',
                        'name'=>'shortname',
                        'label'=>'Role short name',
                        'value'=>$role->name
                        ]) 
                    }}
{{ FormField::custom(['type'=>'text','name'=>'fullname','label'=>'Role full name','value'=>$role->fullname]) }}
{{ FormField::description(['name'=>'description','label'=>'Description','rows'=>3,'value'=>$role->description]) }}
{{ Form::submit(trans('master.updaterole'),['class'=>'btn btn-success','name'=>'update']) }}
{{ Form::close() }}
@stop
