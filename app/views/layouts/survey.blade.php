<!DOCTYPE html>
<html>
    <head>
        <title>{{ Settings::getValue('sitetitle') }}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="mobile-web-app-capable" content="yes">
        <link rel="apple-touch-icon" href="/images/android_icon.png">
        <link rel="shortcut icon" sizes="196x196" href="/images/android_icon.png">
        
        {{ HTML::style('bower_components/bootstrap/dist/css/bootstrap.min.css') }}
        {{ HTML::style('bower_components/fontawesome/css/font-awesome.min.css') }}
        {{ HTML::style('css/components/slide_menu.css') }}
        
        
        <script type="text/javascript">
        var is_ie9_or_newer = false;
        </script>
        <!--[if gte IE 9]>
        <script type="text/javascript">
        is_ie9_or_newer = true;
        </script>
        
        <![endif]-->
        <![if !IE]>
        <script type="text/javascript">
        is_ie9_or_newer = true;
        </script>
        
        <![endif]>
        
        <!--[if lt IE 9]>
            {{ HTML::script('https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js') }}
            {{ HTML::script('https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js') }}
        <![endif]-->
    </head>
    <body class="">
        @include('menu.slide')
        <div id="wrap">
            <header id="page-header">
                <div class="container">
                    <a href="/">
                    <img src="{{ asset('images/logo.png') }}" alt="{{ trans('master.logoalt') }}"/>
                    </a>
                    @include('menu.main')
                </div>
            </header>
            <div class="wrapper">
                <div class="container">
                    <div class="page-content">
                        @yield('content')
                    </div>
                </div>
            </div>
        </div>
        <footer id="page-footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-9">
                        {{ HTML::link('/about',trans('master.about')) }} | 
                        {{ HTML::link('/contact',trans('master.contact')) }} |
                        {{ HTML::link('/contact',trans('master.businessbenefits')) }} |
                        {{ HTML::link('/contact',trans('master.tos')) }} |
                        {{ HTML::link('/contact',trans('master.privacy')) }} |
                        {{ HTML::link('/contact',trans('master.report')) }}
                    </div>
                </div>
            </div>
        </footer>
        
        <!--{{ HTML::script('js/parsley.min.js') }}-->
        
        {{ HTML::script('js/libraries-min.js') }}
        {{ HTML::script('scripts/app-min.js') }}
        {{ HTML::script('bower_components/bootstrap/dist/js/bootstrap.min.js') }}
        
        <script src="//cdnjs.cloudflare.com/ajax/libs/ckeditor/4.2/ckeditor.js"></script>
        @yield('extrafootercontent')
        <script type="text/javascript" charset="utf-8">
            $(function() { $('body').hide().show(); });
        </script>
    </body>
</html>


































