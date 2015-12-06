<?php

class GroupController extends BaseController {
    
    public $layout = 'layouts.master';

    /**
     * 
     * @return type
     */
    public function showAllGroups() {
        $groups = Group::all();
        return View::make('group.groups')
                ->with('groups',$groups)
            ->with('bodyclasses','groupspage');
    }
    
    /**
     * 
     */
    public function manageGroups() {
        $groups = Group::all();
        $this->layout->content = View::make('group.manage')->with('groups',$groups);
    }
    
    /**
     * 
     * @return type
     */
    public function joinGroup() {
        if($_POST) {
            $user = Auth::user();
            if(Input::has('join'))
                $user->joinGroup(Input::get('id'));
            elseif(Input::has('leave'))
                $user->leaveGroup(Input::get('id'));
        }
        
        return Redirect::to('/groups');
    }
    
    /**
     * 
     * @return type
     */
    public function addGroup() {
        if($_POST) {
            $group = new Group;
            
            $group->name = Input::get('name');
            $group->description = Input::get('description');
            $group->keycode = Input::get('keycode');
            $group->timestart = strtotime(Input::get('timestart'));
            $group->timeend = 0;
            $group->thumbnail = '';
            $group->outcome = Input::get('outcome');
            $group->survey = Input::get('survey');
            $group->postsurvey = Input::get('postsurvey');
            $group->createdby = Auth::user()->id;
            
            if(Input::hasFile('thumbnail')) {
                $file = Input::file('thumbnail');
                $pixpath = '/uploads/pix/group/';
                $destinationPath = public_path().$pixpath;
                $filename = str_replace(" ","_",$group->name).'.'.$file->getClientOriginalExtension();
                $file->move($destinationPath,$filename);
                $group->thumbnail = base64_encode($pixpath.$filename);
            }
            
            $group->save();
            
            return Redirect::to('groups/manage');
        }
        //Outcome menu
        $outcomes = Outcome::all();
        $outcomes_menu = array();
        $outcomes_menu[0] = trans('master.choose');
        foreach($outcomes as $outcome) {
            $outcomes_menu[$outcome->id] = trans($outcome->name);
        }
        //Survey menu
        $surveys = Survey::all();
        $surveys_menu = array();
        $surveys_menu[0] = trans('master.choose');
        foreach($surveys as $survey) {
            $surveys_menu[$survey->id] = trans($survey->name);
        }
        return View::make('group.add')
                ->with('outcomes',$outcomes_menu)
                ->with('surveys',$surveys_menu)
                ->with('bodyclasses','addgroup');
    }
    
    /**
     * This will handle both updating and deleting group
     */
    public function updateGroup() {
        if($_POST) {
            if(Input::has('delete')) {
                $group = Group::find(Input::get('id'));

                if(is_null($group)) {
                    return Redirect::to('groups/manage');
                }

                $group->delete();
                return Redirect::to('groups/manage');
            } elseif(Input::has('edit')) {
                $group = Group::find(Input::get('id'));

                if(is_null($group)) {
                    return Redirect::to('groups/manage');
                }
                
                return Redirect::to('group/edit')->with('update_group',$group);
            } elseif(Input::has('addremusers')) {
                $group = Group::find(Input::get('id'));
                if(is_null($group)) {
                    return Redirect::to('groups/manage');
                }
                return Redirect::action('GroupController@manageUsers',array('id'=>$group->id));
            } elseif(Input::has('update')) {
                $group = Group::find(Input::get('id'));
                if(is_null($group)) {
                    return Redirect::to('groups/manage');
                }
                
                $group->name = Input::get('name');
                $group->description = Input::get('description');
                $group->timestart = strtotime(Input::get('timestart'));
                $group->outcome = Input::get('outcome');
                $group->survey = Input::get('survey');
                $group->postsurvey = Input::get('postsurvey');
                
                if(Input::hasFile('thumbnail')) {
                    $file = Input::file('thumbnail');
                    $pixpath = '/uploads/pix/group/';
                    $destinationPath = public_path().$pixpath;
                    $filename = str_replace(" ","_",$group->name).'.'.$file->getClientOriginalExtension();
                    $file->move($destinationPath,$filename);
                    $group->thumbnail = base64_encode($pixpath.$filename);
                }
                
                $group->save();
                
                return Redirect::to('groups/manage');
            }
        }
        $group = Session::get('update_group');
        if(is_null($group)) {
            return Redirect::to('groups/manage');
        }
        //Outcome menu
        $outcomes = Outcome::all();
        $outcomes_menu = array();
        $outcomes_menu[0] = trans('master.choose');
        foreach($outcomes as $outcome) {
            $outcomes_menu[$outcome->id] = trans($outcome->name);
        }
        //Survey menu
        $surveys = Survey::all();
        $surveys_menu = array();
        $surveys_menu[0] = trans('master.choose');
        foreach($surveys as $survey) {
            $surveys_menu[$survey->id] = trans($survey->name);
        }
        return $this->layout->content = View::make('group.edit')
                ->with('outcomes',$outcomes_menu)
                ->with('surveys',$surveys_menu)
                ->with('group',$group);
    }
    
    public function manageUsers($groupid) {
        
        $group = Group::find($groupid);
        if(is_null($group)) {
            return Redirect::to('groups/manage');
        }
        
        $this->layout->content = View::make('group.addusers')
                ->with('group',$group);
    }
    
    public function groupUsers() {
        if(!$_POST) {
            App::abort(404);
        }
        $input=Input::all();
        $group=Group::find($input['id']);
        if(Input::has('adduser')) {
            if(is_null($group)) {
                return Redirect::to('groups/manage');
            }
            $group->users()->attach($input['userid']);
        } elseif(Input::has('removeuser')) {
            if(is_null($group)) {
                return Redirect::to('groups/manage');
            }
            $group->users()->detach($input['userid']);
        }
        return Redirect::action('GroupController@manageUsers',
                                                array('id'=>$group->id));
    }
    
    public function showMembers($id) {
        $group=Group::find($id);
        
        if(is_null($group)) {
            return Redirect::to('/groups');
        }
        
        $members = $group->getUserList();
        $this->layout->content = View::make('group.members')
                ->with('members',$members)
                ->with('group',$group);
    }

}
