<div id="dice">
        <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" style="display: none" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="350" height="300" id="externalInterface" align="middle">
            <param name="allowScriptAccess" value="sameDomain" />
            <param name="allowFullScreen" value="false" />
            <param name="movie" value="/include/dice/dice.swf" />
            <param name="quality" value="high" />
            <param name="bgcolor" value="#eeeeee" />
            <param value="transparent" name="wmode" />
            <embed src="/include/dice/dice.swf" quality="high" bgcolor="#eeeeee" width="350" height="300" name="externalInterface" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
          </object>
    {{ HTML::script('http://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenLite.min.js') }}
    {{ HTML::script('http://cdnjs.cloudflare.com/ajax/libs/gsap/latest/easing/EasePack.min.js') }}
    {{ HTML::script('http://cdnjs.cloudflare.com/ajax/libs/gsap/latest/plugins/CSSPlugin.min.js') }}

    {{-- HTML::script('include/dice/js/custom.js') --}}

    <script>
        var groupid={{ $group->id }};
        var userid={{ $user->id }};
        var siteurl={{ "'".url('/')."'" }};
            
        {{-- Load strings for the dice --}}
        var roll_the_dice={{"'".trans('dice.rollthedice')."'"}};
        var roll_again={{"'".trans('dice.rollagain')."'"}};
        var you_rolled_x={{"'".trans('dice.yourolled')."'"}};
        var congratulations_you_rolled_x={{"'".trans('dice.congyourolled')."'"}};
    </script>

    {{ HTML::style('include/dice/css/styles.css') }}
    {{-- HTML::script('include/dice/js/three.js') --}}
    {{ HTML::script('include/dice/js/loadxmldoc.js') }}
    {{ HTML::script('include/dice/js/dice_3.3.js') }}
</div>
