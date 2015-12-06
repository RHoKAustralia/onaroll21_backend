<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class GroupMessageChat extends Eloquent {
    
    protected $table='message_group_chats';
    
   
    public function groupmessage() {   

        return $this->belongsTo('GroupMessage');
    }
   
    
}
