<!--<ul class="nav nav-tabs">
    <li class="active"><a href="#text" data-toggle="tab"><span class="glyphicon glyphicon-text-width"></span></a></li>
    <li><a href="#image" data-toggle="tab"><span class="glyphicon glyphicon-camera"></span></a></li>
    <li><a href="#video" data-toggle="tab"><span class="glyphicon glyphicon-film"></span></a></li>
</ul>-->
<!-- Tab panes -->
<div class="tab-content">
    @include('plugins.status_text')
  <div class="tab-pane" id="image">
@include('plugins.status_image')
<!-- The fileinput-button span is used to style the file input field as button -->
<!--    <span class="btn btn-success fileinput-button">
        <i class="glyphicon glyphicon-plus"></i>
        <span>Add files...</span>
         The file input field used as target for the file upload widget 
        <input id="fileupload" type="file" name="files[]" multiple>
    </span>-->
    <br>
    <br>
    <!-- The global progress bar -->
<!--    <div id="progress" class="progress">
        <div class="progress-bar progress-bar-success"></div>
    </div>-->
    <!-- The container for the uploaded files -->
    <div id="files" class="files"></div>
    <br>
  </div>
    <!-- Video tab will be enabled later -->
<!--  <div class="tab-pane" id="video">
      @include('plugins.status_image')
  </div>-->
<!--</div>-->