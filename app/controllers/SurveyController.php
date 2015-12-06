<?php

class SurveyController extends BaseController {

    public $layout='layouts.material_master';

    /**
     * @param string $type
     * @return mixed
     */
    public function showSurvey($type='pre') {
        if(!$_POST) {
            App::abort(404);
        }
        
        $input=Input::all();
        $user=User::find($input['userid']);
        $group=Group::find($input['groupid']);
        
        if(empty($group->survey)) {
            App::abort(404);
        }
        
        if(is_null($user) || is_null($group)) {
            return Redirect::to('/');
        }
        
        $this->layout->content = View::make('survey.'.$type)
            ->with('group',$group)
            ->with('user',$user);
    }
    
    /**
     * 
     */
    public function addSurvey() {
        if($_POST) {
            $input = Input::all();
            // Save the survey
            $rules = array(
                'name'=>'required'
            );
            
            $validator = Validator::make($input, $rules);
            
            $survey = new Survey();
            $survey->name = $input['name'];
            if(isset($input['description']))
                $survey->description = $input['description'];
            
            $survey->save();
            
            return Redirect::to('surveys');
        }
        $this->layout->content = View::make('survey.add');
    }
    
    public function manageSurveys() {
        // TODO: this function will list the surveys
        $surveys = Survey::all();
        $this->layout->content = View::make('survey.manage')
                ->with('surveys',$surveys);
    }
    
    public function updateSurvey() {
        if($_POST) {
            $input = Input::all();
            $survey = Survey::find($input['id']);
            
            if(isset($input['edit'])) {
                //Start editing the survey
                return Redirect::action('SurveyController@editSurvey',array(
                    'id'=>$survey->id
                ));
            }
            if(isset($input['update'])) {
                //Save the survey
                //TODO: validate the input
                $survey = Survey::find($input['id']);
                if(is_null($survey))
                    return Redirect::to('surveys');
                $survey->name = $input['name'];
                $survey->description = $input['description'];
                $survey->save();
                
                return Redirect::to('surveys');;
            }
            if(isset($input['addmessages'])) {
                 //Start editing the survey
                return Redirect::action('SurveyController@surveyMessages',array(
                    'id'=>$survey->id
                ));
            }
            if(isset($input['savemessages'])) {
                //Save the survey
                //TODO: validate the input
                $survey = Survey::find($input['id']);
                if(is_null($survey))
                    return Redirect::to('surveys');
                $premessage = $input['premessage'];
                $postmessage = $input['postmessage'];
                if(DB::table('survey_messages')
                        ->where('survey_id',$survey->id)
                                ->exists()) {
                    DB::table('survey_messages')
                            ->where('survey_id',$survey->id)
                            ->update(array(
                                'premessage'=>$premessage,
                                'postmessage'=>$postmessage
                            ));
                    
                } else {
                    DB::table('survey_messages')
                            ->insert(
                                    array(
                                        'survey_id'=>$survey->id,
                                        'premessage'=>$input['premessage'],
                                        'postmessage'=>$input['postmessage']
                            ));
                }
                
                return Redirect::to('surveys');
            }
            
            return Redirect::action('SurveyController@manageFields',array(
                                                            'id'=>$survey->id
                                                            ));
        }
    }
    
    public function editSurvey($id) {
        $survey = Survey::find($id);
        if(is_null($survey) && empty($survey->id)) {
            return Redirect::to('surveys');
        }
        
        $this->layout->content = View::make('survey.edit')
                ->with('survey',$survey);
    }
    
    public function manageFields($surveyid) {
        $survey = Survey::find($surveyid);
        if(is_null($survey) && empty($survey->id)) {
            return Redirect::to('surveys');
        }
        
        $this->layout->content = View::make('survey.addfields')
                ->with('survey',$survey);
    }
    
    public function addFields($surveyid) {
        if(Request::ajax()) {
            $survey=Survey::find($surveyid);

            $survey->data = serialize(Input::get());

            
            $survey->save();
            
            Log::info($survey->data);

            //return View::make('survey.added')->with('message','ok');
        }
        return View::make('survey.added')->with('message','ok');
    }
    
    /**
     * 
     */
    public function response() {
        $this->hasMany('SurveyResponse','survey_response');
    }
    
    /**
     * 
     * @return type
     */
    public function saveResponse() {
        
        if(!$_POST) {
            App::abort(404);
        }
        
        $input=Input::all();
        $survey=Survey::find($input['surveyid']);
        $group=Group::find($input['groupid']);
        $user=User::find($input['userid']);
        
        if(is_null($survey) || is_null($group) || is_null($user)) {
            App::abort(404);
        }
        
        $response = New SurveyResponse();
        $response->user_id = $input['userid'];
        $response->group_id = $input['groupid'];
        $response->survey_id = $input['surveyid'];
        $response->type = $input['type'];
        $response->response = serialize($input);
        
        $response->save();
        
        return Redirect::to('play/group/'.$group->id)
                ->with('postmessage',$survey->getPostMessage());
        
    }
    
    public function surveyMessages($id) {
        $survey = Survey::find($id);
        return View::make('survey.prepostmessage')
                ->with('survey',$survey);
    }
    
    public function displayResponse($groupid=4,$userid=0,$surveyType='pre') {
        $surveyResponse='';
        if(!empty($userid)) {
            $surveyResponse = DB::table('survey_response')
                    ->where('user_id',$userid)
                    ->where('group_id',$groupid)
                    ->where('type',$surveyType)
                    ->get();
        } else {
            $surveyResponse = DB::table('survey_response')
                    ->where('group_id',$groupid)
                    ->where('type',$surveyType)
                    ->get();
        }
        
        return View::make('survey.export')
                ->with('surveyResponse',$surveyResponse);
    }

}
