<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class RoleController extends BaseController {

    public $layout='layouts.material_master';
    
    public function showAllRoles() {
        $roles = Role::all();
        $this->layout->content = View::make('role.roles')
                ->with('roles',$roles);
    }
    
    public function addRole() {
        if($_POST) {
             $input = Input::all();
            $role = new Role();
            $role->name = $input['shortname'];
            $role->fullname = $input['fullname'];
            $role->description = $input['description'];

            $role->save();

            return Redirect::to('roles');
        }
        
        $this->layout->content = View::make('role.add');
       
    }
    
    public function editRole($roleid) {
        $role = Role::find($roleid);
        
        $this->layout->content = View::make('role.edit')->with('role',$role);
    }
    
    public function updateRole() {
        if($_POST) {
            if(Input::has('addremoveusers')) {
                $role = Role::find(Input::get('id'));
                
                return Redirect::to('role/manageusers')->with('role_assignusers',serialize($role));
            } elseif(Input::has('adduser')) {
                $role = Role::find(Input::get('roleid'));
                $user = Input::get('userid');
                $role->addUser(Input::get('userid'));
                
                return Redirect::to('role/manageusers')->with('role_assignusers',serialize($role));
            } elseif(Input::has('removeuser')) {
                $role = Role::find(Input::get('roleid'));
                $user = Input::get('userid');
                $role->removeUser(Input::get('userid'));
                
                return Redirect::to('role/manageusers')->with('role_assignusers',serialize($role));;
            } elseif(Input::has('edit')) {
                $role = Role::find(Input::get('id'));
                
                if(is_null($role)) {
                    return Redirect::to('/roles');
                }
                return Redirect::action('RoleController@editRole',array('id'=>$role->id));
            } elseif(Input::has('update')) {
                $role = Role::find(Input::get('roleid'));
                
                if(is_null($role)) {
                    return Redirect::to('/roles');
                }
                $input = Input::all();
                $role->name = $input['shortname'];
                $role->fullname = $input['fullname'];
                $role->description = $input['description'];
                
                $role->save();
                
                return Redirect::to('/roles');
            }
        }
        
        $role = unserialize(Session::get('role_assignusers'));
        
        if(is_null($role) || empty($role->id)) {
            return Redirect::to('roles');
        }
        
        $this->layout->content = View::make('role.assign')->with('role',$role);
        
    }
    
    public function manageCapabilities() {
        if($_POST) {
            $input = Input::all();
            if(isset($input['add'])) {
                $role = Role::find($input['roleid']);
                $role->capabilities()->attach($input['capid']);
                
                return Redirect::action('RoleController@manageCapabilities');
            } elseif(isset($input['delete'])) {
                $role = Role::find($input['roleid']);
                $role->capabilities()->detach($input['capid']);
                
                return Redirect::action('RoleController@manageCapabilities');
            }
        }
        
        $capabilities=Capability::all();
        $this->layout->content = View::make('capability.capabilities')
                ->with('capabilities',$capabilities);
    }
}
