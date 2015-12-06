<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class Survey extends Eloquent {
    protected $table='surveys';

    public function getPreMessage() {
        return DB::table('survey_messages')
                ->where('survey_id',$this->id)
                ->pluck('premessage');
    }
    
    public function getPostMessage() {
        return DB::table('survey_messages')
                ->where('survey_id',$this->id)
                ->pluck('postmessage');
    }
    
    
}
