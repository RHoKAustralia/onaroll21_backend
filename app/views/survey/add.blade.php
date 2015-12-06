@section('content')
    {{ Form::open(['url'=>'survey/add']) }}
    {{ FormField::custom(['type'=>'text',
                            'name'=>'name',
                            'label'=>trans('master.name')
    ]) }}
    <div class="input-field col s12">
                          <textarea id="description" name="description" class="materialize-textarea"></textarea>
                          <label for="description">Site Description</label>
                        </div>
    {{ Form::submit(trans('master.savesurvey'),['name'=>'save','class'=>'btn btn-success']) }}
@stop