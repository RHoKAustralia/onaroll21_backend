<!DOCTYPE>
<html>
    <head>
        <meta id="viewport" name="viewport" content ="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta http-equiv='cache-control' content='no-cache'>
        <meta http-equiv='expires' content='0'>
        <meta http-equiv="pragma" content="no-cache" />
        <script>
            document.write("<link rel='stylesheet' type ='text/css' href='css/master.css?v=" + Date.now() + "'>");
        </script>
<!--        <link rel="stylesheet" type="text/css" href="css/master.css">-->
        <script src="https://cdn.onesignal.com/sdks/OneSignalSDK.js" async></script>
        <script src="OneSignal.js"></script>
        <link rel="manifest" href="manifest.json">
    </head>
    <body ng-app="oar21">
        <div id="pn-debug" style="display:none">
            <span id="not-supported-message" style="display:none">
                <h2>Please update your browser to Chrome version 42 or later to test push notifications!</h2>
            </span>
            <span id="registerForPushSpan" style="display:none">
                <button id="registerForPushButton">Register</button>
            </span>
            <button id="getIds">Get IDs</button>
            <button id="sendTag">Send Tag</button> Key:<input id="tagKey" type="TEXT" size="10"> Value:<input id="tagValue" type="TEXT" size="10">
            <button id="getTags">Get Tags</button>

            <p>Use the JavaScript Console (Menu>More tools>JavaScript console) on this page as well as the chrome://serviceworker-internals/ page to debug any issues.</p>
            <textarea id="console" type="TEXT" readonly style="width:100%;height:250px;"></textarea>
        </div>
<!--        <div id="page-loader">-->
<!--            <div class="preloader-wrapper active">-->
<!--                <div class="spinner-layer spinner-blue-only">-->
<!--                    <div class="circle-clipper left">-->
<!--                        <div class="circle"></div>-->
<!--                    </div><div class="gap-patch">-->
<!--                        <div class="circle"></div>-->
<!--                    </div><div class="circle-clipper right">-->
<!--                        <div class="circle"></div>-->
<!--                    </div>-->
<!--                </div>-->
<!--            </div>-->
<!--        </div>-->

        <div ng-controller="MainCtrl as main">
            <page-header ng-hide="noHeader"></page-header>
            <notification-cont></notification-cont>
            <side-menu ng-hide="noHeader"></side-menu>
            <group-users ng-hide="noHeader"></group-users>
            <div ng-view></div>
            <a ng-click="closeSideMenu()" class="side-menu-layer"></a>
            <div id="transparent-cover" class="popup-inactive"></div>
            <span id="cover-close-btn" class="popup-inactive white-text" ng-click="togglePopup('active')">Close</span>
        </div>
        <script>
            document.write("<script type='text/javascript' src='js/libraries-min.js?v=" + Date.now() + "'><\/script>");
            document.write("<script type='text/javascript' src='js/non_bower_components/three.min.js?v=" + Date.now() + "'><\/script>");
            document.write("<script type='text/javascript' src='js/non_bower_components/dice.js?v=" + Date.now() + "'><\/script>");
            document.write("<script type='text/javascript' src='scripts/app-min.js?v=" + Date.now() + "'><\/script>");
            document.write("<script type='text/javascript' src='scripts/script.js?v=" + Date.now() + "'><\/script>");
        </script>
<!--        <script src="js/libraries-min.js"></script>-->
<!--        <script src="js/non_bower_components/three.min.js"></script>-->
<!--        <script src="js/non_bower_components/dice.js"></script>-->
<!--        <script src="scripts/app-min.js"></script>-->
<!--        <script src="scripts/script.js"></script>-->
<!--        <script src="scripts/angular-upload.js"></script>-->
<!--        <script src="scripts/services/authenticationService.js"></script>-->
<!--        <script src="scripts/services/globalService.js"></script>-->
<!--        <script src="scripts/services/dropDownService.js"></script>-->
<!--        <script src="scripts/services/flashService.js"></script>-->
<!--        <script src="scripts/services/sessionService.js"></script>-->
<!--        <script src="scripts/services/APICallService.js"></script>-->

