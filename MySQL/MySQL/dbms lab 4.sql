create database hotel;
use hotel;
CREATE TABLE Hotel(HotelNo INT PRIMARY KEY, Hname VARCHAR(20), city VARCHAR(20));
CREATE TABLE Room(RoomNo INT PRIMARY KEY, HotelNo INT NOT NULL,FOREIGN KEY (HotelNo) REFERENCES hotel (HotelNo), Room_Type VARCHAR(20), Room_Price INT);
CREATE TABLE Booking (HotelNo INT NOT NULL, GuestNo INT NOT NULL, DateFrom DATE NOT NULL, DateTo DATE NOT NULL, RoomNo INT NOT NULL, PRIMARY KEY (HotelNo, GuestNo, RoomNo),FOREIGN KEY (HotelNo) REFERENCES Hotel(HotelNo), FOREIGN KEY (GuestNo) REFERENCES Guest(GuestNo), FOREIGN KEY (RoomNo) REFERENCES Room(RoomNo));
CREATE TABLE Guest(GuestNo INT PRIMARY KEY, Guest_Name VARCHAR(20), Guest_Address VARCHAR(255));

insert into hotel values(1, 'Taj', 'Mumbai');
insert into hotel values(2, 'The Oberoi', 'New Delhi');
insert into hotel values(3, 'The Taj Mahal Palace', 'Mumbai');
insert into hotel values(4, 'Hyatt', 'Pune');
insert into hotel values(5, 'Jagat Niwas Palace', 'Udaipur');
insert into hotel values(6, 'JW Marriott', 'Pune');
insert into hotel values(7, 'Shahi Palace', 'Jaisalmer');
select * from Hotel;

insert into Room values(101, 1, 'Deluxe', 10000);
insert into Room values(102, 2, 'Presedential Suite', 20000);
insert into Room values(103, 3, 'Studio Room', 7000);
insert into Room values(104, 4, 'Deluxe', 10000);
insert into Room values(105, 5, 'Double Room', 5000);
insert into Room values(106, 6, 'Suite', 8000);
insert into Room values(107, 7, 'Single Room', 3000);
select * from Room;

insert into booking values(1, 11, '2022-04-20', '2022-05-01', 101);
insert into booking values(2, 22, '2021-05-13', '2021-05-18', 102);
insert into booking values(3, 33, '2022-06-22', '2022-07-01', 103);
insert into booking values(4, 44, '2021-07-26', '2021-08-02', 104);
insert into booking values(5, 55, '2022-08-03', '2022-08-10', 105);
insert into booking values(6, 66, '2021-09-15', '2021-09-19', 106);
insert into booking values(7, 77, '2022-10-28', '2022-11-06', 107);
select * from booking;

insert into Guest values(11, 'Rahul', 'Bandra,Mumbai');
insert into Guest values(22, 'Sanjay', 'INA Colony,Delhi');
insert into Guest values(33, 'Aditi', 'Andheri,Mumbai');
insert into Guest values(44, 'Riya', 'Kothrud,Pune');
insert into Guest values(55, 'Priti', 'Manva Kheda,Udaipur');
insert into Guest values(66, 'Aniket', 'Bavdhan,Pune');
insert into Guest values(77, 'Kaushik', '123 Street,Jaisalmer');
select * from Guest;

-- Queries
-- 1. How many hotels are there?
select count(*) from Hotel;

-- 2. List the price and type of all rooms at the Grosvenor Hotel.
SELECT Room_type, Room_Price FROM Room WHERE HotelNo = (SELECT HotelNo FROM Hotel WHERE Hname = 'Grosvenor');

-- 3. List the number of rooms in each hotel.
SELECT HName, COUNT(Room.RoomNo) as NumRooms FROM Hotel LEFT JOIN Room ON Hotel.HotelNo = Room.HotelNo GROUP BY HName;

-- 4. Update the price of all rooms by 5%.
UPDATE Room SET room_Price = room_Price * 1.05;

-- 5. List full details of all hotels in London.
SELECT * FROM Hotel WHERE City = 'London';

-- 6. What is the average price of a room?
SELECT AVG(Room_Price) FROM Room;

-- 7. List all guests currently staying at the Grosvenor Hotel.
SELECT Guest.Guest_Name FROM Booking JOIN Guest ON Booking.GuestNo = Guest.GuestNo WHERE Booking.HotelNo = (SELECT HotelNo FROM Hotel WHERE Hname = 'Grosvenor');

-- 8. List the number of rooms in each hotel in London.
SELECT HName, COUNT(Room.RoomNo) as NumRooms FROM Hotel LEFT JOIN Room ON Hotel.HotelNo = Room.HotelNo WHERE Hotel.City = 'London' GROUP BY HName;

