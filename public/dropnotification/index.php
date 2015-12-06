<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>CSS Drop Down Menus</title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js"></script>
<script type="text/javascript">
$(function() 
{
$(".view_comments").click(function() 
{

var ID = $(this).attr("id");

$.ajax({
type: "POST",
url: "viewajax.php",
data: "msg_id="+ ID, 
cache: false,
success: function(html){
$("#view_comments"+ID).prepend(html);
$("#view"+ID).remove();
$("#two_comments"+ID).remove();
}
});

return false;
});
});
</script>

<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

body {
	font-family: "Trebuchet MS", Helvetica, Sans-Serif;
	font-size: 14px;
}

a {
	text-decoration: none;
	color: #838383;
}

a:hover {
	color: black;
}

#menu {
	position: relative;
	margin-left: 30px;
}

#menu a {
	display: block;
	width: 140px;
}

#menu ul {
	list-style-type: none;
}

#menu li {
	float: left;
	position: relative;
	text-align: center;
}

#menu ul.sub-menu {
	position: absolute;
	left: -10px;
	z-index: 90;
	display:none;
}

#menu ul.sub-menu li {
	text-align: left;
}

#menu li:hover ul.sub-menu {
	display: block;
}
a
{	text-decoration:none; }
	

.egg{
position:relative;
box-shadow: 0 3px 8px rgba(0, 0, 0, 0.25);
background-color:#fff;
border-radius: 3px 3px 3px 3px;
border: 1px solid rgba(100, 100, 100, 0.4);
}
.egg_Body{border-top:1px solid #D1D8E7;color:#808080;}
.egg_Message{font-size:13px !important;font-weight:normal;overflow:hidden}

h3{font-size:13px;color:#333;margin:0;padding:0}
.comment_ui
{
border-bottom:1px solid #e5eaf1;clear:left;float:none;overflow:hidden;padding:6px 4px 3px 6px;width:431px; cursor:pointer;
}
.comment_ui:hover{
background-color: #F7F7F7;
}
.dddd
{
background-color:#f2f2f2;border-bottom:1px solid #e5eaf1;clear:left;float:none;overflow:hidden;margin-bottom:2px;padding:6px 4px 3px 6px;width:431px; 
}
.comment_text{padding:2px 0 4px; color:#333333}
.comment_actual_text{display:inline;padding-left:.4em}

ol { 
	list-style:none;
	margin:0 auto;
	width:500px;
	margin-top: 20px;
}
#mes{
	padding: 0px 3px;
	border-radius: 2px 2px 2px 2px;
	background-color: rgb(240, 61, 37);
	font-size: 9px;
	font-weight: bold;
	color: #fff;
	position: absolute;
	top: 5px;
	left: 73px;
}
.toppointer{
background-image:url(top.png);
    background-position: -82px 0;
    background-repeat: no-repeat;
    height: 11px;
    position: absolute;
    top: -11px;
    width: 20px;
	right: 354px;
}
.clean { display:none}

</style>

</head>
<body>

<div id="menu">
	<ul>
		<li>
			<a href="#" style="padding:10px 0;">
			<img src="images.png" style="width: 21px;" />
			<?php
			include("db.php");
				$sql=mysql_query("select * from messages");
				$comment_count=mysql_num_rows($sql);
				if($comment_count!=0)
				{
				echo '<span id="mes">'.$comment_count.'</span>';
				}
			?>
			</a>
		<ul class="sub-menu">
		
			<?php
			
			$msql=mysql_query("select * from messages order by id desc");
			while($messagecount=mysql_fetch_array($msql))
			$id=$messagecount['id'];
			$msgcontent=$messagecount['message'];
			?>
			<li class="egg">
			<div class="toppointer"><img src="top.png" /></div>
				<?php 

				$sql=mysql_query("select * from messages where from=1 order by id");
				$comment_count=mysql_num_rows($sql);

				if($comment_count>2)
				{
				$second_count=$comment_count-2;
				} 
				else 
				{
				$second_count=0;
				}
				?>

				<div id="view_comments<?php echo $id; ?>"></div>

				<div id="two_comments<?php echo $id; ?>">
				<?php
				$listsql=mysql_query("select * from messages where from='$id' order by id limit $second_count,2 ");
				while($rowsmall=mysql_fetch_array($listsql))
				{ 
				$c_id=$rowsmall['com_id'];
				$comment=$rowsmall['comments'];
				?>

				<div class="comment_ui">

				<div class="comment_text">
				<div  class="comment_actual_text"><?php echo $comment; ?></div>
				</div>

				</div>
				
				<?php }?>
				<div class="bbbbbbb" id="view<?php echo $id; ?>">
					<div style="background-color: #F7F7F7; border-bottom-left-radius: 3px; border-bottom-right-radius: 3px; position: relative; z-index: 100; padding:8px; cursor:pointer;">
					<a href="#" class="view_comments" id="<?php echo $id; ?>">View all <?php echo $comment_count; ?> comments</a>
					</div>
				</div>
			</li>
		</ul>
		</li>
	</ul>
</div>

</body>
</html>