create database Mangata_Gallo;
drop database Mangata_Gallo;
use Mangata_Gallo;

/*The objective of this activity
Apply commonly used types of constraints in MySQL.*/

/*Task 1: Create the Clients table with the following columns and constraints.
ClientID: INT, NOT NULL and PRIMARY KEY
FullName: VARCHAR(100) NOT NULL
PhoneNumber: INT, NOT NULL and UNIQUE */
CREATE TABLE Clients(
        ClientID INT NOT NULL PRIMARY KEY, 
        FullName VARCHAR(100) NOT NULL,
        PhoneNumber INT NOT NULL UNIQUE);
show columns from clients;

/* Task 2: Create the Items table with the following attributes and constraints:
ItemID: INT, NOT NULL and PRIMARY KEY
ItemName: VARCHAR(100) and NOT NULL
Price: Decimal(5,2) and NOT NULL*/
CREATE TABLE Items(
       ItemID INT NOT NULL PRIMARY KEY,
       ItemName VARCHAR(100) NOT NULL,
       Price DECIMAL(5,2) NOT NULL);
show columns from items;

/*Task 3: Create the Orders table with the following constraints.
OrderID: INT, NOT NULL and PRIMARY KEY
ClientID: INT, NOT NULL and FOREIGN KEY
ItemID: INT, NOT NULL and FOREIGN KEY
Quantity: INT, NOT NULL and maximum allowed items in each order 3 only
COST Decimal(6,2) and NOT NULL*/

CREATE TABLE Orders(
       OrderID INT NOT NULL PRIMARY KEY,
       ClientID INT NOT NULL,
       ItemID INT NOT NULL,
       Quantity INT NOT NULL CHECK(Quantity <=3),
       Cost DECIMAL(6,2) NOT NULL,
       FOREIGN KEY(ClientID) REFERENCES Clients(ClientID) ON DELETE CASCADE,
       FOREIGN KEY(ItemID) REFERENCES Items(ItemID) ON DELETE CASCADE );
       
/*Task 4:  Create the Staff table with the following PRIMARY KEY and NOT NULL constraints:
Staff ID should be INT, NOT NULL and PRIMARY KEY
PhoneNumber should be INT, NOT NULL and UNIQUE 
FullName: VARCHAR(100) NOT NULL.*/

CREATE TABLE Staff(
       StaffID INT NOT NULL PRIMARY KEY,
       PhoneNumber INT NOT NULL UNIQUE,
       FullName VARCHAR(100) NOT NULL);
       

/*Task 5: Create the 'ContractInfo' table with the following key and domain constraints:
Contract ID should be INT, NOT NULL and PRIMARY KEY
StaffID should be INT, NOT NULL. 
Salary should be DECIMAL (7,2), NOT NULL.
Location should be VARCHAR (50) NOT NULL with DEFAULT = "Texas". 
StaffType should be VARCHAR (20) NOT NULL and should accept a "Junior" or a "Senior" value.*/

CREATE TABLE ContractInfo(
       ContractID INT NOT NULL PRIMARY KEY,
       StaffID INT NOT NULL,
       Salary DECIMAL(7,2) NOT NULL,
       Location VARCHAR(50) NOT NULL DEFAULT "Texas",
       StaffType VARCHAR(20) NOT NULL CHECK (StaffType = "Junior" OR StaffType = "Senior"),
       FOREIGN KEY(StaffID) REFERENCES  Staff(StaffID)
       );
       
/*Task 3: Create a foreign key that links the Staff table with the ContractInfo table. 
In this example, you need to apply the referential integrity rule as follows:
Link each member of staff in the Staff table to a specific contract in the Contract Info table. 
Each staff ID existing in the 'Contract Info' table is expected to exist as well in the Staff table. 
The staff ID in the 'Contract Info' table should be defined as a 
foreign key to reference the Staff ID in the Staff table.*/


/*Task 4
Write a SQL statement that creates the Staff table with the following columns.
StaffID: INT , FullName: VARCHAR(100), PhoneNumber: VARCHAR(10)  */

ALTER TABLE Staff
MODIFY COLUMN PhoneNumber VARCHAR(10);

/*Task 5
Write a SQL statement to apply the following constraints to the Staff table:
StaffID: INT NOT NULL and PRIMARY KEY
FullName: VARCHAR(100) and NOT NULL
PhoneNumber: INT NOT NULL  */

ALTER TABLE Staff
MODIFY COLUMN PhoneNumber VARCHAR(10) NOT NULL;


/*Task 6
Write a SQL statement that adds a new column 
called 'Role' to the Staff table with the following constraints:
Role: VARCHAR(50) and NOT NULL*/

ALTER TABLE Staff
ADD COLUMN Role VARCHAR(50) NOT NULL;
show columns from Staff;

/*Task 4
Write a SQL statement that drops 
the Phone Number column from the 'Staff' table.*/
ALTER TABLE Staff
DROP COLUMN PhoneNumber;
show columns from Staff;