<!--        <script src="scripts/filters/filters.js"></script>-->
<!--        <script src="scripts/controllers/login.js"></script>-->
<!--        <script src="scripts/controllers/bypasslogin.js"></script>-->
<!--        <script src="scripts/controllers/SignUpController.js"></script>-->
<!--        <script src="scripts/controllers/main.js"></script>-->
<!--        <script src="scripts/controllers/journal.js"></script>-->
<!--        <script src="scripts/controllers/dice.js"></script>-->
<!--        <script src="scripts/controllers/mission.js"></script>-->
<!--        <script src="scripts/controllers/message.js"></script>-->
<!--        <script src="scripts/controllers/messageSelectGroup.js"></script>-->
<!--        <script src="scripts/controllers/messageSelectUser.js"></script>-->
<!--        <script src="scripts/controllers/messageView.js"></script>-->
<!--        <script src="scripts/controllers/groupMessage.js"></script>-->
<!--        <script src="scripts/controllers/wall.js"></script>-->
<!--        <script src="scripts/controllers/posts.js"></script>-->
<!--        <script src="scripts/controllers/survey.js"></script>-->
<!--        <script src="scripts/controllers/supportTicket.js"></script>-->
<!--        <script src="scripts/controllers/howto.js"></script>-->
<!--        <script src="scripts/controllers/notificationAdminController.js"></script>-->
<!--        <script src="scripts/controllers/accountSettingsController.js"></script>-->
<!--        <script src="scripts/controllers/notificationController.js"></script>-->
<!--        <script src="scripts/controllers/mood.js"></script>-->
<!--        <script src="scripts/controllers/support.js"></script>-->
<!--        <script src="scripts/controllers/legal.js"></script>-->
<!--        <script src="scripts/controllers/howtoOutside.js"></script>-->
<!--        <script src="scripts/controllers/missionsCompleted.js"></script>-->
<!--        <script src="scripts/controllers/groupmessagelist.js"></script>-->

<!--        <script src="js/new/TweenLite.min.js"></script>-->
<!--        <script src="js/new/EasePack.min.js"></script>-->
<!--        <script src="js/new/processing.min.js"></script>-->
<!--        <script src="js/new/tagcloud.jquery.js"></script>-->
<!--        <script src="js/new/freewall.js"></script>-->
<!--        <script src="js/new/animations_test.js"></script>-->

        
<!--        <script src="scripts/controllers/postNewController.js"></script>-->
<!--        <script src="scripts/controllers/postAsController.js"></script>-->
<!--        <script src="scripts/controllers/preSurveyController.js"></script>-->
<!--        <script src="scripts/controllers/postSurveyController.js"></script>-->


<!--        <script src="js/css_browser_selector.js"></script>-->
<!--        <script type="text/javascript" src="js/jquery.modal.min.js"></script>-->
<!--        <script src="js/browser-detect-alert.js"></script>-->
        
        
		
		<script>
		$(document).ready(function() {
            document.body.style.webkitTouchCallout='none';
        });
        $(document).keypress(function(event)
		{
		    if(String.fromCharCode(event.which) == "∂" || String.fromCharCode(event.which) == "*")
		    {
		    	//
		    	if($("#pn-debug").css("display") == "none")
		    	{
		    		$("#pn-debug").css("display", "block");
		    	}
		    	else $("#pn-debug").css("display", "none");
		    }
		 })
		</script>
	<?php
		if (!App::environment('production'))
		{
			echo '<div style="position:absolute;top:0px;left:0;color: #fff;z-index: 1000;text-align:center;width:100%;font-weight: bold;background-color: rgba(0,0,0,0.4);">Environment - '.App::environment().'</div>';
		}
	?>
    </body>


    <script type="text/javascript">
    
    function isIE () {
      var myNav = navigator.userAgent.toLowerCase();
      return (myNav.indexOf('msie') != -1) ? parseInt(myNav.split('msie')[1]) : false;
    }


    var isIE = isIE();

    if (isIE){
        location.href = "#IEDetected";
    }

    </script>
</html>




























