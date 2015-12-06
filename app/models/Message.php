<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class Message extends Eloquent {
    
    protected $table='messages';
    
    public function from()
    {
        return $this->belongsTo('User', 'from','id');
    }

    public function to()
    {
        return $this->belongsToMany('User','to','id');
    }
    
}
