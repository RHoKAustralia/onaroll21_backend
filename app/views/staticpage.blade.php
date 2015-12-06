@extends('layouts.master')
@section('content')
<div class="static-page">
<h3 class="static-page-heaidng">{{ $page->heading }}</h3>
<div class="static-page-text">
    {{ htmlspecialchars_decode($page->content) }}
</div>
</div>
@stop