<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<link rel="stylesheet" href="../Page4/styles/final.css">
<body>
<h2>Congratulations, Your tickets have been booked !</h2>
<div class="php">
<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "travelmanagement";
$conn = mysqli_connect($servername,$username,"",$dbname);
// error_reporting(0);

$flightNumber = $_GET['fno'];



$query = "select * from flightroutes where flightnumber = '$flightNumber';";	
$data = mysqli_query($conn,$query);
$result = mysqli_fetch_assoc($data);

echo "FLIGHT NUMBER - " . $result['flightNumber']."<br> <b>FLIGHT NAME - </b> ".$result['flightname']."<br> SOURCE -  ".$result['source']."<br> DESTINATION - ".$result['destination']." <br> COST per person - ".$result['cost'];
echo"<br>";

session_start();
$passengercalciflight =  $_SESSION['passengerflight'];
$indicost = $result['cost'];
// echo $passengercalci;
// echo $indicost;

echo "<br>TOTAL COST - ";

$stmt = $conn->prepare("CALL calculate_cost_flight(?,?,?)");
mysqli_stmt_bind_param($stmt, "iii", $passengercalciflight,$indicost,$flightNumber);
$result2=mysqli_stmt_execute($stmt);

$query2 = "select * from totaltravelcostflight where flightno = '$flightNumber';";
$data2 = mysqli_query($conn,$query2);
$result2 = mysqli_fetch_assoc($data2);
echo $result2['TotalCost'];

?>
</div>

<a href="../Page1/index.html"><button>Submit</button></a>
</body>
</html>

