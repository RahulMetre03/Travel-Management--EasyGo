CREATE DATABASE customers_db;
USE customers_db;

DROP TABLE Customer;
CREATE TABLE Customer (cust_id INT PRIMARY KEY,Principal_amount FLOAT NOT NULL,Rate_of_interest FLOAT NOT NULL,No_of_years INT);
INSERT INTO Customer VALUES(1, 10000.00, 5.00, 2);
INSERT INTO Customer VALUES(2, 5000.00, 3.50, 5);
INSERT INTO Customer VALUES(3, 7500.00, 4.25, 3);
INSERT INTO Customer VALUES(4, 15000.00, 6.00, 4);

CREATE TABLE TEMPLIST (cust_id INT,Simple_interest DECIMAL(10,2));

-- cursor 
