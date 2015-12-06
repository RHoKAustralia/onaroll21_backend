<?php

class AuthController extends BaseController {

    public function requireLogin() {
        if($_POST) {
            if (!Input::has('username')) {
                //Redirect with appropriate message
                return View::make('auth.login')->with('message',trans('master.emptyusername'));
            } elseif (!Input::has('password')) {
                // Redirect with appropriate message
                return View::make('auth.login')->with('message',trans('master.emptypassword'));
            }

            if(Auth::attempt(array('username'=>Input::get('username'),'password'=>Input::get('password'),'suspended'=>0))) {
                // Add to log
                $user=Auth::user();
                DB::insert('insert into user_log (user_id,type,created_at,updated_at) value (?,?,?,?)',
                                array(
                                    $user->id,
                                    'login',
                                    date('Y-m-d H:i:s'),
                                    date('Y-m-d H:i:s')
                                    )
                        );
                return Redirect::intended();
            } else {
                return View::make('auth.login')->with('message',trans('master.incorrectlogin'));
            }
        }
        
        return View::make('auth.login');
    }
    
    public function login() {
        if(Input::has('username') && Input::has('password')) {
            
        }
    }
    
    public function logout() {
        if(Auth::check()) {
            Auth::logout();
            Session::flush();
            return Redirect::to('login')->with('successmessage',trans('master.logoutsuccess'));
        }
        // What to do when the user is not logged in
    }
    
    /**
     * This function should log the user in and return the details:
     * - User details
     * - Pending task
     * - Groups that the user is part of
     * @return type
     */
    public function apiLogin() {

        if (filter_var(Input::get('username'), FILTER_VALIDATE_EMAIL) === false) {
               $credentials=array(
                    'username'=>Input::json('username'),
                    'password'=>Input::json('password'),
                    'suspended'=>0
                );
        }else{


                $credentials=array(
                    'email'=>Input::json('username'),
                    'password'=>Input::json('password'),
                    'suspended'=>0
                );

        }



        
        if(Auth::attempt($credentials)) {
            $user=Auth::user();
            //TODO: Add the user group details
            $user->picture= $user->APIGetPictureSrc();
            $user->groupCount=$user->getGroupCount();
            $user->pendingTask=1;   //TODO: change this to the actual pending task
            $user->moodcheck=1;     //TODO: change this to correct info from the database
            $user->isOnApp = "false";

            $role = DB::table('users')
                ->join('role_assignments', 'users.id', '=', 'role_assignments.user_id')
                ->select('role_assignments.role_id')
                ->where('users.id','=',$user->id)
                ->get();

            if ($role) {
                $user->role = $role{0}->role_id;
            }

            // set the group id to session
            $groupid = DB::table('group_users')
                ->where('user_id', $user->id)
                ->pluck('group_id');

            Session::put('groupid', $groupid);

			// check if the playerid is set if so add to the user
			$playerId = Session::get('playerid');
			if(isset($playerId)) 
                {
                    \mobile\writeMobilePNtoDB($playerId);
                    $user->isOnApp = "true";
                }

            return Response::json($user);
        } else {
            $credentials['success']=false;
            $user =  DB::table('users')
                ->where('username', Input::json('username'))
                ->where('suspended', 1)
                ->get();

            if ($user){
                return Response::json(array('flash'=>'Your account has been suspended'),500);
            }else{
                return Response::json(array('flash'=>'Invalid username or password'),500);
            }


            
        }
    }
    
    public function apiLogout() {
        return Response::json(array('flash'=>'You have been successfully logged out!!'));
    }

}
