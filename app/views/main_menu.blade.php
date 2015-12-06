<div class="container">
        <div class="navbar navbar-onaroll navbar-fixed-top" role="navigation">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="/">On A Roll 21</a>
            </div>
            <div class="navbar-collapse collapse">
              @if(Auth::check())
                <ul class="nav navbar-nav">
                      <li><a href="/">{{ trans('menu.home') }}</a></li>
                      <li><a href="/instructions">{{ trans('menu.instructions') }}</a></li>
                      <li><a href="/groups">{{ trans('menu.groups') }}</a></li>
                      <li class="dropdown">
                          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                              {{ trans('menu.surveys') }}
                              <b class="caret"></b>
                          </a>
                          <ul class="dropdown-menu">
                              <li><a href="/survey/pre">{{ trans('menu.presurvey') }}</a></li>
                              <li><a href="/survey/post">{{ trans('menu.postsurvey') }}</a></li>
                          </ul>
                      </li>
                      <li><a href="/play">{{ trans('menu.play') }}</a></li>
                </ul>
                
                    <ul class="nav navbar-nav pull-right">
                        <li>
                            
                            @if(empty(Auth::user()->picture))
                            <img data-src="holder.js/45x45" alt="user image" 
                                 class="user-image img-circle" width="45px" 
                                 height="45px" />
                            @else
                            <img src="{{ base64_decode(Auth::user()->picture) }}" alt="user image" 
                                 class="user-image img-circle" width="45px" 
                                 height="45px" />
                            @endif
                        </li>
                    
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <span class="glyphicon glyphicon-cog"></span>
                            <b class="caret">
                            </b>
                        </a>
                      <ul class="dropdown-menu">
                          @if(Auth::user()->hasRole('admin'))
                            <li class="dropdown-header">{{ trans('menu.users') }}</li>
                            <li><a href="/users/manage">{{ trans('menu.manageusers') }}</a></li>
                            <li><a href="/user/add">{{ trans('menu.addauser') }}</a></li>
                            <li class="divider"></li>                        
                            <li class="dropdown-header">{{ trans('menu.groups') }}</li>
                            <li><a href="/groups/manage">{{ trans('menu.managegroups') }}</a></li>
                            <li><a href="/group/add">{{ trans('menu.creategroup') }}</a></li>
                            <li class="divider"></li>
                            <li class="dropdown-header">{{ trans('menu.tasks') }}</li>
                            <li><a href="/task/add">{{ trans('menu.createnewtask') }}</a></li>
                            <li><a href="/tasks/manage">{{ trans('menu.managetasks') }}</a></li>
                             <li class="divider"></li>
                            <li class="dropdown-header">{{ trans('menu.outcomes') }}</li>
                            <li><a href="/outcome/add">{{ trans('menu.createnewoutcome') }}</a></li>
                            <li><a href="/outcomes">{{ trans('menu.manageoutcomes') }}</a></li>
                            <li class="divider"></li>
                            <li class="dropdown-header">{{ trans('menu.roles') }}</li>
                            <li><a href="/roles">{{ trans('menu.assignroles') }}</a></li>
                            <li class="divider"></li>
                            <li class="dropdown-header">{{ trans('menu.surveys') }}</li>
                            <li><a href="/surveys">{{ trans('menu.managesurveys') }}</a></li>
                            <li><a href="/survey/add">{{ trans('menu.addsurvey') }}</a></li>
                            <li class="divider"></li>
                          @endif
                        <li class="dropdown-header">{{ trans('menu.options') }}</li>
                        <li><a href="/user/profile/view">{{ trans('menu.viewprofile') }}</a></li>
                        <li><a href="/user/profile/edit">{{ trans('menu.editprofile') }}</a></li>
                        <li><a href="/logout">{{ trans('menu.logout') }}</a></li>
                      </ul>
                    </li>
                    </ul>
                @endif
                
            </div>
          </div>
        </div>

      </div>