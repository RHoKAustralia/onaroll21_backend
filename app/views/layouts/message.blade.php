<!DOCTYPE html>
<html>
    <head>
        <title>{{ Settings::getValue('sitetitle') }}</title>
<!--        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">-->
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0, target-densityDpi=device-dpi" />
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="mobile-web-app-capable" content="yes">
        <link rel="apple-touch-icon" href="/images/android_icon.png">
        <link rel="shortcut icon" sizes="196x196" href="/images/android_icon.png">
        {{ HTML::style('css/bootstrap.min.css') }}
        {{ HTML::style('css/font-awesome.min.css') }}
        {{ HTML::style('css/onaroll21.css') }}
        {{ HTML::style('css/slide_menu.css') }}
        
        <script type="text/javascript">
        var is_ie9_or_newer = false;
        </script>
        <!--[if gte IE 9]>
        <script type="text/javascript">
        is_ie9_or_newer = true;
        </script>
        {{ HTML::script('include/dice/js/three.js') }}
        <![endif]-->
        <![if !IE]>
        <script type="text/javascript">
        is_ie9_or_newer = true;
        </script>
        {{ HTML::script('include/dice/js/three.js') }}
        <![endif]>
        
        <!--[if lt IE 9]>
            {{ HTML::script('https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js') }}
            {{ HTML::script('https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js') }}
        <![endif]-->
    </head>
    <body class="messages">
        @include('menu.slide')
        <div id="wrap">
            <header id="page-header">
                <div class="container">
                    <a href="/">
                    <img class="logo" src="{{ asset('images/logo.png') }}" alt="{{ trans('master.logoalt') }}"/>
                    </a>
                    @include('menu.main')
                </div>
            </header>
            <div class="wrapper">
                <div class="container">
                    <div class="page-content">
                        @yield('sidenav')
                        @yield('content')
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        @include('layouts.footer')
        {{ HTML::script('js/jquery.min.js') }}
        {{ HTML::script('js/bootstrap.min.js') }}
        {{ HTML::script('js/holder.js') }}
        {{ HTML::script('js/onaroll21.js') }}
        {{-- HTML::script('js/status.js') --}}
        <script src="//cdnjs.cloudflare.com/ajax/libs/ckeditor/4.2/ckeditor.js"></script>
        <script type="text/javascript" charset="utf-8">
            $(function() { $('body').hide().show(); });
        </script>
    </body>
</html>
