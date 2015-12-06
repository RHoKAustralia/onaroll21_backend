/*!
 *  Lang.js for Laravel localization in JavaScript.
 *
 *  @version 1.0.2
 *  @license MIT
 *  @site    https://github.com/rmariuzzo/Laravel-JS-Localization
 *  @author  rmariuzzo
 */

'use strict';

(function(root, factory) {

    if (typeof define === 'function' && define.amd) {
        // AMD support.
        define([], factory);
    } else if (typeof exports === 'object') {
        // NodeJS support.
        module.exports = new(factory())();
    } else {
        // Browser global support.
        root.Lang = new(factory())();
    }

}(this, function() {

    // Default options //

    var defaults = {
        defaultLocale: 'en' /** The default locale if not set. */
    };

    // Constructor //

    var Lang = function(options) {
        options = options || {};
        this.defaultLocale = options.defaultLocale || defaults.defaultLocale;
    };

    // Methods //

    /**
     * Set messages source.
     *
     * @param messages {object} The messages source.
     *
     * @return void
     */
    Lang.prototype.setMessages = function(messages) {
        this.messages = messages;
    };

    /**
     * Returns a translation message.
     *
     * @param key {string} The key of the message.
     * @param replacements {object} The replacements to be done in the message.
     *
     * @return {string} The translation message, if not found the given key.
     */
    Lang.prototype.get = function(key, replacements) {
        if (!this.has(key)) {
            return key;
        }

        var message = this._getMessage(key, replacements);
        if (message === null) {
            return key;
        }

        if (replacements) {
            message = this._applyReplacements(message, replacements);
        }

        return message;
    };

    /**
     * Returns true if the key is defined on the messages source.
     *
     * @param key {string} The key of the message.
     *
     * @return {boolean} true if the given key is defined on the messages source, otherwise false.
     */
    Lang.prototype.has = function(key) {
        if (typeof key !== 'string' || !this.messages) {
            return false;
        }
        return this._getMessage(key) !== null;
    };

    /**
     * Gets the plural or singular form of the message specified based on an integer value.
     *
     * @param key {string} The key of the message.
     * @param count {integer} The number of elements.
     * @param replacements {object} The replacements to be done in the message.
     *
     * @return {string} The translation message according to an integer value.
     */
    Lang.prototype.choice = function(key, count, replacements) {
        // Set default values for parameters replace and locale
        replacements = typeof replacements !== 'undefined' ? replacements : [];

        // Message to get the plural or singular
        var message = this.get(key, replacements);

        // Check if message is not null or undefined
        if (message === null || message === undefined) {
            return message;
        }

        // Separate the plural from the singular, if any
        var messageParts = message.split('|');

        // Get the explicit rules, If any
        var explicitRules = [];
        var regex = /{\d+}\s(.+)|\[\d+,\d+\]\s(.+)|\[\d+,Inf\]\s(.+)/;

        for (var i = 0; i < messageParts.length; i++) {
            messageParts[i] = messageParts[i].trim();

            if (regex.test(messageParts[i])) {
                var messageSpaceSplit = messageParts[i].split(/\s/);
                explicitRules.push(messageSpaceSplit.shift());
                messageParts[i] = messageSpaceSplit.join(' ');
            }
        }

        // Check if there's only one message
        if (messageParts.length === 1) {
            // Nothing to do here
            return message;
        }

        // Check the explicit rules
        for (var i = 0; i < explicitRules.length; i++) {
            if (this._testInterval(count, explicitRules[i])) {
                return messageParts[i];
            }
        }

        // Standard rules
        if (count > 1) {
            return messageParts[1];
        } else {
            return messageParts[0];
        }
    };

    /**
     * Set the current locale.
     *
     * @param locale {string} The locale to set.
     *
     * @return void
     */
    Lang.prototype.setLocale = function(locale) {
        this.locale = locale;
    };

    /**
     * Get the current locale.
     *
     * @return {string} The current locale.
     */
    Lang.prototype.getLocale = function() {
        return this.locale || this.defaultLocale;
    };

    /**
     * Parse a message key into components.
     *
     * @param key {string} The message key to parse.
     *
     * @return {object} A key object with source and entries properties.
     */
    Lang.prototype._parseKey = function(key) {
        if (typeof key !== 'string') {
            return null;
        }
        var segments = key.split('.');
        return {
            source: this.getLocale() + '.' + segments[0],
            entries: segments.slice(1)
        };
    };

    /**
     * Returns a translation message. Use `Lang.get()` method instead, this methods assumes the key exists.
     *
     * @param key {string} The key of the message.
     *
     * @return {string} The translation message for the given key.
     */
    Lang.prototype._getMessage = function(key) {

        key = this._parseKey(key);

        // Ensure message source exists.
        if (this.messages[key.source] === undefined) {
            return null;
        }

        // Get message text.
        var message = this.messages[key.source];
        while (key.entries.length && (message = message[key.entries.shift()]));

        if (typeof message !== 'string') {
            return null;
        }

        return message;
    };

    /**
     * Apply replacements to a string message containing placeholders.
     *
     * @param message {string} The text message.
     * @param replacements {object} The replacements to be done in the message.
     *
     * @return {string} The string message with replacements applied.
     */
    Lang.prototype._applyReplacements = function(message, replacements) {
        for (var replace in replacements) {
            message = message.split(':' + replace).join(replacements[replace]);
        }
        return message;
    };

    /**
     * Checks if the given `count` is within the interval defined by the {string} `interval`
     *
     * @param  count {int}  The amount of items.
     * @param  interval {string}    The interval to be compared with the count.
     * @return {boolean}    Returns true if count is within interval; false otherwise.
     */
    Lang.prototype._testInterval = function(count, interval) {
        /**
         * From the Symfony\Component\Translation\Interval Docs
         *
         * Tests if a given number belongs to a given math interval.
         * An interval can represent a finite set of numbers: {1,2,3,4}
         * An interval can represent numbers between two numbers: [1, +Inf] ]-1,2[
         * The left delimiter can be [ (inclusive) or ] (exclusive).
         * The right delimiter can be [ (exclusive) or ] (inclusive).
         * Beside numbers, you can use -Inf and +Inf for the infinite.
         */

        return false;
    };

    return Lang;

}));


