<?php

use Illuminate\Auth\UserInterface;
use Illuminate\Auth\Reminders\RemindableInterface;

class User extends Eloquent implements UserInterface, RemindableInterface {

    /**
     * The database table used by the model.
     *
     * @var string
     */
    protected $table = 'users';

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = array('password');

    /**
     * Get the unique identifier for the user.
     *
     * @return mixed
     */
    public function getAuthIdentifier() {
        return $this->getKey();
    }

    /**
     * Get the password for the user.
     *
     * @return string
     */
    public function getAuthPassword() {
        return $this->password;
    }

    /**
     * Get the e-mail address where password reminders are sent.
     *
     * @return string
     */
    public function getReminderEmail() {
        return $this->email;
    }

    /**
     * 
     * @return type
     */
    public function groups() {
        //print_r($this->belongsToMany('Group', 'group_users')->withTimestamps());
        return $this->belongsToMany('Group', 'group_users')->withTimestamps();
    }

    /**
     * 
     * @param type $groupid
     */
    public function joinGroup($groupid) {
        $this->groups()->attach($groupid);
    }

    /**
     * 
     * @param type $groupid
     */
    public function leaveGroup($groupid) {
        $this->groups()->detach($groupid);
    }

    /**
     * This function will return whether the user is a part of the 
     * group or not
     * 
     * @param type $groupid
     * @return type
     */
    public function hasGroup($groupid) {
        return in_array($groupid, array_fetch($this->groups->toArray(), 'id'));
    }

    /**
     * 
     * @return type
     */
    public function getGroupCount() {
        return count(array_fetch($this->groups->toArray(), 'id'));
    }

    /**
     * 
     * @return type
     */
    public function getGroups() {
        return $this->groups;
    }

    /**
     * Get the roles a user has
     */
    public function roles() {
        return $this->belongsToMany('Role', 'role_assignments');
    }

    /**
     * Find out if User is an employee, based on if has any roles
     *
     * @return boolean
     */
    public function isEmployee() {
        $roles = $this->roles->toArray();
        return !empty($roles);
    }

    /**
     * Find out if user has a specific role
     *
     * $return boolean
     */
    public function hasRole($check) {
        return in_array($check, array_fetch($this->roles->toArray(), 'name'));
    }

    /**
     * Get key in array with corresponding value
     *
     * @return int
     */
    private function getIdInArray($array, $term) {
        foreach ($array as $key => $value) {
            if ($value == $term) {
                return $key;
            }
        }

        throw new UnexpectedValueException;
    }

    /**
     * 
     * @return type
     */
    public function postLike() {
        return $this->hasMany('Like', 'likes', 'user_id', 'post_id');
    }

    /**
     * 
     * @param type $postid
     * @return type
     */
    public function hasLike($postid) {
        return DB::table('likes')
                        ->where('user_id', $this->id)
                        ->where('post_id', $postid)
                        ->count();
    }

    /**
     * 
     * @return type
     */
    public function comments() {
        return $this->hasMany('Comment');
    }

    public function tasks() {
        return $this->hasMany('Task', 'user_tasks');
    }

    public function getPendingTask($groupid, $outcomeid) {
        return DB::table('user_tasks')
                        ->where('user_id', $this->id)
                        ->where('group_id', $groupid)
                        ->where('outcome_id', $outcomeid)
                        ->where('complete', 0)
                        ->get();
    }

    public function completeTask($groupid, $taskid) {

        return DB::table('user_tasks')
                        ->where('user_id', $this->id)
                        ->where('group_id', $groupid)
                        ->where('task_id', $taskid)
                        ->update(array('complete' => 1, 'updated_at' => new DateTime));
    }

    public function completedTaskCount() {
        return DB::table('user_tasks')
                        ->where('user_id', $this->id)
                        ->count();
    }

    public function messages() {
        return $this->hasMany('Message', 'from', 'id');
    }

    public function getMessages($toUserId) {
        return $this->messages()->where('to', $toUserId);
    }

    public function getMessageCount() {
        return count(array_fetch($this->messages->toArray(), 'id'));
    }

    public function getPictureSrc($size) {
        if (!empty($this->picture)) {
            if (preg_match('/OAR/', $this->picture))
                return 'src="' . asset('images/user/common/' . $this->picture) . '"';
            return 'src="' . base64_decode($this->picture) . '"';
        } elseif (file_exists(public_path() . '/images/user/common/' . strtolower(str_replace(" ", "_", $this->screenhandle) . '.jpg'))) {
            return 'src="' . asset('/images/user/common/' . strtolower(str_replace(" ", "_", $this->screenhandle)) . '.jpg') . '"';
        }

        return 'data-src="/holder.js/' . $size . '"';
    }

    public function fullname() {
        return $this->firstname . ' ' . $this->lastname;
    }

    public function surveyResponses() {
        return $this->hasMany('SurveyResponse', 'survey_response');
    }

    public function postSurveyCompleted($groupid) {
        return DB::table('survey_response')
                        ->where('user_id', $this->id)
                        ->where('group_id', $groupid)
                        ->where('type', 'post')
                        ->count();
    }

    public function preSurveyCompleted($groupid) {
        return DB::table('survey_response')
                        ->where('user_id', $this->id)
                        ->where('group_id', $groupid)
                        ->where('type', 'pre')
                        ->count();
    }

    public function getDisplayName() {
        if (isset($this->screenhandle) && !empty($this->screenhandle)) {
            return $this->screenhandle;
        }
        return t('master.anonymous');
    }

    public function hasPosted($groupid, $taskid) {
        return DB::table('posts')
                        ->where('user_id', $this->id)
                        ->where('group_id', $groupid)
                        ->where('task_id', $taskid)
                        ->count();
    }

