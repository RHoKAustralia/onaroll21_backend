<?php

/**
 * Custom error pages
 */

App::missing(function($exception)
{
    return Response::view('errors.missing', array(), 404);
});

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the Closure to execute when that URI is requested.
|
*/

//Route::any('login','AuthController@requireLogin');
//Route::any('logout','AuthController@logout');
//Route::get('/page/{type}', function($type){
//    $content = Settings::where('name',$type)->pluck('value');
//    $page = new stdClass();
//    $page->heading = trans('master.'.$type);
//    $page->content = $content;
//    return View::make('staticpage')
//            ->with('page',$page)
//            ->with('bodyclass','staticpage');
//})->where(array('type'=>'[a-z-]+'));
//Route::controller('password', 'RemindersController');
Route::get('/mobile','APIController@mobile');


Route::get('/', function(){
    return View::make('index');
});


Route::get('logout','AdminController@adminlogout');


Route::get('/console','AdminController@adminLogin');

Route::post('/console/login','AdminController@adminLoginAction');


Route::group(array('prefix' => 'api'), function() {
    Route::get('/leaderboard/getLeaderBoardStatisticReport','LeaderBoardController@getLeaderBoardStatisticReport');
    Route::get('/leaderboard/getLeaderBoardUserReport','LeaderBoardController@getLeaderBoardUserReport');
    Route::get('/leaderboard/getLeaderBoardData','LeaderBoardController@getLeaderBoardData');
    Route::get('/leaderboard/getTeamImages','LeaderBoardController@getTeamImages');
    Route::get('/email/unsubscribe/{mail}','APIController@emailUnsubscribe')->where(array('mail'=>'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'));
	Route::post('/global/notificationNum','APIController@notificationNum');
    Route::get('/global/isNativeApp','APIController@isNativeApp');
    Route::post('/global/taskCompleted','APIController@taskCompleted');
    Route::get('/global/cron/notificationEmail','EmailController@notificationEmailCron');
    Route::get('/global/cron/suspendEmailWarningCron','EmailController@suspendEmailWarningCron');
    Route::get('/global/cron/accountSuspentionNotificationCron','EmailController@accountSuspentionNotificationCron');
	Route::post('/global/getProgress','APIController@getProgress');
    Route::post('/auth/login','AuthController@apiLogin');
    Route::post('/auth/checkLogin','APIController@apiCheckLogin');
	Route::post('/servcie/signup','APIController@apiSignUp');
    Route::post('/service/forgotpwd','APIController@forgotPwd');
    Route::post('/global/supportFeedback','APIController@supportFeedback');
    Route::post('/message/searchConversationByID','APIController@searchConversationByID');
    Route::post('/message/searchByID','APIController@messageSearchByID');
    Route::post('/global/moodCheckTime','APIController@moodCheckTime');
    Route::post('/service/writePNtoDB','APIController@writePNtoDB');
    
    Route::get('outcome/addMissionAjax','OutcomeController@addMissionAjax');

    /* GROUP MESSAGE */
    Route::post('/service/groupmessage/getConversationList','GroupMessageController@getConversationList');

    Route::post('/service/groupmessage/sendGroupMessage','GroupMessageController@sendMessageToTheGroup');

    Route::post('/service/groupmessage/createNewConversation','GroupMessageController@createNewConversation');

    Route::post('/service/groupmessage/retriveGroupMessage','GroupMessageController@retriveGroupMessage');

    Route::post('/service/groupmessage/addUserToConversation','GroupMessageController@addUserToConversation');

    Route::post('/service/groupmessage/getNotificationStatus','GroupMessageController@getNotificationStatus');

    Route::post('/service/groupmessage/updateNotificationStatus','GroupMessageController@updateNotificationStatus');


    /* END GROUP MESSAGE */

    Route::post('/signup/isEmailExist','APIController@isEmailExist');

    Route::post('/service/writeMobilePNtoDB','APIController@writeMobilePNtoDB');
    Route::post('/service/writePNtoDBPublic','APIController@writePNtoDBPublic');
//  Route::get('/service/testPushNotification','APIController@testPushNotification');
    Route::post('/service/updateDeviceStatus','APIController@updateDeviceStatus');
    Route::get('/service/resizeImagesInsideUploadFolder','APIController@callResizeImagesInsideUploadFolder');

    Route::post('/mission/getPendingTask','APIController@pendingTask');
    Route::group(array('before'=>'apiauth'),function() {
        Route::get('/auth/logout','AuthController@apiLogout');
        Route::post('/group/private/posts','APIController@getPrivatePosts');
        Route::post('/group/posts','APIController@getGroupPosts');
        Route::post('/group/countPosts','APIController@countPosts');
        Route::post('/group/privateposts','APIController@getGroupPrivatePosts');

        

        Route::post('/post/delete','APIController@deletePost');

        
		Route::post('/group/postByID','APIController@getGroupPostByID');
        Route::post('/group/list','APIController@getGroupList');
		Route::post('/group/user','APIController@getUserListByGroupID');
        Route::post('/user/words','APIController@getUserWords');
        Route::post('/user/photos','APIController@getUserImages');
        Route::post('/fetch/currenttask','APIController@getNewTask');
        Route::post('/user/posts','APIController@fetchAllPosts');
        Route::post('/user/acceptmission','APIController@acceptMission');
        Route::post('/add/post','APIController@addPost');
        Route::post('/add/comment','APIController@addComment');
        Route::post('/user/post/like','APIController@updateLike');
        Route::post('/user/wellbeingtracks','APIController@getWellbeingTracks');
        Route::post('/user/survey/complete','APIController@saveSurveyResponse');
        Route::post('/groupMessage/memberList','APIController@groupMessageMemberList');
        Route::post('/notification/removeNotification','APIController@notificationRemove');

        Route::post('/groupMessage/initRoomData','APIController@initRoomData');
        Route::post('/user/survey/completePreSurvey','APIController@completePreSurvey');

        Route::post('/user/mood/update','APIController@updateAPIWellbeing');
        Route::post('/user/taskscore','APIController@updateTaskScore');
        Route::post('/user/update','APIController@updateUserProfile');
        Route::post('/user/feedback','APIController@updateFeedback');

        Route::post('/post/report','APIController@postReport');

        Route::post('/post/fetchPostByID','APIController@fetchPostByID');

        Route::post('/post/submitEditedContent','APIController@submitEditedContent');

        Route::post('/comment/report','APIController@commentReport');
		
		
		Route::post('/message/send','APIController@messageSend');

        Route::post('/groupMessage/send','APIController@groupMessageSend');

        Route::post('/groupMessage/getTheCurrentUserLIst','APIController@getTheCurrentUserLIst');

        Route::post('/groupMessage/messageList','APIController@groupMessageList');

        Route::post('/groupMessage/leaveChat','APIController@groupMessageLeaveChat');

        Route::post('/groupMessage/newMember','APIController@groupMessageNewMember');

        Route::post('/groupMessage/removeMember','APIController@groupMessageremoveMember');

        Route::post('/groupMessage/searchByUserID','APIController@groupMessageSearchByUserID');
		
		Route::post('/global/areAllTasksDone','APIController@areAllTasksDone');
		//Route::post('/global/notificationEmail','APIController@notificationEmail');
		Route::post('/notification/setNotification','APIController@setNotification');
		Route::post('/notification/getNotification','APIController@getNotification');
		Route::post('/notification/getNotificationList','APIController@getNotificationList');
		Route::post('/survey/getSurveyList','APIController@getSurveyList');
		Route::post('/survey/isPresurveyCompleted','APIController@isPresurveyCompleted');
		Route::post('/survey/saveResponse','APIController@saveSResponse');
		Route::post('/mission/detectLastMission','APIController@detectLastMission');
    });
});

