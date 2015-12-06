<?php

class EmailController extends BaseController {

    // this cron job clone function is for the server to access once a day

    public function notificationEmailCron(){

		$userObj = new stdClass();

        // read user data from the database and check if the user are not inside admin group
        $users =  DB::table('users')
        		->where('notification_email', 1)
                ->where('suspended', 0)
                ->get(array(
                	'id', 
                	'username', 
                	'firstname',
                	'lastname',
                	'email',
                	'created_at',
                	'updated_at'
                	));



		if(sizeof($users) < 1) print_r('no users found<br/>');   



        // loop thru all the users with email_notification enable

        foreach ($users as $user)
		{

			// init role assignment to check wether the user is admin or normal user
        	$role_assignments =  DB::table('role_assignments')
        		->where('user_id', $user->id)
                ->where('role_id', 1)
                ->get();

            //print_r($role_assignments);    

            if(count($role_assignments) > 0) continue;

		    // building up the userObj

		    $userObj->id        	= $user->id;
		    $userObj->username 		= $user->username;
		    $userObj->firstname 	= $user->firstname;
		    $userObj->lastname 		= $user->lastname;
		    $userObj->email 		= $user->email;
		    $userObj->created_at 	= $user->created_at;
		    $userObj->updated_at 	= $user->updated_at;

		    $groupid 				= null;
		    $group 					= null;

		    $notifications 			= null;

		    // init user task object
		    $userTaskObj = new UserTask;

		    $fiveDaysAgo = new DateTime('now - 5 days');

		    $oneDaysAgo = new DateTime('now - 1 days');

		    $groupid = DB::table('group_users')
			->where('user_id', $user->id)
			->pluck('group_id');

			// select group_name based on user_id from user table
			$group = DB::table('groups')
			->where('id', $groupid)
			->get(array(
                	'id', 
                	'name'
                	));


			// set the user group to the 1st group
			// currently the user has one group only but the user may have more group in the future
			// so initially set the user group to the 1st element of the array

			$userObj->groupid = $group[0]->id;		
			$userObj->groupname = $group[0]->name;	

			

			// get the latest 5 notifications belong to the user 
			$notifications = DB::table('notifications')
			->where('user_id', $user->id)		
			->orderBy('id', 'desc')
			->take(5)->get();



			// get the user outgoing notifications in the last 1 day

			$outGoingNotifications = DB::table('notifications')
			->where('source_user_id', $user->id)	
			->where('created_at', '>', $oneDaysAgo->format(DateTime::ISO8601))	
			->orderBy('id', 'desc')
			->get();


			// check the user post in the last 1 day

			$wallPost = DB::table('posts')
			->where('user_id', $user->id)	
			->where('group_id', $groupid)	
			->where('created_at', '>', $oneDaysAgo->format(DateTime::ISO8601))	
			->orderBy('id', 'desc')
			->get();

			
			$totaltasks = $userTaskObj->totalTasks($userObj->groupid);

			// completed tasks
			$completedTasks = DB::table('user_tasks')
				->where('user_id', $user->id)
				->where('group_id', $groupid)
				->where('complete', 1)
				->orderBy('id', 'desc')
				->get(array('id','updated_at'));


			// check to see if user is first in group to complete missions and the 1st in the team to finish
			$results = DB::select('select ut.user_id, count(1) finished, max(ut.updated_at) as complete_at, u.username, u.id
				from user_tasks ut JOIN users u ON u.id = user_id
				where ut.group_id = ?
					and ut.complete = 1
				group by ut.user_id
	            having count(1) = ?
				order by max(ut.updated_at) LIMIT 1', array($groupid, $totaltasks));   
			


			
			// set object value
			$userObj->number_of_completed_tasks 						= count($completedTasks);
			$userObj->completed_tasks 									= $completedTasks;
			$userObj->days_since_last_completed_task 					= 0;
			$userObj->missions_completed 								= 'false';
			$userObj->first_to_complete_all_missions 					= 'false';
			$userObj->number_of_total_tasks 							= $totaltasks;
			$userObj->first_to_complete_all_missions_username 			= "";
			
			//Get days passed since user created
			$timeStartDate = $userObj->created_at;
			$dayPassed = daysDiff(new DateTime($timeStartDate), new DateTime('now'))+1;
			
			
			// check if the user has completed all their tasks
			if (count($completedTasks) == $totaltasks /*&& $dayPassed == $totaltasks*/ && $totaltasks > 0){

					$userObj->missions_completed = 'true';

					if(count($results > 0) && $results[0]->user_id == $user->id)
					{
						$userObj->first_to_complete_all_missions = 'true';
						
					}
			}
			// TODO In else - create code to get days since user last completed task. Assign value to $userObj->days_since_last_completed_task
			else
			{
				
				if (count($completedTasks) > 0){
					// get last completed task
					$lastCompletedTask = reset($completedTasks);

					$userObj->days_since_last_completed_task = daysDiff(new DateTime($lastCompletedTask->updated_at), new DateTime('now'));
				}
			}
			print('$userObj->days_since_last_completed_task: '.$userObj->days_since_last_completed_task.'<br>');
			

			$userObj->inactive_user = 'false';
			$userObj->inactive_user_on_missions = 'false';

			// begin pendingTask related code 

			// get pending_task of user
			$pendingTask = DB::table('user_tasks')
			->where('user_id', $user->id)
			->where('group_id', $groupid)
			->where('complete', 0)
			->orderBy('id', 'desc')
			->first();

			$userObj->pending_task = $pendingTask;


			// check if user has not used the app by checking pending tasks or out going notifications
			 //TODO: add check for $userObj->days_since_last_completed_task in IF
			if (count($outGoingNotifications) == '0' && count($wallPost) == '0' && !isset($userObj->pending_task) && daysDiff(new DateTime($userObj->created_at), new DateTime('now')) > 0 && $userObj->missions_completed != true)
			{
				// check if the user has any completed tasks
				$userObj->inactive_user = 'true';
			}
			elseif($userObj->days_since_last_completed_task > 1)
			{
				$userObj->inactive_user_on_missions = 'true';
			}
			print('$userObj->inactive_user: '.$userObj->inactive_user.'<br>');

			$userObj->pending_task_everyday = 'false';
			// if there is a pending task that is at least 1 day old
			if ($pendingTask){
				$pendingDaysOld = daysDiff(new DateTime($pendingTask->created_at), new DateTime('now'));
				print('pendingDaysOld: '.$pendingDaysOld.'<br>');
				if($pendingDaysOld > 0)  $userObj->pending_task_everyday = 'true';
			} 



			print('count($outGoingNotifications): '.count($outGoingNotifications).'<br>');
			
			print('count($wallPost): '.count($wallPost).'<br>');
			
			print('isset($userObj->pending_task): '.isset($userObj->pending_task).'<br>');
			
			print('daysDiff(new DateTime($userObj->created_at), new DateTime(now)): '.daysDiff(new DateTime($userObj->created_at), new DateTime('now')).'<br>');


			
			
			print('userObj->pending_task_everyday: '.$userObj->pending_task_everyday.'<br>');
			
			print('$userObj->completed_tasks: '.$userObj->number_of_completed_tasks.'<br>');
			
			print('$userObj->missions_completed: '.$userObj->missions_completed.'<br>');
			
			print('first_to_complete_all_missions: '.$userObj->first_to_complete_all_missions.'<br>');

			print('inactive_user_on_missions: '.$userObj->inactive_user_on_missions.'<br>');
			
			// end pendingTask related code 

			
			$noNotificationFlag = true;

			if ($notifications){
				$noNotificationFlag = false;
				$userObj->notifications = $notifications;
			}

			

			$userObj->notification_content = "";

			// check if there is any notification belongs to the user

			// call push notification object


            $pushNotificationObject = new PushNotificationController();

            $mailContent = "Hi ".$userObj->firstname."<br/><br/>";

            // set nothing to send flag to check whether to send an email
			$nothingToSend = true;


			// if there is a pending task the last 1 day
            if ($userObj->pending_task_everyday == 'true'){

            	// sendput push notification

            	//$pushNotificationObject->sendPushNotification(SITE_URL."/#/mission", "Just a friendly reminder that you have a pending Mission and your team mates need you! If you haven't already, \nplease log in to On A Roll 21 and let them know how you roll.", "mobile", $userObj->id);

                $mailContent .= "Just a friendly reminder that you have a pending Mission and your team mates need you! If you haven't already, please log in to On A Roll 21&trade; and let them know how you roll.<br/><br/>";
				
				$nothingToSend = false;
            }

            //  if no activitives
            elseif ($userObj->inactive_user == 'true'){

            	// send out push notification

            	//$pushNotificationObject->sendPushNotification(SITE_URL."/#/journal", "Just a friendly reminder that you've not accepted any Missions or participated in your teams Wall. \nYour team mates need you! If you haven't already, please log in to On A Roll 21 and let them know how you roll...", "mobile", $userObj->id);

                $mailContent .= "Just a friendly reminder that you've not accepted any Missions or participated in your teams Wall. Your team mates need you! If you haven't already, please log in to On A Roll 21 and let them know how you roll...<br><br>";
				
				$nothingToSend = false;
            }
            else if($userObj->inactive_user_on_missions == 'true')
            {
            	// send out push notification
            	//$pushNotificationObject->sendPushNotification(SITE_URL."/#/journal", "Just a friendly reminder that you've not recently accepted any Missions. \nYour team mates need you! If you haven't already, please log in to On A Roll 21 and let them know how you roll...", "mobile", $userObj->id);

                $mailContent .= "Just a friendly reminder that you've not recently accepted any Missions. Your team mates need you! If you haven't already, please log in to On A Roll 21 and let them know how you roll...<br><br>";
				
				$nothingToSend = false;
            }
            
			// user finished all tasks
			elseif ($userObj->missions_completed == 'true'){

				$mailContent .= "You are awesome! You've completed all missions and achieved your goal! <br/><br/>";
				
				$nothingToSend = false;
			}

			// check if the user is the first to complete all missions

			if ($dayPassed <= $totaltasks){



					if ($userObj->first_to_complete_all_missions == 'true'){

						$mailContent .= "And you are the first in your team to do so! You win a CHOCOLATE COOKIE :) <br/><br/>";
						
						// sending email
						$nothingToSend = false;
						
					}else{

						// check if the record exists
						
						

						if (count($results) > 0 /*&& $dayPassed == $totaltasks*/)
						{
							$mailContent .= "Congratulations to ".$results[0]->username." for being the first to reach their goal in team ".$userObj->groupname."! <br/><br/>";
							$nothingToSend = false;
						}
						

					}

			}

			if (isset($mailContent) && !$noNotificationFlag){
				// if newest notification is older than 1 day display no new notifications message
				$newestNotification =  reset($notifications);

				$daysSinceNewest = daysDiff(new DateTime($newestNotification->created_at), new DateTime('now'));
				
				print('daysSinceNewest: '.$daysSinceNewest.'<br>');
				
				if ($daysSinceNewest > 1) 
				{
					$mailContent .= "You currently have no new notifications.<br/>";
					$mailContent .= "Your passed notifications in Team ".$userObj->groupname.":<br/><br/>";
				}
				else 
				{
					$mailContent .= "Your latest notifications in Team ".$userObj->groupname.":<br/><br/>";
				}

				$nothingToSend = false;


			}	


			if (isset($notifications))
			{
				// add notification into the notification collection	
				foreach ($notifications as $key => $value)
				{

					$m = new \MomentPHP\MomentPHP($value->created_at);
					$momentFromVo = $m->fromNow();

					$userFirstname = DB::table('users')
						->where('id', $value->source_user_id)
						->pluck("firstname");

					// message type
					if ($value->type == "message"){

						$mailContent .= $userFirstname.' sent you a message: '.$value->message.' - '.$momentFromVo.'  <br/>';

					}

					// new roller type
					if ($value->type == "newgroupmember"){

						$mailContent .= $userFirstname.' has joined your team - '.$momentFromVo.'  <br/>';
					}


					// new like
					if ($value->type == "newlike"){

						$mailContent .= $userFirstname.' liked your post - '.$momentFromVo.' <br/>';
					}

					// new lcomment
					if ($value->type == "newcomment"){

						$mailContent .= $userFirstname.' commented on your post - '.$momentFromVo.' <br/>';
					}

					// group first to complete
					if ($value->type == "firstcomplete"){
						$mailContent .= $value->message.' - '.$momentFromVo.'  <br/>';
					}
				}
            }

            // if nothing to send skip to the next user
            if ($nothingToSend) continue;

            // build up the notification email object
            
            $notificationEmailObj['content'] = $mailContent;
            $notificationEmailObj['email'] = $userObj->email;

            echo $mailContent;
            echo "--------------------------------------</br>".$userObj->email;;
            
            if (isset($mailContent)){

                // send out email notification
                $baseController = new BaseController();
                $baseController->notificationEmail($userObj->email, $notificationEmailObj,"Another Day Rolls By!..", "", "notification");           

            }	
		}

		

		return "OK - Task Done";

		

    }


    /**
     * this function is to sending out email to the user if | they are not completed the task after during the time frame | 
     * @return number of email sending out
     */
    public function suspendEmailWarningCron(){

    	// init PushNotification

    	$pushNotificationObject = new PushNotificationController();

    	$userObj = new stdClass();

        // read user data from the database
        $users =  DB::table('users')
        		->where('suspend_after', 1)
				->where('suspended', 0)
                ->where('warning_email_sent', 0)
                ->get(array(
                	'id', 
                	'username', 
                	'firstname',
                	'lastname',
                	'email',
                	'created_at'
                	));

		if(sizeof($users) < 1) print_r('no users found<br/>');  

        // loop thru all the users with email_notification enable
        
        print('**suspendEmailWarningCron** <br>');
        
        

        foreach ($users as $user)
		{



			// init role assignment to check wether the user is admin or normal user
        	$role_assignments =  DB::table('role_assignments')
        		->where('user_id', $user->id)
                ->where('role_id', 1)
                ->get();

            //print_r($role_assignments);    

            if(count($role_assignments) > 0) continue;
		    

		    $userObj->id = $user->id;

		    $userObj->username = $user->username;

		    $userObj->firstname = $user->firstname;

		    $userObj->lastname = $user->lastname;

		    $userObj->email = $user->email;

		    $userObj->created_at = $user->created_at;

            // get the current group

            $groupid = DB::table('group_users')
                ->where('user_id', $userObj->id)
                ->pluck('group_id');


            $group =   DB::table('groups')
                ->where('id', $groupid)
                ->get();                 


            $userObj->groupid = $group[0]->id;   
            $userObj->groupname = $group[0]->name;  

			$userTaskObj = new UserTask;
			$totaltasks = $userTaskObj->totalTasks($userObj->groupid);

            // check the number of day passed
            if (count($group) > 0)
            {
				$timeStartDate = $userObj->created_at;

				$dayPassed = daysDiff(new DateTime($timeStartDate), new DateTime('now'))+1;

				// compare the number of day passed and total mission
				
				print('dayPassed: '.$dayPassed.'<br>');
				print('totaltasks: '.$totaltasks.'<br>');
				
				
				 if (($dayPassed) == $totaltasks)
				 {

					// send out email
					$warningEmailBody['name'] = $userObj->firstname;
					$warningEmailBody['email'] = $userObj->email;

					$this->notificationEmail($userObj->email, $warningEmailBody,"OAR21 Your account...", "", "warningnotification");
					
					print('warningEmailBody: If you have not yet completed all your missions you have 5 days left to complete your goal!<br>');
					
					// send out push notification

					$pushNotificationObject->sendPushNotification(SITE_URL."/#/journal", "If you have not yet completed all your missions you have 5 days left to complete your goal!", "mobile", $userObj->id);
					
					$user = User::find($userObj->id);

					$user->warning_email_sent = 1;

					$user->save();


				 }

             }

        }

        return "OK - Task Done";

    }



    /**
     * Suspend user after 
     * @return number of user affected
     */
    public function accountSuspentionNotificationCron()
    {

    		$userObj = new stdClass();
		
	        // read user data from the database
	        $users =  DB::table('users')
	        		->where('suspend_after', 1)
	                ->get(array(
	                	'id', 
	                	'created_at'
	                	));

			if(sizeof($users) < 1) print_r('no users found<br/>');      

	        // loop thru all the users with email_notification enable
	        
	        foreach ($users as $user)
			{
			 	
			 	// init role assignment to check wether the user is admin or normal user
	        	$role_assignments =  DB::table('role_assignments')
	        		->where('user_id', $user->id)
	                ->where('role_id', 1)
	                ->get();

	            // get the current group id

	            $groupid = DB::table('group_users')
	                ->where('user_id', $user->id)
	                ->pluck('group_id');


	            if(count($role_assignments) > 0) continue;   

			    $userObj->id = $user->id;

			    $userObj->created_at = $user->created_at;

	             // get total tasks

	            $userTaskObj = new UserTask;
				$totaltasks = $userTaskObj->totalTasks($groupid);

	             // calculating suspended date 86400 = 1 day ; 432000 = 5 days
	             $totalDaysBeforeSuspention = $totaltasks + 5;
	             $userCreatedTime = new DateTime($user->created_at);
	             $actualDays = $userCreatedTime->modify('+ '.$totalDaysBeforeSuspention.' days');
	             $currentDate = new DateTime();
	             $interval = daysDiff($actualDays, $currentDate);	    

	             if($interval == 0) //can we round this off to days only? not minuets/seconds etc?
	             {
	                $user = User::find($user->id);

	                $user->suspended = 1;

	                $user->save();

	             }

         }

        return "OK - Task Done";

    }




    

}

?>