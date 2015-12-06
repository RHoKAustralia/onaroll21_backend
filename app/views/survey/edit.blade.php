@section('content')
    {{ Form::open(['url'=>'survey/update']) }}
    {{ Form::hidden('id',$survey->id) }}
    {{ FormField::custom(['type'=>'text',
                            'name'=>'name',
                            'label'=>trans('master.name'),
                            'value'=>$survey->name
    ]) }}
    {{ FormField::description(['name'=>'description',
                                'rows'=>3,
                                'value'=>$survey->description
    ]) }}
    {{ Form::submit(trans('survey.updatesurveybtn'),['name'=>'update','class'=>'btn btn-success btn-sm']) }}
@stop