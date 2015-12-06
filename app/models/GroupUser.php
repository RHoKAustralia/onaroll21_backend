<?php

class GroupUser extends Eloquent {

    /**
     * The database table used by the model.
     *
     * @var string
     */
    protected $table = 'group_users';
    
    
    public function users() {
         return $this->hasOne('User','id');
    }
}
