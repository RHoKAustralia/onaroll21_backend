<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class Settings extends Eloquent {

    protected $table='site_settings';
    
    
    /**
     * This will link the users to permissions
     * 
     * @return type
     */
    public static function getValue($name) {
        $value = self::where('name',$name)
                ->pluck('value');
        return $value;
    }
}