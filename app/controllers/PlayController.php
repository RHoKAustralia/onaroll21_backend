<?php

class PlayController extends BaseController {

    public $layout = 'layouts.play';

    public function showDice($groupid = 0) {
        /**
         * Steps Involved:
         * 1. Check if the user has more than one group
         * 2. IF the user is a part of more than one group then display the
         * group list or else display the dice
         */
        /**
         * Get the current user
         */
        $user = Auth::user();

        /**
         * Execute if we are looking for a specific group
         */
        if (!empty($groupid)) {
            // TODO: either the user should be admin or should be a part of 
            // this group
            if (!$group = Group::find($groupid)) {
                App::abort(404);
            }
            /**
             * Check if the user can view the group/post in it
             */
            if (!$user->hasGroup($groupid) && !$user->hasRole('admin')) {
                App::abort(404);
            }

            // Check if the user has a pending task
            if ($pendingTask = DB::table('user_tasks')
                    ->where('user_id', $user->id)
                    ->where('group_id', $group->id)
                    ->where('complete', 0)
                    ->get()
            ) {
                return Redirect::action('PlayController@showStatusPage', array('id' => $group->id))->with('task', $pendingTask);
            }

            return Redirect::action('PlayController@showStatusPage', array('id' => $group->id))->with('task', $pendingTask);
            // TODO: pass the group id as well...This will help us fetch the 
            // latest task
        } else {
            if ($user->getGroupCount() > 1 || $user->hasRole('admin')) {    // TODO: Also check if the user can view all the groups
                if ($user->hasRole('admin')) {
                    $groups = Group::all();
                } else {
                    $groups = $user->getGroups();
                }
                $this->layout->content = View::make('play.groups')
                        ->with('groups', $groups)
                        ->with('user', $user);
            } elseif ($user->getGroupCount() == 1) {
                $group = $user->getGroups()->first();
                return Redirect::action('PlayController@showStatusPage', array('id' => $group->id));
            } elseif ($user->getGroupCount() == 0) {
                // TODO: tell the user that there are no groups and he/she needs
                //  to be part of atleast one group
                $this->layout->content = View::make('play.nogroup');
            }
        }
    }

    /**
     * TODO: Documentation
     * @param type $groupid
     * @return type
     */
    public function showStatusPage($groupid) {
        if (empty($groupid))
            App::abort(404);

        $user = Auth::user();
        $group = Group::find($groupid);    // I will have to fetch the user's current group
        $userCurrentTask = $user->getPendingTask($group->id, $group->outcome);

        if ($userCurrentTask) {
            $task = Task::find($userCurrentTask[0]->task_id);  // I will have to fetch the user's curent task
        } else {
            $task = Task::find(5);
        }

        // TODO: fetch the posts for this group
        $posts = Post::orderBy('id', 'DESC')->where('group_id', $group->id)->take(5)->get();
        $postCount = Post::where('group_id', $group->id)->count();

        $current = new stdClass();
        $current->user = $user->id;
        $current->group = $group->id;
        $current->task = $task->id;
        $this->layout->bodyclasses = 'status-page';
        $this->layout->content = View::make('play.status')
                ->with('user', $user)
                ->with('group', $group)
                ->with('task', $task)
                ->with('current', $current)
                ->with('posts', $posts)
                ->with('postcount', $postCount);
    }

    /**
     * 
     * @return type
     */
    public function getCurrentTask() {
        return View::make('play.current_task');
    }

