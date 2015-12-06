<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class Wellbeing extends Eloquent {

    /**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'wellbeing_tracks';
        
        const FANTASTIC=5;
        const PRETTY_GOOD=4;
        const NEUTRAL=3;
        const NOT_GREAT=2;
        const TERRIBLE=1;

        public function user() {
            return $this->belongsTo('User','user_id');
        }
        
        public function group() {
            return $this->belongsTo('Group','group_id');
        }
        
        public function survey() {
            return $this->belongsTo('Survey','survey_id');
        }
}
