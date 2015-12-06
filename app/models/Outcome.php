<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class Outcome extends Eloquent {

    /**
     * The database table used by the model.
     *
     * @var string
     */
    protected $table = 'outcomes';
        
    /**
     * This function connects the outcome to tasks and vice versa
     * 
     * @return type
     */
    public function tasks() {
        return $this->belongsToMany('Task', 'outcome_tasks')
            ->withTimestamps();
    }
    
    /**
     * Connect the outcome with final task
     * @return type
     */
    public function finalTask() {
        return $this->hasOne('FinalTask','outcome_id');
    }
    
    /**
     * 
     * @param type $taskid
     */
    public function addFinalTask($taskid) {
        $this->finalTask()->insert(array('outcome_id'=>$this->id,'task_id'=>$taskid));
    }
    
    public function getFinalTask() {
        return DB::table('final_task')
                ->where('outcome_id',$this->id)
                ->pluck('task_id');
    }
    
    /**
     * This function adds the specified task to the outcome
     * 
     * @param type $taskid
     */
    public function addTask($taskid) {
        $this->tasks()->attach($taskid);
    }
    
    /**
     * This function removes the specified task from outcome
     * 
     * @param type $taskid
     */
    public function removeTask($taskid) {
        $this->tasks()->detach($taskid);
    }
    
    /**
     * 
     */
    public function hasTask($taskid) {
        return in_array($taskid, array_fetch($this->tasks->toArray(), 'id'));
    }
    
    public function getTaskCount() {
        return count($this->tasks->toArray());
    }
    
    /**
     * This function will return a random task
     * @return type
     */
    public function getRandomTask() {
        return array_rand(array_fetch($this->tasks->toArray(),'id'));
    }
    
    /**
     * This function would move the task up in the list of outcome tasks
     */
    public function moveTaskUp() {
        
    }
    
    /**
     * This function will move the task down in the list of outcome tasks
     */
    public function moveTaskDown() {
        
    }
}
