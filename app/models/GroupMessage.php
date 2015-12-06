<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class GroupMessage extends Eloquent {
    
    protected $table='message_group';
    
   
    public function messagegroupchats()
    {
        return $this->hasMany('GroupMessageChat', 'message_group_id');
    }
   
    
}
