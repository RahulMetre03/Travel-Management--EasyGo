<?php
   $source = $_POST['source'];
   $destination = $_POST['destination'];
   $date = $_POST['date'];
   $passengers = $_POST['passengers'];

	// Database connection
	$conn = new mysqli('localhost','root','','travelmanagement');
	if($conn->connect_error){
		echo "$conn->connect_error";
		die("Connection Failed : ". $conn->connect_error);
	} 
    else 
    {
		$stmt = $conn->prepare("insert into travelmanagement.flightTravel(Source, Destination, dateOfTravel, noOfPassengers) values(?, ?, ?, ?)");
		$stmt->bind_param("sssi", $source, $destination, $date, $passengers);
		$execval = $stmt->execute();

		session_start();
		$_SESSION['passengerflight']=$passengers;

		// echo $execval;
		// echo "Registration successfully...";
		// $stmt->close();
		// $conn->close();
		include "options.php";
	}

	
?>


