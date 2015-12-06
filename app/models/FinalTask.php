<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class FinalTask extends Eloquent {

    protected $table='final_task';
    
    
    /**
     * This will link the users to permissions
     * 
     * @return type
     */
    public function outcome() {
        return $this->belongsTo('Outcome');
    }
}