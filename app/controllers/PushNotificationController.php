<?php



class PushNotificationController extends NotificationController {


		// type could be desktop or mobile

    public function pushNotification($message, $native_pn_click_url, $android, $ios, $chrome, $player_ids, $type){


        $content = array(
          "en" => $message
          );
        
        
        // set 2 cases , 1 for desktop , 2 for mobile

        switch($type){
            case 'desktop':
                $fields = array(
                  'app_id' => "7d4d4ffc-e676-11e4-a5aa-0749b36a8880",
                  //'included_segments' => array($_POST["segments"]),
                  //'data' => array('url'=>$native_pn_click_url), 
                  'isAndroid' => $android,
                  'isIos' => $ios,
                  'isChromeWeb' => $chrome,
                  //'isChrome' => true,
                  'include_player_ids' => $player_ids,
                  //'content_available' => true,
                  'android_background_data' => true,
                  //'template_id' => true,
                  //'url' => $chrome_pn_click_url,
                  'contents' => $content
                );
                break;

            case 'mobile':
                $fields = array(
                  'app_id' => "7d4d4ffc-e676-11e4-a5aa-0749b36a8880",
                  //'included_segments' => array($_POST["segments"]),
                  'data' => array('url'=>$native_pn_click_url), 
                  'isAndroid' => $android,
                  'isIos' => $ios,
                  'isChromeWeb' => $chrome,
                  //'isChrome' => true,
                  'include_player_ids' => $player_ids,
                  //'content_available' => true,
                  'android_background_data' => true,
                  //'template_id' => true,
                  //'url' => $native_pn_click_url,
                  'contents' => $content,
                  'ios_badgeType' => 'Increase',
                  'ios_badgeCount' => 1
                );
                break;
        }

        
        
        $fields = json_encode($fields);
        //print("JSON sent:<br>");
        //print($fields);
        
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
        
        //return $response;





        
        $return["allresponses"] = $response;
        $return = json_encode( $return);

        


    }


    public function sendPushNotification($url,$message, $type, $userid){

        $user = Auth::user();

        $list = DB::table('devices')->where('user_id', $userid)->get();

        //print_r($userid);

        $deviceArrayChrome = array();
        $deviceArrayMobile = array();

        $i = 0;
        $j= 0;

        foreach($list as $item){
            
            
            //$deviceArray[$i] = $item;

            if ($item->active == 1){

                if (strpos($item->device,'Chrome') !== false) {
                    $deviceArrayChrome[$j] = $item->player_id;
                    $j++;
                }else{
                    $deviceArrayMobile[$i] = $item->player_id;
                    $i++;
                }
            
            }
            
            
            

        }

        // send out push notification

        //if($user->push_notification == "1"){
            $this->pushNotification($message, $url, "true", "true", "true", $deviceArrayMobile, "mobile");
        //}

        


    }


}


?>