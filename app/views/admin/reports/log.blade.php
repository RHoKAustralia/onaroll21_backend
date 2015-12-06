@extends('layouts.master')

@section('content')
<!-- Main bar -->
  	<div class="mainbar">
<!-- Page heading -->
<div class="page-head">
    <h2 class="pull-left"><i class="glyphicon glyphicon-user"></i> {{ Lang::get('reports.logs') }}</h2>

    <div class="clearfix"></div>

</div>
<!-- Page heading ends -->


<!-- Matter -->

<div class="matter">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <table class="table table-striped table-bordered" style="width:90%">
                    <thead>
                        <tr>
                            <th>{{ t('master.username') }}</th>
                            <th>{{ t('master.firstname') }}</th>
                            <th>{{ t('master.lastname') }}</th>
                            <th>{{ t('master.organisation') }}</th>
                            <th>{{ t('reports.firstlogin') }}</th>
                            <th>{{ t('reports.lastlogin') }}</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($logs as $log)
                        <tr>
                            <td>{{ $log->username }}</td>
                            <td>{{ $log->firstname }}</td>
                            <td>{{ $log->lastname }}</td>
                            <td>{{ $log->organisation }}</td>
                            <td>{{ $log->firstlogin }}</td>
                            <td>{{ $log->lastlogin }}</td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Matter ends -->

</div>

<!-- Mainbar ends -->	    	
<div class="clearfix"></div>
@stop