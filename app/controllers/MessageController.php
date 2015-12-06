<?php

class MessageController extends BaseController {

    public $layout='layouts.message';

    /**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index() {
            //
            $user = Auth::user();
            
            $messages = $user->messages();
            
            
//            $this->layout->content = View::make('message.messages')
//                    ->with('messages',$messages);
            
            return Response::json(json_encode($messages));
	}

	/**
	 * Show the form for creating a new resource.
	 *
	 * @return Response
	 */
	public function create()
	{
		//
	}

	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
	public function store() {
            //
            $input=Input::all();
            $message = new Message();
            $message->from = $input['fromuser'];
            $message->to = $input['touser'];
            $message->message = $input['message'];
            
            $message->save();
            
            return Redirect::action('MessageController@show',array('id'=>Input::get('touser')));
	}

	/**
	 * Display the messages exchanged with a specified user.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
            //
            $user = User::find($id);
            $fromUser = Auth::user();
            if(is_null($user)) {
                // Redirect to the messages list page
                return Redirect::to('/messages');
            }
            $messages=Message::whereRaw(
                    '(`from` = ? and `to` = ?) or 
                        (`from` = ? and `to` = ?)',
                                        array(
                                            $fromUser->id,
                                            $user->id,
                                            $user->id,
                                            $fromUser->id
                                        ))
                                ->get();
            $this->layout->content = View::make('message.message')
                    ->with('fromuser',$fromUser)
                    ->with('touser',$user)
                    ->with('messages',$messages);
	}

	/**
	 * Show the form for editing the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		//
	}

	/**
	 * Update the specified resource in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		//
	}

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		//
	}

}