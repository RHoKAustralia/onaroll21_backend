<?php

class Group extends Eloquent {

	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'groups';
        
        /**
         * 
         * @return type
         */
        public function users() {
            return $this->belongsToMany('User','group_users')->withTimestamps();
        }

        /**
         * 
         * @return type
         */
        public function outcomes() {
            return $this->hasOne('Outcome','groups');
        }
        
        /**
         * 
         * @return type
         */
        public function tasks() {
            return $this->hasMany('Task');
        }
        
        /**
         * 
         * @return type
         */
        public function getUserCount() {
            return count(array_fetch($this->users->toArray(), 'id'));
        }
        
        /**
         * This function returns the list of users in that group
         * @return type
         */
        public function getUserList() {
            return $this->users;
        }
        
        /**
         * This function will return the src for group thumbnail. If the thumbnail
         * is empty, the function will return the reference to holder js file ;)
         * 
         * @return string
         */
        public function getThumbnailSrc($size) {
            if(!empty($this->thumbnail)) {
                return 'src="'.base64_decode($this->thumbnail).'"';
            }
            return 'data-src="/holder.js/'.$size.'"';
        }
        
        public function surveyResponses() {
            return $this->hasMany('SurveyResponse','survey_responses');
        }
        
        public function getImages() {
            $posts = Post::orderBy('id', 'DESC')->where('group_id', $this->id)->get();
            $returnStr='';
            foreach ($posts as $post) {
                if($post->statustype=='image')
                $returnStr.=$post->displayMontage();
            }
            return $returnStr;
        }
        
        public function APIGetImages() {
            $posts = Post::orderBy('id', 'DESC')->where('group_id', $this->id)->get();
            $returnStr=array();
            foreach ($posts as $post) {
                if($post->statustype=='image')
                $returnStr[]=$post->displayAPIMontage();
            }
            return $returnStr;
        }
        
        /**
         * This function will return the src for group thumbnail. If the thumbnail
         * is empty, the function will return the reference to holder js file ;)
         * 
         * @return string
         */
        public function APIGetThumbnailSrc($size='') {
            if(!empty($this->thumbnail)) {
                return URL::to('/').base64_decode($this->thumbnail);
            }
        }

}