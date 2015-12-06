<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class Role extends Eloquent {

    /**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'roles';
        
    /**
     * Get users with a certain role
     */
    public function users() {
        return $this->belongsToMany('User', 'role_assignments')
            ->withTimestamps();
    }
    
    public function addUser($userid) {
        $this->users()->attach($userid);
    }
    
    public function removeUser($userid) {
        $this->users()->detach($userid);
    }
    
    public function hasUser($userid) {
        return in_array($userid, array_fetch($this->users->toArray(),'id'));
    }
    
    public function getUserCount() {
        return count(array_fetch($this->users->toArray(),'id'));
    }
    
    /**
     * This function links users to permissions
     */
    public function capabilities() {
        return $this->belongsToMany('Capability','role_capabilities')
            ->withTimestamps();
    }
    
    public function hasCapability($capabilityId) {
        return in_array($capabilityId,
                array_fetch($this->capabilities->toArray(),'id'));
    }

}