    public function getWords() {
        $stopwords = "1,2,3,4,5,6,7,8,9,0.,able,about,above,according,accordingly,across,actually,after,afterwards,again,against,ain't,all,allow,allows,almost,alone,along,already,also,although,always,am,among,amongst,an,and,another,any,anybody,anyhow,anyone,anything,anyway,anyways,anywhere,apart,appear,appreciate,appropriate,are,aren't,around,as,aside,ask,asking,associated,at,available,away,awfully,be,became,because,become,becomes,becoming,been,before,beforehand,behind,being,believe,below,beside,besides,best,better,between,beyond,both,brief,but,by,c'mon,c's,came,can,can't,cannot,cant,cause,causes,certain,certainly,changes,clearly,co,com,come,comes,concerning,consequently,consider,considering,contain,containing,contains,corresponding,could,couldn't,course,currently,definitely,described,despite,did,didn't,different,do,does,doesn't,doing,don't,done,down,downwards,during,each,edu,eg,eight,either,else,elsewhere,enough,entirely,especially,et,etc,even,ever,every,everybody,everyone,everything,everywhere,ex,exactly,example,except,far,few,fifth,first,five,followed,following,follows,for,former,formerly,forth,four,from,further,furthermore,get,gets,getting,given,gives,go,goes,going,gone,got,gotten,greetings,had,hadn't,happens,hardly,has,hasn't,have,haven't,having,he,he's,hello,help,hence,her,here,here's,hereafter,hereby,herein,hereupon,hers,herself,hi,him,himself,his,hither,hopefully,how,howbeit,however,i'd,i'll,i'm,i've,ie,if,ignored,immediate,in,inasmuch,inc,indeed,indicate,indicated,indicates,inner,insofar,instead,into,inward,is,isn't,it,it'd,it'll,it's,its,itself,just,keep,keeps,kept,know,knows,known,last,lately,later,latter,latterly,least,less,lest,let,let's,like,liked,likely,little,look,looking,looks,ltd,mainly,many,may,maybe,me,mean,meanwhile,merely,might,more,moreover,most,mostly,much,must,my,myself,name,namely,nd,near,nearly,necessary,need,needs,neither,never,nevertheless,new,next,nine,no,nobody,non,none,noone,nor,normally,not,nothing,novel,now,nowhere,obviously,of,off,often,oh,ok,okay,old,on,once,one,ones,only,onto,or,other,others,otherwise,ought,our,ours,ourselves,out,outside,over,overall,own,particular,particularly,per,perhaps,placed,please,plus,possible,presumably,probably,provides,que,quite,qv,rather,rd,re,really,reasonably,regarding,regardless,regards,relatively,respectively,right,said,same,saw,say,saying,says,second,secondly,see,seeing,seem,seemed,seeming,seems,seen,self,selves,sensible,sent,serious,seriously,seven,several,shall,she,should,shouldn't,since,six,so,some,somebody,somehow,someone,something,sometime,sometimes,somewhat,somewhere,soon,sorry,specified,specify,specifying,still,sub,such,sup,sure,t's,take,taken,tell,tends,th,than,thank,thanks,thanx,that,that's,thats,the,their,theirs,them,themselves,then,thence,there,there's,thereafter,thereby,therefore,therein,theres,thereupon,these,they,they'd,they'll,they're,they've,think,third,this,thorough,thoroughly,those,though,three,through,throughout,thru,thus,to,together,too,took,toward,towards,tried,tries,truly,try,trying,twice,two,un,under,unfortunately,unless,unlikely,until,unto,up,upon,us,use,used,useful,uses,using,usually,value,various,very,via,viz,vs,want,wants,was,wasn't,way,we,we'd,we'll,we're,we've,welcome,well,went,were,weren't,what,what's,whatever,when,whence,whenever,where,where's,whereafter,whereas,whereby,wherein,whereupon,wherever,whether,which,while,whither,who,who's,whoever,whole,whom,whose,why,will,willing,wish,with,within,without,won't,wonder,would,would've,wouldn't,yes,yet,you,you'd,you'll,you're,you've,your,yours,yourself,yourselves,zero,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
        $stopwords = explode(",", $stopwords);
        $reg_exp = "/(http|https|ftp|ftps)\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?/";

        $words = DB::table('posts')
                ->where('user_id', $this->id)
                ->where('statustype', 'text')
                ->lists('status');
        $imgWords = DB::table('posts')
                ->where('user_id', $this->id)
                ->where('statustype', 'image')
                ->lists('status');

        foreach ($imgWords as $index => $val) {
            $status = unserialize($val);
            if (!preg_match($reg_exp, $status['text'])) {
                $words[] = $status['text'];
            }
        }



        foreach ($words as $key => $text) {
            if (preg_match($reg_exp, $text)) {
                $words[$key] = '';
            }
        }
        $words = explode(" ", implode(" ", $words));

        $words = filter_stopwords($words, $stopwords);
        $words = word_freq($words);
        return $words;
    }
    
    public function APIGetPictureSrc($size='') {
        if (!empty($this->picture)) {
            if (preg_match('/OAR/', $this->picture))
                return URL::to('/') . asset('images/user/common/' . $this->picture);
            return URL::to('/').base64_decode($this->picture);
        } elseif (file_exists(public_path() . '/images/user/common/' . strtolower(str_replace(" ", "_", $this->screenhandle) . '.jpg'))) {
            return URL::to('/') . asset('/images/user/common/' . strtolower(str_replace(" ", "_", $this->screenhandle)) . '.jpg');
        }

        return 'data-src="/holder.js/' . $size . '"';
    }

    public function getRememberToken() {
        return $this->remember_token;
    }

    public function setRememberToken($value) {
        $this->remember_token = $value;
    }

    public function getRememberTokenName() {
        return 'remember_token';
    }

}
