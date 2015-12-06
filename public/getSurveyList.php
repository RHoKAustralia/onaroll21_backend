<?php
$id = $_GET['surveyid'];


// check the id param whether it exist or not
if (!isset($id) || $id == ""){
	
	echo "You must enter ID as Param";
	
	
}else{
	
	$returnRow = "";
	
	// connect to the database
	
	mysql_connect("localhost:8889", "root", "root") or
    die("Could not connect: " . mysql_error());
	mysql_select_db("laravel");
	
	$result = mysql_query("SELECT * FROM surveys WHERE id=".$id);
	
	//loop thru the result from mysql_query
	
	while ($row = mysql_fetch_array($result, MYSQL_NUM)) {
	    
		//$returnRow = $row;
		// assign the result to $returnRow var
		
		$returnRow = str_replace('{"fields":',"",rtrim(unserialize($row[3])[0]));
			
		$returnRow = rtrim($returnRow, "}");
		
	}
	
	mysql_free_result($result);
}

// return the JSON

echo($returnRow);

?>