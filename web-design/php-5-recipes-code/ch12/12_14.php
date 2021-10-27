<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<title>Sample 12.13</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body>
	<div align="center">
		<p>Click a link to change the text color of the verbiage below:</p>
		<a href="sample12_13.html?color=1">Green</a><br />
		<a href="sample12_13.html?color=2">Red</a><br />
		<a href="sample12_13.html?color=3">Blue</a><br />
		<a href="sample12_13.html">Reset</a>
		<?php
			//The first thing we must do is read in the value.
			//Note the use of the intval() function.
			//By forcing an integer value, we kill of SQL injection problems.
			$color = intval ($_GET['color']);
						
			//Now, we can perform an action based on the result.
			if ($color == 1){
				$fontcolor = "00FF00";
			} elseif ($color == 2){
				$fontcolor = "FF0000";
			} elseif ($color == 3){
				$fontcolor = "0000FF";
			} else {
				$fontcolor = "000000";
			}
			?><p style="color: #<?php echo $fontcolor; ?>; font-weight: bold;">Hello World!</p><?php
		?>
	</div>
</body>
</html>