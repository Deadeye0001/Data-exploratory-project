/*
Purpose : Tried to create a database and tabales from scrach
          Ran vaious test to check if the database was giving correct result.
*/

-- Create the Database
Create Database OnlineRetailDB;
Go

-- Use the database
Use OnlineRetailDB;
Go

-- Create the Customer Talbe - 1
Create Table Customers (
	CustomerID	INT PRIMARY KEY IDENTITY(1,1)
	,FirstName NVARCHAR(50)
	,LastName  NVARCHAR(50)
	,Email NVARCHAR (100)
	,Phone NVARCHAR(50)
	,Address NVARCHAR(255)
	,City NVARCHAR(50)
	,State NVARCHAR(50)
	,Zipcode NVARCHAR(50)
	,Country NVARCHAR(50)
	,CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create the Products table - 2
Create Table Products (
	ProductID Int Primary Key Identity(1,1),
	ProductName Nvarchar(100),
	CategoryID Int,
	Price Decimal (10,2),
	Stock Int,
	CreatedAt Datetime Default Getdate()
);

-- Create the Category table - 3
Create Table Categories (
	CategoryID Int Primary key Identity(1,1),
	CategoryName Nvarchar (100),
	Description Nvarchar (255)
);

-- Create the order table - 4
Create Table Orders (
	OrderID Int Primary Key Identity (1,1),
	CustomerID Int, 
	OrderDate Datetime Default GetDate(),
	TotalAmount Decimal (10,2),
	Foreign Key (CustomerID) References Customers(CustomerID)
);

-- Create the OrderItems table - 5
Create Table OrderItems (
	OrderItemID Int Primary Key Identity(1,1),
	OrderID Int,
	ProductID Int,
	Quantity Int,
	Price Decimal (10,2)
	Foreign Key (ProductID) References Products(ProductID),
	Foreign Key (OrderID) References Orders(OrderID)
);

-- Insert sample data into Categories table
Insert into Categories (CategoryName, Description)
Values 
('Electronices', 'Devices and Gadgets'),
('Clothing', 'Apparel and Accessories'),
('Books', 'Printed and Electornics Books');

-- Insert sample data into productes table
Insert into Products (ProductName, CategoryID, Price, Stock)
Values 
('SmartPhone', 1, 699.99, 50),
('Laptop', 1, 999.99, 30),
('T-shirt', 2, 19.99,100),
('Jeans', 2, 49.99, 60),
('Fictions Novel', 3, 14.99, 200),
('Science Journal', 3, 29.99, 150);

-- Insert sample date into Customers table
Insert Into Customers (FirstName, LastName, Email, 
Phone, Address, City, State, Zipcode, Country)
Values
('Sameer', 'Khanna', 'sameer.khanna@example.com', 
'123-456-789', '123 Elm st.', 'SpringFiled', 'IL', '110040', 'India'),
('Jane', 'Smith', 'janesmith@example.com', '456-456-789', 
'563 Oak st.', 'Medison', 'WI', '11057', 'India'),
('Harshad', 'Patel', 'harshadpatel@example.com', '123-897-789', 
'67 mana lane.', 'pune', 'MH', '110087', 'India');

-- Instert sample data into order table
Insert Into Orders ( CustomerID, OrderDate, TotalAmount)
Values
(1, Getdate(), 719.98),
(2, Getdate(), 49.99),
(3, Getdate(), 44.98);

-- Insert sample date into orderitems table
Insert Into OrderItems (OrderID, ProductID, Quantity, Price)
Values 
(1, 1, 1, 69.99),
(1, 3, 1, 19.99),
(2, 4, 1, 49.99),
(3, 5, 1, 14.99),
(3, 6, 1, 29.99);


-- Query 1 : Retreive all orders for a specific customer
Select o.OrderID, o.OrderDate, o.TotalAmount, oi.ProductID,
p.ProductName, oi.Quantity, oi.Price
From Orders o
Join OrderItems oi
On Oi.OrderID = o.OrderID
Join Products p
On p.ProductID	= oi.ProductID
Where o.CustomerID = 1;

-- Query 2 : Frind the total sales for each product
Select p.ProductID, p.ProductName, Sum(oi.Quantity * oi.Price) TotalSales
From OrderItems oi
Join Products p
on p.ProductID = oi.ProductID
Group by p.ProductID, p.ProductName
Order by TotalSales;

--Query 3 : Calculate the average order value
Select AVG(TotalAmount) Average 
From Orders;

--Query 4 : List the top 5 customers by total spending
Select c.CustomerID, c.FirstName, c.LastName, sum(O.TotalAmount) TotalSpent
From Customers c
Join Orders o
on c.CustomerID = o.CustomerID
Group by c.CustomerID, c.FirstName, c.LastName
Order by TotalSpent DESC
Offset 0 Rows
Fetch First 2 rows only;

--Query 5 : Retrieve the most popular product category
Select CategoryID, CategoryName, SoldQuantity
From (
Select c.CategoryID, c.CategoryName, Sum(oi.Quantity) SoldQuantity,
ROW_NUMBER() Over (Order by Sum(oi.Quantity) DESC) as rn
From Products p
Join OrderItems oi
On  p.ProductID = oi.ProductID
Join Categories c
On c.CategoryID = p.CategoryID
Group by c.CategoryID, c.CategoryName
)t
Where rn = 1

--Insert the item without stock
Insert Into Products (ProductName, CategoryID, Price, Stock)
Values ('Keyboard', 1, 39.88, 0)


--Query 6 : List all products that are out of stock 
Select * 
From Products 
Where Stock = 0;

--Query 7 : Find customer who placed Orders in the last 30 days
Select c.CustomerID, c.FirstName, c.LastName, o.OrderDate
From Customers c
Join Orders o
On c.CustomerID = o.CustomerID
Where o.OrderDate >= Dateadd(Day, -30, Getdate());


--Query 8 : Calculate the total numer of orders placed each month

Select  Year(OrderDate) OrderYear, Month(OrderDate) OrderMonth,
Count(OrderID) Totalorders
From Orders
Group by Year(OrderDate), Month(OrderDate)
Order by OrderYear, OrderMonth;

--Query 9 :  Retrieve the details of the most recent order
Select Top 1 c.FirstName, c.LastName, o.Orderdate
From Customers c
join Orders o
On c.CustomerID = o.CustomerID
Order by o.Orderdate DESC;

--Query 10 : Find the average price for each category
Select c.CategoryID, c.CategoryName, AVG(p.Price) AveragePrice
From Categories c
Join Products p
On c.CategoryID = p.CategoryID
Group by c.CategoryID, c.CategoryName;

--Query 11 : List customers who have never placed an order
Select c.CustomerID, c.FirstName, c.LastName, o.OrderID
From Customers c
Left Join Orders o
On c.CustomerID = o.CustomerID
Where o.OrderID is null;

--Query 12 : Retrieve the total quantity sold for each product
Select p.ProductID, p.ProductName, SUM(oi.Quantity) TotalQuantitySold
From Orderitems oi Join Products P
On p.ProductID = oi.ProductID
Group by p.ProductID, p.ProductName;

--Query 13 : Calculate the total Revenue generated from each category
Select  c.CategoryID, c.CategoryName, Sum(oi.Price*oi.Quantity) Revenue
From OrderItems oi 
Left join products p
On p.ProductID = oi.ProductID
Left join Categories c
On C.CategoryID = p.CategoryID
Group by c.CategoryID, c.CategoryName
Order By Revenue DESC;

--Query 14 : Find the highest-priced product in each category
Select c.CategoryID, c.CategoryName, p.ProductID, p.ProductName,
p.Price
From Categories c
Left join Products p
On c.CategoryID = p.CategoryID
Where p.price = (
	Select MAX(price) 
	From Products p1 
	Where p1.CategoryID = p.CategoryID
)
Order by p.Price DESC

-- Query 15 :  Retreive orders with a total amount greater than a specific Value (e.g. $500)
Select *
From Orders
Where TotalAmount >  500
	
-- Query 16 : List products along with the number of orders order by count
Select p.productID, p.ProductName, Count(oi.OrderId) as OrderCount
From Products p Join OrderItems oi
On p.ProductID = oi.ProductID
Group by p.productID, p.ProductName
Order by OrderCount DESC;

--Query 17 : Find the top 3 most frequentyly ordered products
Select Top 3 p.ProductID, p.ProductName, Count(oi.OrderID) OrderCount
From OrderItems oi join Products p
On oi.ProductID = p.ProductID
Group by p.ProductID, p.ProductName
Order by OrderCount

--Query 18 : Calculate the total number of customers from each country
Select count(customerid) TotalCustomer, Country
From customers 
Group by Country
Order by TotalCustomer DESC

--Query 19 : Retrieve the list of customers along with their Spending
Select c.CustomerID, c.FirstName, c.LastName, Sum(o.TotalAmount) TotalSpending
From Orders o Left join Customers c
On o.CustomerID = c.CustomerID
Group by c.CustomerID, c.FirstName, c.LastName

