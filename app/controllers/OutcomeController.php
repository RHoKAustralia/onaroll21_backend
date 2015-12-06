<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class OutcomeController extends BaseController {

    public $layout='layouts.material_master';
    
    public function showAllOutcomes() {
        // This function will list all outcomes
        $outcomes = Outcome::all();
        $this->layout->content = View::make('outcome.manage')->with('outcomes',$outcomes);
    }
    
    
    public function addMissionAjax(){
        
        $input = Input::all();
        
        $outcomeid = $input['outcomeid'];
        $taskid = $input['taskid'];
        
        $outcome = OutcomeTask::where('outcome_id', $outcomeid)->where('task_id', $taskid)->count();
        
        //print_r($outcome);
        
        if ($outcome == '1'){
            // record exist
            DB::table('outcome_tasks')->where('outcome_id', $outcomeid)->where('task_id', $taskid)->delete();
            
        }else{
            // non-exist
            DB::table('outcome_tasks')->insert(
                ['outcome_id' => $outcomeid, 'task_id' => $taskid]
            );
            
        }
        
        exit();
        
        
    }
    
    public function addOutcome() {
        if($_POST) {
            if(Input::has('add')) {
                $outcome = new Outcome;
                $outcome->name = Input::get('name');
                $outcome->description = Input::get('description');
                $outcome->type = Input::get('type');
                $outcome->taskcount = 0;
                $outcome->suspended = 0;
                $outcome->createdby = Auth::user()->id;
                
                $outcome->save();
            }
            
            return Redirect::to('/outcomes');
        }
        
        $this->layout->content = View::make('outcome.add');
    }
    
    public function updateOutcome() {
        if($_POST) {
            if(Input::has('update')) {
                $outcome = Outcome::find(Input::get('id'));

                if(is_null($outcome)) {
                    return Redirect::to('outcomes');
                }
                
                $outcome->name = Input::get('name');
                $outcome->description = Input::get('description');
                $outcome->type = Input::get('type');
                
                $outcome->save();
            } elseif(Input::has('edit')) {
                $outcome = Outcome::find(Input::get('id'));
                if(is_null($outcome)) {
                    return Redirect::to('outcomes');
                }
                return Redirect::to('outcome/update')->with('update_outcome',serialize($outcome));
            } elseif(Input::has('suspend')) {
                $outcome = Outcome::find(Input::get('id'));
                $outcome->suspended = 1;
                
                $outcome->save();
            } elseif(Input::has('activate')) {
                $outcome = Outcome::find(Input::get('id'));
                $outcome->suspended = 0;
                
                $outcome->save();
            } elseif(Input::has('addtask')) {
                $outcome = Outcome::find(Input::get('id'));
                if(is_null($outcome)) {
                    return Redirect::to('outcomes');
                }
                return Redirect::to('outcome/addtask')->with('addtask_outcome',serialize($outcome));
            } elseif(Input::has('delete')) {
                $outcome = Outcome::find(Input::get('id'));
                
                $outcome->delete();
            }
            
            return Redirect::to('/outcomes');
        }
        
        $outcome = unserialize(Session::get('update_outcome'));
        if(is_null($outcome)) {
            return Redirect::to('/outcomes');
        }
        
        $this->layout->content = View::make('outcome.edit')->with('outcome',$outcome);
    }
    
    public function addTask() {
        if($_POST) {
            if(Request::has('id')) {
                $outcome = Outcome::find(Request::get('outcomeid'));
                if(Request::has('add'))
                    $outcome->addTask(Request::get('id'));
                if(Request::has('remove'))
                    $outcome->removeTask(Request::get('id'));
                
                if(Request::has('up'))
                    $outcome->moveTaskUp(Request::get('id'));
                if(Request::has('down'))
                    $outcome->moveTaskDown(Request::get('id'));
                if(Request::has('markfinal'))
                    $outcome->addFinalTask(Request::get('id'));
                if(Request::has('removefinal'))
                    $outcome->finalTask()->delete(
                            array('task_id'=>Request::get('id')));
                
                
                return Redirect::to('outcome/addtask')
                        ->with('addtask_outcome',serialize($outcome));
            }
        }
        // This is where we will add task/s to outcome
        $outcome = unserialize(Session::get('addtask_outcome'));
        if(is_null($outcome) || !isset($outcome->id)) {
            return Redirect::to('/outcomes');
        }
        $this->layout->content = View::make('outcome.addtask')
                ->with('outcome',$outcome);
    }

}