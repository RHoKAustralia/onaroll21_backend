





@section('content')
<style>

    .fb-save-wrapper{
        
        display: none !important;
        
        
    }    
    
</style>
<link href="https://dobtco.github.io/formbuilder/dist/formbuilder.css" rel="stylesheet" type="text/css"/>
<link href="https://dobtco.github.io/formbuilder/vendor/css/vendor.css" rel="stylesheet" type="text/css"/>
        

<script src="https://dobtco.github.io/formbuilder/vendor/js/vendor.js"></script>
<script src="https://dobtco.github.io/formbuilder/dist/formbuilder.js"></script>
<div id="survey-form-builder"></div>

<script>
$(function() {
    fb= new Formbuilder({
        selector:'#survey-form-builder',
        @if(!empty($survey->data))bootstrapData: {{ str_replace('{"fields":',"",rtrim(unserialize($survey->data)[0],"}")) }}@endif
    });
    
    fb.on('save', function(payload){
        console.log(payload);
        var test = payload;
        $.ajax({
            url: '/survey/fields/add/{{$survey->id}}',
            type: 'post',
            data: JSON.stringify(test),
            contentType: "application/json",
            success: function(data,status) {
                if(data == "ok") {
                    console.log('Survey added');
                } else {
                    console.log('It was successful!!');
                }
            },
            error: function(xhr, desc) {
                console.log("Error condition");
                    console.log(xhr);
                    console.log("Details: " + desc);
              }
        }); // End Ajax call
      })
});
</script>
@stop

@section('extrafootercontent')


@stop