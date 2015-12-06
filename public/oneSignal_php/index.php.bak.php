<?php
  function sendMessage()
  {
  
    $content = array(
      "en" => 'Hi John - Gef liked your post. Log in to post a comment'
      );
    
    $fields = array(
      'app_id' => "7d4d4ffc-e676-11e4-a5aa-0749b36a8880",
      'included_segments' => array('All'),
      /*'send_after' => 'Fri May 02 2014 00:00:00 GMT-0700 (PDT)',*/
      'data' => array("data1" => "data1", "url"=>"app.onaroll21.com", "data2"=>"data2"), 
      'isAndroid' => true,
      'isIos' => true,
      'isChromeWeb' => true,
      //'isChrome' => true,
      //'include_player_ids' => array("id1","id2"),
      'content_available' => true,
      'android_background_data' => true,
      //'template_id' => true,
      //'url' => "string",
      'contents' => $content
    );
    
    $fields = json_encode($fields);
    print("\nJSON sent:\n");
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
  
  print("\n\nJSON received:\n");
  print($return);
  print("\n")
?>