(function(root) {
    Lang.setMessages({"en.capabilities":{"site\/members:view":"View all site members","site\/members:search":"Search site members","site\/members:message":"Message a member","site\/alarm:view":"View alarm","site\/alarm:update":"Update alarm","site\/group:join":"Join group","site\/group:leave":"Leave group","site\/bugs:report":"Report bugs","site\/language:choose":"Choose language","site\/user:add":"Add user","site\/user:delete":"Delete user","site\/user:view":"View user","site\/user:search":"Search a user","group\/user:view":"View user profile","group\/user:search":"Search a group","site\/group:add":"Add a group","site\/group:edit":"Edit a group","site\/group:delete":"Delete a group","site\/group:changestart":"Change group start date","site\/group:joinmultiple":"Join multiple groups","":""},"en.dice":{"rollthedice":"Roll","rollagain":"Roll again","yourolled":"You rolled","congyourolled":"Congratulations, you rolled","dicerollintro":"<h3>Play<\/h3>","tasksavebtn":"Accept","todaysactivity":"Today's mission: "},"en.instructions":1,"en.master":{"welcome":"Welcome to On A Roll 21","email":"Email address","username":"Username","firstname":"First name","lastname":"Last name","city":"City","country":"Country","taskname":"Mission name","taskauthor":"Mission author","tasknameholder":"Mission name","taskdescription":"Mission Description","didyouknow":"Did you know","reference":"Reference","password":"Password","organisation":"Organisation","description":"Description","userpicture":"Picture","editbtn":"Edit","suspendbtn":"Suspend","deletebtn":"Delete","addnewuser":"Add a new user","groupname":"Team name","groupdescription":"Team description","groupstartdate":"Start date","grouppicture":"Picture","groupoutcome":"Goal","groupsurvey":"Pre-Survey","grouppostsurvey":"Post-Survey","addgroup":"Add Team","updategroup":"Update Team","managegroup":"Manage Team","addtask":"Add Mission","addnewtask":"Add a new Mission","updatetask":"Update Mission","loginusername":"Username","loginpassword":"Password","loginbtn":"Log in","emptyusername":"Username must be supplied","emptypassword":"Password must be supplied","incorrectlogin":"Oops! We cannot verify the login details. Please try again.","logoutsuccess":"You have been successfully logged out","joingroup":"Join","leavegroup":"Leave","viewgroup":"View Team","outcomename":"Goal name","outcomedescription":"Goal description","addoutcome":"Add Goal","activatebtn":"Activate","updateoutcome":"Update","addbtn":"Add","removebtn":"Remove","addremoveusers":"Add\/Remove users","addnewrole":"Add a new role","adduserbtn":"Add","name":"Name","action":"Action","upbtn":"Up","dwnbtn":"Down","signup":"New to On A Roll 21? :clickhere to get started","clickhere":"Click here","registersuccess":"Your account has been created successfully.","choose":"Choose","sharebtn":"Share","lblstatusbox":"Status:","play":"Play","uploadimage":"Upload image..","sendreminder":"Send request","forgotpasswordtext":"Please enter the email address you submitted at signup so we can send you a unique link where you can reset your password.","emailfromname":"On A Roll 21","comment":"Comment","signupbtn":"Sign up","createaccount":"sign up","unlike":"Unlike","like":"Like","markcomplete":"Mark complete","starttime":"Start date","addrole":"Add role","updaterole":"Update role","markfinalbtn":"Mark final","removefinal":"Remove final mission","fewtasks":"Missions < 21","forgotpassword":"Forgot password?","savesurvey":"Save survey","wellbeingsavebtn":"Accept","addnewsurvey":"Add new survey","nosurveys":"There are no surveys for this Team to complete. Please select \"Add new survey\" if you wish to include.","addfieldsbtn":"Add\/removefields","login":"Log in","noaccount":"Don't have an account?","wanttolearnmore":"Want to learn more?","seehow":"See how On A Roll 21 helps you work better","haveaccount":"Already have an account?","or":"or","resetpassword":"Reset your password","signupheading":"Sign up for On A Roll 21","about":"About On A Roll 21","contact":"Contact Us","businessbenefits":"Business benefits","tos":"Terms of use","privacy":"Privacy policy","report":"Report abuse","register":"Sign up","groupsintro":"<br \/>Hi :name!\n    <br \/><br \/>\n    <p>    \n    Here are the teams that are available for you to join. \n    Simply select \"Join\" to choose which team to play in or \"Leave\" to remove yourself from the team. Select a team name for further team info.<\/p><br \/>","playintro":"<br \/>Hi :name!\n    <br \/><br \/>\n    <p>    \n    You are currently a member of more than one team. Select \"Play\" against the team you want to roll with.<\/p><br \/>","playgroupsintro":"<br \/>Hi :name!\n    <br \/><br \/>\n    <p>    \n    Here are the teams that are available for you to join. \n    Simply select \"Join\" to choose which team to play in or \"Leave\" to remove yourself from the team. Select a team name for further team info.<\/p><br \/>","datejoined":"Date joined:","viewprofile":"Profile","message":"Message","members":"Rollers","membersintro":"<br \/>Hi :name!\n    <br \/><br \/>\n    <p>Here are the rollers that are in your team. Simply select \"Profile\" (or their name) to view a roller. You can send a message to a roller by selecting \"Message\".<\/p>","addagroup":"Add a Team","getstarted":"Get started","sitesettings":"Site settings","assigncapabilities":"Assign capabilities","roll":"Roll","done":"Done","statuspagewelcome":"Hi :name!","homepageintrotop":"On A Roll 21&TRADE; is a digital behaviour change program that helps promote happiness, wellbeing and productivity in 21 days.","homepageintrobottom":"\"Waiting to be happy limits our brain's potential for success, \n                    whereas if we can help cultivate a positive brain \n                    it makes us more motivated, efficient, resilient, creative and productive,\n                    all of which drive improved health outcomes and performance.\" <br \/>- Lisa Mcleod, Clinical Psychologist and On A Roll 21 program inventor","howdidyouroll":"How did you roll?","howtoplay":"How to play","aboutus":"About On A Roll 21","surveypageintrotop":"<h5>Welcome to On A Roll 21!<\/h5>\n        <p>Please complete the following brief survey before your participation in the 21-day program.<\/p>\n","surveypageintrobottom":"The survey has a total of 23 questions, which are all multiple \n        choice with the opportunity for comments at the end. It should take \n        you about 3 to 5 minutes to complete. It is important that you answer \n        each question honestly. Your answers will be treated with strict \n        confidentiality and respect, and will be collated for the sole purpose \n        of understanding the effectiveness of the program\u2019s aims and objectives. \n        Individuals will not be identified in the information submitted. All data \n        derived from this survey will be stored in a database, \n        which is password protected, and can only be accessed \n        by On A Roll 21 program designers.","presurveyhead":"On A Roll 21 Pre-Survey","postsurveyhead":"On A Roll 21 Post-Survey","postsurveypageintrotop":"<h5>Welcome to On A Roll 21!<\/h5>\n        <p>Please complete the following brief survey before your participation in the 21-day program.<\/p>","postsurveypageintrobottom":"The survey has a total of 23 questions, which are all multiple \n        choice with the opportunity for comments at the end. It should take \n        you about 3 to 5 minutes to complete. It is important that you answer \n        each question honestly. Your answers will be treated with strict \n        confidentiality and respect, and will be collated for the sole purpose \n        of understanding the effectiveness of the program\u2019s aims and objectives. \n        Individuals will not be identified in the information submitted. All data \n        derived from this survey will be stored in a database, \n        which is password protected, and can only be accessed \n        by On A Roll 21 program designers.","logoalt":"On A Roll 21 logo","howareyoufeeling":"How are you feeling?","nopresurvey":"It appears that you have not completed the Pre-Survey. Please complete so we can track how you're travelling during On A Roll 21.","commentboxplaceholder":"Write your comment here","wellbeinghistory":"Mood Map","postsurveypopupintro":"Congratulations! You have now reached day 21. One last surprise mission awaits. We ask that you first complete this post-survey to help us track how you progressed during the program. Thank you!","postsurveypopuphead":"Post survey","presurveypopuphead":"Pre survey","day":"Day","daysleft":"Days left","acceptedtasks":"Accepted missions","signupagreement":"By selecting \"create account\" you accept the following <a href=\"\/page\/tos\">terms and conditions<\/a> and our <a href=\"\/page\/privacy\">privacy policy<\/a>","anonymous":"Anonymous","rollername":"Roller name","postsurvey":"Post survey","loading":"Loading...","sendmessage":"Send message","contactthanks":"Thank you. You message has been sent successfully","offender":"Offender","group":"Team","persontoreport":"Person to report","statusareadisabler":"Please roll the dice and accept your mission before posting.","clicktoroll":"  ","currenttask":"<b>Your mission in progress<\/b>","mood_fantastic":"Fantastic","mood_prettygood":"Pretty good","mood_neutral":"Okay","mood_notgreat":"Not great","mood_terrible":"Terrible","mood_sel_message":"Your response will be anonymous and averaged across the team. It will not be visible to other team members.","addanewuser":"Add a new user","updateuser":"Update user","editprofile":"Edit profile","joined":"Joined","addmessagesbtn":"Messages","ok":"OK","thankyou":"Thank you!","helpdesk-faqs":"Helpdesk - FAQs","":""},"en.menu":{"home":"Home","instructions":"Instructions","groups":"Teams","surveys":"Surveys","presurvey":"Pre-survey","postsurvey":"Post-survey","play":"Play","users":"Users","manageusers":"Manage users","addauser":"Add a user","creategroup":"Create team","tasks":"Missions","createnewtask":"Create new mission","managetasks":"Manage missions","createnewoutcome":"Create new goal","manageoutcomes":"Manage goals","options":"Options","logout":"Log out","editprofile":"Update profile","viewprofile":"View profile","managegroups":"Manage teams","outcomes":"Goals","roles":"Roles","assignroles":"Assign roles","managesurveys":"Manage surveys","addsurvey":"Add survey","roll":"Roll!","getstarted":"Get started","howtoplay":"How to play On A Roll 21","sitesettings":"Site settings","assigncapabilities":"Assign capabilities","messages":"Messages","language":"Language","profile":"Profile","settings":"Settings","":""},"en.pagination":{"previous":"&laquo; Previous","next":"Next &raquo;"},"en.profile":{"team":"Team:","motto":"Motto:","phone":"Ph:","email":"Work email:","contact":"Contact:","stats":"Stats:","messages":"Messages:","taskscompleted":"Missions completed:","joined":"Joined:","terrible":"Terrible","notgreat":"Not great","prettygood":"Pretty good","fantastic":"Fantastic","neutral":"Okay","":""},"en.reminders":{"password":"Passwords must be at least six characters and match the confirmation.","user":"We can't find a user with that email address.","token":"This password reset token is invalid.","sent":"Password reminder sent!","reset":"Password reset successful!"},"en.reports":{"logs":"User logs","firstlogin":"First login","lastlogin":"Last login"},"en.survey":{"welcomeheading":"<h3>Welcome to On A Roll 21!<\/h3>","presurveyintro":"<p>Please complete the following brief survey <b>before<\/b> your \n                        participation in the 21-day program.<\/p>\n                    <p>The survey has a total of 23 questions, which are all \n                    multiple choice with the opportunity for comments at the end. \n                    It should take you about 3 to 5 minutes to complete. It is \n                    important that you answer each question honestly. Your answers\n                    will be treated with strict confidentiality and respect, and \n                    will be collated for the sole purpose of understanding the \n                    effectiveness of the program\u2019s aims and objectives. Individuals \n                    will not be identified in the information submitted. All data \n                    derived from this survey will be stored in a database, \n                    which is password protected, and can only be accessed \n                    by En Masse program designers.<\/p>","pre_gender":"Gender","pre_age":"Age","pre_employmenttype":"Employment type","pre_fulltime":"Full time","pre_parttime":"Part time","pre_selfemployed":"Self employed","pre_contract":"Contract","surveyintro":"Survey introduction","surveyconclusion":"Survey conclusion","savemsgbtn":"Save","updatesurveybtn":"Update survey","postmodalmessage":"","prepostmessageheading":"Survey Introduction and conclusion messages","":""},"en.validation":{"accepted":"The :attribute must be accepted.","active_url":"The :attribute is not a valid URL.","after":"The :attribute must be a date after :date.","alpha":"The :attribute may only contain letters.","alpha_dash":"The :attribute may only contain letters, numbers, and dashes.","alpha_num":"The :attribute may only contain letters and numbers.","array":"The :attribute must be an array.","before":"The :attribute must be a date before :date.","between":{"numeric":"The :attribute must be between :min and :max.","file":"The :attribute must be between :min and :max kilobytes.","string":"The :attribute must be between :min and :max characters.","array":"The :attribute must have between :min and :max items."},"confirmed":"The :attribute confirmation does not match.","date":"The :attribute is not a valid date.","date_format":"The :attribute does not match the format :format.","different":"The :attribute and :other must be different.","digits":"The :attribute must be :digits digits.","digits_between":"The :attribute must be between :min and :max digits.","email":"The :attribute format is invalid.","exists":"The selected :attribute is invalid.","image":"The :attribute must be an image.","in":"The selected :attribute is invalid.","integer":"The :attribute must be an integer.","ip":"The :attribute must be a valid IP address.","max":{"numeric":"The :attribute may not be greater than :max.","file":"The :attribute may not be greater than :max kilobytes.","string":"The :attribute may not be greater than :max characters.","array":"The :attribute may not have more than :max items."},"mimes":"The :attribute must be a file of type: :values.","min":{"numeric":"The :attribute must be at least :min.","file":"The :attribute must be at least :min kilobytes.","string":"The :attribute must be at least :min characters.","array":"The :attribute must have at least :min items."},"not_in":"The selected :attribute is invalid.","numeric":"The :attribute must be a number.","regex":"The :attribute format is invalid.","required":"The :attribute field is required.","required_if":"The :attribute field is required when :other is :value.","required_with":"The :attribute field is required when :values is present.","required_without":"The :attribute field is required when :values is not present.","same":"The :attribute and :other must match.","size":{"numeric":"The :attribute must be :size.","file":"The :attribute must be :size kilobytes.","string":"The :attribute must be :size characters.","array":"The :attribute must contain :size items."},"unique":"The :attribute has already been taken.","url":"The :attribute format is invalid.","recaptcha":"The :attribute field is not correct.","custom":[],"attributes":[]},"es.capabilities":{"site\/members:view":"View all site members","site\/members:search":"Search site members","site\/members:message":"Message a member","site\/alarm:view":"View alarm","site\/alarm:update":"Update alarm","site\/group:join":"Join group","site\/group:leave":"Leave group","site\/bugs:report":"Report bugs","site\/language:choose":"Choose language","site\/user:add":"Add user","site\/user:delete":"Delete user","site\/user:view":"View user","site\/user:search":"Search a user","group\/user:view":"View user profile","group\/user:search":"Search a group","site\/group:add":"Add a group","site\/group:edit":"Edit a group","site\/group:delete":"Delete a group","site\/group:changestart":"Change group start date","site\/group:joinmultiple":"Join multiple groups","":""},"es.dice":{"rollthedice":"Roll","rollagain":"Roll again","yourolled":"You rolled","congyourolled":"Congratulations, you rolled","dicerollintro":"<h3>Play<\/h3>","tasksavebtn":"Accept","todaysactivity":"Today's mission: "},"es.instructions":1,"es.master":{"welcome":"Welcome to On A Roll 21","email":"Email address","username":"Username","firstname":"First name","lastname":"Last name","city":"City","country":"Country","taskname":"Mission name","taskauthor":"Mission author","tasknameholder":"Mission name","taskdescription":"Mission Description","didyouknow":"Did you know","reference":"Reference","password":"Password","organisation":"Organisation","description":"Description","userpicture":"Picture","editbtn":"Edit","suspendbtn":"Suspend","deletebtn":"Delete","addnewuser":"Add a new user","groupname":"Team name","groupdescription":"Team description","groupstartdate":"Start date","grouppicture":"Picture","groupoutcome":"Goal","addgroup":"Add Team","updategroup":"Update Team","managegroup":"Manage Team","addtask":"Add Mission","addnewtask":"Add a new Mission","updatetask":"Update Mission","loginusername":"Username","loginpassword":"Password","loginbtn":"Log in","emptyusername":"Username must be supplied","emptypassword":"Password must be supplied","incorrectlogin":"Oops! We cannot verify the login details. Please try again.","logoutsuccess":"You have been successfully logged out","joingroup":"Join","leavegroup":"Leave","viewgroup":"View Team","outcomename":"Goal name","outcomedescription":"Goal description","addoutcome":"Add Goal","activatebtn":"Activate","updateoutcome":"Update","addbtn":"Add","removebtn":"Remove","addremoveusers":"Add\/Remove users","addnewrole":"Add a new role","adduserbtn":"Add","name":"Name","action":"Action","upbtn":"Up","dwnbtn":"Down","signup":"New to On A Roll 21? :clickhere to get started","clickhere":"Click here","registersuccess":"Your account has been created successfully.","choose":"Choose","sharebtn":"Share","lblstatusbox":"Status:","play":"Play","uploadimage":"Upload image..","sendreminder":"Send request","forgotpasswordtext":"Please enter the email address you submitted at signup so we can send you a unique link where you can reset your password.","emailfromname":"On A Roll 21","comment":"Comment","signupbtn":"Sign up","createaccount":"sign up","unlike":"Unlike","like":"Like","markcomplete":"Mark complete","starttime":"Start date","addrole":"Add role","updaterole":"Update role","markfinalbtn":"Mark final","removefinal":"Remove final mission","fewtasks":"Missions < 21","forgotpassword":"Forgot password?","savesurvey":"Save survey","wellbeingsavebtn":"Accept","addnewsurvey":"Add new survey","nosurveys":"There are no surveys for this Team to complete. Please select \"Add new survey\" if you wish to include.","addfieldsbtn":"Add\/removefields","login":"Log in","noaccount":"Don't have an account?","wanttolearnmore":"Want to learn more?","seehow":"See how On A Roll 21 helps you work better","haveaccount":"Already have an account?","or":"or","resetpassword":"Reset your password","signupheading":"Sign up for On A Roll 21","about":"About On A Roll 21","contact":"Contact Us","businessbenefits":"Business benefits","tos":"Terms of use","privacy":"Privacy policy","report":"Report abuse","register":"Sign up","groupsintro":"<br \/>Hi :name!\n    <br \/><br \/>\n    <p>    \n    Here are the teams that are available for you to join. \n    Simply select \"Join\" to choose which team to play in or \"Leave\" to remove yourself from the team. Select a team name for further team info.<\/p><br \/>","playintro":"<br \/>Hi :name!\n    <br \/><br \/>\n    <p>    \n    You are currently a member of more than one team. Select \"Play\" against the team you want to roll with.<\/p><br \/>","playgroupsintro":"<br \/>Hi :name!\n    <br \/><br \/>\n    <p>    \n    Here are the teams that are available for you to join. \n    Simply select \"Join\" to choose which team to play in or \"Leave\" to remove yourself from the team. Select a team name for further team info.<\/p><br \/>","datejoined":"Date joined:","viewprofile":"Profile","message":"Message","members":"Rollers","membersintro":"<br \/>Hi :name!\n    <br \/><br \/>\n    <p>Here are the rollers that are in your team. Simply select \"Profile\" (or their name) to view a roller. You can send a message to a roller by selecting \"Message\".<\/p>","addagroup":"Add a Team","getstarted":"Get started","sitesettings":"Site settings","assigncapabilities":"Assign capabilities","roll":"Roll","done":"Done","statuspagewelcome":"Hi :name!","homepageintrotop":"On A Roll 21&TRADE; is a digital behaviour change program that helps promote happiness, wellbeing and productivity in 21 days.","homepageintrobottom":"\"Waiting to be happy limits our brain's potential for success, \n                    whereas if we can help cultivate a positive brain \n                    it makes us more motivated, efficient, resilient, creative and productive,\n                    all of which drive improved health outcomes and performance.\" <br \/>- Lisa Mcleod, Clinical Psychologist and On A Roll 21 program inventor","howdidyouroll":"How did you roll?","howtoplay":"How to play","aboutus":"About On A Roll 21","surveypageintrotop":"<h5>Welcome to On A Roll 21!<\/h5>\n        <p>Please complete the following brief survey before your participation in the 21-day program.<\/p>\n","surveypageintrobottom":"The survey has a total of 23 questions, which are all multiple \n        choice with the opportunity for comments at the end. It should take \n        you about 3 to 5 minutes to complete. It is important that you answer \n        each question honestly. Your answers will be treated with strict \n        confidentiality and respect, and will be collated for the sole purpose \n        of understanding the effectiveness of the program\u2019s aims and objectives. \n        Individuals will not be identified in the information submitted. All data \n        derived from this survey will be stored in a database, \n        which is password protected, and can only be accessed \n        by On A Roll 21 program designers.","presurveyhead":"On A Roll 21 Pre-Survey","postsurveyhead":"On A Roll 21 Post-Survey","postsurveypageintrotop":"<h5>Welcome to On A Roll 21!<\/h5>\n        <p>Please complete the following brief survey before your participation in the 21-day program.<\/p>","postsurveypageintrobottom":"The survey has a total of 23 questions, which are all multiple \n        choice with the opportunity for comments at the end. It should take \n        you about 3 to 5 minutes to complete. It is important that you answer \n        each question honestly. Your answers will be treated with strict \n        confidentiality and respect, and will be collated for the sole purpose \n        of understanding the effectiveness of the program\u2019s aims and objectives. \n        Individuals will not be identified in the information submitted. All data \n        derived from this survey will be stored in a database, \n        which is password protected, and can only be accessed \n        by On A Roll 21 program designers.","logoalt":"On A Roll 21 logo","howareyoufeeling":"How are you feeling?","nopresurvey":"It appears that you have not completed the Pre-Survey. Please complete so we can track how you're travelling during On A Roll 21.","commentboxplaceholder":"Write your comment here","wellbeinghistory":"Mood Map","postsurveypopupintro":"This is where we will put the post survey intro will be explaining what happens after the post survey","postsurveypopuphead":"Post survey","presurveypopuphead":"Pre survey","day":"Day","daysleft":"Days left","acceptedtasks":"Accepted missions","signupagreement":"By selecting \"create account\" you accept the following <a href=\"\/page\/tos\">terms and conditions<\/a> and our <a href=\"\/page\/privacy\">privacy policy<\/a>","anonymous":"Anonymous","rollername":"Roller name","postsurvey":"Post survey","loading":"Loading...","sendmessage":"Send message","contactthanks":"Thank you. You message has been sent successfully","offender":"Offender","group":"Team","persontoreport":"Person to report","statusareadisabler":"Please roll the dice and accept your mission before posting.","clicktoroll":"  ","currenttask":"<b>Your mission in progress<\/b>","mood_fantastic":"Fantastic","mood_prettygood":"Pretty good","mood_neutral":"Okay","mood_notgreat":"Not great","mood_terrible":"Terrible","mood_sel_message":"Your response will be anonymous and averaged across the team. It will not be visible to other team members.","addanewuser":"Add a new user","updateuser":"Update user","editprofile":"Edit profile","joined":"Joined","":""},"es.menu":{"home":"Home","instructions":"Instructions","groups":"Teams","surveys":"Surveys","presurvey":"Pre-survey","postsurvey":"Post-survey","play":"Play","users":"Users","manageusers":"Manage users","addauser":"Add a user","creategroup":"Create team","tasks":"Missions","createnewtask":"Create new mission","managetasks":"Manage missions","createnewoutcome":"Create new goal","manageoutcomes":"Manage goals","options":"Options","logout":"Log out","editprofile":"Update profile","viewprofile":"View profile","managegroups":"Manage teams","outcomes":"Goals","roles":"Roles","assignroles":"Assign roles","managesurveys":"Manage surveys","addsurvey":"Add survey","roll":"Roll!","getstarted":"Get started","howtoplay":"How to play On A Roll 21","sitesettings":"Site settings","assigncapabilities":"Assign capabilities","messages":"Messages","language":"Language","profile":"Profile","settings":"Settings","":""},"es.pagination":{"previous":"&laquo; Previous","next":"Next &raquo;"},"es.profile":{"team":"Team:","motto":"Motto:","phone":"Ph:","email":"Work email:","contact":"Contact:","stats":"Stats:","messages":"Messages:","taskscompleted":"Missions completed:","joined":"Joined:","terrible":"Terrible","notgreat":"Not great","prettygood":"Pretty good","fantastic":"Fantastic","neutral":"Okay","":""},"es.reminders":{"password":"Passwords must be at least six characters and match the confirmation.","user":"We can't find a user with that email address.","token":"This password reset token is invalid.","sent":"Password reminder sent!"},"es.survey":{"welcomeheading":"<h3>Welcome to On A Roll 21!<\/h3>","presurveyintro":"<p>Please complete the following brief survey <b>before<\/b> your \n                        participation in the 21-day program.<\/p>\n                    <p>The survey has a total of 23 questions, which are all \n                    multiple choice with the opportunity for comments at the end. \n                    It should take you about 3 to 5 minutes to complete. It is \n                    important that you answer each question honestly. Your answers\n                    will be treated with strict confidentiality and respect, and \n                    will be collated for the sole purpose of understanding the \n                    effectiveness of the program\u2019s aims and objectives. Individuals \n                    will not be identified in the information submitted. All data \n                    derived from this survey will be stored in a database, \n                    which is password protected, and can only be accessed \n                    by En Masse program designers.<\/p>","pre_gender":"Gender","pre_age":"Age","pre_employmenttype":"Employment type","pre_fulltime":"Full time","pre_parttime":"Part time","pre_selfemployed":"Self employed","pre_contract":"Contract","":""},"es.validation":{"accepted":"The :attribute must be accepted.","active_url":"The :attribute is not a valid URL.","after":"The :attribute must be a date after :date.","alpha":"The :attribute may only contain letters.","alpha_dash":"The :attribute may only contain letters, numbers, and dashes.","alpha_num":"The :attribute may only contain letters and numbers.","array":"The :attribute must be an array.","before":"The :attribute must be a date before :date.","between":{"numeric":"The :attribute must be between :min and :max.","file":"The :attribute must be between :min and :max kilobytes.","string":"The :attribute must be between :min and :max characters.","array":"The :attribute must have between :min and :max items."},"confirmed":"The :attribute confirmation does not match.","date":"The :attribute is not a valid date.","date_format":"The :attribute does not match the format :format.","different":"The :attribute and :other must be different.","digits":"The :attribute must be :digits digits.","digits_between":"The :attribute must be between :min and :max digits.","email":"The :attribute format is invalid.","exists":"The selected :attribute is invalid.","image":"The :attribute must be an image.","in":"The selected :attribute is invalid.","integer":"The :attribute must be an integer.","ip":"The :attribute must be a valid IP address.","max":{"numeric":"The :attribute may not be greater than :max.","file":"The :attribute may not be greater than :max kilobytes.","string":"The :attribute may not be greater than :max characters.","array":"The :attribute may not have more than :max items."},"mimes":"The :attribute must be a file of type: :values.","min":{"numeric":"The :attribute must be at least :min.","file":"The :attribute must be at least :min kilobytes.","string":"The :attribute must be at least :min characters.","array":"The :attribute must have at least :min items."},"not_in":"The selected :attribute is invalid.","numeric":"The :attribute must be a number.","regex":"The :attribute format is invalid.","required":"The :attribute field is required.","required_if":"The :attribute field is required when :other is :value.","required_with":"The :attribute field is required when :values is present.","required_without":"The :attribute field is required when :values is not present.","same":"The :attribute and :other must match.","size":{"numeric":"The :attribute must be :size.","file":"The :attribute must be :size kilobytes.","string":"The :attribute must be :size characters.","array":"The :attribute must contain :size items."},"unique":"The :attribute has already been taken.","url":"The :attribute format is invalid.","recaptcha":"The :attribute field is not correct.","custom":[],"attributes":[]}});
})(window);
