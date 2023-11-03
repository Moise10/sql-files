create database little_lemon;
drop database little_lemon;
use little_lemon;
CREATE TABLE Customers(
      CustomerID INT NOT NULL PRIMARY KEY, 
      FullName VARCHAR(100) NOT NULL,
      PhoneNumber VARCHAR(15) NOT NULL UNIQUE);
      
insert into Customers (CustomerID, FullName, PhoneNumber) 
            values (2, 'Christina Letherbury', '972-305-8342'),
                   (4, 'Aurea Bydaway', '880-487-5408'),
                   (5, 'Bogey Bevir', '945-176-1047'),
                   (6, 'Kelbee Klempke', '471-598-8806'),
                   (7, 'Adelaida Kerr', '605-762-4637'),
                   (8, 'Karon Egiloff', '284-318-1847'),
                   (9, 'Janek Sign', '856-777-9379'),
                   (10, 'Braden Sapseed', '312-863-5765'),
                   (11, 'Bobinette Doddrell', '822-207-7080'),
                   (12, 'Calida Wallege', '688-658-9606'),
                   (13, 'Sibella Carswell', '129-724-7121'),
                   (14, 'Hillier Lecky', '527-877-1002'),
                   (15, 'Nester Biskupek', '523-731-8022');
show columns from Customers;
select * from customers;
CREATE TABLE Bookings (
      BookingID INT NOT NULL PRIMARY KEY, 
      BookingDate DATE NOT NULL,  
      TableNumber INT NOT NULL, 
      NumberOfGuests INT NOT NULL CHECK (NumberOfGuests <= 8), 
      CustomerID INT NOT NULL, 
      FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID) ON DELETE CASCADE ON UPDATE CASCADE); 

INSERT INTO Bookings (BookingID, BookingDate, TableNumber, NumberOfGuests, CustomerID) 
      VALUES (68, '2023-03-13', 65, 5, 2),
             (28, '2022-11-14', 28, 6, 4),
             (14, '2023-05-28', 62, 6, 5),
             (18, '2023-05-14', 5, 7, 6),
             (54, '2023-03-08', 39, 1, 7),
             (2,  '2022-12-22', 12, 7, 8),
             (76, '2022-09-23', 15, 5, 9),
             (29, '2023-05-30', 90, 1, 10),
             (33, '2022-09-25', 55, 1, 11),
             (22, '2022-12-16', 39, 4, 12),
             (27, '2022-12-30', 56, 5, 13),
             (57, '2023-04-03', 39, 5, 14),
             (79, '2023-06-13', 76, 7, 15);
select * from bookings;

CREATE TABLE FoodOrders (OrderID INT, Quantity INT, Cost Decimal(4,2));
show columns from FoodOrders;

/*Task 1: Use the ALTER TABLE statement with MODIFY command to make the OrderID 
the primary key of the 'FoodOrders' table. */
ALTER TABLE FoodOrders
MODIFY COLUMN OrderID INT PRIMARY KEY;

/* Task 2: Apply the NOT NULL constraint to the quantity and cost columns. */
ALTER TABLE FoodOrders
MODIFY COLUMN Quantity INT NOT NULL,
MODIFY COLUMN Cost DECIMAL(6,2) NOT NULL;

/*Task 3: Create two new columns, OrderDate with a DATE datatype and 
CustomerID with an INT datatype. Declare both must as NOT NULL. 
Declare the CustomerID as a foreign key in the FoodOrders table to reference 
the CustomerID column existing in the Customers table.*/

ALTER TABLE FoodOrders
ADD COLUMN OrderDate DATE NOT NULL,
ADD COLUMN CustomerID INT NOT NULL , 
ADD FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID);

/*Task 4: Use the DROP command with ALTER statement to delete the OrderDate 
column from the 'FoodOrder' table. */

ALTER TABLE FoodOrders
DROP COLUMN OrderDate;





