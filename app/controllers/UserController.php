<?php

class UserController extends BaseController {

    public $layout='layouts.material_master';

    /**
     * 
     * @return type
     */
    public function showAllUsers() {
        $layout='layouts.material_master';
        $users = User::all();
        return View::make('user.manage')->with('users', $users);
    }

    /**
     * 
     */
    public function addUser() {

        if ($_POST) {
            $input = Input::all();

            $rules = array(
                'username' => 'required|unique:users',
                'password' => 'required',
                'screenhandle' => 'required',
                'email' => 'required|unique:users|email',
                'firstname' => 'required|alpha',
                'lastname' => 'required',
                'city' => 'required',
                'country' => 'required',
            );
            
            $messages = array(
                'screenhandle.required' => 'The Roller name can not be blank'
            );

            $validator = Validator::make($input, $rules, $messages);

            if ($validator->fails()) {
                return Redirect::to('user/add')
                                ->withErrors($validator);
            } else {
                $user = new User;

                $user->username = Input::get('username');
                $user->password = Hash::make(Input::get('password'));
                $user->screenhandle=Input::get('screenhandle');
                $user->firstname = Input::get('firstname');
                $user->lastname = Input::get('lastname');
                $user->email = Input::get('email');
                $user->city = Input::get('city');
                $user->country = Input::get('country');
                $user->organisation = Input::get('organisation');
                $user->description = Input::get('description');
                $user->picture = '';
                $user->suspended = 0;

                if (Input::hasFile('picture')) {
                    $file = Input::file('picture');
                    $pixpath = '/uploads/pix/user/';
                    $destinationPath = public_path() . $pixpath;
                    $filename = $user->username . '.' . $file->getClientOriginalExtension();
                    $file->move($destinationPath, $filename);
                    $user->picture = base64_encode($pixpath . $filename);
                }

                $user->save();

                return Redirect::to('users/manage');
            }
        }

        $this->layout->content = View::make('user.add');
    }

    /**
     * 
     */
    public function showProfile($id = 0) {
        if (!empty($id))
            $user = User::find($id);
        else
            $user = Auth::user();
        
        $group = $user->getGroups()->first();
        
        if(is_null($group)) {
            $wellbeing='';
        } else {
        
            //Get the wellbeing stats
            $wellbeing = DB::table('wellbeing_tracks')
                    ->select('group_id',DB::raw('CEIL(AVG(mood)) as mood'),DB::raw('DATE(created_at) as date'))
                    ->where('user_id',$user->id)
                    ->where('group_id',$group->id)
                    ->groupBy('date')
                    ->get();

            foreach($wellbeing as $wellbeingTrack) {
                $wellbeingTrack->day = (strtotime($wellbeingTrack->date) - $group->timestart)/86400;
                if(floor($wellbeingTrack->day <= 0))
                    $wellbeingTrack->day=1;
                else
                    $wellbeingTrack->day=floor($wellbeingTrack->day)+1;
            }
//            echo '<pre>';
//            print_r($wellbeing);
//            echo '</pre>';
//            die;
//            $updatedTracks = array();
//            for($i=1;$i<=21;$i++) {
//                foreach($wellbeing as $wellbeingTrack) {
//                    if(!isset($wellbeingTrack->{}))
//                }
//            }
        }
        
        
//        echo '<pre>';
//        print_r($wellbeing);
//        echo '</pre>';
//        die;
//        
        $this->layout->content = View::make('user.profile')
                ->with('user', $user)
            ->with('wellbeing',$wellbeing);
    }

    public function editProfile() {
        $user = Auth::user();
        $this->layout->content = View::make('user.editprofile')->with('user', $user);
    }

    public function updateProfile() {
        if (!$_POST) {
            App::abort(404);
        }
        
        $input = Input::all();

        $rules = array(
            'email' => 'required|email',
            'screenhandle' => 'required',
            'firstname' => 'required|alpha',
            'lastname' => 'required',
            'city' => 'required',
            'country' => 'required',
        );
        
        $messages = array(
            'screenhandle.required' => 'The Roller name can not be blank'
        );

        $validator = Validator::make($input, $rules, $messages);

        if ($validator->fails()) {
            return Redirect::to('user/profile/edit')
                            ->withErrors($validator);
        } else {

            $user = User::find(Input::get('id'));
            if (is_null($user)) {
                return Redirect::to('users/manage');
            }

            if (Input::has('password')) {
                $user->password = Hash::make(Input::get('password'));
            }
            $user->screenhandle=Input::get('screenhandle');
            $user->firstname = Input::get('firstname');
            $user->lastname = Input::get('lastname');
            $user->city = Input::get('city');
            $user->country = Input::get('country');
            $user->organisation = Input::get('organisation');
	    $user->email = Input::get('email');
            $user->description = Input::get('description');

            if (Input::hasFile('picture')) {
                $file = Input::file('picture');
                $pixpath = '/uploads/pix/user/';
                $destinationPath = public_path() . $pixpath;
                $filename = $user->username . '.' . $file->getClientOriginalExtension();
                $file->move($destinationPath, $filename);
                $user->picture = base64_encode($pixpath . $filename);
            }

            $user->save();

            return Redirect::to('user/profile/view');
        }
    }

