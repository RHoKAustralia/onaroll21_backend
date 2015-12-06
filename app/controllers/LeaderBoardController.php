<?php

class LeaderBoardController extends BaseController {


	/*
	// @param: none
	// this function will return the team's data from the db
	// @return: a collection in JSON format that contains teams information
	*/


	public function getLeaderBoardData(){
		$input = Input::all();
		$userTaskObj = new UserTask;

		// DEFINE JSON STRING


		// create new LeaderBoard Object 

		$leaderBoardObj = new stdClass();
        
//		$input['keycodes'] = '{"teams": [
//		  {"keycode": "dev001"},
//		  {"keycode": "mim001"}
//		]}';

		// decode json string 

		$teamArray = $input['keycodes'];

		$teamArray = $teamArray['teams'];

		$returnArray = array();

		$teamCounter = 0;

		foreach ($teamArray as $key => $value) {
			# code...

			$group = DB::table('groups')
        		->where('keycode', $value['keycode'])
        		->get();

        	$totalPlayers = DB::table('users')
		        		->where('keycode', $value['keycode'])
		        		->count();

			// check the group existence
			if (count($group) > 0){

				// run the logic code to get the number of days passed

				$groupDetails = $group[0];

				

				$timeStartDate = new DateTime(date("Y-m-d", $groupDetails->timestart));

				$dayPassed = daysDiff($timeStartDate, new DateTime('now'))+1;

				$returnArray[$teamCounter]['teamid']	=  $groupDetails->id;
				$returnArray[$teamCounter]['teamname']	=  $groupDetails->name;
				$returnArray[$teamCounter]['teamPIC']	=  SITE_URL.base64_decode($groupDetails->thumbnail);
				$returnArray[$teamCounter]['daypassed']	=  $dayPassed;
				$returnArray[$teamCounter]['totalPlayers']	=  $totalPlayers;

				/*
				// DEFINE VARIABLE
				//
				*/

				$totalNumTeamMissions 		= 0;
				$totalNumCompletedMissions 	= 0;
				$totalNumLikes 				= 0;
				$totalNumComments 			= 0;
				$totalNumPosts 				= 0;

				$day = array();

				// loop thru days
				for ($i=1; $i <= $dayPassed; $i++) { 
					# code...

					

					$date = $timeStartDate->format('Y-m-d');

					$returnArray[$teamCounter]['day'][$i]['date'] = $date ;

					// get the number of completed mission on that day

					$completedTasks = DB::table('user_tasks')
		        		->where('group_id', $groupDetails->id)
		        		->where('complete', 1)
		        		->where('created_at', 'LIKE' , $date.'%')
		        		->get();

		        	$totalNumCompletedMissions = $totalNumCompletedMissions + count($completedTasks) ;


		        	$day[$i]['completedTasks'] = count($completedTasks) ;


		        	// get the total posts based on groupID

		        	$totalPosts = DB::table('posts')
		        		->where('group_id', $groupDetails->id)
		        		->where('created_at', 'LIKE' , $date.'%')
		        		->count();


		        	$totalNumPosts = $totalPosts + $totalNumPosts ;

		        	
		        	$day[$i]['totalPosts'] = $totalPosts ;	

		        	// get the total likes , comments each day JOIN 2 tables into one SQL statement

		        	$totalLikesArray = DB::select('select l.id 
					FROM likes as l, posts as p 
					WHERE p.group_id = ? AND l.post_id = p.id AND l.created_at LIKE ?
					', array($groupDetails->id, $date.'%'));   


		        	$totalLikes = count($totalLikesArray);

		        	$totalNumLikes = $totalLikes + $totalNumLikes ;

		        	$day[$i]['totalLikes'] = $totalLikes;	


		        	// get total comment

		        	$totalCommentsArray = DB::select('select l.id 
					FROM comments as l, posts as p 
					WHERE p.group_id = ? AND l.post_id = p.id AND l.created_at LIKE ?
					', array($groupDetails->id, $date.'%'));   


		        	$totalComments = count($totalCommentsArray);

		        	$totalNumComments = $totalComments + $totalNumComments ;

		        	$day[$i]['totalComments'] = $totalComments;	

		        	$timeStartDate->modify('+1 day');


				}


				$returnArray[$teamCounter]['totalNumTeamMissions']		=  $userTaskObj->totalTasks($groupDetails->id);
				$returnArray[$teamCounter]['totalNumCompletedMissions']	=  $totalNumCompletedMissions;
				$returnArray[$teamCounter]['totalNumLikes']				=  $totalNumLikes;
				$returnArray[$teamCounter]['totalNumComments']			=  $totalNumComments;
				$returnArray[$teamCounter]['totalNumPosts']				=  $totalNumPosts;
				$returnArray[$teamCounter]['totalPoints']               =  $totalNumComments + $totalNumLikes + $totalNumPosts + ($totalNumCompletedMissions*6);
				$returnArray[$teamCounter]['score']                     =  round(($returnArray[$teamCounter]['totalPoints']/$returnArray[$teamCounter]['totalPlayers'])/$returnArray[$teamCounter]['daypassed'], 1);

				$dayCollection = array($day);

				$returnArray[$teamCounter]['day'] = $dayCollection[0];

			}

			$teamCounter++;
		}

		function compare($a, $b) {
			$result = null;

			if ($a['score'] == $b['score']) {
				if ($a['totalPoints'] = $b['totalPoints']) {
					$result = 0;
				} else {
					$result = ($a['totalPoints'] > $b['totalPoints']) ? -1 : 1;
				}
			} else {
				$result = ($a['score'] > $b['score']) ? -1 : 1;
			}

			return $result;
		}

		usort($returnArray, "compare");

		$leaderBoardObj->teams = $returnArray;

		// return json data
		return $_GET['callback'] . '('.json_encode($leaderBoardObj).')';
//		return json_encode($leaderBoardObj);


	}



	/*
	// @param: none
	// this function will return the team's post images from the db
	// @return: a collection in JSON format that contains teams images
	*/


	public function getTeamImages(){

		$input = Input::all();
		$imageObj = new UserTask;
        
//		$input['keycodes'] = '{"teams": [
//		  {"keycode": "dev001"},
//		  {"keycode": "mim001"}
//		]}';

		// decode json string 

		$teamArray = $input['keycodes'];

		$teamArray = $teamArray['teams'];

		$returnArray = array();

		$postCounter = 0;

		// loop thru team keycodes

		foreach ($teamArray as $key => $value) {

			

			$groupid = DB::table('groups')
        		->where('keycode', $value['keycode'])
        		->pluck('id');


        	$posts = Post::orderBy('id', 'DESC')->where('group_id', $groupid)->get();


        	// loop thru posts

        	foreach ($posts as $post) {
        		# code...
        		$post->image = ($post->statustype = 'image') ? $post->displayMediaApi() : '';

        		if ($post->image){

        			$dom = new DOMDocument();
					$dom->loadHTML($post->image);
					$returnArray['images'][$postCounter] = $dom->getElementsByTagName('img')->item(0)->getAttribute('src');

					$postCounter++;

        		}

        		
        	}     	

		}

		shuffle($returnArray['images']);

		// return data
		return $_GET['callback'] . '('.json_encode($returnArray).')';


	}

	/*
	// @param: none
	// this function will return an excel spreadsheet for Dashboard report
	// @return:
	*/
	public function getLeaderBoardStatisticReport() {
		$totalUsers = self::getTotalUsers();
		$registeredToday = self::whoRegisteredToday();
		$registeredYesterday = self::howManyRegisteredSinceYesterday();
		$rolledToday = count(self::whoRolledToday(0));
		$completedToday = count(self::whoRolledToday(1));

		$data = array(
			array("Total User"=>$totalUsers,
				"How many registered since 4:30PM yesterday"=>$registeredYesterday,
				"How many rolled today"=>$rolledToday,
				"How many completed mission today"=>$completedToday)
		);

		// filename for download
		$filename = "GOC_data_statistic" . date('Ymd') . ".xls";

		header("Content-Disposition: attachment; filename=\"$filename\"");
		header("Content-Type: application/vnd.ms-excel");

		$flag = false;
		foreach($data as $row) {
			if(!$flag) {
				// display field/column names as first row
				echo implode("\t", array_keys($row)) . "\r\n";
				$flag = true;
			}

			echo implode("\t", array_values($row)) . "\r\n";
		}
	}

	/*
	// @param: none
	// this function will return an excel spreadsheet for Dashboard report
	// @return:
	*/
	public function getLeaderBoardUserReport() {
		$registeredToday = self::whoRegisteredToday();
		$rolledOnce = self::whoHaveRolledOnce();
		$rolledToday = self::whoRolledToday(0);
		$completedToday = self::whoRolledToday(1);

//		print_r($rolledOnce);
//		exit();

		$data = array();
		$emptyLine = array("Criteria"=>"","First Name"=>"", "Last Name"=>"", "Team"=>"");

		// filename for download
		$filename = "GOC_data_user" . date('Ymd') . ".xls";

		header("Content-Disposition: attachment; filename=\"$filename\"");
		header("Content-Type: application/vnd.ms-excel");

		array_push($data,array("Criteria"=>"Who registered today","First Name"=>"", "Last Name"=>"", "Team"=>""));

		if (!empty($registeredToday)) {
			foreach ($registeredToday as $user) {
				$temp = array("Criteria"=>"","First Name"=>$user->first_name, "Last Name"=>$user->last_name, "Team"=>$user->group_name);

				array_push($data, $temp);
			}
		}

		array_push($data,array("Criteria"=>"Who have rolled once","First Name"=>"", "Last Name"=>"", "Team"=>""));

		if (!empty($rolledOnce)) {
			foreach ($rolledOnce as $user) {
				$temp = array("Criteria"=>"","First Name"=>$user->first_name, "Last Name"=>$user->last_name, "Team"=>$user->group_name);

				array_push($data, $temp);
			}
		}

		array_push($data,array("Criteria"=>"Who rolled today","First Name"=>"", "Last Name"=>"", "Team"=>""));

		if (!empty($rolledToday)) {
			foreach ($rolledToday as $user) {
				$temp = array("Criteria"=>"","First Name"=>$user->first_name, "Last Name"=>$user->last_name, "Team"=>$user->group_name);

				array_push($data, $temp);
			}
		}

		array_push($data,array("Criteria"=>"Who completed mission today","First Name"=>"", "Last Name"=>"", "Team"=>""));

		if (!empty($completedToday)) {
			foreach ($completedToday as $user) {
				$temp = array("Criteria"=>"","First Name"=>$user->first_name, "Last Name"=>$user->last_name, "Team"=>$user->group_name);

				array_push($data, $temp);
			}
		}

		$flag = false;
		foreach($data as $row) {
			if(!$flag) {
				// display field/column names as first row
				echo implode("\t", array_keys($row)) . "\r\n";
				$flag = true;
			}

			if ($row['Criteria'] != '') {
				echo implode("\t", array_values($emptyLine)) . "\r\n";
			}

			echo implode("\t", array_values($row)) . "\r\n";
		}
	}

	/*
	// @param: none
	// this function will return total number of users in the same company
	// @return: integer
	*/
	public function getTotalUsers() {
		$result = DB::select(DB::raw("select count(*) as 'total'
			from groups g
			join group_users u
			on g.id = u.group_id
			where g.description like 'GOC %'"));

		return $result[0]->total;
	}

	/*
	// @param: none
	// this function will return list of users who have only rolled once
	// @return: json
	*/
	public function whoHaveRolledOnce() {
		//get users who have completed at least 1 task
		$users = DB::select(DB::raw("select u.id, u.firstname as 'first_name', u.lastname as 'last_name', g.name as 'group_name'
			from users u
			join group_users gu on u.id = gu.user_id
			join groups g on g.id = gu.group_id
			join user_tasks ut on ut.user_id = u.id and ut.group_id = g.id and ut.complete = 1
			where g.description like 'GOC %'"));

		if ($users) {
			$result = array();

			//filter people who only completed 1 task
			$i =0;

			foreach ($users as $user) {
				$userID = $user->id;

				$rollCount = DB::select(DB::raw("select count(*) as 'num'
					from user_tasks
					where user_id = $userID and complete = 1"));

				if ($rollCount[0]->num == 1) {
					$result[$i] =  $user;

					$i++;
				}
			}

			return $result;

		} else {
			return false;
		}
	}

	/*
	// @param: none
	// this function will return list of users who registered today
	// @return: json
	*/
	public function whoRegisteredToday() {
		$result = DB::select(DB::raw("select u.firstname as 'first_name', u.lastname as 'last_name', g.name as 'group_name', concat(extract(hour from u.created_at),':',extract(minute from u.created_at),':',extract(second from u.created_at)) as 'signup_time'
			from users u
			join group_users gu on u.id = gu.user_id
			join groups g on g.id = gu.group_id
			where DATE(u.created_at)=CURDATE() and g.description like 'GOC %'"));

		if ($result) {
			return $result;
		} else {
			return false;
		}
	}

	/*
	// @param: none
	// this function will return number of users who registered since 4:30 yesterday
	// @return: integer
	*/
	public function howManyRegisteredSinceYesterday() {
		$yesterday = date('Y-m-d',strtotime('-1 days'));
		$yesterdayTime = strtotime("$yesterday 16:30:00");

		$result = DB::select(DB::raw("select count(*) as 'num'
			from users u
			join group_users gu on u.id = gu.user_id
			join groups g on g.id = gu.group_id
			where UNIX_TIMESTAMP(u.created_at) >= $yesterdayTime and g.description like 'GOC %'"));

		if ($result) {
			return $result[0]->num;
		} else {
			return false;
		}
	}

	/*
	// @param: integer
	// this function will return list of users who have rolled or completed mission today
	// @return: json
	*/
	public function whoRolledToday($taskStatus) {
		$timeClause = null;

		if ($taskStatus == 0) {
			$timeClause = 'ut.created_at';
		} else {
			$timeClause = 'ut.updated_at';
		}

		$result = DB::select(DB::raw("select u.firstname as 'first_name', u.lastname as 'last_name', g.name as 'group_name'
			from users u
			join group_users gu on u.id = gu.user_id
			join groups g on g.id = gu.group_id
			join user_tasks ut on ut.user_id = u.id and ut.group_id = g.id
			where DATE($timeClause)=CURDATE() and complete = $taskStatus and g.description like 'GOC %'"));

		if ($result) {
			return $result;
		} else {
			return false;
		}
	}

}

?>