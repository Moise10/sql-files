CREATE DATABASE IF NOT EXISTS Lucky_Shrub;
USE Lucky_Shrub;
drop database Lucky_Shrub;
CREATE TABLE Orders (
      OrderID INT NOT NULL PRIMARY KEY, 
      ClientID VARCHAR(10),  
      ProductID VARCHAR(10),  
      Quantity   INT, 
      Cost DECIMAL(6,2),
      Date DATE 
      );
INSERT INTO Orders (OrderID, ClientID, ProductID , Quantity, Cost, Date) 
VALUES (1, "Cl1", "P1", 10, 500, "2020-09-01"),  
(2, "Cl2", "P2", 5, 100, "2020-09-05"),  
(3, "Cl3", "P3", 20, 800, "2020-09-03"),  
(4, "Cl4", "P4", 15, 150, "2020-09-07"),  
(5, "Cl3", "P3", 10, 450, "2020-09-08"),  
(6, "Cl2", "P2", 5, 800, "2020-09-09"),  
(7, "Cl1", "P4", 22, 1200, "2020-09-10"),  
(8, "Cl3", "P1", 15, 150, "2020-09-10"),  
(9, "Cl1", "P1", 10, 500, "2020-09-12"),  
(10, "Cl2", "P2", 5, 100, "2020-09-13"),  
(11, "Cl4", "P5", 5, 100, "2020-09-15"), 
(12, "Cl1", "P1", 10, 500, "2022-09-01"),  
(13, "Cl2", "P2", 5, 100, "2022-09-05"),  
(14, "Cl3", "P3", 20, 800, "2022-09-03"),  
(15, "Cl4", "P4", 15, 150, "2022-09-07"),  
(16, "Cl3", "P3", 10, 450, "2022-09-08"),  
(17, "Cl2", "P2", 5, 800, "2022-09-09"),  
(18, "Cl1", "P4", 22, 1200, "2022-09-10"),  
(19, "Cl3", "P1", 15, 150, "2022-09-10"),  
(20, "Cl1", "P1", 10, 500, "2022-09-12"),  
(21, "Cl2", "P2", 5, 100, "2022-09-13"),   
(22, "Cl2", "P1", 10, 500, "2021-09-01"),  
(23, "Cl2", "P2", 5, 100, "2021-09-05"),  
(24, "Cl3", "P3", 20, 800, "2021-09-03"),  
(25, "Cl4", "P4", 15, 150, "2021-09-07"),  
(26, "Cl1", "P3", 10, 450, "2021-09-08"),  
(27, "Cl2", "P1", 20, 1000, "2022-09-01"),  
(28, "Cl2", "P2", 10, 200, "2022-09-05"),  
(29, "Cl3", "P3", 20, 800, "2021-09-03"),  
(30, "Cl1", "P1", 10, 500, "2022-09-01");
show tables;
show columns from orders;
select * from orders;

-- Write a SQL statement to print all records of orders where the cost is $250 or less
select * from Orders where Cost <= 250;

-- Write a SQL statement to print all records of orders where the cost is between $50 and $750.
select * from Orders where Cost between 50 and 750;

/* Write a SQL statement to print all records of orders that have been placed by the client with 
 the id of Cl3 and where the cost of the order is more than $100. */
select * from Orders where ClientId = "Cl3" and Cost > 100;

/*Write a SQL statement to print all records of orders that have a product 
id of p1 or p2 and the order quantity is more than 2 */
select * from Orders where ProductID = "p1" or ProductID = "p2" and Quantity > 2;

select * from orders;
select ordertotal from orders where ordertotal between 400 and 900;

/*Write a SQL REPLACE statement that inserts 
two new orders with the following details:  

Order 9 data:
OrderID = 9, ClientID = "Cl1", ProductID = "P1", Quantity = 10, 
Cost = 5000,
 
Order 10 data: OrderID = 10, ClientID = "Cl2", ProductID = "P2", Quantity = 5, 
Cost = 100 */
select * from orders;
REPLACE INTO orders(OrderID, ClientID, ProductID, Quantity, Cost) values(9, "Cl1", "P1", 10, 5000);
REPLACE INTO orders(OrderID, ClientID, ProductID, Quantity, Cost) values(10, "Cl2", "P2", 5, 100);

/*Task 2: Lucky Shrub have noticed that the cost of order number 9 is $5000. 
This is a mistake. The order must cost $500. You must help them to 
change it to $500 by writing a relevant REPLACE statement.
*/

REPLACE INTO orders(OrderID, ClientID, ProductID, Quantity, Cost) values(9, "Cl1", "P1", 10, 500);
/* OR */ 
REPLACE INTO Orders SET OrderID = 9, ClientID = "Cl1", ProductID = "P1", Quantity = 10, Cost = 500;


/*Task 3: Write a SQL statement that creates a stored procedure called 'GetOrdersData' 
which retrieves all data from the Orders table.*/

DELIMITER $$

CREATE PROCEDURE GetOrdersData()
BEGIN
     SELECT * FROM Orders;

END$$

DELIMITER ;

CALL GetOrdersData();


/*Task 2: Write a SQL statement that creates a stored procedure called “GetListOfOrdersInRange”. 
The procedure must contain two parameters that determine the range of retrieved data 
based on the user input of two cost values “MinimumValue” and “MaximumValue”.*/

DELIMITER $$
CREATE PROCEDURE GetListOfOrdersInRange(MinimumValue DECIMAL, MaximumValue DECIMAL)
BEGIN 
     SELECT *  FROM Orders WHERE Cost >= MinimumValue AND Cost <= MaximumValue;
END$$

DELIMITER ;

CALL GetListOfOrdersInRange(150, 600);


/*Task 1:Create a SQL function that prints the cost value of a specific order 
based on the user input of the OrderID. The expected output result should be 
the same as the result in the screenshot below when you call the function with an OrderID of 5.*/

CREATE FUNCTION FindCost(order_id INT) 
RETURNS DECIMAL (5,2) DETERMINISTIC 
RETURN (SELECT Cost FROM Orders WHERE OrderID = order_id);

SElECT FindCost(5);


/*Task 2:Create a stored procedure called GetDiscount. This stored procedure must 
return the final cost of the customer's order after the discount value has been deducted. 
The discount value is based on the order's quantity. 
The stored procedure must have the following specifications: 
The procedure should take one parameter that accepts a user input value of an OrderID. 
The procedure must find the order quantity of the specific OrderID. 
If the value of the order quantity is more than or equal to 20 then 
the procedure should return the new cost after a 20% discount. 
If the value of the order quantity is less than 20 and more than or equal 
to 10 then the procedure should return the new cost after a 10% discount.*/

DELIMITER //
CREATE PROCEDURE GetDiscount( OrderIDInput INT )
BEGIN 
   DECLARE cost_after_discount DECIMAL(7, 2);
   DECLARE current_cost DECIMAL(7, 2);
   DECLARE order_quantity INT;
   SELECT Quantity INTO order_quantity FROM Orders WHERE OrderID = OrderIDInput; 
   SELECT Cost INTO current_cost FROM Orders WHERE OrderID = OrderIDInput; 
   IF order_quantity >= 20 THEN
	  SET cost_after_discount = current_cost - (current_cost * 0.2);              
   ELSEIF (order_quantity >= 10) THEN
	  SET cost_after_discount = current_cost - (current_cost * 0.1); 
   ELSE SET cost_after_discount = current_cost;
   END IF;
   SELECT cost_after_discount;
END //

DELIMITER ;