Route::group(array('before'=>'auth'),function(){
    Route::get('/instructions', 'HomeController@showInstructions');

    Route::get('users', 'UserController@showAllUsers');
    Route::get('administration',function(){
       return Redirect::to('admin/site');
    });
    Route::get('users/manage','UserController@manageUsers');
    Route::get('user/add','UserController@addUser');
    Route::get('user/show','UserController@showProfile');
    Route::get('user/update','UserController@editUser');
    Route::get('user/edit','UserController@updateUser');
    Route::post('user/add','UserController@addUser');
    Route::post('user/update','UserController@updateUser');
    Route::get('user/profile/view','UserController@showProfile');
    Route::get('user/profile/view/{id}','UserController@showProfile')
            ->where(array('id'=>'[0-9]+'));
    Route::get('user/profile/edit','UserController@editProfile');
    Route::post('user/profile/update','UserController@updateProfile');
    Route::get('user/assignrole','UserController@updateUser');


    Route::get('groups','GroupController@showAllGroups');
    Route::get('groups/manage','GroupController@manageGroups');
    Route::get('group/add','GroupController@addGroup');
    Route::post('group/add','GroupController@addGroup');
    Route::get('group/edit','GroupController@updateGroup');
    Route::post('group/update','GroupController@updateGroup');
    Route::post('group/join','GroupController@joinGroup');
    Route::get('group/users/{id}','GroupController@manageUsers')
            ->where(array('id'=>'[0-9]+'));
    Route::post('group/users','GroupController@groupUsers');
    Route::get('group/members/{id}','GroupController@showMembers')
            ->where(array('id'=>'[0-9]+'));

    Route::get('task/add','TaskController@addTask');
    Route::post('task/add','TaskController@addTask');
    Route::get('tasks/manage','TaskController@manageTask');
    Route::get('task/edit','TaskController@updateTask');
    Route::post('task/update','TaskController@updateTask');

    Route::get('outcomes','OutcomeController@showAllOutcomes');
    Route::get('outcome/add','OutcomeController@addOutcome');
    Route::post('outcome/add','OutcomeController@addOutcome');
    Route::post('outcome/update','OutcomeController@updateOutcome');
    Route::get('outcome/update','OutcomeController@updateOutcome');
    Route::post('outcome/addtask','OutcomeController@addTask');
    Route::get('outcome/addtask','OutcomeController@addTask');

    Route::get('survey/add','SurveyController@addSurvey');
    Route::post('survey/add','SurveyController@addSurvey');
    Route::post('survey/update','SurveyController@updateSurvey');
    Route::get('survey/messages/{id}','SurveyController@surveyMessages')
            ->where(array('id'=>'[0-9]+'));
    Route::post('survey/messages','SurveyController@surveyMessages');
    Route::get('surveys','SurveyController@manageSurveys');
    Route::get('survey/edit/{id}','SurveyController@editSurvey')
            ->where(array('id'=>'[0-9]+'));
    Route::get('survey/fields/{id}','SurveyController@manageFields')
            ->where(array('id'=>'[0-9]+'));
    Route::post('survey/fields/{id}','SurveyController@manageFields')
            ->where(array('id'=>'[0-9]+'));
    Route::post('survey/fields/add/{id}','SurveyController@addFields');
    Route::get('survey/{type}','SurveyController@showSurvey')
            ->where(array('type'=>'[a-z]+'));
    Route::post('survey/{type}','SurveyController@showSurvey')
            ->where(array('type'=>'[a-z]+'));

    Route::post('survey/response/save','SurveyController@saveResponse');
    Route::get('survey/response/export','SurveyController@displayResponse');

    Route::get('play','PlayController@showDice');
    Route::get('play/group/{id}','PlayController@showDice')
            ->where(array('id'=>'[0-9]+'));
    Route::post('play/task/accept','PlayController@acceptTask');
    Route::post('play/task/accept','PlayController@acceptTask');
    Route::get('play/status/{id}','PlayController@showStatusPage')
            ->where(array('id'=>'[0-9]+'));
    Route::get('play/currenttask',function(){
        return Redirect::to('/play');
    });
    Route::post('play/currenttask','PlayController@getCurrentTask');
    Route::post('play/status/post/ajax','PlayController@ajaxStatusPost');
    Route::post('play/status/update/ajax/commentpost','PlayController@ajaxCommentPost');
    Route::post('play/status/update/ajax/commentdelete','PlayController@ajaxCommentDelete');
    Route::post('play/status/update/ajax/updatelike','PlayController@ajaxUpdateLike');

    Route::get('play/test','PlayController@testStatus');
    Route::post('/test/status/update','PlayController@testStatus');
    Route::get('play/status/post','PlayController@postStatus');
    Route::post('play/status/post','PlayController@postStatus');
    Route::post('play/status/update','PlayController@updateStatus');
    Route::get('play/{type}',function($type){
        $content = Settings::where('name',$type)->pluck('value');
        $page = new stdClass();
        $page->heading = trans('master.'.$type);
        $page->content = $content;
        return View::make('staticpage')
                ->with('page',$page);
    })->where(array('type'=>'[a-z]+'));
    Route::post('play/ajax/loadposts','PlayController@loadPosts');
    Route::get('play/ajax/loadposts','PlayController@loadPosts');
    Route::post('/post/delete','PlayController@deletePost');
    Route::post('wellbeing/update','PlayController@updateWellbeing');
    Route::post('/comment/delete','PlayController@deleteComment');


    Route::get('capabilities','RoleController@manageCapabilities');
    Route::post('roles/capability/update','RoleController@manageCapabilities');

    Route::get('messages','MessageController@index');
    Route::get('messages/message/{id}','MessageController@show')
        ->where(array('id'=>'[0-9]+'));
    Route::post('messages/message','MessageController@store');

    /**
     * Report abuse
     */
    Route::get('/report',function(){
        return View::make('contact.report');
    });

    Route::post('/report',function() {
            $data = Input::all();
            $rules = array(
                'name' => 'required',
                'email' => 'required',
                'offender' => 'required',
                'subject' => 'required',
                'group' => 'required',
                'text' => 'required',
                'recaptcha_response_field' => 'required|recaptcha',
            );

            $validator = Validator::make($data, $rules);

            if ($validator->fails()) {
                return Redirect::to('report')
                                ->withInput()
                                ->withErrors($validator);
            } else {
                sendEmail($data,'report');
                return View::make('contact.report')->with('thanks','thanks');
            }
    });
});

