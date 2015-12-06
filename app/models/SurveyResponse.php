<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class SurveyResponse extends Eloquent {

    /**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'survey_response';
        
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
