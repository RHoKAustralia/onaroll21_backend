@if(Auth::guest())
<div class="homepage-header-links pull-right">
    {{ HTML::link('/login',strtoupper(trans('master.login'))) }}
    {{-- HTML::link('/register',strtoupper(trans('master.register'))) --}}
</div>
@else
<div class="header-links">
<div class="container">
    <div class="navbar navbar-header">
        <p id="button" class="navbar-toggle">
            <label for="handler-left" id="left" href="#">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </label>
            </p>
    </div>
    <div class="navbar-collapse collapse">
        @if(Auth::check())
        <ul class="nav navbar-nav pull-right">
            <li><a href="/groups" data-toggle="tooltip" data-placement="bottom" title="{{ trans('menu.groups') }}"><i class="fa fa-group fa-lg"></i></a></li>
            <li><a href="/messages" data-toggle="tooltip" data-placement="bottom" title="{{ trans('menu.messages') }}"><i class="glyphicon glyphicon-comment"></i></a></li>
            <li>
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-toggle="tooltip" data-placement="bottom" title="{{ trans('menu.play') }}"><i class="fa fa-play fa-lg"></i></a>
                <ul class="dropdown-menu" role="menu">
                    <li>
                        <a href="/play/howtoplay">{{ trans('menu.howtoplay') }}</a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="/play">{{ trans('menu.roll') }}</a>
                    </li>
                </ul>
            </li>
            <li><a href="/user/profile/view" data-toggle="tooltip" data-placement="bottom" title="{{ trans('menu.profile') }}"><i class="fa fa-user fa-lg"></i></a></li>
            <li>
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-toggle="tooltip" data-placement="bottom" title="{{ trans('menu.settings') }}"><i class="fa fa-cog fa-lg"></i></a>
                <ul class="dropdown-menu" role="menu">
                    @if(Auth::user()->hasRole('admin'))
                    <li><a href="/admin/site">{{ t('menu.sitesettings') }}</a></li>
                    <li><a href="/report/logs">{{ t('reports.logs') }}</a></li>
                    <li><a href="/language">{{ trans('menu.language') }}</a></li>
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
                            <li><a href="/capabilities">{{ trans('menu.assigncapabilities') }}</a></li>
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
@endif