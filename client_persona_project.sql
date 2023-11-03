show tables;
/** 
Task 1:
Lucky Shrub need to find out what their average sale price, 
or cost was for a product in 2022.
You can help them with this task by creating a FindAverageCost() 
function that returns the average sale price value of all products in a specific year. 
This should be based on the user input.
**/

CREATE FUNCTION FindAverageCost(YearInput INT)
RETURNS DECIMAL(10,2) DETERMINISTIC 
RETURN ( SELECT AVG(Cost) AS AverageCost_2022 FROM Orders WHERE YEAR(Date) = YearInput);

SELECT FindAverageCost(2022);


/** 
Task 2 
Lucky Shrub need to evaluate the sales patterns 
for bags of artificial grass over the last three years. 
Help them out using the following steps:

Step 1: Create the EvaluateProduct stored procedure that outputs 
the total number of items sold during the last three years for the P1 Product ID. 
Input the ProductID when invoking the procedure. 
Step 2: Call the procedure. 
Step 3: Output the values into outside variables.  
**/

DELIMITER // 
CREATE PROCEDURE EvaluateProduct(
                           IN product_id VARCHAR(10), 
                           OUT SoldItemsIn2020 INT, 
                           OUT SoldItemsIn2021 INT, 
                           OUT SoldItemsIn2022 INT)
BEGIN
SELECT SUM(Quantity) INTO SoldItemsIn2020 
FROM Orders WHERE ProductID=product_id AND YEAR(Date)=2020; 
SELECT SUM(Quantity) INTO SoldItemsIn2021 
FROM Orders WHERE ProductID=product_id AND YEAR(Date)=2021;
SELECT SUM(Quantity) INTO SoldItemsIn2022 
FROM Orders WHERE ProductID=product_id AND YEAR(Date)=2022; 
END //
DELIMITER ;

SET @sold_items_2020 = 2020;
SET @sold_items_2021 = 2021;
SET @sold_items_2022 = 2022;


CALL EvaluateProduct('P1', @sold_items_2020, @sold_items_2021, @sold_items_2022);

/**Step 3: Output the values into outside variables. **/

SELECT @sold_items_2020, @sold_items_2021, @sold_items_2022;


/**
Task 3 

Lucky Shrub need to automate the orders process in their database. 
The database must insert a new record of data in response 
to the insertion of a new order in the Orders table. 
This new record of data must contain a new ID and the current date and time.
You can help Lucky Shrub by creating a trigger called UpdateAudit. 
This trigger must be invoked automatically AFTER a new order is inserted into the Orders table.
**/

CREATE TRIGGER UpdateAudit AFTER INSERT
ON Orders
FOR EACH ROW
INSERT INTO Audit ( OrderDateTime )
VALUES (current_timestamp );


/**
Task 4 

Lucky Shrub need location data for their clients and employees. 
To help them out, create an optimized query that outputs the following data:
    - The full name of all clients and employees from 
    the Clients and Employees tables in the Lucky Shrub database.  
	- The address of each person from the Addresses table.  
**/

SELECT Employees.FullName, Addresses.Street, Addresses.County 
FROM Employees INNER JOIN Addresses 
ON Employees.AddressID = Addresses.AddressID
UNION
SELECT Clients.FullName, Addresses.Street, Addresses.County 
FROM Clients INNER JOIN Addresses ON Clients.AddressID = Addresses.AddressID 
ORDER BY Street;


/**
Task 5:
Lucky Shrub need to find out what quantities of wood panels they are selling. 
The wood panels product has a Product ID of P2. The following query returns
the total quantity of this product as sold in the years 2020, 2021 and 2022: 

SELECT CONCAT(SUM(Cost), "(2020)") AS "Total sum of P2 Product" 
FROM Orders WHERE YEAR(Date) = 2020 AND ProductID = "P2" UNION 
SELECT CONCAT(SUM(Cost), "(2021)") FROM Orders 
WHERE YEAR(Date) = 2021 AND ProductID = "P2"
UNION SELECT CONCAT(SUM(Cost), "(2022)") FROM Orders 
WHERE YEAR(Date) = 2022 AND ProductID = "P2";

You are tasked to optimize this query by recreating it as a common table expression (CTE). 
**/

