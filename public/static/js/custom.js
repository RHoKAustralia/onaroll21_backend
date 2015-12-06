$(function () {
    favorite();
    deleteComment();
    followUnFollow();
    deleteReply();
    reply();
    adminImageApprove();
// timeago js
    var time = $('abbr.timeago');
    time.timeago();
// timeago js ends here

    $("[data-toggle='tooltip']").tooltip();
    $('#dp1').datepicker({
        format: 'yyyy-mm-dd'
    });

});

function reply() {
    var c = $(".replybutton");
    var b = $(".closebutton");
    var a = $(".replytext");
    c.on("click", function () {
        var d = $(this).attr("id");
        $(this).hide();
        $("#open" + d).show();
        a.focus()
    });
    b.on("click", function () {
        var d = $(this).attr("id");
        $("#open" + d).hide();
        c.show()
    });
    $(".replyMainButton").click(function () {
        var e = $(this).attr("id");
        var f = $("#textboxcontent" + e).val();
        var d = "textcontent=" + f + "&reply_msgid=" + e;
        if (f === "") {
            a.stop().css("background-color", "#FFFF9C")
        } else {
            $.ajax({
                type: "POST",
                url: "../../reply",
                data: d,
                success: function (h) {
                    var g = $(h).css("font-weight", "bold");
                    $("#openbox-" + e).after(g);
                    $("#openbox-" + e).hide(300)
                }
            })
        }
        return false
    })
}

function followUnFollow() {
    $(".follow").on("click", function () {
        var c = $(this);
        var b = "id=" + c.attr("id");
        $.ajax({type: "POST", url: "../../follow", data: b, success: function (a) {
            $.when(c.fadeOut(300).promise()).done(function () {
                if (c.hasClass("btn")) {
                    c.removeClass("btn-default").addClass("btn-success").text(a).fadeIn()
                } else {
                    c.replaceWith('<span class="notice_mid_link">' + a + "</span>")
                }
            })
        }});
        return false
    })
}

function adminImageApprove() {
    $(".adminImageApprove").on("click", function () {
        var c = $(this);
        var b = "id=" + c.attr("id");
        $.ajax({type: "POST", url: "../../admin/images/approval", data: b, success: function (a) {
            $.when(c.fadeOut(300).promise()).done(function () {
                if (c.hasClass("btn")) {
                    c.removeClass("btn-default").addClass("btn-success").text(a).fadeIn()
                } else {
                    c.replaceWith('<span class="notice_mid_link">' + a + "</span>")
                }
            })
        }});
        return false
    })
}

function deleteComment() {
    var a = $("button.delete-comment");
    a.on("click", function () {
        var c = $(this);
        var e = c.attr("data-content");
        var b = "id=" + e;
        $.ajax({type: "POST", url: "../../deletecomment", data: b, success: function (d) {
            $("#comment-" + e).hide(500)
        }})
    })
}

function deleteReply() {
    var a = $("button.delete-reply");
    a.on("click", function () {
        var c = $(this);
        var e = c.attr("data-content");
        var b = "id=" + e;
        $.ajax({type: "POST", url: "../../deletereply", data: b, success: function (d) {
            $("#reply-" + e).hide(500)
        }})
    })
}

function favorite() {
    $(".favoritebtn").on("click", function () {
        var c = $(this);
        var b = "id=" + c.attr("id");
        $.ajax({type: "POST", url: "../../favorite", data: b, success: function (a) {
            $.when(c.fadeOut(300).promise()).done(function () {
                if (c.hasClass("btn")) {
                    c.removeClass("btn-default").addClass("btn-success").text(a).fadeIn()
                } else {
                    c.replaceWith('<span class="notice_mid_link">' + a + "</span>")
                }
            })
        }});
        return false
    })
}

function run_pinmarklet() {
    var e = document.createElement('script');
    e.setAttribute('type', 'text/javascript');
    e.setAttribute('charset', 'UTF-8');
    e.setAttribute('src', 'http://assets.pinterest.com/js/pinmarklet.js?r=' + Math.random() * 99999999);
    document.body.appendChild(e);
}
// THEME SWITCHER

window.console=window.console||(function(){var a={};a.log=a.warn=a.debug=a.info=a.error=a.time=a.dir=a.profile=a.clear=a.exception=a.trace=a.assert=function(){};return a})();(function(a){jQuery(document).ready(function(b){b(".default").click(function(){b("#colors").attr("href","/static/css/bootstrap.min.css");return false});b(".one").click(function(){b("#colors").attr("href","/static/css/1.min.css");return false});b(".two").click(function(){b("#colors").attr("href","/static/css/2.min.css");return false});b(".three").click(function(){b("#colors").attr("href","/static/css/bootstrap.min.css");return false});b(".four").click(function(){b("#colors").attr("href","/static/css/4.min.css");return false});b(".five").click(function(){b("#colors").attr("href","/static/css/5.min.css");return false});b("#layout-switcher").on("change",function(){b("#layout").attr("href",b(this).val()+".css")});b("#style-switcher").animate({left:"-154px"});b("#style-switcher h2 a").click(function(c){c.preventDefault();var d=b("#style-switcher");console.log(d.css("left"));if(d.css("left")==="-154px"){b("#style-switcher").animate({left:"0px"})}else{b("#style-switcher").animate({left:"-154px"})}});b(".colors li a").click(function(c){c.preventDefault();b(this).parent().parent().find("a").removeClass("active");b(this).addClass("active")});b(".bg li a").click(function(d){d.preventDefault();b(this).parent().parent().find("a").removeClass("active");b(this).addClass("active");var c=b(this).css("backgroundImage");b("body").css("backgroundImage",c)});b(".bgsolid li a").click(function(d){d.preventDefault();b(this).parent().parent().find("a").removeClass("active");b(this).addClass("active");var c=b(this).css("backgroundColor");b("body").css("backgroundColor",c).css("backgroundImage","none")});b("#reset a").click(function(d){var c=b(this).css("backgroundImage");b("body").css("backgroundImage","url(/sites/all/themes/centum/images/bg/noise.png)")})})})(jQuery);