<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class Comment extends Eloquent {

    protected $table='comments';
    
    
    /**
     * This will link the users to permissions
     * 
     * @return type
     */
    public function posts() {
        return $this->belongsTo('Post','post_id');
    }
    
    public function user()
    {
        return $this->belongsTo('User');
    }
}