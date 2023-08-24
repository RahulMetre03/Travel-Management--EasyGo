<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Available Options</title>

	<style>
		body
		{
			display: flex;
			flex-direction:column;
			align-items:center;
			justify-content:center;
			padding:2rem;
		}
	.table
	{
		display: flex;
		justify-content: center;
		/* border: 2px solid black; */
		padding: 25px;
	}
	th,td
	{
		padding:10px;
	}
	
	</style>
</head>
<body>
	<h1>Here are the available travel options based on your choices</h1>
	<div class="table">
		<table border = "2">
	<tr>
		<th>Flight No.</th>
		<th>Flight Name</th>
		<th>Source</th>
		<th>Destination</th>
		<th>Cost</th>
		<th>Confirm</th>
	</tr>
	
	</div>


<?php


error_reporting(0);
$source = $_POST['source'];
$destination = $_POST['destination'];
$query = "select * from travelmanagement.flightroutes where source = '$source' and destination = '$destination'";
$data = mysqli_query($conn,$query);
$total = mysqli_num_rows($data);
if($total!=0)
{
	
	while ($result = mysqli_fetch_assoc($data)) 
	{
	
		echo "
		<tr>
		<td>".$result['flightNumber']."</td>
		<td>".$result['flightname']."</td>
		<td>".$result['source']."</td>
		<td>".$result['destination']."</td>
		<td>".$result['cost']."</td>
		<td><a href='final.php?fno=$result[flightNumber]'>Book</td>
		</tr>
		
		";
		
	}
	// echo $result['flightNumber']." ".$result['flightname']." ".$result['source']." ".$result['destination']." ".$result['cost'];
}
else
{
	echo "<tr><th colspan='6'>Sorry, No Flights Available</th></tr>";
}

?>

</body>
</html>