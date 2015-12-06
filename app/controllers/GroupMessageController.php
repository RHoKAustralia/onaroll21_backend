<?php

class GroupMessageController extends BaseController {
    
    
    /*
	get conversation list based on user session id
    */

	public function getConversationList(){

		$user = Auth::user();

		$returnVar = array();

		/*
		$returnVar[0]['type'] = "test";
		$returnVar[0]['pic'] = "test";
		$returnVar[0]['uusername'] = "test";
		$returnVar[0]['message'] = "test";
		$returnVar[0]['updated_at'] = "test";
		*/


		//print_r($user);
		$i = 0;
		$conversationUserList = ConversationUser::where('user_id', $user->id)->orderBy('created_at','desc')->get();


		function sortById($x, $y) {
			return $x['created_at_unix'] - $y['created_at_unix'];
		}


		foreach ($conversationUserList as $key => $value) {


			$conversation = Conversation::where('id', $value->conversation_id)->get();

			//print_r($conversation);

			$lastestMessage = DB::select('select * from conversation_message where conversation_id = ? ORDER BY id DESC LIMIT 1', array($value->conversation_id));
			$members = DB::select("select u.id, concat(u.firstname, ' ', u.lastname) as full_name from conversation_user c join users u on u.id = c.user_id where conversation_id = ?", array($value->conversation_id));
			# code...
			//print_r($lastestMessage);

			if (count($lastestMessage) > 0){
				$lastSender = DB::select('select * from users where id = ? ORDER BY id DESC LIMIT 1', array($lastestMessage[0]->sender_id));

				$returnVar[$i]['pic'] = base64_decode($lastSender[0]->picture);
				$returnVar[$i]['members'] = json_encode($members);
				$returnVar[$i]['message'] = $lastestMessage[0]->message;
				$m = new \MomentPHP\MomentPHP($lastestMessage[0]->created_at);
	            $momentFromVo = $m->fromNow();
				$returnVar[$i]['updated_at'] = $momentFromVo;
				$returnVar[$i]['created_at_sorting'] = $lastestMessage[0]->created_at;
				$returnVar[$i]['created_at_unix'] = strtotime($lastestMessage[0]->created_at);
				$returnVar[$i]['conversation_id'] = $value->conversation_id;
				$returnVar[$i]['lastest_message_id'] = $lastestMessage[0]->id;
			}

			$i++;

			//print_r($lastestMessage);

		}

		usort($returnVar, 'sortById');

		$returnVar = array_reverse($returnVar);


		//print_r($conversationList);

		return $returnVar;

	}


	/*
	update notification status
    */

	public function updateNotificationStatus(){

		$user = Auth::user();

		$input = Input::all();

		$status = 1;

		if ($input['st'] == "false"){
			$status = 0;
		}


		GroupNotificationStatus::where('conversation_id', '=', $input['conversationID'])->where('user_id', '=', $user->id)->update(array('status' => $status));

		


		//return $input['status'];

	}



	/*
	send message to the group
    */

