<?php

class TaskController extends BaseController {
    
    public $layout='layouts.material_master';

    public function addTask() {
        if($_POST) {
            
            // Lets start validation
            // validate input
            $rules = array(
              'name' => 'required|max:50',
              'description' => 'required',
              'didyouknow'  => 'required',
                'reference'  => 'required',
            );
            $validation = Validator::make(Input::all(), $rules);
            
            if($validation->fails()){
              Input::flash();
              return Redirect::back()->withInput()
                      ->withErrors($validation);
            }
            
            $task = new Task;
            
            $task->name = Input::get('name');
            $task->description = Input::get('description');
            $task->didyouknow = Input::get('didyouknow');
            $task->reference = Input::get('reference');
            $task->author = Input::get('taskauthor');
            $task->createdby = 0;
            $task->suspended=0;
            $task->number=0;

            $task->save();
            
            return Redirect::to('tasks/manage');
        }
        return View::make('task.add');
    }
    
    public function manageTask() {
        $tasks = Task::all();
        return View::make('task.manage')->with('tasks',$tasks);
    }
    
    /**
     * This will handle both updating and deleting tasks
     */
    public function updateTask() {
        if($_POST) {
            if(Input::has('delete')) {
                $task = Task::find(Input::get('id'));

                if(is_null($task)) {
                    return Redirect::to('tasks/manage');
                }

                $task->delete();
                return Redirect::to('tasks/manage');
            } elseif(Input::has('edit')) {
                $task = Task::find(Input::get('id'));

                if(is_null($task)) {
                    return Redirect::to('tasks/manage');
                }
                
                return Redirect::to('task/edit')->with('update_task', serialize($task));
            } elseif(Input::has('update')) {
                $task = Task::find(Input::get('id'));
                if(is_null($task)) {
                    return Redirect::to('tasks/manage');
                }
                
                $task->name = Input::get('name');
                $task->description = Input::get('description');
                $task->didyouknow = Input::get('didyouknow');
                $task->reference = Input::get('reference');
                $task->author = Input::get('taskauthor');
                
                $task->save();
                
                return Redirect::to('tasks/manage');
            }
        }
        $task = unserialize(Session::get('update_task'));
        if(is_null($task) || empty($task->id)) {
            return Redirect::to('tasks/manage');
        }

        return $this->layout->content = View::make('task.edit')->with('task',$task);
    }

}