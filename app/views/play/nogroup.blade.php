@extends('layouts.master')

@section('content')
    Oh no, you do not appear to be a part of any group. To play, you need to be 
    part of atleast one group. {{ HTML::link('/groups',trans('master.clickhere')) }} to 
    subscribe to one of the public groups
@stop