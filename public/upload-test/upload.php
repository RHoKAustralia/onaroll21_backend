<?php




move_uploaded_file($_FILES['image_file']['tmp_name'], "./upload/".$_FILES['image_file']['name']);

echo $_FILES['image_file']['name'];

?>