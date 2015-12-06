<?php

/*
 * Let's just first assume that a user will onely have one group
 * with one and only one outcome
 */
/**
 * These are the variables that have been supplied in the request
 */
$groupid = Request::get('groupid') ?: 1;
$userid = Request::get('userid') ?: 1;
$group = Group::find($groupid);
$outcome = Outcome::find($group->outcome);
$availArray = array_fetch($outcome->tasks->toArray(),'id');
$currentDay = round((time()-$group->timestart)/86400,0);

$doneArray=array();
$doneArray = DB::table('user_tasks')
        ->where('group_id',$groupid)
        ->where('user_id',$userid)
        ->where('complete',1)
        ->lists('task_id');
$doneArray[] = $outcome->getFinalTask();


$array = array_diff($availArray, $doneArray);



if(empty($array)) {
    if($currentDay>=21) {
        $array[20] = $outcome->getFinalTask();
    } else {
        $array=$availArray;
    }
} elseif($currentDay>=21) {
    $array=array();
    $array[20] = $outcome->getFinalTask();
}

echo '<pre>';
print_r($array);
echo '</pre>';

$rand = array_rand($array);
$task = Task::find($array[$rand]);//$user->getNextTask();
$returnObject = new stdClass();

$pendingTask = DB::table('user_tasks')
                    ->where('user_id', $userid)
                    ->where('group_id', $group->id)
                    ->where('complete', 0)
                    ->get();


echo 'Random: '.$rand;

$returnObject->taskno = $rand+1;
$returnObject->title = '<p id="todaysactivity"><b>'.t('dice.todaysactivity').'</b>'.makeClickableLinks($task->description).'</p>';
$returnObject->didyouknow = makeClickableLinks($task->didyouknow);
$returnObject->reference = makeClickableLinks($task->reference);

echo '<pre>';
print_r($returnObject);
echo '</pre>';
die;