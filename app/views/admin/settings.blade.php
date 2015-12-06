@section('content')

{{ Form::open(['url'=>'admin/site']) }}

    
    
    <div class="page-title">Site Settings</div>
                      
                      <label for="sitetitle">Site title</label>
                      <input class="form-control" type="text" name="sitetitle" placeholder="Site name" value="{{ Settings::where('name','sitetitle')->count() ? Settings::where('name','sitetitle')->pluck('value') : '' }}" id="sitetitle">
                      <label for="punchline">Punch line</label>
                      <input class="form-control" type="text" name="punchline" placeholder="Punch line..." value="{{ Settings::where('name','punchline')->count() ? Settings::where('name','punchline')->pluck('value') : '' }}" id="punchline">
                      <label for="punchline">Maximum members in group</label>
                      <input class="form-control" type="text" name="maxgroupmembers" placeholder="members in group" value="{{ Settings::where('name','maxgroupmembers')->count() ? Settings::where('name','maxgroupmembers')->pluck('value') : 12 }}" id="maxgroupmembers">
                      
                      <div class="row">
                        <div class="input-field col s12">
                          <textarea id="sitedescription" name="sitedescription" class="materialize-textarea">{{ Settings::where('name','sitedescription')->count() ? Settings::where('name','sitedescription')->pluck('value') : '' }}</textarea>
                          <label for="textarea1">Site Description</label>
                        </div>
                      </div>
                      
                    

    
    {{ Form::submit('Save',['name'=>'savesettings','class'=>'btn btn-warning btn-sm']) }}
{{ Form::close() }}
<br /><br />
@stop
