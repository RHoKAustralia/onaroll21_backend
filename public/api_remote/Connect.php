<?php

//localhost  CONNECTION
$DBhost = "localhost";
$DBuser = "root";
$DBpass = "root";
$DBName = "laravel";



// The connection and db select part (You won't have to edit this).
$Connect = mysql_connect($DBhost,$DBuser,$DBpass);
mysql_select_db($DBName, $Connect);

//print "Connect: ".$Connect;



?>