@extends('layouts.master')

@section('content')

@if(!empty($surveyResponse))
<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Response</th>
        </tr>
        @foreach($surveyResponse as $response)
        <?php
        $survey = Survey::find($response->survey_id);
        $user = User::find($response->user_id);
        if(!is_null($survey)) {
            $data = unserialize($survey->data);
            $fields = json_decode($data[0])->fields;
//            echo '<pre>';
//            print_r($fields);
//            echo '</pre>';
//            die;
        }
        ?>
        <tr>
            <td>{{ $user->fullName() }}</td>
            <td>{{ $response->type }}</td>
            <td>
                @foreach(unserialize($response->response) as $key => $val)
                @if($key!='_token' && $key!='' && $key!='' && $key!='' )
                @foreach($fields as $field)
                @if($field->cid==$key)
                {{ $field->label.' - '.$val.'<br />' }}
                @endif
                @endforeach
                @endif
                @endforeach
            </td>
        </tr>
        @endforeach
    </thead>
</table>
    
@endif
@stop