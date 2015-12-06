<?php

$url = "http://oar21.antwaite.com.au:8888/api_remote/oar_data.php";
//$url = "oar_data.php";
$data = array('token' => '123456789', 'group_id' => '15'); //, 'email' => 'anthony.waite@enmasse.com.au');

// use key 'http' even if you send the request to https://...
$options = array(
    'http' => array(
        'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
        'method'  => 'POST',
        'content' => http_build_query($data),
    ),
);
$context  = stream_context_create($options);
$result = file_get_contents($url, false, $context);


print_r($result);

?>


<script>

console.log(<?php echo $result; ?>);

</script>