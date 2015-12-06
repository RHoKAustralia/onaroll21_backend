<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
 
class RegisterController extends BaseController {
 
    /**
     * User Repository
     */
    protected $user;
    
    public $layout = 'layouts.login';

    /**
     * Inject the User Repository
     */
    public function __construct(User $user)
    {
        $this->user = $user;
    }

    public function index()
    {
        if(Auth::check()) {
            return Redirect::to('/');
        }
        $this->layout->content = View::make('auth.register');
    }

    public function store()
    {
        
        if($_POST) {
            $input = Input::all();

            $rules = array(
                'username' => 'required|unique:users',
                'password' => 'required',
                'email' => 'required|unique:users|email',
                'firstname' => 'required|Alpha',
                'lastname' => 'required|alpha_dash',
                'city' => 'required',
                'country' => 'required|Alpha',
                'recaptcha_response_field' => 'required|recaptcha',
            );

            $validator = Validator::make($input,$rules);

            if($validator->fails()) {
                return Redirect::to('register')
                        ->withInput()
                        ->withErrors($validator);
            } else {
                $user = new User;

                $user->username = Input::get('username');
                $user->password = Hash::make(Input::get('password'));
                $user->firstname = Input::get('firstname');
                $user->lastname = Input::get('lastname');
                $user->email = Input::get('email');
                $user->city = Input::get('city');
                $user->country = Input::get('country');
                $user->organisation = Input::get('organisation');
                $user->description = Input::get('description');
                $user->picture = '';
                $user->suspended=0;

                if(Input::hasFile('picture')) {
                    $file = Input::file('picture');
                    $pixpath = '/uploads/pix/user/';
                    $destinationPath = public_path().$pixpath;
                    $filename = $user->username.'.'.$file->getClientOriginalExtension();
                    $file->move($destinationPath,$filename);
                    $user->picture = base64_encode($pixpath.$filename);
                }

                $user->save();

                return Redirect::to('login')
                        ->with('successmessage', trans('master.registersuccess'));
                }
        }


        return Redirect::route('register.index')
          ->withInput()
          ->withErrors($s->errors());
    }
 
}
