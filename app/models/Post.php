<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Post extends Eloquent {

    /**
     * The database table used by the model.
     *
     * @var string
     */
    protected $table = 'posts';

    /**
     * 
     * @return type
     */
    public function comments() {
        return $this->hasMany('Comment');
    }

    /**
     * 
     * @return type
     */
    public function likes() {
        return $this->hasMany('Like');
    }
    
    /**
     * 
     * @return type
     */
    public function getLikeCount() {
        return count(array_fetch($this->likes->toArray(), 'id'));
    }
	
	
	

    /**
     * 
     * @return type
     */
    public function getComments() {
        return $this->comments;
    }

    /**
     * This function will return the post comments that is compatible with singlepage API
     */
    public function getAPIComments() {
        $comments=$this->comments;
        foreach($comments as $comment) {
            $user=User::find($comment->user_id);
            $commentUser=new stdClass();
            $commentUser->picture=$user->APIGetPictureSrc();
            $commentUser->screenhandle=$user->screenhandle;
			$commentUser->firstname=$user->firstname;
			$commentUser->lastname=$user->lastname;
            $comment->user=$commentUser;
        }
        return $comments;
    }


    public function videoType($url) {
        if(preg_match('/http:\/\/(www\.)*vimeo\.com\/.*/',$url)){
            // do vimeo stuff
            return 'vimeo';
        }

        if(preg_match('/http:\/\/(www\.)*youtube\.com\/.*/',$url)){
            // do youtube stuff
            return '<iframe width="100%" src="http://www.youtube.com/embed/whwgmLlO6Vo?autoplay=1"></iframe>';
        } else {
            return '<iframe width="100%" src="http://www.youtube.com/embed/whwgmLlO6Vo?autoplay=1"></iframe>';
        }
    }

    /**
     * 
     * @return string
     */
    public function filterStatus() {
        $reg_exp = "/(http|https|ftp|ftps)\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?/";
        if($this->statustype=='image') {
            $status = unserialize($this->status);
            preg_match($reg_exp, $status['text'], $url);
            $statusText = $status['text'];
        } else {
            preg_match($reg_exp, $this->status, $url);
            $statusText = $this->status;
        }

        // remove url 

//        $statusText = preg_replace('/\b(https?):\/\/[-A-Z0-9+&@#\/%?=~_|$!:,.;]*[A-Z0-9+&@#\/%=~_|$]/i', '', $statusText);

        if(preg_match_all("/(http|https|ftp|ftps)\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?/",$this->status,$m)){
             // matches found in $m

            // relace eith html tags

            //$statusText .= "<br/>";
            //$statusText .= $this->videoType($m[0][0]);
            
            //echo $m[0][0];
        }





        $videotype = $this->videoType($this->status);


        
        return $statusText;
    }
    
    /**
     * 
     * @param type $url
     * @return boolean
     */
    public function video_info($url) {

        $googleAPIKey = "AIzaSyBZ6kkDz06SYj9sxM-8rtXtcd4mELdCMTc";

        if (strpos($url, "youtube.com")) {
            $url = parse_url($url);
            //$vid = parse_str($url['query'], $output);
            if(!isset($output['v']))
                return false;
            $video_id = $output['v'];
            $data['video_type'] = 'youtube';
            $data['video_id'] = $video_id;
            
        } // End Youtube
// Handle Vimeo
        else if (strpos($url, "vimeo.com")) {
            $video_id = explode('vimeo.com/', $url);
            $video_id = $video_id[1];
            $data['video_type'] = 'vimeo';
            $data['video_id'] = $video_id;
            $xml = simplexml_load_file("http://vimeo.com/api/v2/video/$video_id.xml");

            foreach ($xml->video as $video) {
                $data['id'] = $video->id;
                $data['title'] = $video->title;
                $data['info'] = $video->description;
                $data['url'] = $video->url;
                $data['upload_date'] = $video->upload_date;
                $data['mobile_url'] = $video->mobile_url;
                $data['thumb_small'] = $video->thumbnail_small;
                $data['thumb_medium'] = $video->thumbnail_medium;
                $data['thumb_large'] = $video->thumbnail_large;
                $data['user_name'] = $video->user_name;
                $data['urer_url'] = $video->urer_url;
                $data['user_thumb_small'] = $video->user_portrait_small;
                $data['user_thumb_medium'] = $video->user_portrait_medium;
                $data['user_thumb_large'] = $video->user_portrait_large;
                $data['user_thumb_huge'] = $video->user_portrait_huge;
                $data['likes'] = $video->stats_number_of_likes;
                $data['views'] = $video->stats_number_of_plays;
                $data['comments'] = $video->stats_number_of_comments;
                $data['duration'] = $video->duration;
                $data['width'] = $video->width;
                $data['height'] = $video->height;
                $data['tags'] = $video->tags;
            } // End foreach
        } // End Vimeo
        elseif(strpos($url,"soundcloud.com")) {
            $data['video_type'] = 'soundcloud';
            $data['video']='<iframe width="100%" height="166" scrolling="no" 
                frameborder="no" src="https://w.soundcloud.com/player/?url='.$url.'&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_artwork=true"></iframe>';
        }
// Set false if invalid URL
        else {
            $data = false;
        }

        return $data;
    }
    
    /**
     * This outputs the media
     * @return string
     */
    public function displayMedia() {
        $returnStr = '';
        if($imagesrc=unserialize($this->status)) {
            if(isset($imagesrc['image'])) {
                $fileSrc=base64_decode($imagesrc['image']);
                $fileType = @mime_content_type(public_path().$fileSrc);
                
                
                    if(preg_match('/image/i',$fileType)){
                        $filename=public_path().$fileSrc;
                        
                        $returnStr='<a data-toggle="lightbox" href="'.$fileSrc.'" class="thumbnail swipebox" class="swipebox" title="">
                                    <img src="'.$fileSrc.'" />
                                    </a>';
                    } elseif(preg_match('/audio/i',$fileType)) {
                        $returnStr='<audio controls width="100%">
                                        <source src="'.$fileSrc.'" />
                                    </audio>';
                    } elseif(preg_match('/video/i',$fileType)) {
                        $returnStr='<video width="100%" height="240" controls="controls" preload="none" >
                                       <source src="'.asset($fileSrc).'" type="video/mp4" />
                                <!-- Flash fallback for non-HTML5 browsers without JavaScript -->
                                <object width="320" height="240" type="application/x-shockwave-flash" data="flashmediaelement.swf">
                                    <param name="movie" value="flashmediaelement.swf" />
                                    <param name="flashvars" value="controls=true&file='.asset($fileSrc).'" />
                                </object>
                                    </video>';
                    }
            }
        }
        return $returnStr;
    }
    
    /**
     * This outputs the media (mobile)
     * @return string
     */
    public function displayMediaApi() {
        $returnStr = '';
        if($imagesrc=@unserialize($this->status)) {
            if(isset($imagesrc['image'])) {
                $fileSrc=base64_decode($imagesrc['image']);
                $fileType = @mime_content_type(public_path().$fileSrc);
                    if(preg_match('/image/i',$fileType)){
                        $filename=public_path().$fileSrc;
                        
                        $returnStr='<img src="'.URL::to($fileSrc).'" />';
                    } elseif(preg_match('/audio/i',$fileType)) {
                        $returnStr='<audio controls width="100%">
                                        <source src="'.URL::to($fileSrc).'" />
                                    </audio>';
                    } elseif(preg_match('/video/i',$fileType)) {
                        $returnStr='<video width="100%" height="240" controls="controls" preload="none" >
                                       <source src="'.URL::to($fileSrc).'" type="video/mp4" />
                                    </video>';
                    }
            }
        }
        return $returnStr;
    }
    
    /**
     * 
     * @return string
     */
    public function displayMontage() {
        $returnStr = '';
        if($imagesrc=unserialize($this->status)) {
            if(isset($imagesrc['image'])) {
                $fileSrc=base64_decode($imagesrc['image']);
                $fileType = mime_content_type(public_path().$fileSrc);
                
                
                    if(preg_match('/image/i',$fileType)){
                        $filename=public_path().$fileSrc;
                        
                        $returnStr='<a href="'.$fileSrc.'">
                                    <image src="'.$fileSrc.'" />
                                    </a>';
                    }
            }
        }
        
        return $returnStr;
    }
    
    /**
     * 
     * @return string
     */
    public function displayAPIMontage() {
        $returnStr = '';
        if($imagesrc=unserialize($this->status)) {
            if(isset($imagesrc['image'])) {
                $fileSrc=base64_decode($imagesrc['image']);
                $fileType = @mime_content_type(public_path().$fileSrc);    
                    if(preg_match('/image/i',$fileType)){
                        $filename=public_path().$fileSrc;
                        $returnStr=URL::to('/').$fileSrc;
                    }
            }
        }
        
        return $returnStr;
    }



}
