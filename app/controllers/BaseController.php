<?php

class BaseController extends Controller {

    /**
     * Setup the layout used by the controller.
     *
     * @return void
     */
    protected function setupLayout() {
        if ( ! is_null($this->layout)) {
            $this->layout = View::make($this->layout);
        }
    }


    /*
     * 
     * @Author : John Le
     * @Function : Send email notification
     * @return : ( BOOL ) return the status in BOOL (true | false)
     */
     
     
     public function notificationEmail($email,$msg, $header, $name, $emailTemplate){
        
        $input=Input::all();
        
        $user = array(
            'email'=>$email,
            'header'=>$header,
            'name' => $name
        );
        
        // the data that will be passed into the mail view blade template
        $data = array(
            'detail'=>$msg
            
        );
        
        // use Mail::send function to send email passing the data and using the $user variable in the closure
        Mail::send('emails.'.$emailTemplate, $data, function($message) use ($user)
        {
          $message->from('support@onaroll21.com', 'On A Roll 21™');
          $message->to($user['email'], $user['name'])->subject($user['header']);
        });
        
        return $input;
     
     }








     /*
     * 
     * @Author : John Le
     * @Function : Send technical support email
     * @return : ( BOOL ) return the status in BOOL (true | false)
     */
     
     
     public function supportEmail($email,$msg, $header, $name, $emailTemplate){
        
        $input=Input::all();
        
        $user = array(
            'email'=>$email,
            'header'=>$header,
            'name' => $name
        );
        
        // the data that will be passed into the mail view blade template
        $data = array(
            'detail'=>$msg
            
        );



        
        // use Mail::send function to send email passing the data and using the $user variable in the closure
        Mail::send('emails.'.$emailTemplate, $data, function($message) use ($user)
        {

          

          if (isset($user['email'])){
                $userTemp = $user;

                $message->from($userTemp['email'], 'On A Roll 21™');
                $message->to('support@onaroll21.com', $userTemp['name'])->subject($userTemp['header']);
          }

          
        });

        //print_r($user);
        
        return "true";
     
     }

}