    /**
     * 
     * @return type
     */
    public function postStatus() {
        // This function needs to store the information in DB
        if ($_POST) {
            $input = Input::all();
            $user = User::find($input['userid']);
            $group = Group::find($input['groupid']);
            $task = Task::find($input['taskid']);

            //We need to validate the input first
            $rules = array(
                'status_image' => 'max:3072'
            );

            $messages = array(
                'status_image.max' => 'File size is more than the allowed limit of 3MB. Please try uploading a smaller image'
            );

            $validator = Validator::make($input, $rules, $messages);

            if ($validator->fails()) {
                return Redirect::action('PlayController@showStatusPage', array('id' => $group->id))
                                ->withInput()
                                ->withErrors($validator);
            }

            $post = new Post();
            $post->user_id = $input['userid'];
            $post->group_id = $input['groupid'];
            $post->task_id = $input['taskid'];
            $post->statustype = 'text';


            if (Input::hasFile('status_image')) {
                $status = array();
                $status['text'] = $input['status_text'];
                $file = Input::file('status_image');
                $filecreationname = sha1($user->id . $group->id . $task->id . time() . $file->getClientOriginalName());
                $pixpath = '/uploads/pix/posts/' . $filecreationname . '/';
                $destinationPath = public_path() . $pixpath;
                $filename = $filecreationname . '.' . $file->getClientOriginalExtension();

                File::makeDirectory($destinationPath);

                $video_formats = array('mp4', 'mov', 'avi', 'wav', 'flv', 'wmv');
                if (in_array($file->getClientOriginalExtension(), $video_formats)) {
                    $file->move($destinationPath, $filename);
                } else {
                    $img = Image::make(Input::file('status_image')->getRealPath());
                    if (preg_match('/.jpg$/i', $filename) || preg_match('/.jpeg$/i', $filename)) {
                        // Before resizing correct image orientation
                        $orientation = @$img->exif('Orientation');

                        if (!empty($orientation)) {
                            switch ($orientation) {
                                case 8:
                                    $img->rotate(90);
                                    break;
                                case 3:
                                    $img->rotate(180);
                                    break;
                                case 6:
                                    $img->rotate(-90);
                                    break;
                            }
                        }
                    }
                    //$img->resize($thumb_w, $thumb_h, false);
                    $img->save(public_path() . $pixpath . $filename, 60);
                    //////////////END - IMAGE OPT/////////////
                }
                $status['image'] = base64_encode($pixpath . $filename);
                $post->statustype = 'image';

                $post->status = serialize($status);
            } else {
                $post->status = Input::get('status_text');
                if (isset($input['url'])) {
                    $thumbnail = new stdClass();
                    $thumbnail->original_url = $input['original_url'];
                    $thumbnail->url = $input['url'];
                    $thumbnail->type = $input['type'];
                    $thumbnail->provider_url = $input['provider_url'];
                    $thumbnail->provider_display = $input['provider_display'];
                    $thumbnail->provider_name = $input['provider_name'];
                    $thumbnail->favicon_url = $input['favicon_url'];
                    $thumbnail->title = $input['title'];
                    $thumbnail->description = $input['description'];
                    $thumbnail->thumbnail_url = $input['thumbnail_url'];
                    $thumbnail->author_name = $input['author_name'];
                    $thumbnail->author_url = $input['author_url'];
                    $thumbnail->media_type = $input['media_type'];
                    $thumbnail->media_html = $input['media_html'];
                    $thumbnail->media_width = $input['media_width'];
                    $thumbnail->media_height = $input['media_height'];

                    $post->thumbnail = serialize($thumbnail);
                }
            }

            $post->save();
            //Close the task here
            $user->completeTask($group->id, $task->id);
            return Redirect::action('PlayController@showStatusPage', array('id' => $post->group_id))
                            ->with('statusposted', 1);
        }
    }

    /**
     * 
     * @return type
     */
    public function updateStatus() {

        if (!$_POST) {
            App::abort(404);
        }

        $input = Input::all();

        $user = User::find($input['userid']);
        $group = Group::find($input['groupid']);

        if (isset($input['likeBtn'])) {
            $post = Post::find($input['postid']);
            $like = new Like();
            $like->user_id = $user->id;
            $like->post_id = $post->id;
            $like->save();
        } elseif (isset($input['unlikeBtn'])) {
            $like = DB::table('likes')->where('post_id', $input['postid'])->where('user_id', $user->id)->delete();
        } elseif (isset($input['postcomment'])) {
            $post = Post::find($input['postid']);
            $comment = new Comment();
            $comment->user_id = $user->id;
            $comment->post_id = $post->id;
            $comment->comment = $input['comment'];

            $comment->save();
        } elseif (isset($input['completetask'])) {
            $user->completeTask($group->id, $input['taskid']);
            return Redirect::action('PlayController@showStatusPage', array('id' => $group->id));
        }

        return Redirect::action('PlayController@showStatusPage', array('id' => $group->id));
    }

    /**
     * This function will be called from the dice page. It will accept the 
     * task that the user has agreed to and will send that to the database
     */
    public function acceptTask() {
        if (!$_POST) {
            App::abort(404);
        }

        $user = User::find(Input::get('userid'));
        $group = Group::find(Input::get('groupid'));
        $outcome = Outcome::find($group->outcome);
        $task = Task::find(Input::get('taskid'));

        // TODO: Check if the record already exists in the DB

        DB::table('user_tasks')->insert(
                array(
                    'user_id' => $user->id,
                    'group_id' => $group->id,
                    'outcome_id' => $outcome->id,
                    'task_id' => $task->id,
                    'created_at' => new DateTime,
                    'updated_at' => new DateTime
                )
        );

        return Redirect::action('PlayController@showStatusPage', array('id' => $group->id));
    }

    /**
     * This function will be used to store the wellbieng of individuals
     */
    public function updateWellbeingStatus() {
        
    }

    /**
     * 
     * @return type
     */
    public function deletePost() {
        if (!$_POST) {
            App::abort(404);
        }

        $input = Input::all();

        $post = Post::find($input['postid']);
        $post->delete();

        return Redirect::action('PlayController@showStatusPage', array('id' => $input['groupid']));
    }