-- 9. Create one view on above database and query it.
CREATE VIEW BookingDetails AS SELECT b.HotelNo, b.GuestNo, g.Guest_Name, g.Guest_Address, b.RoomNo, r.Room_Type, r.Room_Price, b.DateFrom, b.DateTo, h.Hname, h.city FROM Booking b JOIN Guest g ON b.GuestNo = g.GuestNo JOIN Room r ON b.RoomNo = r.RoomNo JOIN Hotel h ON b.HotelNo = h.HotelNo;

-- set 2

create database orders;
use orders;

create table emp(eno int primary key,ename varchar(20) not null,zip int not null, FOREIGN KEY(zip) references zipcode(zip),hdate date);
insert into emp values(101,'Bhavesh',411039,'2004-05-22');
insert into emp values(102,'Sahil',411018,'2003-08-23');
insert into emp values(103,'paritosh',411028,'2004-02-09');
insert into emp values(104,'Bhuvam',411048,'2005-05-13');
insert into emp values(105,'Rohit',411068,'2005-10-17');
select * from emp;

create table parts(pno int primary key, pname varchar(20)not null,qty_on_hand int check(qty_on_hand > 0) not null,price decimal(10,2) not null check(price >= 0));
insert into parts values(111,'part-a',10,550);
insert into parts values(112,'part-b',20,150);
insert into parts values(113,'part-c',30,250);
insert into parts values(114,'part-d',40,350);
insert into parts values(115,'part-e',50,450);
select * from parts;

create table customer(cno int PRIMARY KEY,cname varchar(20) not null,street varchar(50) not null,zip int not null, FOREIGN KEY(zip) references zipcode(zip),phone varchar(15)not null);
insert into customer values(1,'Ravesh','ABC chowk',411039,'328763283111');
insert into customer values(2,'Kavesh','ABCD chowk',411018,'32876328231');
insert into customer values(3,'Mavesh','ABCX chowk',411028,'32856777831');
insert into customer values(4,'Javesh','ABCA chowk',411048,'32821212831');
insert into customer values(5,'Lavesh','ABCC chowk',411068,'32876328312');
select * from customer;

create table odr(ono int PRIMARY KEY,cno int not null,FOREIGN KEY(cno) references customer(cno),recievedate date not null,shippeddate date not null);
insert into odr values(11,1,'2004-05-23','2004-05-22');
insert into odr values(12,2,'2003-08-24','2003-08-23');
insert into odr values(13,3,'2004-02-11','2004-02-09');
insert into odr values(14,4,'2005-05-16','2005-05-13');
insert into odr values(15,5,'2005-10-19','2005-10-17');
select * from  odr;

create table odetails(ono int not null,foreign key(ono) references odr(ono),pno int not null,foreign key(pno) references parts(pno),qty int not null,primary key(ono,pno));
insert into odetails values(11,111,10);
insert into odetails values(12,112,2);
insert into odetails values(13,113,5);
insert into odetails values(14,114,6);
insert into odetails values(15,115,2);
select * from odetails;

create table zipcode(zip int primary key,city varchar(30));
insert into zipcode values('411039','Pune');
insert into zipcode values('411018','Mumbai');
insert into zipcode values('411028','Jaipur');
insert into zipcode values('411048','Kochi');
insert into zipcode values('411068','Rameshwaram');
select * from zipcode;

-- 1. get pno,pname values of parts that are priced less than $20.00
SELECT pno, pname FROM parts WHERE price < 20.00;

-- 2. get the ono & cname values of customer whose orders have not yet been shipped
SELECT odr.ono, customer.cname FROM odr JOIN customer ON odr.cno = customer.cno WHERE shippeddate IS NULL;

-- 3. get the cname values of customer who have placed order with emp living in ‘Pune’ or ‘mumbai’
SELECT customer.cname FROM odr JOIN customer ON odr.cno = customer.cno JOIN emp ON emp.Zip = customer.Zip WHERE emp.Zip IN ('Pune', 'mumbai');

-- 4. get the cities in which customer or emp are located
SELECT Zip, city FROM zipcode WHERE Zip IN (SELECT Zip FROM customer UNION SELECT Zip FROM emp);

-- 5. get the totalquantity of part 1060 that has been ordered
SELECT SUM(qty) FROM odetails WHERE pno = 1060;

-- 6. get the total no of customer
SELECT COUNT(*) FROM customer;

-- 7. Create one view
CREATE VIEW odr_details AS SELECT odr.ono, customer.cname, parts.pname, odetails.qty
FROM odr INNER JOIN customer ON odr.cno = customer.cno INNER JOIN odetails ON odr.ono = odetails.ono INNER JOIN parts ON odetails.pno = parts.pno;