WITH
P2_Sales_2020 AS (SELECT CONCAT(SUM(Cost), " (2020)") AS "Total sum of P2 Product" 
FROM Orders WHERE YEAR(Date) = 2020 AND ProductID= "P2"),
P2_Sales_2021 AS (SELECT CONCAT(SUM(Cost), " (2021)") AS "Total sum of P2 Product" 
FROM Orders WHERE YEAR(Date) = 2021 AND ProductID= "P2"),
P2_Sales_2022 AS (SELECT CONCAT(SUM(Cost), " (2022)") AS "Total sum of P2 Product" 
FROM Orders WHERE YEAR(Date) = 2022 AND ProductID= "P2")
SELECT * FROM P2_Sales_2020
UNION
SELECT * FROM P2_Sales_2021
UNION
SELECT * FROM P2_Sales_2022; 

/**
Task 6
Lucky Shrub want to know more about the activities of the clients 
who use their online store. 
The system logs the ClientID and the ProductID information for each activity 
in a JSON Properties column inside the Activity table. 
This occurs while clients browse through Lucky Shrub products online. 
The following screenshot shows the Activity table. 

Utilize the Properties data to output the following information:
The full name and contact number of each client from the Clients table.  
The ProductID for all clients who performed activities.   

Tip:
Use the following code to access the property value with double quotations from the JSON datatype:
->'$.PropertyName
Use the following code to access the property value without double quotations from the JSON datatype:
 ->>'$. PropertyName
**/

SELECT Activity.Properties ->>'$.ClientID' 
AS ClientID, Activity.Properties ->>'$.ProductID' 
AS ProductID, Clients.FullName, Clients.ContactNumber 
FROM Clients RIGHT JOIN Activity 
ON Clients.ClientID = Activity.Properties ->>'$.ClientID';


/**
Task 7:
Lucky Shrub need to find out how much revenue their top selling product generated. 
Create a stored procedure called GetProfit that returns the overall profits 
generated by a specific product in a specific year. 
This should be based on the user input of the ProductID and Year.  
**/

DELIMITER //
CREATE PROCEDURE GetProfit(IN product_id VARCHAR(10), IN YearInput INT)
BEGIN
DECLARE profit DEC(7,2) DEFAULT 0.0; 
DECLARE sold_quantity, buy_price, sell_price INT DEFAULT 0;
SELECT SUM(Quantity) INTO sold_quantity FROM Orders WHERE ProductID = product_id AND YEAR(Date) = YearInput; 
SELECT BuyPrice INTO buy_price FROM Products WHERE ProductID = product_id; 
SELECT SellPrice INTO sell_price FROM Products WHERE ProductID = product_id;
SET profit = (sell_price * sold_quantity) - (buy_price * sold_quantity);
Select profit; 
END //
DELIMITER ;

CALL GetProfit('P1', 2020);


/** 
Task 8 

Lucky Shrub need a summary of their client's details, 
including their addresses, order details and the products they purchased. 
Help them out by creating a virtual table called DataSummary 
that joins together the four tables that contain this data. 
These four tables are as follows:
Clients,  
Addresses,  
Orders, 
and Products.  
The virtual table must display the following data:
The full name and contact number for each client from the Clients table. 
The county that each client lives in from the Addresses table. 
The name of the product they purchased from the Products table.  
and the ProductID, cost and date of each order from the Orders table.  
The virtual table should show relevant data for year 2022 only. 
Order the data by the cost of the highest order. 
**/

CREATE VIEW DataSummary AS SELECT Clients.FullName, 
                Clients.ContactNumber, Addresses.County, 
                Products.ProductName, Orders.ProductID, 
                Orders.Cost, Orders.Date 
FROM Clients
INNER JOIN Addresses ON Clients.AddressID = Addresses.AddressID 
INNER JOIN Orders ON Clients.ClientID = Orders.ClientID 
INNER JOIN Products ON Orders.ProductID = Products.ProductID 
WHERE YEAR(Orders.Date) = 2022 ORDER BY Orders.Cost DESC;



