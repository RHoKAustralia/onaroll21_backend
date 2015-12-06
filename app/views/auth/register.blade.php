@section('content')
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-8">
                <div class="signup-form">
                    <h5>{{ strtoupper(trans('master.signupheading')) }}</h5>
                    @if($errors->any())
                    <div class="alert alert-danger">
                        <a class="close" href="#" data-dismiss="alert">x</a>
                      <ul>
                        {{ implode('', $errors->all('<li>:message</li>'))}}
                      </ul>
                    </div>
                    @endif

                    {{ Form::open(array('route' => 'register.store')) }}

                        {{ FormField::username(['label'=>trans('master.username'),
                                                'value'=>Input::old('username')]) }}
                        {{ FormField::password(['label'=>trans('master.password'),
                                                'value'=>Input::old('password')]) }}
                        {{ FormField::email(['label'=>trans('master.email'),
                                                'value'=>Input::old('email')]) }}
                        {{ FormField::custom(['type'=>'text',
                                                'label'=>trans('master.firstname'),
                                                'name'=>'firstname',
                                                'value'=>Input::old('firstname')]) }}
                        {{ FormField::custom(['type'=>'text',
                                                'label'=>trans('master.lastname'),
                                                'name'=>'lastname',
                                                'value'=>Input::old('lastname')]) }}
                        {{ FormField::custom(['type'=>'text',
                                                'label'=>trans('master.city'),
                                                'name'=>'city',
                                                'value'=>Input::old('city')]) }}
                        {{ FormField::custom(['type'=>'text',
                                                'label'=>trans('master.country'),
                                                'name'=>'country',
                                                'value'=>Input::old('country')]) }}
                        {{ FormField::custom(['type'=>'text',
                                                'label'=>trans('master.organisation'),
                                                'name'=>'organisation',
                                                'value'=>Input::old('organisation')]) }}
                        {{ FormField::description(['label'=>trans('master.description'),
                                                'name'=>'description','rows'=>3,
                                                'value'=>Input::old('description')]) }}
                        {{ Form::label('picture',trans('master.userpicture'))}}
                        {{ Form::file('picture',array('id'=>'picture')) }}
                        {{ Form::captcha() }}
                        <p><small>{{ trans('master.signupagreement') }}</small></p>
                        <br /><br />
                        {{ Form::submit(trans('master.signupbtn'),array('class'=>'btn btn-warning btn-sm'))}}

                    {{ Form::close() }}
                </div>
            </div>
            <div class="col-md-4">
                <div class="signuppanel"> 
                    {{ trans('master.haveaccount') }}
                    <br />
                    {{ HTML::link('/login',trans('master.login'),array('class'=>'')) }} 
                    {{ trans('master.or') }}
                    <br />
                    {{ HTML::link('password/remind',trans('master.resetpassword'),array('class'=>'')) }}
                </div>
                <div class="moreinfo-panel">
                    {{ trans('master.wanttolearnmore') }}
                    <br />
                    {{ HTML::link('/register',trans('master.seehow'),array('class'=>'')) }}
                </div>
            </div>
        </div>
    </div>
@stop