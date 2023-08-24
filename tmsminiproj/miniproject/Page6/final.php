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
// error_reporting(0);

$trainNumber = $_GET['tno'];

$query = "select * from trainroutes where trainNumber = '$trainNumber'";	
$data = mysqli_query($conn,$query);
$result = mysqli_fetch_assoc($data);

echo "TRAIN NUMBER - " . $result['trainNumber']."<br> <b>TRAIN NAME - </b> ".$result['trainname']."<br> SOURCE -  ".$result['source']."<br> DESTINATION - ".$result['destination']." <br> COST per person - ".$result['cost'];


session_start();
$passengercalcitrain =  $_SESSION['passengertrain'];
$indicost = $result['cost'];
// echo $passengercalci;
// echo $indicost;

echo "<br>TOTAL COST - ";

$stmt = $conn->prepare("CALL calculate_cost_train(?,?,?)");
mysqli_stmt_bind_param($stmt, "iii", $passengercalcitrain,$indicost,$trainNumber);
$result2=mysqli_stmt_execute($stmt);

$query2 = "select * from totaltravelcosttrain where trainnumber = '$trainNumber';";
$data2 = mysqli_query($conn,$query2);
$result2 = mysqli_fetch_assoc($data2);
echo $result2['totalcost']

?>
</div>

<a href="../Page1/index.html"><button>Submit</button></a>
</body>
</html>

