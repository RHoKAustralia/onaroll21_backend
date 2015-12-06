@extends('layouts.master')

@section('content')
<!-- Main bar -->
  	<div class="mainbar">
<!-- Page heading -->
<div class="page-head">
    <h2 class="pull-left"><i class="glyphicon glyphicon-user"></i> User management</h2>

    <div class="clearfix"></div>

</div>
<!-- Page heading ends -->


<!-- Matter -->

<div class="matter">
    
        <div class="row">
            <div class="col-md-12">


               
                <table class="table table-striped striped table-bordered">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>{{ t('master.firstname') }}</th>
                            <th>{{ t('master.username') }}</th>
                            <th>{{ t('master.lastname') }}</th>
                            <th>{{ t('master.action') }}</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($users as $user)
                        @if($user->suspended)
                        <tr class="warning">
                            @else
                        <tr>
                            @endif
                            <td>{{ $user->id }}</td>
                            <td><a href="/user/profile/view/{{ $user->id }}">{{ $user->username }}</a></td>
                            <td>{{ $user->firstname }}</td>
                            <td>{{ $user->lastname }}</td>
                            <td>
                                {{ Form::open(array('url' => 'user/update')) }}
                                {{ Form::hidden('id',$user->id) }}
                                {{ Form::submit(trans('master.editbtn'),array('class'=>'btn btn-xs btn-success','name'=>'edit')) }}
                                @if($user->suspended)
                                {{ Form::submit(trans('master.suspendbtn'),array('class'=>'btn btn-xs btn-warning','name'=>'suspend','disabled'=>'disabled')) }}
                                {{ Form::submit(trans('master.activatebtn'),array('class'=>'btn btn-xs btn-success','name'=>'activate')) }}
                                @else
                                {{ Form::submit(trans('master.suspendbtn'),array('class'=>'btn btn-xs btn-warning','name'=>'suspend')) }}
                                @endif
                                {{ Form::submit(trans('master.deletebtn'),array('class'=>'btn btn-xs btn-danger','name'=>'delete')) }}
                               
                                @if($user->suspend_after === 1)
                                
                                <input class="btn btn-xs btn-warning" name="deactivesap" value="DEACTIVE SUSPEND AFTER PERIOD " type="submit" >

                                
                                @endif

                                @if($user->suspend_after === 0)
                                
                                <input class="btn btn-xs btn-success" name="activesap" value="ACTIVE SUSPEND AFTER PERIOD " type="submit" >

                                
                                @endif
                                {{ Form::close() }}
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
                {{ HTML::link('user/add',trans('master.addnewuser')) }}

            </div>
        </div>
    
</div>

<!-- Matter ends -->

</div>

<!-- Mainbar ends -->	    	
<div class="clearfix"></div>
@stop