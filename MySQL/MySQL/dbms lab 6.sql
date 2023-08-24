CREATE DATABASE orders1;
use orders1;

CREATE TABLE Product (prod_id INT PRIMARY KEY,prod_name VARCHAR(255),qty_on_hand INT);
INSERT INTO Product VALUES (100, 'Product 1', 10);
INSERT INTO Product VALUES (200, 'Product 2', 20);
INSERT INTO Product VALUES (300, 'Product 3', 30);
INSERT INTO Product VALUES (400, 'Product 3', 30);
INSERT INTO Product VALUES (500, 'Product 3', 30);
SELECT * FROM Product;
DELETE from Product;

DROP TABLE ordr;
CREATE TABLE ordr (order_id INT PRIMARY KEY AUTO_INCREMENT,cust_id INT,FOREIGN KEY (cust_id) REFERENCES Customer1(cust_id),prod_id INT,FOREIGN KEY (prod_id) REFERENCES Product(prod_id),order_date DATE,qty_ordered INT);
SELECT * FROM ordr;
delete from ordr;

CREATE TABLE Customer1 (cust_id INT PRIMARY KEY,cust_name VARCHAR(255),phone VARCHAR(20),address VARCHAR(255));
INSERT INTO Customer1 VALUES (1, 'Customer 1', '123-456-7890', '123 Main St');
INSERT INTO Customer1 VALUES (2, 'Customer 2', '234-567-8901', '456 Elm St');
INSERT INTO Customer1 VALUES (3, 'Customer 3', '345-678-9012', '789 Oak St');
INSERT INTO Customer1 VALUES (4, 'Customer 4', '7897897897', 'hdhdhdhhhdh');
INSERT INTO Customer1 VALUES (5, 'Customer 5', '7878788777', 'sbdgdggdgdj');
SELECT * FROM Customer1;

DELIMITER //
CREATE PROCEDURE insert_order(
IN p_cust_id INT,
IN p_prod_id INT,
IN p_qty_ordered INT,
OUT p_qty_on_hand_updated INT
)
BEGIN
DECLARE v_qty_on_hand INT;
DECLARE v_finished INT;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
declare continue handler for not found set v_finished = 1;
if v_finished =1 then
select 'Product ID does not exist';
end if;
SELECT qty_on_hand INTO v_qty_on_hand
FROM Product
WHERE prod_id = p_prod_id;
  
IF v_qty_on_hand >= p_qty_ordered THEN
INSERT INTO `Ordr` (cust_id, prod_id, order_date, qty_ordered)
VALUES (p_cust_id, p_prod_id, NOW(), p_qty_ordered);
UPDATE Product
SET qty_on_hand = qty_on_hand - p_qty_ordered
WHERE prod_id = p_prod_id;
SELECT qty_on_hand INTO p_qty_on_hand_updated
FROM Product
WHERE prod_id = p_prod_id;
    
SET @message = 'Order placed successfully.';
ELSE
SET @message = 'Order cannot be fulfilled due to insufficient quantity.';
SELECT qty_on_hand INTO p_qty_on_hand_updated
FROM Product
WHERE prod_id = p_prod_id;
END IF;
  
SELECT @message AS message;
END //
DELIMITER ;

SET @qty_on_hand_updated = 0;
CALL insert_order(2, 300, 17, @qty_on_hand_updated);
SELECT @qty_on_hand_updated;

drop procedure insert_order;



