<?php

class Task extends Eloquent {

    /**
     * The database table used by the model.
     *
     * @var string
     */
    protected $table = 'tasks';
    
    /**
     * This function links the tasks to outcomes and vice versa
     * 
     * @return type
     */
    public function outcomes() {
        return $this->belongsToMany('Outcome', 'outcome_tasks')
                ->withTimestamps();
    }
    
    public function users() {
        return $this->belongsToMany('User','user_tasks')
                ->withTimestamps();
    }
}
