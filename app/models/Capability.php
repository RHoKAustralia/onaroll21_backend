<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class Capability extends Eloquent {

    protected $table='capabilities';
    
    
    /**
     * This will link the users to permissions
     * 
     * @return type
     */
    public function users() {
        return $this->hasMany('User','role_capabilities')->withTimestamps();
    }
}