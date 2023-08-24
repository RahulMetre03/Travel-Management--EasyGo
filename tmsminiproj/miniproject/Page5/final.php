<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<link rel="stylesheet" href="../Page5/styles/final.css">
<body>
<h2>Congratulations, Your tickets have been booked !</h2>
<div class="php">
<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "travelmanagement";
$conn = mysqli_connect($servername,$username,"",$dbname);
error_reporting(0);

$busNumber = $_GET['bno'];

$query = "select * from busroutes where busnumber = '$busNumber'";	
$data = mysqli_query($conn,$query);
$result = mysqli_fetch_assoc($data);

echo "BUS NUMBER - " . $result['BusNumber']."<br> <b>BUS NAME - </b> ".$result['BusName']."<br> SOURCE -  ".$result['Source']."<br> DESTINATION - ".$result['Destination']." <br> COST per person - ".$result['cost'];

session_start();
$passengercalcibus =  $_SESSION['passengerbus'];
$indicost = $result['cost'];
// echo $passengercalci;
// echo $indicost;

echo "<br>TOTAL COST - ";

$stmt = $conn->prepare("CALL calculate_cost_bus(?,?,?)");
mysqli_stmt_bind_param($stmt, "iii", $passengercalcibus,$indicost,$busNumber);
$result2=mysqli_stmt_execute($stmt);

$query2 = "select * from totaltravelcostbus where busnumber = '$busNumber';";
$data2 = mysqli_query($conn,$query2);
$result2 = mysqli_fetch_assoc($data2);
echo $result2['totalcost'];

?>
</div>

<a href="../Page1/index.html"><button>Submit</button></a>
</body>
</html>

