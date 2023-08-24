drop database airport;
create database airport;
use airport;

drop TABLE Airline;
CREATE TABLE Airline (Airline_Name varchar(255) NOT NULL PRIMARY KEY);
INSERT INTO Airline VALUES ('Vistara');
INSERT INTO Airline VALUES ('SpiceJet');
INSERT INTO Airline VALUES ('Indigo');
INSERT INTO Airline VALUES ('Air India');
INSERT INTO Airline VALUES ('Jet Airways');
SELECT * FROM Airline;

drop TABLE Airplane;
CREATE TABLE Airplane (RegNo int NOT NULL PRIMARY KEY,ModelNo int NOT NULL,Capacity int NOT NULL,Airline_Name varchar(255),FOREIGN KEY (Airline_Name) REFERENCES Airline(Airline_Name));
INSERT INTO Airplane VALUES (101, 11 ,400, 'Vistara');
INSERT INTO Airplane VALUES (202, 22 ,350, 'SpiceJet');
INSERT INTO Airplane VALUES (303, 33 ,500, 'Indigo');
INSERT INTO Airplane VALUES (404, 44 ,400, 'Air India');
INSERT INTO Airplane VALUES (505, 55 ,450, 'Jet Airways');
SELECT * FROM Airplane;

drop TABLE Flights;
CREATE TABLE Flights (FlightNo varchar(255) NOT NULL PRIMARY KEY,From_Dest varchar(255),To_Dest varchar(255),Departure_Date date,Departure_time time,
Arrival_Date date,Arrival_time time,AirplaneRegNo int NOT NULL,FOREIGN KEY (AirplaneRegNo) REFERENCES Airplane(RegNo));
INSERT INTO Flights VALUES ('VT1001', 'Mumbai', 'Pune', '2023-05-01', '11:20', '2023-05-01', '12:20', 101);
INSERT INTO Flights VALUES ('SJ2002', 'New Delhi', 'Hyderabad', '2023-05-10', '01:55', '2023-05-10', '04:10', 202);
INSERT INTO Flights VALUES ('IG3003', 'Kolkata', 'Goa', '2023-04-24', '08:10', '2023-04-24', '16:50', 303);
INSERT INTO Flights VALUES ('AI4004', 'Mumbai', 'Chennai', '2023-04-28', '05:45', '2023-04-28', '07:40', 404);
INSERT INTO Flights VALUES ('JA5005', 'Srinagar', 'Chennai', '2023-05-14', '19:55', '2023-05-15', '02:40', 505);
SELECT * FROM Flights;

drop TABLE Passenger;
CREATE TABLE Passenger (Email varchar (255),Firstname varchar(255),Surname varchar(255),PRIMARY KEY(Email));
INSERT INTO Passenger VALUES ('rahul@gmail.com', 'Rahul', 'Jagtap');
INSERT INTO Passenger VALUES ('priya22@gmail.com', 'Priya', 'Banerjee');
INSERT INTO Passenger VALUES ('sachin@gmail.com', 'Sachin', 'Verma');
INSERT INTO Passenger VALUES ('harita.j@gmail.com', 'Harita', 'Joshi');
INSERT INTO Passenger VALUES ('akshay12@gmail.com', 'Akshay', 'Patel');
SELECT * FROM Passenger;

drop TABLE Booking;
CREATE TABLE Booking (pEmail varchar(255),FOREIGN KEY (pEmail) REFERENCES Passenger(Email),FlightNo varchar(255) NOT NULL,FOREIGN KEY (FlightNo) REFERENCES Flights(FlightNo),No_Seats int NOT NULL);
INSERT INTO Booking VALUES ('rahul@gmail.com', 'VT1001', 2);
INSERT INTO Booking VALUES ('priya22@gmail.com', 'SJ2002', 1);
INSERT INTO Booking VALUES ('sachin@gmail.com', 'IG3003', 3);
INSERT INTO Booking VALUES ('harita.j@gmail.com', 'AI4004', 1);
INSERT INTO Booking VALUES ('akshay12@gmail.com', 'JA5005', 2);
SELECT * FROM Booking;

-- 1. Display the Passenger email ,Flight_no,Source and Destination Airport Names for all flights booked
select b.pEmail, b.FlightNo, f.From_dest, f.To_Dest from booking as b join flights as f on b.FlightNo = f.FlightNo;
-- 2. Display the flight and passenger detailsfor the flights booked having Departure Date between 23-08-2021 and 25-08-2021
SELECT *
FROM Flights AS f JOIN Booking AS b ON b.FlightNo = f.FlightNo JOIN Passenger AS p ON p.Email = b.pEmail WHERE (Departure_Date) BETWEEN '2021-08-23' AND '2021-08-25';

-- 3. Display the top 5 airplanesthat participated in Flights from ‘Mumbai’ to ‘London’ based on the airplane capacity
SELECT a.RegNo, a.Capacity FROM Airplane AS a JOIN Flights AS f ON f.AirplaneRegNo = a.RegNo WHERE f.From_Dest = 'Mumbai' AND f.To_Dest = 'London' ORDER BY a.Capacity DESC LIMIT 5;

-- 4.Display the passenger first names who have booked the no_ofseats smaller than the average number of seats booked by all passengers for the arrival airport:”New Delhi”
SELECT p.Firstname FROM Passenger AS p JOIN Booking AS b ON p.Email = b.pEmail JOIN Flights AS f ON b.FlightNo = f.FlightNo WHERE f.To_Dest = 'New Delhi' GROUP BY p.Email HAVING SUM(b.No_Seats) < (SELECT AVG(No_Seats) FROM Booking);

-- 5.Display the surnames of passengers who have not booked a flight from “Pune” to “Bangalore”
SELECT Surname FROM Passenger WHERE Email NOT IN (SELECT pEmail FROM Booking WHERE FlightNo IN (SELECT FlightNo FROM Flights WHERE From_Dest = 'Pune' AND To_Dest = 'Bangalore'));

-- 6.Display the Passenger details only if they have booked flights on 21st July 2021. (Use Exists)
SELECT * FROM Passenger AS p WHERE EXISTS (SELECT 1 FROM Booking AS b JOIN Flights AS f ON b.FlightNo = f.FlightNo WHERE b.pEmail = p.Email AND f.Departure_Date = '2021-07-21');

-- 7.Display the Flight-wise total time duration of flights if the duration is more than 8 hours (Hint : Date function,Aggregation,Grouping)
SELECT FlightNo, TIMEDIFF(MAX(CONCAT(Arrival_date, ' ', Arrival_time)), MIN(CONCAT(Departure_date, ' ', Departure_time))) AS Total_Duration FROM Flights GROUP BY FlightNo HAVING Total_Duration > '08:00:00';

-- 8. Display the Airplane-wise average seating capacity for any airline
SELECT a.Airline_Name, AVG(a.Capacity) AS Avg_Seating_Capacity FROM Airplane AS a GROUP BY a.Airline_Name;

-- 9. Display the total number of flights which are booked and travelling to “London” airport.
SELECT COUNT(*) AS Total_Flights_To_London FROM Booking AS b JOIN Flights AS f ON b.FlightNo = f.FlightNo WHERE f.To_Dest = 'London';

-- 10. Create a view having information about flight_no,airplane_no,capacity.
CREATE VIEW Flight_Airplane_Capacity AS SELECT Flights.FlightNo, Airplane.RegNo, Airplane.Capacity FROM Flights INNER JOIN Airplane ON Flights.AirplaneRegNo = Airplane.RegNo;