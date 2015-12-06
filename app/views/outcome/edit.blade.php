@section('content')
    {{ Form::open(['url'=>'outcome/update']) }}
        {{ Form::hidden('id',$outcome->id) }}
        {{ FormField::custom(['type'=>'text','name'=>'name','placeholder'=>trans('master.outcomename'),'value'=>$outcome->name]) }}
        {{ FormField::description(['name'=>'description','placeholder'=>trans('master.outcomedescription'),'rows'=>3,'value'=>$outcome->description]) }}
        {{ FormField::custom(['type'=>'select','name'=>'type','value'=>array('public','private'),'default'=>$outcome->type]) }}
        {{ Form::submit(trans('master.updateoutcome'),['class'=>'btn btn-success','name'=>'update']) }}
    {{ Form::close() }}
@stop