	public function addUserToConversation(){
		$user = Auth::user();
		$input = Input::all();

		$conversationType = $input['type'];
		$conversationID = $input['conversationID'];

		$newConversationUsers = json_decode($input['userlist'], true);

		//check if a single conversation already exists
		if ($conversationType && $conversationType == 'single') {
			$otherUser = ($newConversationUsers[0]['id'] == $user->id) ? $newConversationUsers[1]['id'] : $newConversationUsers[0]['id'];

			$singleConversation = DB::select(DB::raw("select distinct *
				from conversation_user u
				join conversations c on c.id = u.conversation_id
				where c.type = 'single' and (u.user_id = :currentUser or u.user_id = :otherUser)
				group by u.conversation_id
				having count(u.conversation_id) = 2"), array('currentUser'=>$user->id, 'otherUser'=>$otherUser));

			if ($singleConversation) {
				return $singleConversation{0}->conversation_id;
			}
		}

		//create a new conversation if input doesn't have conversation id
		if (!$conversationID) {
			$conversation = new Conversation;
			$conversation->name = "Untitled Conversation";
			$conversation->lastest_message = "The room has been created !";
			$conversation->leader_id = $user['id'];
			$conversation->type = $conversationType;
			$conversation->save();

			$conversationID = $conversation->id;
		} else {
			Conversation::where('id','=', $conversationID)->update(['type'=> $conversationType]);
		}

		$currentConversationUsers = ConversationUser::where('conversation_id', '=', $conversationID)->get();

		foreach (json_decode($input['userlist']) as $key => $value) {
			# code...
			//print_r($value);

			$duplicateRecord = ConversationUser::where('user_id', '=', $value->id)->where('conversation_id', '=', $conversationID)->get();

			if (count($duplicateRecord) <= 0){

				$conversationUser = new ConversationUser;
				$conversationUser->conversation_id = $conversationID;
				$conversationUser->user_id = $value->id;
				$conversationUser->save();

				// add user notification status
				$notificationStatus = new GroupNotificationStatus;
				$notificationStatus->conversation_id = $conversationID;
				$notificationStatus->user_id = $value->id;
				$notificationStatus->save();
			}
		}

		foreach ($currentConversationUsers as $key => $value) {
			$result = array_search(intval($value->user_id), array_column($newConversationUsers, 'id'));

			if (!$result && (intval($value->user_id) != intval($user->id))) {
				ConversationUser::where('user_id', '=', $value->user_id)->where('conversation_id', '=', $conversationID)->delete();
			}
		}

		return $conversationID;
	}

	/*
	send message to the group
    */

	public function sendMessageToTheGroup(){


		$user = Auth::user();

		$input = Input::all();

		//print_r(json_decode($input['userList']));

		$conversationMessage = new ConversationMessage;

		$conversationMessage->message = $input['message'];
		$conversationMessage->sender_id = $user['id'];
		$conversationMessage->member = $input['userList'];


		// add user to the group

		$userListArray = json_decode($input['userList']);



		$apicontroller = new APIController();


		$conversationMessage->conversation_id = $input['conversationID'];

		$conversationMessage->save();


		foreach ($userListArray as $key => $value) {
		 	# code...


		 	if ($user->id != $value->id){

		 		// send notification to the other members among the group

		 		$notificationCheck = GroupNotificationStatus::where('conversation_id', '=', $input['conversationID'])->where('user_id', '=', $value->id)->get();

		 	
		 		if ($notificationCheck[0]->status == "1"){
		 			$apicontroller->addNotification($value->id, 'newgroupmessage', $input['conversationID'], $input['message'] );
		 		}

		 		


		 	}

		 	// end codition check
		 

		}

		// end loop
		
		

	}



	/*
	send message to the group
    */

	public function retriveGroupMessage(){
		$input = Input::all();
            $user = Auth::user();


            $messages = DB::table('conversation_message')->where('conversation_id', $input['conversationID'])->orderBy('id', 'desc')->get();

            //$scope.messages = $messages;

             $userid = $user->id;



            $userList = ConversationUser::where('conversation_id', '=', $input['conversationID'])->get();


            $userNotificationStatus = GroupNotificationStatus::where('conversation_id', '=', $input['conversationID'])->where('user_id', '=', $user->id)->get();



            $userListArray = array();


            

            $j = 0;

            foreach ($userList as $key => $value) {
            	# code...
            	//echo($value->user_id);

            	$userInfo = DB::select('select * from users where id = ?', array($value->user_id));

            	$userListArray[$j]['id'] = $userInfo[0]->id;

            	$userListArray[$j]['full_name'] = $userInfo[0]->firstname.' '.$userInfo[0]->lastname;


            	
            	$j++;

            }

            

           

            $i = 0;

            $tmessages['user_list'] = json_encode($userListArray);

            $tmessages['status'] = false;

            if (isset($userNotificationStatus[0])){



	            if ($userNotificationStatus[0]->status == 1) {
	            	# code...
	            	$tmessages['status'] = true;
	            }

            }


            foreach($messages as $message){

                    $user = DB::select('select * from users where id = ?', array($message->sender_id));

                    //print_r($user[0]->picture);

                    $m = new \MomentPHP\MomentPHP($message->created_at);
                	$momentFromVo = $m->fromNow();

                    $tmessages['mlist'][$i]['userid'] = $user[0]->id;
                    $tmessages['mlist'][$i]['pic'] = base64_decode($user[0]->picture);
                    $tmessages['mlist'][$i]['fname'] = $user[0]->firstname." ".$user[0]->lastname;
                    $tmessages['mlist'][$i]['message'] = $message->message;
                    $tmessages['mlist'][$i]['created_at'] = $momentFromVo;
                    $tmessages['mlist'][$i]['id'] = $message->id;
                    $tmessages['mlist'][$i]['current_user'] = $userid;

                    
                    


                    $i++;

            }


            return json_encode($tmessages);





		// 
	}


	/*
	create new conversation
    */

	public function createNewConversation(){

		$user = Auth::user();

		$input = Input::all();

		// get the lastest conversation ID

		

		$conversation = new Conversation;


		$conversation->name = "Untitled Conversation";

		$conversation->lastest_message = "The room has been created !";

		$conversation->leader_id = $user['id'];

		// save to database

		$conversation->save();

		// return to the browser

		return json_encode($conversation->id);

	}


}

?>