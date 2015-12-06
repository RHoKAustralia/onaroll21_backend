<?php


/**
 * API controller to be used by front end single page app
 */
class APIController extends \BaseController {
    /**
     * Fetch all the posts for group along with the specific user details
     * @return type
     */
    //TODO: Check for all the requirements against the output of this function
    public function getGroupPosts()
    {
        $input = Input::all();
        $groupid = $input['groupid'];
        $authuser = Auth::user();
        if (Input::has('limitfrom')) {
            $skip = Input::get('limitfrom');
        } else {
            $skip = 0;
        }
        $group = Group::find($groupid);
        if (is_null($group)) {
            return Response::json(array(
                'success' => false,
                'errors' => 'Group not found'
            ), 400); // 400 being the HTTP code for an invalid request.
        }
        //Now fetch all the posts of that group
        $posts = Post::orderBy('id', 'DESC')->where('group_id', $groupid)->where('private', '0')->take(5)->skip($skip)->get();

        foreach ($posts as $post) {
            // get task description
            
            $task = Task::orderBy('id', 'DESC')->where('id', $post->task_id)->take(1)->get();

            $post->status = $post->status;
            $post->task_title = $task[0]->name;
            $post->task_content = $task[0]->description;
            $post->display_mission = $post->display_mission;
            $post->status_text = preg_replace('/\b(https?):\/\/[-A-Z0-9+&@#\/%?=~_|$!:,.;]*[A-Z0-9+&@#\/%=~_|$]/i', '', $post->filterStatus());
            

            if(preg_match_all("/(http|https|ftp|ftps)\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?/",$post->status,$m)){
                 
                 parse_str( parse_url( $m[0][0], PHP_URL_QUERY ), $my_array_of_vars );
                 //echo $my_array_of_vars['v'];    
                 //$post->youtube_media_url = $my_array_of_vars['v'];
                 //echo $post->media_url;
            }

            $post->image = ($post->statustype = 'image') ? $post->displayMediaApi() : '';
            $post->screenhandle = User::find($post->user_id)->screenhandle;
			$post->firstname = User::find($post->user_id)->firstname;
			$post->lastname = User::find($post->user_id)->lastname;
            $post->comments = $post->getAPIComments();
            $user = User::find($post->user_id);
            $post->userImage = $user->APIGetPictureSrc();


            $post->likeCount = count(Like::orderBy('id', 'DESC')->where('post_id', $post->id)->get());
            if ($authuser->hasLike($post->id)) {
                $post->like = true;
            } else {
                $post->like = false;
            }
        }

        return $posts->toJson();
    }

    public function countPosts() {
        $input = Input::all();
        $groupid = $input['groupid'];

        $count = Post::orderBy('id', 'DESC')->where('group_id', $groupid)->where('private', '0')->count();

        return $count;
    }

    public function isNativeApp(){

            $isOnApp = "false";

            $playerId = Session::get('playerid');
            if(isset($playerId)) 
                {
                    
                    $isOnApp = "true";
                }



                return $isOnApp;

    }



    public function getGroupPrivatePosts()
    {
        $input = Input::all();
        $groupid = $input['groupid'];
        $authuser = Auth::user();
        if (Input::has('limitfrom')) {
            $skip = Input::get('limitfrom');
        } else {
            $skip = 0;
        }
        $group = Group::find($groupid);
        if (is_null($group)) {
            return Response::json(array(
                'success' => false,
                'errors' => 'Group not found'
            ), 400); // 400 being the HTTP code for an invalid request.
        }
        //Now fetch all the posts of that group
        $posts = Post::orderBy('id', 'DESC')->where('group_id', $groupid)->where('private', '1')->take(5)->skip($skip)->get();

        foreach ($posts as $post) {
            $post->status = $post->status;
            $post->status_text = $post->filterStatus();
            $post->image = ($post->statustype = 'image') ? $post->displayMediaApi() : '';
            $post->screenhandle = User::find($post->user_id)->screenhandle;
            $post->firstname = User::find($post->user_id)->firstname;
            $post->lastname = User::find($post->user_id)->lastname;
            $post->comments = $post->getAPIComments();
            $user = User::find($post->user_id);
            $post->userImage = $user->APIGetPictureSrc();
            if ($authuser->hasLike($post->id)) {
                $post->like = true;
            } else {
                $post->like = false;
            }
        }

        return $posts->toJson();
    }








    /**
     * Fetch all the private posts for group along with the specific user details
     * @return type
     */
    //TODO: Check for all the requirements against the output of this function
    public function getPrivatePosts()
    {
        $input = Input::all();
        $groupid = $input['groupid'];
        $authuser = Auth::user();
        if (Input::has('limitfrom')) {
            $skip = Input::get('limitfrom');
        } else {
            $skip = 0;
        }
        $group = Group::find($groupid);
        if (is_null($group)) {
            return Response::json(array(
                'success' => false,
                'errors' => 'Group not found'
            ), 400); // 400 being the HTTP code for an invalid request.
        }
        //Now fetch all the posts of that group
        $posts = Post::orderBy('id', 'DESC')->where('group_id', $groupid)->where('private', '1')->where('user_id', $authuser['id'])->take(10)->skip($skip)->get();

        foreach ($posts as $post) {
            $post->status = $post->status;
            $post->status_text = $post->filterStatus();
            $post->image = ($post->statustype = 'image') ? $post->displayMediaApi() : '';
            $post->screenhandle = User::find($post->user_id)->screenhandle;
            $post->firstname = User::find($post->user_id)->firstname;
            $post->lastname = User::find($post->user_id)->lastname;
            $post->comments = $post->getAPIComments();
            $user = User::find($post->user_id);
            $post->userImage = $user->APIGetPictureSrc();
            if ($authuser->hasLike($post->id)) {
                $post->like = true;
            } else {
                $post->like = false;
            }
        }

        return $posts->toJson();
    }






	/**
     * @author : John Le
	 * Fetch a single posy by specific ID along with the specific user details
     * @return json object
     */
    //TODO: Check for all the requirements against the output of this function
	public function getGroupPostByID(){
		
		$input = Input::all();
        $groupid = $input['groupid'];
		$postid = $input['postid'];
        $authuser = Auth::user();
        if (Input::has('limitfrom')) {
            $skip = Input::get('limitfrom');
        } else {
            $skip = 0;
        }
        $group = Group::find($groupid);
        if (is_null($group)) {
            return Response::json(array(
                'success' => false,
                'errors' => 'Group not found'
            ), 400); // 400 being the HTTP code for an invalid request.
        }
        //Now fetch all the posts belong to that group
        $posts = Post::orderBy('id', 'DESC')->where('id', $postid)->take(1)->skip($skip)->get();
		
		
        foreach ($posts as $post) {


            $task = Task::orderBy('id', 'DESC')->where('id', $post->task_id)->take(1)->get();
            $post->task_title = $task[0]->name;
            $post->task_content = $task[0]->description;
            $post->display_mission = $post->display_mission;
            $post->status = $post->status;
            $post->status_text = $post->filterStatus();
            $post->image = ($post->statustype = 'image') ? $post->displayMediaApi() : '';
            $post->screenhandle = User::find($post->user_id)->screenhandle;
            $post->firstname = User::find($post->user_id)->firstname;
            $post->lastname = User::find($post->user_id)->lastname;
            $post->comments = $post->getAPIComments();
            $user = User::find($post->user_id);
            $post->userImage = $user->APIGetPictureSrc();
            $post->likeCount = count(Like::orderBy('id', 'DESC')->where('post_id', $post->id)->get());
            if ($authuser->hasLike($post->id)) {
                $post->like = true;
            } else {
                $post->like = false;
            }
        }
		
		
        return $posts->toJson();
		
	}

    /**
     * This function returns the list of all the groups that the logged in user
     * has access to
     * @return JSON groupList
     */
    public function getGroupList() {
        $user = Auth::user();

        if ($user->hasRole('admin')) {
            $groups = Group::all();
        } else {
            //$groups = $user->getGroups(); //Group::all();
            //print_r($groups);
            $groups = Group::where('keycode','=', $user->keycode)->get();

             //$groups = $groups[0];

             //print_r($user->keycode);   

        }
        foreach ($groups as $group) {
            $group->members = $group->getUserCount();
            $group->thumbnailSrc = $group->APIGetThumbnailSrc();
            $group->preSurveyCompleted=$user->preSurveyCompleted($group->id);
            $group->postSurveyCompleted=$user->postSurveyCompleted($group->id);
            $group->daysPassed = daysDiff(new DateTime($user->created_at), new DateTime('now'))+1;
        }

        //TODO: Get the user progress in group

        return $groups->toJson();
    }
	
	
	
	/**
	 * 
	 * @Author : John Le @ En Masse
     * This function returns the list of all users that belong to specific group by group ID
     * @return JSON userList
     */
    public function getUserListByGroupID() {
        $user = Auth::user();
		$input = Input::all();
		
		
		$groupusers = GroupUser::where('group_id', '=', $input['id'])->where('user_id','<>', $user->id)->get();
		
		$users = array();
		$i = 0;
		
		foreach($groupusers as $groupuser){
			
			$users[$i] = DB::select('select * from users where id = ?', array($groupuser->user_id));
			
			$users[$i][0]->picture = base64_decode($users[$i][0]->picture);
			
			$i++;
			
		}
		
        return json_encode($users);
        
    }

    /**
     * This returns the words for word cloud
     * @return type
     */
    public function getUserWords() {
        $user = Auth::user();
        $words = $user->getWords();
        return Response::json($words);
    }
	
	 /**
     * Check the pending task
     * @return pending task
	 * 
     */
	
	
	public function pendingTask(){
		
		$return = "false";
		
		$groupid = Input::json('groupid');
        $user = Auth::user();
        $userid = $user->id;
		
		$group = Group::find($groupid);
        $outcome = Outcome::find($group->outcome);
		
		
        $availArray = array_fetch($outcome->tasks->toArray(), 'id');
        $currentDay = round((time() - $group->timestart) / 86400, 0);

        $pendingTask = DB::table('user_tasks')
                ->where('user_id', $userid)
                ->where('group_id', $group->id)
                ->where('complete', 0)
                ->first();
				
				
		$pendingTaskDetails = DB::table('tasks')
                ->where('id', $pendingTask->task_id)
                ->first();		
				
				
				
		 $returnObject = new stdClass();		
				
		if ($pendingTask){
            // get the task time

            $pdTaskTime = strtotime($pendingTaskDetails->created_at);

            // get the current time
            $currentTime = time();

            // calculate the time, if there is an inactive task
            $timetmp = false;

            if ($currentTime - $pdTaskTime > 2880){
                    //print_r($currentTime);
                   $timetmp = true; 
            }
			
			$returnObject->pendingTask = 1;
			$returnObject->taskid = $pendingTaskDetails->id;
			$returnObject->title = makeClickableLinks($pendingTaskDetails->name);
			$returnObject->mission = makeClickableLinks($pendingTaskDetails->description);
			$returnObject->didyouknow = makeClickableLinks($pendingTaskDetails->didyouknow);
			$returnObject->reference = makeClickableLinks($pendingTaskDetails->reference);
            $returnObject->date = $timetmp;
		    $returnObject->taskid = $pendingTaskDetails->id;
			
			
			//$return = $pendingTaskDetails;
			
		}		
				
		//print_r($pendingTaskDetails);
		return Response::json($returnObject);
		
		
	}
	
