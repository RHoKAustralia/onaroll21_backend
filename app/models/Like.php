<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class Like extends Eloquent {

    protected $table='likes';
    
    /**
     * This will link the likes to posts
     * 
     * @return type
     */
    public function posts() {
        return $this->belongsTo('Post','likes')
            ->withTimestamps();
    }
    
    public function users() {
        return $this->belongsTo('Post','likes')
            ->withTimestamps();
    }
}