    /**
     * 
     * @return type
     */
    public function deleteComment() {
        if (!$_POST) {
            App::abort(404);
        }

        $input = Input::all();

        $comment = Comment::find($input['commentid']);
        $comment->delete();

        return Redirect::action('PlayController@showStatusPage', array('id' => $input['groupid']));
    }

    /**
     * 
     */
    public function updateWellbeing() {
        if (!$_POST) {
            App::abort(404);
        }
        $input = Input::all();

        $wellbeing = new Wellbeing();
        $wellbeing->user_id = $input['userid'];
        $wellbeing->group_id = $input['groupid'];
        $wellbeing->task_id = isset($input['taskid']) && !empty($input['taskid']) ? $input['taskid'] : '';

        switch ($input['mood']) {
            case preg_match('/terrible/i', $input['mood']) == 1:
                $wellbeing->mood = 1;
                break;
            case preg_match('/not\ great/i', $input['mood']) == 1:
                $wellbeing->mood = 2;
                break;
            case preg_match('/okay/i', $input['mood']) == 1:
                $wellbeing->mood = 3;
                break;
            case preg_match('/pretty\ good/i', $input['mood']) == 1:
                $wellbeing->mood = 4;
                break;
            case preg_match('/fantastic/i', $input['mood']) == 1:
                $wellbeing->mood = 5;
                break;
            default:
                $wellbeing->mood = 1;
                break;
        }

        $wellbeing->save();

        return Redirect::to('play/group/' . $input['groupid']);
    }

    public function ajaxStatusPost() {
        if ($_POST) {
            $input = Input::all();
            $user = User::find($input['userid']);
            $group = Group::find($input['groupid']);
            $task = Task::find($input['taskid']);

            $post = new Post();
            $post->user_id = $input['userid'];
            $post->group_id = $input['groupid'];
            $post->task_id = $input['taskid'];
            $post->statustype = 'text';


            if (Input::hasFile('status_image')) {
                $status = array();
                $status['text'] = $input['status_text'];
                $file = Input::file('status_image');
                $filecreationname = sha1($user->id . $group->id . $task->id . time() . $file->getClientOriginalName());
                $pixpath = '/uploads/pix/posts/' . $filecreationname . '/';
                $destinationPath = public_path() . $pixpath;
                $filename = $filecreationname . '.' . $file->getClientOriginalExtension();

                File::makeDirectory($destinationPath);

                $file->move($destinationPath, $filename);
                $status['image'] = base64_encode($pixpath . $filename);
                $post->statustype = 'image';

                $post->status = serialize($status);
            } else {
                $post->status = Input::get('status_text');
            }

            $post->save();
            return View::make('play.ajax.addpost')
                            ->with('status_user', $user)
                            ->with('user', $user)
                            ->with('post', $post)
                            ->with('group', $group);
        }
    }

    public function ajaxCommentPost() {
        $input = Input::all();

        $user = User::find($input['userid']);
        $group = Group::find($input['groupid']);

        $post = Post::find($input['postid']);
        $comment = new Comment();
        $comment->user_id = $user->id;
        $comment->post_id = $post->id;
        $comment->comment = $input['comment'];

        $comment->save();

        $new_comment = Comment::find($comment->id);

        return View::make('play.ajax.addcomment')
                        ->with('new_comment', $new_comment)
                        ->with('group', $group);
    }

    /**
     * 
     * @return type
     */
    public function ajaxUpdateLike() {
        $input = Input::all();

        $user = User::find($input['userid']);
        $group = Group::find($input['groupid']);

        if ($input['type'] == 'unlike') {
            $post = Post::find($input['postid']);
            $like = DB::table('likes')->where('post_id', $input['postid'])->where('user_id', $user->id)->delete();

            return View::make('play.ajax.unlikebtnresponse')
                            ->with('post', $post);
        } else {

            $post = Post::find($input['postid']);
            $like = new Like();
            $like->user_id = $user->id;
            $like->post_id = $post->id;
            $like->save();

            return View::make('play.ajax.likebtnresponse')
                            ->with('post', $post);
        }
    }

    public function loadPosts() {
        if (!$_POST) {
            App::abort(404);
        }
        $group = Group::find(Input::get('group_id'));
        $user = Auth::user();
        $skip = Input::get('group_no') * 5;
        // TODO: fetch the posts for this group
        $posts = Post::orderBy('id', 'DESC')->where('group_id', $group->id)->take(5)->skip($skip + 5)->get();
        if (is_null($posts)) {
            echo 'All done';
            exit;
        }

        //If the user is not logged in or the session has timed out
        if (Auth::guest()) {
            return '';
        }
        return View::make('play.ajax.loadPosts')
                        ->with('posts', $posts)
                        ->with('group', $group)
                        ->with('user', $user);
    }

}
