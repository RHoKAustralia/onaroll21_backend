<?php

$player_ids = $_POST["player_ids"]; //String
$android = $_POST["android"]; //Boolean - send PN to Android device
$ios = $_POST["ios"]; //Boolean - send PN to ios device
$chrome = $_POST["chrome"]; //Boolean - send PN to chrome device
$chrome_pn_click_url = $_POST["chrome_pn_click_url"]; //String - open URL on PN click
$native_pn_click_url = $_POST["native_pn_click_url"]; //String - open URL on PN click
$message = $_POST["message"]; //String
//$segments = $_POST["segments"]; //Array - target a group of users based on segment set up in OneSignal



function sendMessage()
{
	$content = array(
	  "en" => $_POST["message"]
	  );
	
	$fields = array(
	  'app_id' => "7d4d4ffc-e676-11e4-a5aa-0749b36a8880",
	  //'included_segments' => array($_POST["segments"]),
	  'data' => array('url'=>$_POST["native_pn_click_url"]), 
	  'isAndroid' => $_POST["android"],
	  'isIos' => $_POST["ios"],
	  'isChromeWeb' => $_POST["chrome"],
	  //'isChrome' => true,
	  'include_player_ids' => array($_POST["player_ids"]),
	  'content_available' => true,
	  'android_background_data' => true,
	  //'template_id' => true,
	  'url' => $_POST["chrome_pn_click_url"],
	  'contents' => $content
	);
	
	$fields = json_encode($fields);
	print("JSON sent:<br>");
	print($fields);
	
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, "https://gamethrive.com/api/v1/notifications");
	curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json',
	                       'Authorization: Basic N2Q0ZDUwN2UtZTY3Ni0xMWU0LWE1YWItMjMyYTA0OTNlNDU2'));
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
	curl_setopt($ch, CURLOPT_HEADER, FALSE);
	curl_setopt($ch, CURLOPT_POST, TRUE);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	
	$response = curl_exec($ch);
	curl_close($ch);
	
	return $response;
}


$response = sendMessage();
$return["allresponses"] = $response;
$return = json_encode( $return);

print("<br><br>JSON received:<br>");
print($return);

 
?>