	/**
     * Return the percentage of the progressbar by number
     * @return number
	 * 
     */
	
	public function getProgress(){
        
        
        // get all the inputs, variable init
        
        $groupid = Input::json('groupid');
        $user = Auth::user();
        $userid = $user->id;
        
        $result = array();
        
        // get the total tasks
        
        $group = Group::find($groupid);
        $outcome = Outcome::find($group->outcome);
        
        
        $availArray = array_fetch($outcome->tasks->toArray(), 'id');
        
        //print_r();
        
        $countAvailArray = count($availArray);
        
        // get the completed tasks
        
        $completedTasks = DB::table('user_tasks')
                ->where('user_id', $userid)
                ->where('group_id', $groupid)
                ->where('complete', 1)
                ->get();

        $missions = DB::table('groups')
            ->join('outcome_tasks', 'groups.outcome', '=', 'outcome_tasks.outcome_id')
            ->select('outcome_tasks.*')
            ->where('groups.id', '=', $groupid)
            ->orderBy('outcome_tasks.created_at')
            ->get();

        // get total likes for team

        $totalLikes = DB::select('select l.id
					FROM likes as l, posts as p
					WHERE p.group_id = ? AND l.post_id = p.id
					', array($groupid));


        //print_r(count($completedTasks));
        
        
        $countCompletedTasksArray = count($completedTasks);
        // calculating the percentage
        
        $progress =  ($countCompletedTasksArray / $countAvailArray) * 100;

//        $startDate = strtotime($missions{0}->created_at);
        $startDate = strtotime(User::find($user->id)->created_at);

        $today = strtotime('now');

        $result['progress'] = round($progress, 0);
        $result['total_mission'] = count($missions);
//        $result['start_date'] = $missions{0}->created_at;
        $result['start_date'] = $user->created_at;
        //$result['completed_days'] = floor(($today - $startDate)/(60*60*24))+1;
        $result['completed_days'] = daysDiff(new DateTime($user->created_at), new DateTime('now'))+1;
        $result['completed_missions'] = count($completedTasks);
        $result['total_likes'] = count($totalLikes);

        return $result;
        
        
    }
	
	
	

    /**
     * Fetch the current task for this user and group combination, will return
     * the pending task if the user has any pending task
     *
     * @param json $groupid id of the group that the user is currently accessing
     * @param json $userid id of the currently logged in user
     * @return json $returnObject will return the task details or the error message
     */
    public function getNewTask() {
    	
    	
        $groupid = Input::json('groupid');
        $user = Auth::user();
        $userid = $user->id;

        $returnObject = new stdClass();
        $returnObject->status = 'error';
        $returnObject->message = array();
        if (empty($userid)) {
            $statusMessage[] = 'Userid can not be empty';
        }
        //TODO: check if user exists
        //TODO: check if group exists
        if (empty($groupid)) {
            $statusMessage[] = 'Groupid can not be empty';
        }

        $group = Group::find($groupid);
        $outcome = Outcome::find($group->outcome);
		
		
        $availArray = array_fetch($outcome->tasks->toArray(), 'id');
        $currentDay = round((time() - $group->timestart) / 86400, 0);

        $pendingTask = DB::table('user_tasks')
                ->where('user_id', $userid)
                ->where('group_id', $group->id)
                ->where('complete', 0)
                ->first();
				
		// check if there is a pending task
				
		if ($pendingTask) {
            $task = Task::find($pendingTask->task_id);

            $returnObject->pendingTask = 1;
            $returnObject->taskno=  array_search($pendingTask->task_id,$availArray);
        }else {

            // return the random number but different than the last number
            
            $lastMission[] = DB::table('final_task')->where('outcome_id', $group->outcome)->pluck('task_id');
			
			$tmpUserTaskArray[] = DB::table('user_tasks')->where('outcome_id', $group->outcome)->where('user_id', $userid)->lists('task_id');
			
			$doneArray = $tmpUserTaskArray[0];
			
			
			
			$array = array_diff($availArray, $lastMission);
			
			//print_r($availArray);
			
			$array = array_diff($array, $doneArray);
			
			
			
			$array = array_values($array);
			
			$numberOfDay = count($availArray);
			
			//print_r($numberOfDay);
			
			//print_r($array);
			
			if (empty($array)) {
				
				//echo "sss";
				
                //if ($currentDay == count($tmpUserTaskArray) + 1) {
                	
                    //$rand = array_rand($array);
				    $returnObject->taskno = count($availArray);
	            	$task = Task::find($lastMission); 
					
					//print_r($task[0]->description);
					
					$returnObject->title['name'] = strip_tags(makeClickableLinks($task[0]->name));
					$returnObject->title['description'] = strip_tags(makeClickableLinks($task[0]->description));
			        $returnObject->didyouknow = strip_tags(makeClickableLinks($task[0]->didyouknow));
			        $returnObject->reference = strip_tags(makeClickableLinks($task[0]->reference));
					$returnObject->taskid = $task[0]->id;	
					
                //} 
				
				//echo $currentDay;
            } else{
            	
				
            	
				$rand = array_rand($array);
			    $returnObject->taskno = $rand + 1;
            	$task = Task::find($array[$rand]); 
				$returnObject->title['name'] = strip_tags(makeClickableLinks($task->name));
				$returnObject->title['description'] = strip_tags(makeClickableLinks($task->description));
		        $returnObject->didyouknow = strip_tags(makeClickableLinks($task->didyouknow));
		        $returnObject->reference = strip_tags(makeClickableLinks($task->reference));
				$returnObject->taskid = $task->id;	
				
            }
			
			//print_r($array);
			
			
            $returnObject->pendingTask = 0;
            
			//print_r($rand);
        }	
		
		//print_r($returnObject);	
		
        $returnObject->status = "success";
        	
				
		/*
		 * 
		 		
        if ($pendingTask) {
            $task = Task::find($pendingTask->task_id);

            $returnObject->pendingTask = 1;
            $returnObject->taskno=  array_search($pendingTask->task_id,$availArray);
        } else {

            $doneArray[] = $outcome->getFinalTask();

            $array = array_diff($availArray, $doneArray);

            $array = array_values($array);

            if (empty($array)) {
                if ($currentDay >= 21) {
                    $array[20] = $outcome->getFinalTask();
                } else {
                    $array = $availArray;
                }
            } elseif ($currentDay >= 21) {
                $array = array();
                $array[20] = $outcome->getFinalTask();
            }

            $rand = array_rand($array);
            $task = Task::find($array[$rand]); //$user->getNextTask();
            $returnObject->pendingTask = 0;
            $returnObject->taskno = $rand + 1;
        }

        $returnObject->title = makeClickableLinks($task->description);
        $returnObject->didyouknow = makeClickableLinks($task->didyouknow);
        $returnObject->reference = makeClickableLinks($task->reference);
        $returnObject->status = "success";
        $returnObject->taskid = $task->id;
        //Return the JSON object with the info
        return Response::json($returnObject);
		 * */
		 return Response::json($returnObject);
    }

    /**
     * Accepts the mission for a user
     * @param int userid JSON
     * @param int groupid JSON
     * @param int taskid JSON
     * @return JSON $returnObject JSON object
     */
    public function acceptMission() {
        $user = User::find(Input::get('userid'));
        $group = Group::find(Input::get('groupid'));
        $outcome = Outcome::find($group->outcome);
        $task = Task::find(Input::get('taskid'));

        // TODO: validate the input
        // TODO: Check if the record already exists in the DB

        DB::table('user_tasks')->insert(
                array(
                    'user_id' => $user->id,
                    'group_id' => $group->id,
                    'outcome_id' => $outcome->id,
                    'task_id' => $task->id,
                    'created_at' => new DateTime,
                    'updated_at' => new DateTime
                )
        );

        $returnObject = new stdClass();
        $returnObject->status = 'ok';
        $returnObject->message = 'Task accepted!';

        return Response::json($returnObject);
    }

    /**
     * This function will return the user progress
     * @param int userid
     * @param int groupid
     * @return json data this should contain all the group related data for the usre
     */
    public function trackUserProgress() {
        $input = (array) Input::json();
    }

    /**
     * This function will toggle like for the user and a post
     * @param int userid
     * @param int postid
     * @param int type
     * @return json data status object containing all the parameters
     */
    public function updateLike() {
        $input = Input::all();
        $user = Auth::user();

        if ($input['type'] == 'unlike') {
            $post = Post::find($input['postid']);
            $like = DB::table('likes')->where('post_id', $input['postid'])->where('user_id', $user->id)->delete();


        } else {
            $post = Post::find($input['postid']);
            $like = new Like();
            $like->user_id = $user->id;
            $like->post_id = $post->id;
            $like->save();
			
			// John part


            if (trim($user->id) != trim($post->user_id)){
			     $this->addNotification($post->user_id, 'newlike', $input['postid'], "likes your post" );
             }
			// end john part
        }
        $returnReponse=  new stdClass();
        $returnReponse->status='OK';
        $returnReponse->message='Like updated';
        return Response::json($returnReponse);
    }

    /**
     * This function will add/update user feedback
     * @param int userid
     * @param int postid
     * @param int feedback
     * @return json data json object
     */
    public function updateTaskScore() {
        $input=Input::all();
        $user=Auth::user();
        $taskid=$input['taskid'];
        $score=$input['score'];

        $date=new \DateTime;

        DB::insert('insert into task_score (user_id, task_id, score, created_at, updated_at) values (?, ?, ?, ?, ?)', array($user->id, $taskid, $score, $date, $date));

        $returnObject=new stdClass();
        $returnObject->status='OK';
        $returnObject->message='Feedback updated';

        return Response::json($returnObject);
    }


    







    /**
     *
     */
    public function updateFeedback() {
        $input=Input::all();
        $user=Auth::user();
        $feedback=$input['feedback'];

        $date=new \DateTime;

        DB::insert('insert into feedback (user_id, feedback, created_at, updated_at) values (?, ?, ?, ?)', array($user->id, $feedback, $date, $date));

        $returnObject=new stdClass();
        $returnObject->status='OK';
        $returnObject->message='Feedback updated';

        return Response::json($returnObject);
    }

    /**
     * TODO: convert this to AJAX and usable with angular
     */
    public function addComment() {
        $input = Input::all();

        $userAuth=Auth::user();

        $user = User::find($input['user_id']);

        $post = Post::find($input['post_id']);
        $comment = new Comment();
        $comment->user_id = $user->id;
        $comment->post_id = $post->id;
        $comment->comment = $input['comment'];

        $comment->save();
		
		//$this->addNotification(0, 'newcomment', $input['post_id'], $input['comment'] );
		//print_r($input['user_id']);
		//print_r($userAuth->id);

        // add a new notification
        if (trim($userAuth->id) != trim($post->user_id)){

            $this->addNotification($post->user_id, 'newcomment', $input['post_id'], "has commented on your post" );

            Session::set('notificationMessage', $input['comment']);
        }

        $postComments = Comment::where('post_id','=',$post->id)->where('user_id','<>',$userAuth->id)->get();

        if ($postComments) {

            
            $tempUserID = 0;

            foreach ($postComments as $comm) {

                if ($tempUserID != $comm->user_id){
                    $this->addNotification($comm->user_id, 'newcommentother', $input['post_id'], "has commented on a post you commented on" );
                }



                $tempUserID = $comm->user_id;
                
                
                Session::set('notificationMessage', $input['comment']);
            }
        }

        // end add notification
        $returnResponse=new stdClass();
        $returnResponse->status='OK';
        $returnResponse->message='Comment udpated successfully';
        return Response::json($returnResponse);
    }

    /**
     * TODO: this is the standard non-angular method and needs to be converted
     * to AJAX style
     * @param type $param
     */
    public function deleteComment($param) {

        $input = (array) Input::json();
        $comment = Comment::find($input['commentid']);

        $returnObject = new stdClass();

        if ($comment->delete()) {
            $returnObject->status = 'ok';
            $returnObject->message = 'Comment deleted successfully';
        } else {
            $returnObject->status = 'error';
            $returnObject->message = 'An error occurred';
        }

        return Response::json($returnObject);
    }




    /**
     * This function returns the 
     * has access to
     * @return JSON groupList
     */
    public function isEmailExist() {


        $returnMsg = "false";

        // search email address inside the database

        $user =  DB::table('users')
                ->where('email', Input::get('email'))
                ->get();
        
        // check the user result set

        if (count($user) > 0){
                $returnMsg = "true";
        }

        return $returnMsg;



    }

    /**
     * Adds a post to the database.
     * @param int userid
     * @param int groupid
     * @param int taskid
     * @return JSON $returnObject
     */
    public function addPost() {

        $returnObject = new stdClass();
        // This function needs to store the information in DB
        $newPost = json_decode(Input::get('post'));   //Get the post from input
        $userid = $newPost->userid;
        $groupid = $newPost->groupid;
        $taskid = $newPost->taskid;
        $user = User::find($userid);
        $group = Group::find($groupid);
        $task = Task::find($taskid);

        //print_r($newPost);

        if (!$taskid){

                $taskid = 0;
                $task = 0;

        }

        if (is_null($user)) {
            return Response::json(array(
                        'success' => false,
                        'errors' => 'User not found'
                            ), 400); // 400 being the HTTP code for an invalid request.
        }
        if (is_null($group)) {
            return Response::json(array(
                        'success' => false,
                        'errors' => 'Group not found'
                            ), 400); // 400 being the HTTP code for an invalid request.
        }
        if (is_null($task)) {
            return Response::json(array(
                        'success' => false,
                        'errors' => 'Task not found'
                            ), 400); // 400 being the HTTP code for an invalid request.
        }

        $post = new Post();
        $post->user_id = $userid;
        $post->group_id = $groupid;
        $post->task_id = $taskid;
        $post->statustype = 'text';
        if($newPost->type=='note') {
            $post->private=true;
        } else {
            $post->private=false;
        }

        //update mood
        if ($newPost->mood) {
            $wellbeing = new Wellbeing();
            $wellbeing->user_id = $user->id;
            $wellbeing->group_id = $groupid;
            $wellbeing->task_id = 0;
            $wellbeing->mood = $newPost->mood;

            $wellbeing->save();
        }

        // check checkbox 0 | 1
        if($newPost->display_mission) {
            $post->display_mission=true;
        } else {
            $post->display_mission=false;
        }

        if (Input::hasFile('file')) {
            $status = array();
            $status['text'] = $newPost->status_text;
            $file = Input::file('file');
            $filecreationname = sha1($user->id . $group->id . $task['id'] . time() . $file->getClientOriginalName());
            $pixpath = '/uploads/pix/posts/' . $filecreationname . '/';
            $destinationPath = public_path() . $pixpath;
            $filename = $filecreationname . '.' . $file->getClientOriginalExtension();

            File::makeDirectory($destinationPath);

            $video_formats = array('mp4', 'mov', 'avi', 'wav', 'flv', 'wmv');
            if (in_array($file->getClientOriginalExtension(), $video_formats)) {
                $file->move($destinationPath, $filename);




            } else {

                // open an image using Imagick function
                $img = new Imagick($file->getRealPath()); 

                // check if the image is jpeg because exif function just support Imagick
                if (preg_match('/.jpg$/i', $filename) || preg_match('/.jpeg$/i', $filename)) {

                    
                    $exif = exif_read_data($file->getRealPath());
                    if(isset($exif['Orientation'])) {
    
                            // switch orientation
                            switch ($exif['Orientation']) {
                            case 8:
                                
                                $img->rotateImage(new ImagickPixel('none'), -90); 
                                
                                break;
                            case 3:
                                
                                $img->rotateImage(new ImagickPixel('none'), 180); 
                                
                                break;
                            case 6:
                                
                                $img->rotateImage(new ImagickPixel('none'), 90); 
                                
                                break;
                            }
                            
                        
                    }

                }

                // save image
                $img->writeImage(public_path() . $pixpath . $filename);


                // clear and destroy Imagick session
                $img->clear(); 
                $img->destroy(); 



                // compress image by quality ( 80 % )

                $this->compress_image(public_path() . $pixpath . $filename, public_path() . $pixpath . $filename, 70);
                //////////////END - IMAGE OPT/////////////
            }
            $status['image'] = base64_encode($pixpath . $filename);
            $post->statustype = 'image';

            $post->status = serialize($status);
        } else {
            $post->status = $newPost->status_text;
        }

        $post->save();
        //Close the task here
        if ($newPost->type == 'mission') {
            $user->completeTask($group->id, $task->id);
        }

        //TODO: make the post private if the user selected private
        
        $returnObject->status = 'OK';
        $returnObject->message = 'Post added successfully';
        $returnObject->postid = $post->id;
        return Response::json($returnObject);
    }




    function compress_image($src, $dest , $quality)
    {
        $info = getimagesize($src);
        $width = $info[0];
        $height = $info[1];

        // check image mime type
      
        if ($info['mime'] == 'image/jpeg') 
        {
            $image = imagecreatefromjpeg($src);
        }
        elseif ($info['mime'] == 'image/gif') 
        {
            $image = imagecreatefromgif($src);
        }
        elseif ($info['mime'] == 'image/png') 
        {
            $image = imagecreatefrompng($src);
        }
        else
        {
            die('Unknown image file format');
        }

        print_r("FILE SIZE");
        print_r(filesize ( $src ));
      
        //compress and save file to jpg
        if (filesize ( $src ) > 500000){
            imagejpeg($image, $dest, $quality);

            $imagick = new Imagick(realpath($dest));

            $imagick->resizeImage($width*0.5, $height*0.5, 1, 0);

            $imagick->writeImage();

            $imagick->destroy();
        }
        //return destination file
        return $dest;
    }

    /**
     * Deletes the post with the supllied postid
     * @return json $returnObject object containing status and message
     */
    public function deletePost() {
        $inputJson = Input::all();
        

        $post = Post::find($inputJson['postid']);


        $returnObject = new stdClass();
        $returnObject->status = 'ok';
        $returnObject->mission_completed = 'false';


        

        $usertask = UserTask::where('user_id', $post->user_id)->where('task_id', $post->task_id)->where('group_id', $post->group_id)->get();

        if (isset($usertask[0])){

            $userTaskRecord = UserTask::find($usertask[0]->id);

            $userTaskRecord->delete();

            $returnObject->mission_completed = 'true';

        }

        // remove likes associated with the post

        $affectedLikes = Like::where('post_id', $inputJson['postid'])->delete();

        // remove notifications associated with the post

        $affectedNotifications = Notification::where('type', 'newlike')->orWhere('type', 'newcomment')->where('source_id', $inputJson['postid'])->delete();



        

        $post->delete();

        $returnObject->message = "Post deleted successfully";

        return Response::json($returnObject);
    }

    /**
     * To be implemented
     * @param type $param
     * @return type
     */
    public function sendMessage($param) {
        $returnObject = new stdClass();
        $returnObject->success = true;
        $returnObject->message = 'Post deleted successfully';

        return Response::json($returnObject);
    }

    /**
     * TODO: To be implemented
     * @param type $param
     */
    public function markMessageRead($param) {
        $returnObject = new stdClass();
        $returnObject->status = 'ok';
        $returnObject->message = 'Post deleted successfully';

        return Response::json($returnObject);
    }

    /**
     * Returns all the messages of a user
     * @param int userid
     * @return JSON $messages (object)
     */
    public function fetchMessages() {
        $inputJson = Input::json();
        $input = (array) $inputJson;

        //We need to validate the input first
        $rules = array(
            'userid' => ['required']
        );

        $errorMessages = array(
            'userid.required' => 'userid can not be empty'
        );

        $validator = Validator::make($input, $rules, $errorMessages);


        //Exit early if the validator fails
        if ($validator->fails()) {
            return Response::json(array(
                        'success' => false,
                        'errors' => $validator->getMessageBag()->toArray()
                            ), 400); // 400 being the HTTP code for an invalid request.
        }

        $messages = Message::all();
        return Response::json($messages);
    }

    /**
     * This function accepts the groupid and survey type and will return the
     * survey json
     * */
    public function getSurvey() {
        $inputJson = Input::json();
        $groupid = $inputJson->get('groupid');
        $surveyType = $inputJson->get('type');
        $group = Group::find($groupid);
        if (is_null($group)) {
            return Response::json(array(
                        'success' => false,
                        'errors' => 'Invalid group id. Please check the groupid and send the request again'
                            ), 400); // 400 being the HTTP code for an invalid request.
        }
        $survey = Survey::find($group->survey);
        if (!is_null($survey)) {
            $data = unserialize($survey->data);
            $fields = json_decode($data[0])->fields;
        }
    }

    /**
     * This should return the pending task for user
     * @param type $param
     */
    public function getPendingTask() {
        $user = Auth::user();
    }

    public function getUserImages() {
        $user = Auth::user();
        $groups = $user->getGroups();
        $images=array();
        foreach($groups as $group) {
            $posts = Post::orderBy('id', 'DESC')->where('group_id', $group->id)->where('user_id', $user->id)->get();
            foreach ($posts as $post) {
                if($post->statustype=='image') {
                    if($img=$post->displayAPIMontage()) {
                        $images[]=$img;
                    }
                }
            }
        }
        return Response::json($images);
    }

    /**
     * Returns the wellbeing data for the days spent by the user
     * @return mixed
     */
    public function getWellbeingTracks()
    {
        $groupid = Input::get('groupid');
        $user = Auth::user();
        $group = Group::find($groupid);

        if (is_null($group)) {
            return Response::json(array(
                'success' => false,
                'errors' => 'Invalid groupid supplied'
            ), 400); // 400 being the HTTP code for an invalid request.
        }
        //Get the wellbeing stats
//        $wellbeing = DB::table('wellbeing_tracks')
//            ->select('group_id', DB::raw('CEIL(AVG(mood)) as mood'), DB::raw('DATE(created_at) as date'))
//            ->where('user_id', $user->id)
//            ->where('group_id', $group->id)
//            ->groupBy('date')
//            ->get();

//        $wellbeing = DB::table('wellbeing_tracks')
//            ->select('group_id','mood',DB::raw('DATE(created_at) as date'))
//            ->where('user_id', $user->id)
//            ->orderBy('id','desc')
//            ->limit(10)
//            ->get();

        $wellbeing = DB::select(DB::raw("SELECT * FROM (
          SELECT id, group_id, mood, DATE(created_at) as date FROM wellbeing_tracks WHERE user_id = $user->id ORDER BY id DESC LIMIT 10) AS wt
          ORDER BY id ASC"));

        foreach ($wellbeing as $wellbeingTrack) {
            $wellbeingTrack->day = (strtotime($wellbeingTrack->date) - $group->timestart) / 86400;
            if (floor($wellbeingTrack->day <= 0))
                $wellbeingTrack->day = 1;
            else
                $wellbeingTrack->day = floor($wellbeingTrack->day) + 1;
        }

        return Response::json($wellbeing);
    }

    //Save survey
    /**
     * Save the survey response
     * @return type
     */
    public function saveSurveyResponse() {
        $input=Input::all();
        $inputSurvey=$input['survey'];

        $survey=Survey::find($inputSurvey['surveyid']);
        $group=Group::find($inputSurvey['group']);
        $user=Auth::user();

        $response = New SurveyResponse();
        $response->user_id = $user->id;
        $response->group_id = $inputSurvey['group'];
        $response->survey_id = $inputSurvey['surveyid'];
        $response->type = $inputSurvey['type'];
        $response->response = serialize($input);

        $response->save();

        $returnResponse=new stdClass();
        $returnResponse->status='OK';
        $returnResponse->message='Completed';

        return Response::json($returnResponse);
    }

    /**
     * This function gets the current mood info from Single page app and updates that into the database
     * @return mixed
     */
    public function updateAPIWellbeing() {
        $input = Input::all();
        $user=Auth::user();

        $wellbeing = new Wellbeing();
        $wellbeing->user_id = $user->id;
        $wellbeing->group_id = $input['groupid'];
        $wellbeing->task_id = 0;
        $wellbeing->mood = $input['mood'];

        $wellbeing->save();

        $returnResponse=new stdClass();
        $returnResponse->status='OK';
        $returnResponse->message='Mood updated';

        return Response::json($returnResponse);
    }
	
	
	/*
	 * 
	 * @Author : John Le
	 * @Function : this function is to get all the message by ID
	 * @return : the json object contains all the messages
	 */
	
	public function messageSearchByID(){
		
		
		// GET ALL CURRENT USER INFORMATION

        // out comming message
		
		$user = Auth::user();

        
		
		$messages = DB::table('messages')->where('to', $user->id)->orderBy('id', 'desc')->groupBy('to')->get();

        //print_r($messages);

        $omessages = DB::table('messages')->where('from', $user->id)->orderBy('id', 'desc')->get();
		
		
		$messagesVar = array();
		
		$id = 0;
		
		foreach($messages as $message){
			
			//if ($message->to != $user->id){
            $userTemp = Auth::user();


                $umessages = DB::table('messages')->where('to', $userTemp->id)->where('from', $message->from)->get();
                $imessages = DB::table('messages')->where('to', $message->from)->where('from', $userTemp->id)->get();


                $mergedArray = array_merge($umessages, $imessages);

                // gwt the lastest message from the merged array

                $lastestMessageArray =  array();

                foreach ($mergedArray as $key => $value) {
                    # code...

                    $tempID = 0;

                    if ($value->id > $tempID){
                        $tempID = $value->id;
                        $lastestMessageArray = $value;
                    }

                }

                //print_r($lastestMessageArray);

                $user = User::where('id', '=', $message->from)->get();

                $m = new \MomentPHP\MomentPHP($lastestMessageArray->created_at);
                $momentFromVo = $m->fromNow();
				
				
				$messagesVar[$id]['from'] = $message->from;
				$messagesVar[$id]['to'] = $message->to;
				$messagesVar[$id]['message'] = substr($lastestMessageArray->message, 0, 45)." . . .";
				$messagesVar[$id]['updated_at'] = $momentFromVo; 
                $messagesVar[$id]['id'] = $lastestMessageArray->id;
				$messagesVar[$id]['username'] = $user[0]['firstname']." ".$user[0]['lastname'];
				$messagesVar[$id]['pic'] = base64_decode($user[0]['picture']);
                //$messagesVar[$id]['type'] = "From : ";
				
				//print_r($user[0]['firstname']);
				
				
				
				
				
				$id++;
			
			//}
			
		}

        

        
        foreach($omessages as $message){
            
            //if ($message->to != $user->id){

                
                $duplicateFlag = 0;


                foreach ($messagesVar as $key => $value) {
                    # code...

                    

                    if ($message->to == $value['from'] && $message->from == $value['to']){

                        //print_r($value); 
                        $duplicateFlag = 1;

                    }

                }


                
                if ($duplicateFlag == 0){

                    $userTempFlag = Auth::user();
                    
                    $imessagesTemp = DB::table('messages')->where('from', $userTempFlag->id)->where('to', $message->to)->get();
                    $umessagesTemp = DB::table('messages')->where('from', $message->to)->where('to', $userTempFlag->id)->get();
                    
                    //$imessages = DB::table('messages')->where('to', $message->from)->get();

                    $mergedArrayTemp = array_merge($umessagesTemp, $imessagesTemp);

                    //print_r($mergedArrayTemp);


                    $lastestMessageArrayTemp =  array();

                    $tempIDOut = 0;

                    foreach ($mergedArrayTemp as $key => $value) {
                        # code...

                        

                        //print_r($value->id);
                        //echo "<br/>";

                        if ((int)$value->id > $tempIDOut){
                            $tempIDOut = (int)$value->id;
                            $lastestMessageArrayTemp = $value;

                        }

                        

                    }

                    //echo $tempIDOut;

                    //echo "<br/>";

                    
                    //print_r($lastestMessageArrayTemp);

                    $user = User::where('id', '=', $message->to)->get();

                    $m = new \MomentPHP\MomentPHP($lastestMessageArrayTemp->created_at);
                    $momentFromVo = $m->fromNow();
                
                    //$messagesVar[$id]['id'] = $message->id;
                    $messagesVar[$id]['from'] = $message->to;
                    $messagesVar[$id]['to'] = $message->from;
                    $messagesVar[$id]['message'] = substr($lastestMessageArrayTemp->message, 0, 45)." . . .";
                    $messagesVar[$id]['updated_at'] = $momentFromVo; 
                    $messagesVar[$id]['id'] = $message->id; 
                    $messagesVar[$id]['username'] = $user[0]['firstname']." ".$user[0]['lastname'];
                    $messagesVar[$id]['pic'] = base64_decode($user[0]['picture']);
                    //$messagesVar[$id]['type'] = "To : ";

                    
                    $id++;

                }


            
                
            
            //}
            
        }


        

        


        //$messagesVar = array_unique($messagesVar, SORT_REGULAR);
        
		
		//exit();
		//print_r($user['id']);
		
		//DB::select('DELETE from messages where to = ?', array(54));
		
		return Response::json($messagesVar);
		
	}
	
	
	
	/*
	 * 
	 * @Author : John Le
	 * @Function : this function is to get the conversation between user and sender by sender ID
	 * @return : the json object contains all the messages belong to the conversation
	 */
	
	public function searchConversationByID(){
		
		$input = Input::all();
		$user = Auth::user();
		
		$messages = array();
		
		$umessages = Message::where('to', '=', $user['id'])->where('from', $input['id'])->get();
		$imessages = Message::where('to', '=', $input['id'])->where('from', $user['id'])->get();

		//echo($input['id']);
		$i= 0;



		foreach($umessages as $umessage){

			if(true/*$umessage->from != $user['id'] && $umessage->to != $user['id']*/){

				$tou = DB::select('select * from users where id = ?', array($umessage->to));

				$fromu = DB::select('select * from users where id = ?', array($umessage->from));

                $messages['user']['firstname'] = ucfirst($tou[0]->firstname);
                $messages['user']['lastname'] = ucfirst($tou[0]->lastname);

				$messages['list'][$i]['id'] = $umessage->id;

				$messages['list'][$i]['message'] = $umessage->message;
				$messages['list'][$i]['from'] = $umessage->from;
				$messages['list'][$i]['to'] = $umessage->to;
				$messages['list'][$i]['pic'] = base64_decode($fromu[0]->picture);
				$messages['list'][$i]['tousername'] = $tou[0]->firstname." ".$tou[0]->lastname;
				$messages['list'][$i]['fromusername'] = $fromu[0]->firstname." ".$fromu[0]->lastname;

                if ($umessage->from == $user['id']) {
                    $messages['list'][$i]['type'] = 'current_user';
                }

                $m = new \MomentPHP\MomentPHP($umessage->updated_at);
                $momentFromVo = $m->fromNow();
				$messages['list'][$i]['updated_at'] = $momentFromVo;

				$i++;

			}
		}


		foreach($imessages as $imessage){

			if(true/*$imessage->from != $user['id'] && $imessage->to != $user['id']*/){

				$tou = DB::select('select * from users where id = ?', array($imessage->to));

				$fromu = DB::select('select * from users where id = ?', array($imessage->from));

                $messages['user']['firstname'] = ucfirst($tou[0]->firstname);
                $messages['user']['lastname'] = ucfirst($tou[0]->lastname);

				$messages['list'][$i]['id'] = $imessage->id;
				$messages['list'][$i]['message'] = $imessage->message;
				$messages['list'][$i]['from'] = $imessage->from;
				$messages['list'][$i]['to'] = $imessage->to;
				$messages['list'][$i]['pic'] = base64_decode($fromu[0]->picture);
				$messages['list'][$i]['tousername'] = $tou[0]->firstname." ".$tou[0]->lastname;
				$messages['list'][$i]['fromusername'] = $fromu[0]->firstname." ".$fromu[0]->lastname;

                if ($imessage->from == $user['id']) {
                    $messages['list'][$i]['type'] = 'current_user';
                }

				$m = new \MomentPHP\MomentPHP($imessage->updated_at);
                $momentFromVo = $m->fromNow();
                $messages['list'][$i]['updated_at'] = $momentFromVo;
				
				$i++;
			
			}
		}
		
		//print_r($messages);
		
		return $messages;
	}
	
	
	
	/*
	 * 
	 * @Author : John Le
	 * @Function : this function is to send the message to user by ID
	 * @return : status code FAIL OR SUCCESS
	 */
	
	public function messageSend(){
		
		
		
		$input = Input::all();
		$user = Auth::user();
		
		
		
		$message = new Message;

		$message->from = $user['id'];
		
		$message->to = $input['id'];
		
		$message->message = $input['message'];
		
		$message->save();
		
		
		// add new record to notification table

        Session::set('notificationMessage', $input['message']);
		
		$this->addNotification($input['id'], 'message', $message->id, $input['message'] );

        
		
		// end
		
		return "OK";
		
	}


    public function siteURL()
    {
        $protocol = 'http://';
        $domainName = $_SERVER['HTTP_HOST'].'/';
        return $protocol.$domainName;
    }
	
	
	/*
	 * 
	 * @Author : John Le
	 * @Function : add new record to notification table
	 * @return : ( BOOL ) status code
	 */
	
	public function addNotification($userid, $type, $sourceid, $message ){
		
		$user = Auth::user();

        // get target user status

        $userStatus =  DB::table('users')
                ->where('id', $userid)
                ->pluck('suspended');


        if ($userStatus == '0'){
            
        
		
        		$notification = new Notification;
        		
        		$notification->user_id = $userid;

                if (Session::get('source_user_id')){
                    $notification->source_user_id = Session::get('source_user_id');
                }else{
                    $notification->source_user_id = $user['id'];
                }
        		//////////
        		//file_get_content(http://rf.php)
        		/////////
        		
        		
        		$notification->type = $type;
        		
        		$notification->source_id = $sourceid;
        		
        		$notification->message = $message;
        		
        		$notification->save();

                $notification->id;

                // get the server host name and protocol

                if ($_SERVER['SERVER_PORT'] == '80'){
                    $protocol = 'http://';
                }else{
                    $protocol = 'https://';
                }


                
                $domainName = $_SERVER['HTTP_HOST'];
                //echo $protocol.$domainName;


                //////////////// SPECIFY THE TYPE OF NOTIFICATIONS

                $desUrl = "";

                        

                        // set the destination URL here

                        

                        if ($type == "newgroupmessage"){
                            $msg = "sent you a message";
                            $desUrl .= "/#/message/view/".$sourceid;

                            
                        }

                        if ($type == "message"){
                            $msg = "sent you a message";

                            $desUrl .= "/#/message/".$notification->source_user_id;
                            
                        }

                        if ($type == "newlike"){
                            $msg = "likes your post";

                            // set the destination URL here

                            $desUrl .= "/#/wall/".$notification->source_id;
                        }

                        if ($type == "newcomment"){
                            $msg = "has commented on your post";

                            // set the destination URL here

                            $desUrl .= "/#/wall/".$notification->source_id;
                        }

                        if ($type == "newcommentother"){
                            $msg = "has commented on a post you commented on";

                            // set the destination URL here

                            $desUrl .= "/#/wall/".$notification->source_id;
                        }

                        if ($type == "newgroupmember"){
                            $msg = "has joined your team";
                        }

                        if ($type == "missionpending"){
                            $msg = "have one mission pending";
                        }
                $userArray = User::where('id', '=', $notification->source_user_id)->get();  

                //print_r($desUrl);  

                $value = Session::get('notificationMessage');  

                if (isset($value)){
                    $notificationMessage = $value;
                } else{
                    $notificationMessage = "";
                } 

                // set the destination url

                // dont send newgroupmember push notification

                if ($type != "newgroupmember"){


                    $user = User::where('id', '=', $userid)->get();  

                    // check if target user allows sending push notification

                    //print_r ($user[0]);

                    if ($user[0]->push_notification == '1'){

                        //echo "yes";

                        // init the notification object

                        $pushNotificationObject = new PushNotificationController();

                        $pushNotificationObject->sendPushNotification(SITE_URL.$desUrl, $userArray[0]['firstname']." ".$msg."\n \n".$notificationMessage, "mobile", $userid);
                    }

                    
                }

                

                //print_r($userArray[0]['firstname']);

                Session::forget('notificationMessage');

        ///////////////
        }
		
		return true;
	}


	/*
	 * 
	 * @Author : John Le
	 * @Function : this function return the number of the notifications
	 * @return : ( int ) number of notifications
	 */
	
	public function notificationNum(){
		$user = Auth::user();
        
        $notification = Notification::where('user_id', '=', $user['id'])->where('isRead', '=', 0)->get();

        //print_r($notification);
        //$notification_message = Notification::where('user_id', '=', $user['id'])->where('type', '=', 'message')->get();

        $not = "false";

        //print_r($user['id']);

        if (isset($notification[0])){

            $notificationObj = Notification::where('user_id', '=', $user['id'])->where('isRead', '=', 0)->orderBy('id', 'desc')->first();

            $not = $notificationObj;
            $not['count'] = count($notification);
            //$not['message_count'] = count($notification_message);
            $sc = DB::select('select * from users where id = ?', array($notificationObj->source_user_id));

            $not['user'] = $sc;

        }
        
        return $not;
		
	}




    public function notificationRemove(){
        $user = Auth::user();
        
        //$notification = Notification::where('user_id', '=', $user['id'])->where('isRead', '=', 0)->get();
        

        
        
    }
	
	
	/*
	 * 
	 * @Author : John Le
	 * @Function : this function set the status of user notification
	 * @return : ( BOOL ) return the status code TRUE | FALSE
	 */
	
	public function setNotification(){
		$input = Input::all();
		$user = Auth::user();
		
		$user = User::find($user['id']);

		
		
		
		
		// NORMAL OR EMAIL NOTIFICATION
		
		if ($input['type'] == "normal"){
			
			$user->notification = $input['data'];
			
		}else if($input['type'] == "email") {
			
			$user->notification_email = $input['data'];
			
		}else if($input['type'] == "push") {
            
            $user->push_notification = $input['data'];
            
        }else{
			$user->notification_web = $input['data'];
		}
		
		
		
		$user->save();
		
		return "true";
		
	}
	
	
	/*
	 * 
	 * @Author : John Le
	 * @Function : this function get the status of user notification
	 * @return : ( JSON ) return the array contain user notification setting
	 */
	 
	 public function getNotification(){
		$input = Input::all();
		$user = Auth::user();
		
		$user = User::find($user['id']);
		
		return $user;
		
	 }
	 
	 
	 
	 
	 /*
	 * 
	 * @Author : John Le
	 * @Function : this function get the list of all user notifications
	 * @return : ( JSON ) return the array contain user notification list
	 */
	 
	 public function getNotificationList(){
		$input = Input::all();
		$user = Auth::user();
		
		$notifications = Notification::where('user_id', $user['id'])->orderBy('id', 'DESC')->get();
		
		$returnArray = array();
		
		$i = 0;
		
		foreach($notifications as $notification){
			
			//print_r($notification->user_id);

            $msg = "new message";
            $filterImage = "filter-msg.png";

                if ($notification->type == "newlike"){
                    $msg = "new like";
                    $filterImage = "filter-likes.png";
                }

                if ($notification->type == "newcomment"){
                    $msg = "new comment";
                    $filterImage = "filter-comments.png";
                }

                if ($notification->type == "newgroupmember"){
                    $msg = "new team member";
                    $filterImage = "filter-new-roller.png";
                }

                if ($notification->type == "missionpending"){
                    $msg = "mission pending";
                }
			
			$user = DB::select('select * from users where id = ?', array($notification->source_user_id));

            if ($user){


			
        			$returnArray[$i]['id'] = $notification->id;
        			
        			$returnArray[$i]['user_id'] = $notification->user_id;
        			
        			$returnArray[$i]['source_user_id'] = $notification->source_user_id;
        			
        			$returnArray[$i]['type'] = $notification->type;
        			
        			$returnArray[$i]['source_id'] = $notification->source_id;
        			
        			$returnArray[$i]['message'] = $notification->message;

                    $returnArray[$i]['title'] = $msg;

                    $returnArray[$i]['filterImage'] = $filterImage;
        			
        			$returnArray[$i]['isRead'] = $notification->isRead;

                    $returnArray[$i]['source_id'] = $notification->source_id;
        			
        			$returnArray[$i]['updated_at'] = $notification->updated_at; 
        			
        			$returnArray[$i]['created_at'] = $notification->created_at;
        			
        			$returnArray[$i]['type'] = $notification->type;
        			
        			//$returnArray[$i]['userarray'] = $user;
        			
        			$returnArray[$i]['src_user_pic'] = base64_decode($user[0]->picture);
        			
        			$returnArray[$i]['username'] = $user[0]->firstname ." ".$user[0]->lastname;
        			//print_r(base64_decode($user[0]->picture));

            }
			
			DB::table('notifications')->where('id', $notification->id)->update(array('isRead' => 1));
			
			$i++;
			
			
			
		}
		
		
		return $returnArray;
		
	 }


	/*
	 * 
	 * @Author : John Le
	 * @Function : this function get the list of either presurvey or post survey questions
	 * @return : ( JSON ) return the array contains certain survey list
	 */
	 
	 public function getSurveyList(){
	 	
		
	 		$input = Input::all();
			
			
			if ($input['type'] == 'pre'){
				
				$group = Group::where('id', $input['groupid'])->pluck('survey');
				
				//print_r($group);
				
				$survey = Survey::where('id', $group)->get();
				
			}else{
				
				$group = Group::where('id', $input['groupid'])->pluck('postsurvey');
				
				$survey = Survey::where('id', $group)->get();
				
			}	
			
			$ret = str_replace('{"fields":',"",rtrim(unserialize($survey[0]->data)[0]));
			
			$ret = rtrim($ret, "}");
		
			return $ret;
		
	 }
	 
	 
	 /*
	 * 
	 * @Author : John Le
	 * @Function : save user sign-up form to the database
	 * @return : ( BOOL ) return the status in BOOL (true | false)
	 */
	 
	 public function apiSignUp(){
	 	
			$message = "";

            $returnArray = array();


            $securimage = new Securimage();

            $input = Input::all();

            if (!isset($input['securitycode'])){
                $input['securitycode'] = "";
            }



            if ($securimage->check($input['securitycode']) == false) {
                  $message = "Incorrect answer";
            }else{



		
		
            

            $rules = array(
                'username' => 'required|unique:users',
                'password' => 'required',
                'screenhandle' => 'required',
                'email' => 'required|unique:users|email',
                'firstname' => 'required|alpha',
                'lastname' => 'required',
                'city' => 'required',
                'country' => 'required',
            );
            
            $messages = array(
                'screenhandle.required' => 'The Roller name can not be blank'
            );

            //$validator = Validator::make($input, $rules, $messages);
            
            $username =  DB::table('users')
                ->where('username', Input::get('username'))
                ->get();
			
			$user =  DB::table('users')
                ->where('email', Input::get('email'))
                ->get();
			
			$group = DB::table('groups')
                ->where('keycode', Input::get('keycode'))
                ->get();
				
			//print_r($user);	
			
			//print_r(count($group));
			
			// error check
			
			



            


            if (!Input::get('password')){
                
                $message = "Password can not be blank";
                
            }

           

            if (!Input::get('lastname')){
                
                $message = "Lastname can not be blank";
                
            }

            if (!Input::get('firstname')){
                
                $message = "Firstname can not be blank ";
                
            }


            if (!Input::get('securitycode')){
                $message = "Security code can't be blank !";
            }

            
            if (!Input::get('tos')){
                
                $message = "You need to agree with EULA";
                
            }
            
            
			
			if (count($group) == 0){
				$message = "Your keycode is invalid";
			}

            
            


            if (filter_var(Input::get('email'), FILTER_VALIDATE_EMAIL) === false) {
               $message = "Please enter a valid email address !";
            }
			
			if (count($user) > 0){
				$message = "This emailalready exists !";
			}
			
			
            


            if (count($username) > 0){
                $message = "This username already exists !";
            }
			
			// end error check
			
			
			
			
			//echo $message;

            // get incremental number
			
			$rollername = "Roller ".rand(1, 999);

            // generate roller name


            //print_r($input['securitycode']);


			
			
			
			
			if (!$message){
					
					// begin the sigh - up proccess
					
					$user = new User;

	                $user->username = Input::get('email');
	                //$user->password = Hash::make(Input::get('password'));
	                $user->password = Hash::make(Input::get('password'));
	                $user->screenhandle=$rollername;
	                $user->firstname = Input::get('firstname');
	                $user->lastname = Input::get('lastname');
	                $user->email = Input::get('email');
					//$user->picture = "L3VwbG9hZHMvcGl4L3VzZXIvam9obi5sZS5wbmc=";
	                $user->state = "N/A";
	                //$user->country = Input::get('country');
	                $user->keycode = Input::get('keycode');
	                //$user->description = Input::get('description');
	                //$user->picture = '';
	                $user->suspended = 0;
	
	               // add the user to the default group Sydney Group
	
	                 $user->save();

                     $returnArray['user_id'] = $user->id;

                     Session::put('user.lastinsertid', $user->id);
	                
	                
					 $groupuser = new GroupUser;
					 
					 //// Search the matching keycode inside the group table then enroll user to that group
					 
					 if ($user->keycode){
					
							 $group = Group::where('keycode', strtolower ( Input::get('keycode') ))->get();
							 
							 //print_r($group[0]->id);
							 
							 // check this constaint
							 
							 
							
							 $groupuser->group_id = $group[0]->id;
					 
							 $groupuser->user_id = $user->id;
							 
							 $groupuser->save();

                             // add notification to the group

                             //$this->addNotification($post->user_id, 'newgroupmember', $input['postid'], "likes your post" );

                             //loop thru

                             $this->sendNotificationToGroup($group[0]->id, $user->id);

                             // end notification adding
						
					 }

                     if (Input::get('token')){

                         DB::table('custom_user_token')->insert(
                            array('user_id' => $user->id, 'token' => Input::get('token'))
                        );

                     }

                     $emailContent['firstname'] = Input::get('firstname');
                     $emailContent['username'] = Input::get('username');
                     $emailContent['password'] = Input::get('password');
                     $emailContent['teamname'] = $group[0]->name;
					 
					//New Account confirmation email
					$baseController = new BaseController();

                    $baseController->notificationEmail($input['email'],$emailContent,"Welcome to On A Roll 21™", Input::get('firstname').' '.Input::get('lastname'), 'signup');

                    //print_r($baseController);
						
						
				
					// end the sign up process
                	
					$message =  "true"; 
                    
					
            }


        }
			
		$returnArray['status'] = $message;	
		
		return json_encode($returnArray);
		
	 }

     // this function to check whether the email address is valid or not
     // return true | false
     function regexpValidation($email) {
            $pattern = '/^(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){255,})(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){65,}@)(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22))(?:\\.(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22)))*@(?:(?:(?!.*[^.]{64,})(?:(?:(?:xn--)?[a-z0-9]+(?:-+[a-z0-9]+)*\\.){1,126}){1,}(?:(?:[a-z][a-z0-9]*)|(?:(?:xn--)[a-z0-9]+))(?:-+[a-z0-9]+)*)|(?:\\[(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){7})|(?:(?!(?:.*[a-f0-9][:\\]]){7,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?)))|(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){5}:)|(?:(?!(?:.*[a-f0-9]:){5,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3}:)?)))?(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))(?:\\.(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))){3}))\\]))$/iD';
            return preg_match($pattern,$email);
    }



     public function sendNotificationToGroup($groupid, $userid){

            //print_r($groupid.'userid'.$userid);
            
            $groupUser = GroupUser::where('group_id', $groupid)->where('user_id', '!=', $userid)->get();

            foreach ($groupUser as &$value) {
                //echo $value->user_id;
                //Session::put('source_user_id', $userid);
                //$this->addNotification($value->user_id, 'newgroupmember', $userid, "has just joined your team" );
            }

            //print_r($groupUser);


     }



	  public function saveSResponse() {
        
        
        $input=Input::all();
        $survey=Survey::find($input['surveyid']);
        $group=Group::find($input['groupid']);
        $user=User::find($input['userid']);
        
        if(is_null($survey) || is_null($group) || is_null($user)) {
            //App::abort(404);
        }
        
        $response = New SurveyResponse();
        $response->user_id = $input['userid'];
        $response->group_id = $input['groupid'];
        $response->survey_id = $input['surveyid'];
        $response->type = $input['type'];
        $response->response = serialize($input);
        
        $response->save();
        
        
		 
		 
		 return "true";
        
    }
	
	
     /*
	 * 
	 * @Author : John Le
	 * @Function : Detect whether the mission is the last mission or not 
	 * @return : ( BOOL ) return the status in BOOL (true | false)
	 */
	 
	 
	 public function detectLastMission(){
	 	
	 	$input=Input::all();
		
		
		$group = Group::where('id', trim(Input::get('groupid')))->get();
		
		$outcomeID = $group[0]['outcome'];
		
		$finalTask = DB::table('final_task')
                ->where('outcome_id',$outcomeID)
                ->pluck('task_id');
		
		return $finalTask;
		
	 }
	 
	 
	 
	 
	 /*
	 * 
	 * @Author : John Le
	 * @Function : check if whether the pre survey of selected group completed or not
	 * @return : ( BOOL ) return the status in BOOL (true | false)
	 */
	 
	 public function isPresurveyCompleted(){
	 	$input=Input::all();
		$user = Auth::user();
		
		$ret = "false";

        // set the timestamp for the last_login field

        /*DB::table('users')
            ->where('id', $user['id'])
            ->update(array('last_login' => time()));
            */
		
		$surveyResponse = DB::table('survey_response')->where('user_id', $user['id'])->where('group_id', $input['groupid'])->where('type', 'pre')->first();
		
		if ($surveyResponse){
			$ret = "true";
		}
		
		return $ret;
		
	 }
	 
	 
	 public function areAllTasksDone(){
	 	
		$input=Input::all();
		$user = Auth::user();
		
		$ret = "false";
		
		$group = Group::find($input['groupid']);
        $outcome = Outcome::find($group->outcome);
		
		
        $availArray = array_fetch($outcome->tasks->toArray(), 'id');
		
		$availArrayCount = count($availArray);
		
		$tmpUserTaskArray = DB::table('user_tasks')->where('outcome_id', $group->outcome)->where('user_id', $user['id'])->lists('task_id');
			
		
		if ($availArrayCount == count($tmpUserTaskArray)){
			
			// user finished all the tasks
			$ret = "true";
			
			
		}
		
		return $ret;
		
	 }


     /*
     * 
     * @Author : John Le
     * @Function : return true if there is an inactive task for more than 8 hours
     * @return : ( BOOL ) return the status in BOOL (true | false)
     */

     public function getInactiveTask(){

            $ret = "false";



            // get pending task content





            // check if there is more than 8 hours





            return $ret;


     }

     /*
     * 
     * @Author : John Le
     * @Function : send a post report to zend desk support
     * @parameter : userid , postid, groupid
     * @return : none
     */

     public function postReport(){

        $input=Input::all();
        $user = Auth::user();

        

        $userArray = DB::table('users')
                ->where('id', $input['userid'])
                ->get();


         $userArray = $userArray[0];       
        
        //print_r($userArray);

        $headers  = 'MIME-Version: 1.0' . "\r\n";
        $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";

        // Additional headers
        $headers .= 'To: '.$userArray->firstname.' <'.$userArray->email.'>' . "\r\n";

        $notificationEmailObj['content'] = "Name : ".$userArray->firstname.'<br/>'."Email : ".$userArray->email.'<br/>'."Userid : ".$input['userid'].' / PostID : '.$input['postid'].'/ GroupID : '.$input['groupid'];
        
        
        // send email to Zendesk support
        //mail("support@onaroll21.com", "A post has been reported !","Name : ".$userArray->firstname.'<br/>'."Email : ".$userArray->email.'<br/>'."Userid : ".$input['userid'].' / PostID : '.$input['postid'].'/ GroupID : '.$input['groupid'],$headers);

        $baseController = new BaseController();
        $baseController->supportEmail($user['email'], $notificationEmailObj,"A post has been reported !", $userArray->firstname, "supportticket"); 

     }


     /*
     * 
     * @Author : John Le
     * @Function : send a comment report to zend desk support
     * @parameter : userid , commentid, postid, groupid
     * @return : none
     */


     public function commentReport(){

        $input=Input::all();
        $user = Auth::user();

        

        $userArray = DB::table('users')
                ->where('id', $input['userid'])
                ->get();


         $userArray = $userArray[0];       
        
        //print_r($userArray);

        $headers  = 'MIME-Version: 1.0' . "\r\n";
        $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";

        // Additional headers
        $headers .= 'To: '.$userArray->firstname.' <'.$userArray->email.'>' . "\r\n";

        $notificationEmailObj['content'] = "Name : ".$userArray->firstname.'<br/>'."Email : ".$userArray->email.'<br/>'."Userid : ".$input['userid'].' / PostID : '.$input['postid'].'/ CommentID :'.$input['commentid'].'/ GroupID : '.$input['groupid'];
        
        
        // send email to Zendesk support
        //$result = mail("support@onaroll21.com", "A comment has been reported !","Name : ".$userArray->firstname.'<br/>'."Email : ".$userArray->email.'<br/>'."Userid : ".$input['userid'].' / PostID : '.$input['postid'].'/ CommentID :'.$input['commentid'].'/ GroupID : '.$input['groupid'],$headers);

        $baseController = new BaseController();
        $baseController->supportEmail($user['email'], $notificationEmailObj,"A comment has been reported !", $userArray->firstname, "supportticket"); 

        $result = true;

        // check email status ERROR / SUCCESS
        if(!$result) {   
             echo "Error";   
        } else {
            echo "Success";
        }

     }


    /*
     * 
     * @Author : John Le
     * @Function : update the user profile
     * @return : return status code and error message ( if capable )
     */

     public function updateUserProfile(){

            $ret = "false";
            $input=Input::all();
            $user = Auth::user();

            $fileObj = $input['file'];

            //print_r($fileObj->pathName);

            $userdata = json_decode($input['post']);

            //print_r($fileObj);

            $message = "OK";

            if ($input['file'] != 'undefined'){


                if (file_exists(public_path().base64_decode($user['picture']))){

                                if ($user['picture'] != "L3VwbG9hZHMvcGl4L3VzZXIvZGVmYXVsdC5naWY="){

                                    unlink(public_path().base64_decode($user['picture']));
                                    //$message = "unlink !";

                                }
                }



                $fileType = explode('/',$userdata->fileType);

                //print_r(strtolower($user['firstname'].'.'.$user['lastname']));


                $filepath = public_path().'/uploads/pix/user/'.strtolower($user['firstname']).'.'.strtolower($user['lastname']).'.'.$fileType[1];


                //$input['img']

                //$this->base64_to_jpeg($input['file'], $filepath);

                // copy uploaded file to the uploads folder
                //move_uploaded_file(,$filepath);
                $fileObj->move(public_path().'/uploads/pix/user/', strtolower($user['firstname']).'.'.strtolower($user['lastname']).'.'.$fileType[1]);


                // compress image to 70 % of quality

                $this->compress_image($filepath, $filepath, 75);

                //$message = "cool";

            }

            /////// condition check


            $userEmailCheck =  DB::table('users')
                ->where('email', $userdata->email)
                ->where('id', '!=' ,$user->id) 
                ->get();
            
//            $userScreenNameCheck =  DB::table('users')
//                ->where('screenhandle', $userdata->screenname)
//                ->where('id', '!=' ,$user->id)
//                ->get();
            
            
            // error check
            
            
            
            // check the email address

            if (count($userEmailCheck) > 0){
                $message = "This email is already exist !";
            }

            // check the sceen handle

//            if (count($userScreenNameCheck) > 0){
                //$message = "This screen name is already taken !";
//            }

            

            if ($message == "OK"){
                    ////// begin the database updating process

                    $userUpdate = User::find($user->id);

                    
                    if (isset($userdata->password)){
                        $userUpdate->password = Hash::make($userdata->password);
                        //echo "yes";
                    }
//                    $userUpdate->screenhandle=$userdata->screenname;
                    $userUpdate->firstname = $userdata->firstname;
                    $userUpdate->lastname = $userdata->lastname;
                    $userUpdate->email = $userdata->email;

                    //print_r(file_exists(public_path().base64_decode($user['picture'])));

                    if (isset($filepath)){
                        
                        
                        $userUpdate->picture = base64_encode('/uploads/pix/user/'.strtolower($user['firstname']).'.'.strtolower($user['lastname']).'.'.$fileType[1]);
                        
                    }

                    
//                    $userUpdate->state = $userdata->state;
                    //$user->country = Input::get('country');
                    
                    //print_r($userUpdate);
                   
    
                     $userUpdate->save();

                    ////// end the database updating process
            }


            

            





            return $message;


     }




     public function base64_to_jpeg($base64_string, $output_file) {
        $ifp = fopen($output_file, "wb"); 

        $data = explode(',', $base64_string);

        fwrite($ifp, base64_decode($data[1])); 
        fclose($ifp); 

        return $output_file; 
    }

    // this function ll help to reset the user password

    public function forgotPwd(){

        $returnMessage = "";

        $temporaryPassword = substr(md5(time()), 0, 8);

        $userEmailCheck =  DB::table('users')
                ->where('email', Input::get('email'))
                ->get();
            
            
            // check the email address

        if (count($userEmailCheck) == 0){
            $returnMessage = "This email doesn't exist !";
        }

        if ($returnMessage == ""){
            $userUpdate = User::find($userEmailCheck[0]->id);
            $userUpdate->password = Hash::make($temporaryPassword);
            $userUpdate->save();

            //print_r($userEmailCheck[0]->id);

            $notificationEmailObj['content'] = 'Your temporary password is : '.$temporaryPassword;
            $notificationEmailObj['email'] = Input::get('email');

            $this->notificationEmail(
                        Input::get('email'), $notificationEmailObj
                        ,"Reset your password", Input::get('firstname').' '.Input::get('lastname'), 'forgottenpassword');

            
            $returnMessage = "OK";
        }

        return $returnMessage;


    }


    // this function will send email to support@onaroll21.com

    public function supportFeedback(){

        $input=Input::all();
        $user = Auth::user();

        if (!isset($input['name'])){
                $input['name'] = $user['firstname'].' '.$user['lastname'];

        }


        if (!isset($input['email'])){
                $input['email'] = $user['email'];

        }

        

        $notificationEmailObj['content'] = "Name : ".$input['name'].'<br/>'."Email : ".$input['email'].'<br/>'."Message : ".$input['feedback'];
        
        

        //mail("support@onaroll21.com", $input['type'],"Name : ".$input['name'].'<br/>'."Email : ".$input['email'].'<br/>'."Message : ".$input['feedback'],$headers);


        $baseController = new BaseController();
        $baseController->supportEmail($input['email'], $notificationEmailObj,$input['type'], $input['name'], "supportticket");           


    }

    

    



    


    public function moodCheckTime(){

        $user = Auth::user();

        DB::table('users')
            ->where('id', $user['id'])
            ->update(array('last_login' => time()));

    }


    public function taskCompleted(){

        $user = Auth::user();

        $groupid = DB::table('group_users')
                ->where('user_id', $user->id)
                ->pluck('group_id');


        $userArray = DB::table('user_tasks')
                ->where('user_id', $user->id)
                ->where('group_id', $groupid)
                ->get();


         return count($userArray);         


    }



    public function emailUnsubscribe(){

        $input=Input::all();

        //print_r($_SERVER['REQUEST_URI']);

        $mail = explode("/" , $_SERVER['REQUEST_URI']);

        //print_r(trim($mail[4]));


        DB::table('users')
            ->where('email', trim($mail[4]))
            ->update(array('notification_email' => 0));

        //$message = "Unsubscribe successfully.";

        return View::make('api.unsubscribe');

        

    }

    
   public function completePreSurvey(){


        $input=Input::all();
        //$inputSurvey=$input['survey'];


        $survey=Survey::find($input['surveyid']);
        $group=Group::find($input['groupid']);
        $user=Auth::user();

        $response = New SurveyResponse();
        $response->user_id = $user->id;
        $response->group_id = $input['groupid'];
        $response->survey_id = $input['surveyid'];
        $response->type = "pre";
        $response->response = serialize("");

        $response->save();


        return "";

   }  



   /**
     * Fetch all the members belongs to the specific group
     * @return Json list
     */
    //TODO: Check for all the requirements against the output of this function
    public function groupMessageMemberList(){

        $user = Auth::user();
        $input = Input::all();
        
        
        $groupusers = GroupUser::where('group_id', '=', $input['gid'])->get();
        
        $users = array();
        $i = 0;
        
        foreach($groupusers as $groupuser){
            
            $users[$i] = DB::table('users')->where('id', $groupuser->user_id)->get();

            
            $users[$i][0]->picture = base64_decode($users[$i][0]->picture);
            
            $i++;
            
        }
        
        return json_encode($users);


    }


    /**
     * Insert a new record to the group_message table that indicate, and insert initial record tothe group_message_chats table
     * @return room title and room id
     */
    //TODO: Check for all the requirements against the output of this function
    public function initRoomData(){

            // get user data from the current session

            $user = Auth::user();

            $title = "Untitled by ".$user['firstname'];

            $roomArray = array('title' => $title, 'user_id' => $user['id']);

            $id = DB::table('message_group')->insertGetId(
                $roomArray
            );


            // insert record to chat table

            $userArray['uid'] = $user['id'];
            $userArray['name']  = $user['firstname'].' '.$user['lastname'] ;

            $chatArray = array(
                'message_group_id' => $id, 
                'user_id' => $user['id'], 
                'content' => $user['firstname']." has started this conversation",
                'attendees' => json_encode($userArray),
                'type' => "notification"


            );

            DB::table('message_group_chats')->insertGetId(
                $chatArray
            );

            $roomArray['roomid'] = $id;



            // write intro message

            return json_encode($roomArray);

    }



    public function groupMessageSend(){

            $input = Input::all();
            $user = Auth::user();
            
            
            
            $messageArray = array(
                'message_group_id' => $input['id'], 
                'user_id' => $user['id'], 
                'content' => $input['message'],
                'attendees' => json_encode($input['userList']),
                'type' => "message"


            );

            $id = DB::table('message_group_chats')->insertGetId(
                $messageArray
            );
            
            
            
            
            return "OK";

    }



    public function groupMessageList(){

            $input = Input::all();
            $user = Auth::user();


            $messages = DB::table('message_group_chats')->where('message_group_id', $input['id'])->get();

            //$scope.messages = $messages;

            $i = 0;

            foreach($messages as $message){

                    $user = DB::select('select * from users where id = ?', array($message->user_id));

                    //print_r($user[0]->picture);

                    $tmessages[$i]['userid'] = $message->user_id;
                    $tmessages[$i]['pic'] = base64_decode($user[0]->picture);
                    $tmessages[$i]['fname'] = $user[0]->firstname." ".$user[0]->lastname;
                    $tmessages[$i]['content'] = $message->content;
                    $tmessages[$i]['created_on'] = $message->created_on;
                    $tmessages[$i]['type'] = $message->type;


                    $i++;

            }


            return json_encode($tmessages);

    }



    public function groupMessageNewMember(){


            $input = Input::all();

            $chatArray = array(
                'message_group_id' => $input['roomid'], 
                'user_id' => $input['newmemberid'], 
                'content' => $input['newmemberfname']." has joined this conversation",
                'attendees' => json_encode($input['userList']),
                'type' => "notification"


            );

            DB::table('message_group_chats')->insertGetId(
                $chatArray
            );


            return "DONE";


    }


    public function groupMessageremoveMember(){


            $input = Input::all();

            $chatArray = array(
                'message_group_id' => $input['roomid'], 
                'user_id' => $input['newmemberid'], 
                'content' => $input['newmemberfname']." has left this conversation",
                'attendees' => json_encode($input['userList']),
                'type' => "notification"


            );

            DB::table('message_group_chats')->insertGetId(
                $chatArray
            );


            return "DONE";


    }


    public function apiCheckLogin(){

            $input = Input::all();

            $username = $input['username'];
            $password = $input['password'];

            //$user = DB::table('users')->where('username', $input['username'])->where('password', Hash::make($input['password']))->get();

            $status = false;

            if (Auth::attempt(array('username' => $input['username'], 'password' => $input['password'])))
            {
                $status = DB::table('users')->where('username', $input['username'])->get();
            }
            // strim out the square bracket from the json string
            $status = str_replace("[","",json_encode($status));
            $status = str_replace("]","",$status);

            return $status;

    }

    // search the group message by user id 


    public function groupMessageSearchByUserID(){

            $chatArray = array();


            $user = Auth::user();
        
            $messages = GroupMessage::all();

            $tempGroup = 0;

            $flag = "";


            $i = 0;
            
            foreach($messages as $message){

                

                    $chats = DB::table('message_group_chats')->where('message_group_id', $message->id)->get();

                    foreach($chats as $chat){

                            //print_r($chat);

                            foreach(json_decode($chat->attendees) as $attendee){

                                if (isset($attendee->uid)){




                                    //echo $chat->message_group_id ;
                                    //echo $flag;
                                    //echo '</br>';
                                    $attendee->conversationid = $message->id;
                                    $attendee->count = $i;
                                    //print_r( $attendee );
                                    //print_r($chat->message_group_id);

                                    $u = DB::table('users')->where('id', $message->user_id)->get();
                                

                                    if ($flag != $chat->message_group_id){          



                                            
                                            $chatArray[$i]['chat'] = $chat;
                                            $chatArray[$i]['group']['created_on'] = $message->created_on;
                                            $chatArray[$i]['group']['title'] = $message->title;
                                            $chatArray[$i]['group']['id'] = $message->id;
                                            $chatArray[$i]['creator'] = $u;
                                            $chatArray[$i]['creator']['img'] = base64_decode($u[0]->picture);
                                            





                                    }

                                    $flag =  $message->id;

                                    


                                }

                                $i++;

                            }



                    }



                    
                    
                    

            }
            
            //print_r($chatArray);

            return json_encode($chatArray);

    }


    public function getTheCurrentUserLIst(){

        $userArray = array();

        $input = Input::all();
        $user = Auth::user();

        $conversation = DB::table('message_group')->where('id', $input['id'])->get();
        $ulist = DB::table('message_group_chats')->where('message_group_id', $conversation[0]->id)->orderBy('id', 'desc')->first();

        $userArray['group'] = $conversation;
        $userArray['userlist'] = $ulist->attendees;

        return json_encode($userArray);

    }




    public function groupMessageLeaveChat(){

        $userArray = array();

        $input = Input::all();
        $user = Auth::user();

        $conversation = DB::table('message_group')->where('id', $input['id'])->get();
        $ulist = DB::table('message_group_chats')->where('message_group_id', $conversation[0]->id)->orderBy('id', 'desc')->first();

        $i = 0;

        foreach(json_decode($ulist->attendees) as $attendee){
            
            if ($attendee->uid != $user['id']){

                $userArray[$i] = $attendee;
                $i++;

            }
            
            

            

        }

        // initialize the chat array data
        $chatArray = array(
                    'message_group_id' => $input['id'], 
                    'user_id' => $user['id'], 
                    'content' => $user['firstname']." has left this conversation",
                    'attendees' => json_encode($userArray),
                    'type' => "notification"


        );

        // insert the record into the table

        DB::table('message_group_chats')->insertGetId(
                $chatArray
        );

        // return to the browser


        return $userArray;

    }

    /**
     * Insert a new record to the device table
     * @return status TRUE | FALSE
     */

    public function writePNtoDB(){

        $input = Input::all();
        $user = Auth::user();


        // initialize the device array data
        $deviceArray = array(
                    'user_id' => Session::get('user.lastinsertid'), 
                    'device' => $input['device_model'], 
                    'player_id' => $input['id'], 
                    'raw_data' => json_encode($input), 
                    'tags' => json_encode($input['tags'])
        );

        // insert the record into the table
        

        DB::table('devices')->insertGetId(
                $deviceArray
        );

        DB::table('users')
            ->where('id', Session::get('user.lastinsertid'))
            ->update(array('push_notification' => 1));
        

        //print_r($deviceArray);


        return "true";

    }


    



    public function writePNtoDBPublic(){

        // get the input and user session array

        $input = Input::all();
        $user = Auth::user();


        // initialize the device array data
        $deviceArray = array(
                    'user_id' => $input['user_id'], 
                    'device' => $input['device_model'], 
                    'player_id' => $input['player_id'], 
                    'raw_data' => json_encode($input['raw_data']), 
                    'tags' => json_encode($input['tags'])
        );

        // insert the record into the table
        

        DB::table('devices')->insertGetId(
                $deviceArray
        );

        DB::table('users')
            ->where('id', $input['user_id'])
            ->update(array('push_notification' => 1));
        

        //print_r($deviceArray);


        return "true";


    }





    public function writeMobilePNtoDB(){

        $input = Input::all();
        $user = Auth::user();


        $device = DB::table('devices')->where('player_id', trim($input['playerID']))->where('user_id', trim($input['userID']))->first();

        if (count($device) == 1){

             DB::table('devices')
                    ->where('user_id', $input['userID'])->where('player_id', $input['playerID'])
                    ->update(array('active' => 1));

        }

        // check the condition if the playerid is already existence . if not insert a new record, otherwise dont insert

        $ret = "false";

        if (count($device) != 1){

        


                $oneSignal = file_get_contents('https://onesignal.com/api/v1/players/'.$input['playerID']);

                $oneSignal = json_decode($oneSignal);

                //print_r(count($device));


                // initialize the device array data
                $deviceArray = array(
                            'user_id' => $input['userID'], 
                            'device' => $oneSignal->device_model, 
                            'player_id' => $oneSignal->id, 
                            'raw_data' => json_encode($oneSignal), 
                            'tags' => json_encode($oneSignal->tags)
                );

                // insert the record into the table
                

                DB::table('devices')->insertGetId(
                        $deviceArray
                );

                

                DB::table('users')
                    ->where('id', $input['userID'])
                    ->update(array('push_notification' => 1));


                // print out the debug information

                //print_r($deviceArray);

                $ret = "true";


        }

        


        return $ret;


    }

    /**
     * update the status to the device table set it to either 1 or 0 ; 1 for active and 0 for inactive
     * @return status
     */
    //TODO: Check for all the requirements against the output of this function

    public function updateDeviceStatus(){

        $input = Input::all();
        $user = Auth::user();

        // the input should contain playerID, userID and status


        if (isset($input['userID'])){

            $user['id'] = $input['userID'];


        }

        if ($input['status'] == 1 && $input['playerID'] != ""){

            $oneSignal = file_get_contents('https://onesignal.com/api/v1/players/'.$input['playerID']);

            $oneSignal = json_decode($oneSignal);

                //print_r(count($device));


                // initialize the device array data
                $deviceArray = array(
                            'user_id' => $user['id'], 
                            'device' => $oneSignal->device_model, 
                            'player_id' => $oneSignal->id, 
                            'raw_data' => json_encode($oneSignal), 
                            'tags' => json_encode($oneSignal->tags)
                );

                // insert the record into the table

                $searchForDevice = DB::table('devices')->where('user_id', $user['id'])->where('player_id', $oneSignal->id)->get();
                
                if(count($searchForDevice) < 1){

                    DB::table('devices')->insertGetId(
                            $deviceArray
                    );

                }

                

        }

        // update the table 

        DB::table('devices')
                    ->where('user_id', $user['id'])->where('player_id', $input['playerID'])
                    ->update(array('active' => $input['status']));

        return "true";            

    }




    /**
     * this function is about to scan the whole uploads folder and resize the images inside to a certain quality
     * @return number of image
     */
    //TODO: Check for all the requirements against the output of this function

    public function resizeImagesInsideUploadFolder($dir){

        

        // scan the folder and sub folder using RecursiveDirectoryIterator

        $di = new RecursiveDirectoryIterator($dir);
        foreach (new RecursiveIteratorIterator($di) as $filename => $file) {
            echo $filename . ' - ' . $file->getSize() . ' bytes <br/>';

            //$this->compress_image($filename, $filename, 80);

            if (@getimagesize($filename)) { 
                echo "<br/>file exist";
                $this->compress_image($filename, $filename, 85);
            }

            echo "STATUS : OK";


        }

    }



    public function callResizeImagesInsideUploadFolder(){

            
            // call the resize image function using GD library

            $this->resizeImagesInsideUploadFolder(public_path().'/uploads/pix');



    }


    /*
    * get post data by postID
    * @return : return a json string that contains post information
    * @param : postID ia POST method
    */

    public function fetchPostByID(){

        $user = Auth::user();
        $input = Input::all();

        // search for post by ID

        //$searchForPost = DB::table('posts')->where('id', $input['postid'])->get();
        $post = Post::where('id', $input['postid'])->take(1)->get();

        //$jsonOut = json_decode($searchForPost[0]->status);

        $post->status = $post[0]->filterStatus();
        $post->image = ($post[0]->statustype = 'image') ? $post[0]->displayMediaApi() : '';
        //////////

        if ($post->image != ''){

        

                $doc = new DOMDocument();
                $doc->loadHTML($post->image);
                $xpath = new DOMXPath($doc);
                $src = $xpath->evaluate("string(//img/@src)");

                $post->image = $src;

        }

        /////////
        //$post->mission_completed = true;
        //print_r();

        // set display mission

        if ($post[0]->display_mission == 1){
            $post->display_mission = true;
        }

        // get the groupid 

        $groupid = GroupUser::where('user_id', '=', $user['id'])->pluck('group_id');

        

        // get the taskid

        $taskid = $post[0]->task_id;

        

        // get the outcome id



        $group = Group::find($groupid);
        $outcomeid = Outcome::find($group->outcome)->id;

        // execute query

        $userTaskArray = DB::table('user_tasks')->where('outcome_id', $outcomeid)->where('user_id', $user['id'])->where('group_id', $groupid)->where('task_id', $taskid)->where('complete', 1)->get();

        //print_r(count($userTaskArray));

        if (count($userTaskArray) > 0){
            $post->mission_completed = true;
            $post->general = false;
        }else{
            $post->mission_completed = false;
            $post->general = true;
        }

        return json_encode($post);

    }



    /*
    * save edited content to the database
    * @return : return true | false
    * @param : postID via POST method
    */

    public function submitEditedContent(){

        $input = Input::all();

        $user = Auth::user();

        $input['form'] = json_decode($input['post']);

        //print_r($input['file']);

        $fileObj = $input['file'];

        $status = array();

        $post = Post::where('id', $input['form']->id)->take(1)->get();

        // check if the private check box has been checked

        if (isset($input['private'])){

            if ($input['private'] == "true"){

             DB::table('posts')
                    ->where('id', $post[0]->id)
                    ->update(array('private' => 1));

            }
             
        }


        // check if the general check box has been checked

        if (isset($input['general'])){

            if ($input['general'] == "true"){

             DB::table('user_tasks')
                    ->where('user_id', $post[0]->user_id)
                    ->where('group_id', $post[0]->group_id)
                    ->where('task_id', $post[0]->task_id)
                    ->delete();

            }
             
        }


        // check if file object is exist

        // $fileObj = yes

        //print_r($fileObj);

        $imageStr = @unserialize($post[0]->status);

        if ($fileObj != 'undefined'){

            // file object exist

            // if there is already a file on a database , then replace it with the new one

            if ($post[0]->statustype == 'image'){

                    if ( unlink(public_path().base64_decode($imageStr['image'])) ){
                            //echo "yes";
                    }else{
                            //echo "fail";
                    }

                    // set file path for uploading

                    $filepathOrg = '/uploads/pix/posts/'.base64_encode($post[0]->id.'/'.time()).'.'."jpg";

                    $filepath = public_path().$filepathOrg;

                    $status['text'] = $input['form']->status;
                    $status['image'] = base64_encode($filepathOrg);
                    $input['form']->status = serialize($status);

                    $statusT = "image";

                    $fileObj->move(public_path().'/uploads/pix/posts/', base64_encode($post[0]->id.'/'.time()).'.'."jpg");



            }else{

                    // set file path for uploading

                    $filepathOrg = '/uploads/pix/posts/'.base64_encode($post[0]->id.'/'.time()).'.'."jpg";

                    $filepath = public_path().$filepathOrg;

                    $status['text'] = $input['form']->status;
                    $status['image'] = base64_encode($filepathOrg);
                    $input['form']->status = serialize($status);

                    $statusT = "image";

                    $fileObj->move(public_path().'/uploads/pix/posts/', base64_encode($post[0]->id.'/'.time()).'.'."jpg");

            }


            // otherwise just updating status

        }else{

            // file object does not exist, then just update the status


            // if there was a image status then just delete it and update the status

            

            $statusT = "text";
            

            if (isset($input['form']->status_file)){

                $statusT = "text";
                

                if ( @unlink(public_path().base64_decode($imageStr['image'])) ){
                        //echo "yes";
                }else{
                        //echo "fail";
                }


            }else{
                
                // check if $imageSrc exist

                if ($post[0]->statustype == 'image'){

                        $status['text'] = $input['form']->status;
                        $status['image'] = $imageStr['image'];
                        $input['form']->status = serialize($status);

                        $statusT = "image";

                }


            }
             
            


        }

        
        

        // update the existing post

        DB::table('posts')
                    ->where('id', $input['form']->id)
                    ->update(array('status' => $input['form']->status, 'statustype' => $statusT));

        
        return "OK";
        

    }



    /*
    * fetch mission content by postID
    * @return : return JSON string contains mission content
    * @param : postID via POST method
    */


    public function fetchMissionByPostID(){

        // get all post / get input

        $input = Input::all();

        // get the task id from post id

        $post = Post::where('id', $input['postid'])->take(1)->get();

        // get the task conttent 

        $task = Task::where('id', $post[0]['task_id'])->take(1)->get();

        // return the task content to the client

        return json_encode($task[0]);

    }

	public function mobile(){
		$input = Input::all();

		if(isset($input['playerid']))
		{
			Session::put('playerid', $input['playerid']);
		}

		return View::make('index');
	}
	
}