/*
 * Registration routes
 */
Route::get('register', array(
    'uses' => 'RegisterController@index',
    'as' => 'register.index'
));
Route::post('register', array(
    'uses' => 'RegisterController@store',
    'as' => 'register.store'
));

/**
 * Admin section users with admin privileges can access this area
 */
Route::group(array('before' => 'admin'), function () {
    // ROLES
    Route::get('roles','RoleController@showAllRoles');
    Route::post('role/update','RoleController@updateRole');
    Route::get('role/manageusers','RoleController@updateRole');
    Route::get('role/add','RoleController@addRole');
    Route::post('role/add','RoleController@addRole');
    Route::get('role/edit/{id}','RoleController@editRole');
    Route::get('admin/site','AdminController@siteSettings');
    Route::post('admin/site','AdminController@siteSettings');
    Route::get('report/logs','ReportsController@showLogs');
});

/**
 * Contact Pages routes
 */

Route::get('/contact',function(){
    return View::make('contact.contactus');
});

Route::post('/contact',function() {
        $data = Input::all();
        $rules = array(
                'name' => 'required',
                'email' => 'required',
                'subject' => 'required',
                'text' => 'required',
                'recaptcha_response_field' => 'required|recaptcha',
            );

        $validator = Validator::make($data, $rules);

        if ($validator->fails()) {
            return Redirect::to('contact')
                            ->withInput()
                            ->withErrors($validator);
        } else {
            sendEmail($data);
            return View::make('contact.contactus')->with('thanks','thanks');
        }
});

Route::get('/test',function(){
    return View::make('test');
});
