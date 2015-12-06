@section('content')
<link rel="stylesheet" href="http://cdn.embed.ly/jquery.preview-0.3.2.css" />
<div class="updater">
  <i class="fa fa-pencil"></i>
  <div class="inner">
    <i class="up-arrow"></i>
    <form action="/test/status/update" method="POST">
    <input id="url" type="text" name="url"/>

    <!-- Placeholder that tells Preview where to put the selector-->
    <div class="selector-wrapper"></div>
    <input class="btn btn-primary btn-sm" type="submit" value="Post" />
</form>
  </div>
  <div class="selector-wrapper">
  </div>
</div>
<div id="feed"></div>
<script src="http://cdn.embed.ly/jquery.embedly-3.0.5.min.js" type="text/javascript"></script>
  <script src="http://cdn.embed.ly/jquery.preview-0.3.2.min.js" type="text/javascript"></script>
  {{ HTML::script('js/test.js') }}
@stop