@section('content')
<?php
$survey = Survey::find($group->survey);
if(!is_null($survey)) {
    $data = unserialize($survey->data);
    $fields = json_decode($data[0])->fields;
}
?>
<!-- REMOVED AS PER FEEDBACK -->
<!--<div class="banner">
    <img src="{{ asset('images/survey_page_bg.png') }}" alt="banner" width="100%" />
    <div class="container-fluid">
        <div class="row intro">
            <div class="col-md-4"></div>
            <div class="front-page-intro col-md-4 col-sm-5">
                <span class="intro-frame intro-top">
                    {{ trans('master.surveypageintrotop') }}
                </span>
                <span class="intro-frame intro-bottom">
                    {{ trans('master.surveypageintrobottom') }}
                </span>
            </div>
        </div>
    </div>
</div>-->
<div class="clearfix"></div>
@if(!is_null($survey))
<div class="survey-container">
    <div class="container">
        <div class="row">
            <div class="survey-heading col-md-4 col-md-offset-4">
                <h3>{{ trans('master.presurveyhead') }}</h3>
            </div>
        </div>
        <p>{{ $survey->getPreMessage() }}</p>
        <div class="row">
            <div class="survey-form">
                {{ Form::open(['url'=>'survey/response/save','parsley-validate'=>'','id'=>'presurveyform']) }}
                {{ Form::hidden('userid',$user->id) }}
                {{ Form::hidden('groupid',$group->id) }}
                {{ Form::hidden('surveyid',$survey->id) }}
                {{ Form::hidden('type','pre') }}
                <?php $count = 0 ?>
                @foreach($fields as $field)
                <div class="survey-field">
                    <?php $count++ ?>
                    @if($field->field_type =='radio')
                    <div class="survey-question">
                        {{ Form::label(strtolower($field->label),$count.'. '.$field->label) }}<br />
                    </div>
                    
                    <div class="survey-answers">
                        <div class="row">
                        @foreach($field->field_options->options as $option)
                        <div class="survey-answer-options col-md-1 col-xs-1">
                            {{ Form::radio($field->cid,$option->label,'',['data-required'=>'true','class'=>'required']) }}
                            {{ Form::label(strtolower($option->label),$option->label) }}
                        </div>
                        @endforeach
                        </div>
                         <div class="selector"></div>
                         <br />
                    <div class="slider"></div>
                    </div>
                    <br />
                    @else
                    <div class="survey-question">
                        {{ Form::label(strtolower($field->label),$count.'. '.$field->label) }}<br />
                    </div>
                    <div class="survey-answer">
                        {{ FormField::custom(['name'=>$field->cid,
                        'type'=>$field->field_type,
                        'label'=>'',
                        'options'=>isset($field->field_options->options) ? $field->field_options->options :''
                        ]) 
                        }}
                    </div>
                    @endif
                </div>
                @endforeach
                {{ Form::submit('Submit',['class'=>'btn btn-success btn-sm']) }}
                {{ Form::close() }}
            </div>
        </div>
    </div>
</div>
@endif
@stop