    /**
     * 
     */
    public function manageUsers() {
        
        $users = User::all();
        $this->layout = View::make('user.manage')
                ->with('users', $users)
                ->with('bodyclasses','admin manageusers');
        
        
        
    }

    /**
     * This will handle both updating and deleting users
     */
    public function updateUser() {
        if ($_POST) {
            if (Input::has('delete')) {
                $user = User::find(Input::get('id'));

                if (is_null($user)) {
                    return Redirect::to('users/manage');
                }

                $user->delete();
                return Redirect::to('users/manage');
            } elseif (Input::has('edit')) {
                $user = User::find(Input::get('id'));

                if (is_null($user)) {
                    return Redirect::to('users/manage');
                }

                return Redirect::to('user/edit')->with('update_user', $user);
            } elseif (Input::has('update')) {
                $input = Input::all();
                $rules = array(
                    'username' => 'required',
                    'screenhandle'=>'required',
                    'password' => '',
                    'email' => 'required',
                    'firstname' => 'required|alpha',
                    'lastname' => 'required',
                    'city' => 'required',
                    'country' => 'required',
                );

                $validator = Validator::make($input, $rules);

                if ($validator->fails()) {
                    return Redirect::to('user/add')
                                    ->withErrors($validator);
                } else {
                    $user = User::find(Input::get('id'));
                    if (is_null($user)) {
                        return Redirect::to('users/manage');
                    }

                    $user->username = Input::get('username');
                    if (Input::has('password')) {
                        $user->password = Hash::make(Input::get('password'));
                    }
                    $user->screenhandle=Input::get('screenhandle');
                    $user->firstname = Input::get('firstname');
                    $user->lastname = Input::get('lastname');
                    $user->city = Input::get('city');
                    $user->country = Input::get('country');
                    $user->organisation = Input::get('organisation');
		    $user->email = Input::get('email');
                    $user->description = Input::get('description');

                    if (Input::hasFile('picture')) {
                        $file = Input::file('picture');
                        $pixpath = '/uploads/pix/user/';
                        $destinationPath = public_path() . $pixpath;
                        $filename = $user->username . '.' . $file->getClientOriginalExtension();
                        $file->move($destinationPath, $filename);
                        $user->picture = base64_encode($pixpath . $filename);
                    }

                    $user->save();

                    return Redirect::to('users/manage');
                }
            } elseif (Input::has('deactivesap')) {
                $user = User::find(Input::get('id'));

                if (is_null($user)) {
                    return Redirect::to('users/manage');
                }
                $user->suspend_after = 0;

                $user->save();
                return Redirect::to('users/manage');
            } elseif (Input::has('activesap')) {
                $user = User::find(Input::get('id'));

                if (is_null($user)) {
                    return Redirect::to('users/manage');
                }
                $user->suspend_after = 1;
                //$user->created_at = date('Y-m-d H:i:s', time());

                $user->save();
                return Redirect::to('users/manage');
            } elseif (Input::has('suspend')) {
                $user = User::find(Input::get('id'));

                if (is_null($user)) {
                    return Redirect::to('users/manage');
                }
                $user->suspended = 1;

                $user->save();
                return Redirect::to('users/manage');
            }



             elseif (Input::has('activate')) {
                $user = User::find(Input::get('id'));

                if (is_null($user)) {
                    return Redirect::to('users/manage');
                }
                $user->suspended = 0;

                $user->save();
                return Redirect::to('users/manage');
            }
        }
        $user = Session::get('update_user');
        if (is_null($user)) {
            return Redirect::to('users/manage');
        }

        return $this->layout->content = View::make('user.edit')->with('user', $user);
    }

    public function getNextTask() {
        // Get the current user
        $user = Auth::user();

        // Get the group that the user belongs to
        $group = $user->getGroup();

        // Get the outcome from group
        $outcome = Outcome::find($group->outcome);

        // Now get the remaining task/s for this user in the specified group
        $tasks = $user->getRemainingTasks();
    }

}
