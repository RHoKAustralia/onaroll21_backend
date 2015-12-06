<?php

require('Connect.php');


$token = mysql_real_escape_string($_GET['token']);
$user_id = ''; //mysql_real_escape_string($_POST['user_id']);
//$email = mysql_real_escape_string($_POST['email']);
$group_id = mysql_real_escape_string($_GET['group_id']);
$pre_survey = '';
$post_survey = '';
$mood_data = '';


////////////////////
// Get user id
////////////////////
$sql = "SELECT * FROM custom_user_token WHERE token='$token'";

$result = mysql_query($sql);

$num_rows = mysql_num_rows($result);

if ($num_rows) 
{
    while ($row = mysql_fetch_object($result)) 
    {
		$user_id = $row->user_id;
	}	
}


////////////////////
// Mood data query
////////////////////
$sql = "SELECT * FROM wellbeing_tracks WHERE user_id='$user_id' AND group_id='$group_id'";

$result = mysql_query($sql);

$num_rows = mysql_num_rows($result);
$count_loops = 0;

if ($num_rows) 
{
    while ($row = mysql_fetch_object($result)) 
    {
    	$count_loops++;
		$mood_data .= '{"mood": "'.$row->mood.'", "timestamp": "'.strtotime($row->created_at).'"}';
		if($count_loops < $num_rows) $mood_data .= ',';
		
	}	
}
else 
{
	$mood_data = null;
}


////////////////////
// Pre survey query
////////////////////
$sql = "SELECT * FROM survey_response WHERE type='pre' AND user_id='$user_id' AND group_id='$group_id'";

$result = mysql_query($sql);

$num_rows = mysql_num_rows($result);
$count_loops = 0;

if ($num_rows) 
{
    while ($row = mysql_fetch_object($result)) 
    {
    	$count_loops++;
		$pre_survey = '{"response": '.json_encode(unserialize($row->response)).', "timestamp": "'.strtotime($row->created_at).'"}';
		if($count_loops < $num_rows) $pre_survey.= ',';
	}	
}
else 
{
	$pre_survey = '{"response": "", "timestamp": ""}';
}


////////////////////
// Post survey query
////////////////////
$sql = "SELECT * FROM survey_response WHERE type='post' AND user_id='$user_id' AND group_id='$group_id'";

$result = mysql_query($sql);

$num_rows = mysql_num_rows($result);
$count_loops = 0;

if ($num_rows) 
{
    while ($row = mysql_fetch_object($result)) 
    {
    	$count_loops++;
		$post_survey = '{"response": '.json_encode(unserialize($row->response)).', "timestamp": "'.strtotime($row->created_at).'"}';
		if($count_loops < $num_rows) $pre_survey.= ',';
	}	
}
else 
{
	$post_survey = '{"response": "", "timestamp": ""}';
}








header('Content-Type: application/json');

$json = '{"id": "'.$user_id.'", "email": "'.$email.'", "mood_data": ['.$mood_data.'], "pre_survey":'.$pre_survey.', "post_survey":'.$post_survey.'}';


echo $json;





?>






















