<?php

	class UserTask extends Eloquent {

    /**
     * The database table used by the model.
     *
     * @var string
     */
    protected $table = 'user_tasks';
    
    /**
     * This function get the collection of total tasks of user based on groupID
     * 
     * @return type
     */
    public function totalTasks($groupid) {

    		// check to see if a user in the group has been the first to completed all the tasks in the last day
			$outcomeid =   DB::table('groups')
				->where('id', $groupid)
				->pluck('outcome');



			// count outcome task
			$totaltasks = DB::table('outcome_tasks')
				->where('outcome_id', $outcomeid)
				->count(); 

        return $totaltasks;
    }
    
    
}


?>