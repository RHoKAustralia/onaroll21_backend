<input type="checkbox" name="handler-left" class="handler" id="handler-left" onclick="null" />
<div id="menu" style="z-index:0">
    @if(Auth::check())
    <div class="slidemenu">
        <div id="profile">
            <img {{ Auth::user()->getPictureSrc('50x50') }} alt="{{ Auth::user()->fullName() }}" width="50px" height="50px" />
            <div class="profile_info"><strong>{{ Auth::user()->fullName() }}</strong><br><small>{{ Settings::getValue('sitetitle') }}</small></div>
        </div>

        <h3>MENU</h3>
        <ul>
            <li><a href="/"><i class="fa fa-home fa-lg"></i> {{ trans('menu.home') }}</a></li>
            <li><a href="/groups"> <i class="fa fa-group fa-lg"></i> {{ t('Groups') }}</a></li>
            <li><a href="/messages" ><i class="glyphicon glyphicon-comment"></i> {{ t('menu.messages') }}</a></li>
            <li><a href="/user/profile/view"><i class="fa fa-user fa-lg"></i> {{ trans('menu.profile') }}</a></li>
            <li>
                <h3><i class="fa fa-play fa-lg"></i> {{ trans('menu.play') }}</h3>
                <ul class="sub-menu">
                    <li>
                        <a href="/play/howtoplay">{{ trans('menu.howtoplay') }}</a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="/play">{{ trans('menu.roll') }}</a>
                    </li>
                </ul>
            </li>
            <li>
                <h3><i class="fa fa-cog fa-lg"></i> SETTINGS</h3>
                <ul class="sub-menu">
                    <li><a href="/user/profile/view">{{ trans('menu.viewprofile') }}</a></li>
                    <li><a href="/user/profile/edit">{{ trans('menu.editprofile') }}</a></li>
                    <li><a href="/logout">{{ trans('menu.logout') }}</a></li>
                </ul>
            </li>
        </ul>
    </div>
    @endif
</div>