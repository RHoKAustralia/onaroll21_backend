@section('content')
<h3>{{ trans('master.addoutcome') }}</h3>
    {{ Form::open(['url'=>'outcome/add']) }}
        {{ FormField::custom(['type'=>'text','name'=>'name','placeholder'=>trans('master.outcomename')]) }}
        <div class="input-field col s12">
                          <textarea id="description" name="description" class="materialize-textarea"></textarea>
                          <label for="description">Site Description</label>
                        </div>
        {{ FormField::custom(['type'=>'select','name'=>'type','value'=>array('public','private')]) }}
        {{ Form::submit(trans('master.addoutcome'),['class'=>'btn btn-success btn-sm','name'=>'add']) }}
    {{ Form::close() }}
@stop
