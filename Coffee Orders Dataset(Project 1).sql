

SELECT *
FROM Orders

SELECT *
FROM Products

SELECT *
FROM Customers

DROP TABLE IF EXISTS #UpdatedProducts
CREATE TABLE #UpdatedProducts
(ProductID Nvarchar(255),
Size float,
UnitPrice money,
Priceper100g money,
Profit Float,
CoffeeTypeName Nvarchar(255),
RoastypeName Nvarchar(255),
)


INSERT INTO #UpdatedProducts
SELECT ProductID,
Size ,
UnitPrice ,
Priceper100g ,
Profit,
CASE
	WHEN CoffeeType='Ara' THEN 'Arabica'
	WHEN CoffeeType ='Rob' THEN 'Robusa'
	WHEN CoffeeType = 'lib' THEN 'Liberica'
	WHEN CoffeeType = 'Exc' THEN 'Excelsa'
END CoffeeTypeName,
CASE
	WHEN RoastType='L' THEN 'Light'
	WHEN RoastType ='M' THEN 'Medium'
	WHEN RoastType = 'D' THEN 'Dark' 
END RoastTypeName
FROM Products

-- NO Of products Sales Per coffeeType & RoastType
SELECT CoffeeTypeName, RoastypeName,COUNT(pro.ProductID) ProductCount,SUM(Sales) NoOfSales
FROM Orders Ord
JOIN #UpdatedProducts Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID
GROUP BY CoffeeTypeName, RoastypeName


-- Total Number of Customers
SELECT COUNT(Cus.CustomerID) TotalCustomer ,SUM(Sales) NoOfSales
FROM Orders Ord
JOIN #UpdatedProducts Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID


-- ToTalSales Profit Per Region
SELECT Country , SUM(Sales) TotalSales,SUM(Profit) TotalPtofit
FROM Orders Ord
JOIN #UpdatedProducts Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID
GROUP BY Country
ORDER BY TotalPtofit DESC


-- Total sales & Purchases Of Customers
SELECT CustomerName,SUM(Quantity) QuantityOfPurchase,SUM(Sales) TotalSales,
CASE
	WHEN SUM(Sales) >=250 THEN 'Platnum'
	WHEN SUM(sales) >= 150 THEN 'Gold'
	Else 'Silver'
END CustomerStatus
FROM Orders Ord
JOIN #UpdatedProducts Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID
GROUP BY CustomerName
HAVING SUM(Quantity) >=10 
ORDER BY TotalSales DESC


SELECT *
FROM Orders Ord
JOIN #UpdatedProducts Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID
WHERE CustomerName = 'Allis Wilmore'


-- Total Sales & Order By Sizes
SELECT Size, COUNT(OrderID),SUM(Sales)
FROM Orders Ord
JOIN #UpdatedProducts Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID
GROUP BY Size

-- No Of LoyaltyCard Per Region
SELECT Country,LoyaltyCard,COUNT(LoyaltyCard) CountOfLoyaltyCard
FROM Orders Ord
JOIN #UpdatedProducts Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID
GROUP BY Country,LoyaltyCard
ORDER BY LoyaltyCard


-- Cities with the most sales
SELECT Country,City,SUM(Sales) TotalSales
FROM Orders Ord
JOIN #UpdatedProducts Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID
WHERE City IN ('Ballivor','London','Washington')
GROUP BY Country,City
ORDER BY Country ,TotalSales DESC


-- TOP 10 best selling products
SELECT Ord.ProductID,COUNT(OrderID) NoOFOrders,SUM(Sales) As TotalSales
FROM Orders Ord
JOIN #UpdatedProducts Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID
GROUP BY Ord.ProductID
HAVING SUM(Sales) >= 1523
ORDER BY TotalSales DESC


--Total Sales By LoyaltyCard
SELECT LoyaltyCard,COUNT(Cus.CustomerID) NoOfCustomers,SUM(Sales) TotalSales
FROM Orders Ord
JOIN #UpdatedProducts Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID
GROUP BY LoyaltyCard
ORDER BY TotalSales DESC

--CREATING VIEWS

--1 ProfitPerRegion
WITH ProfitPerRegion AS
(
-- ToTalSales Profit Per Region
SELECT Country , SUM(Sales) TotalSales,SUM(Profit) TotalPtofit
FROM Orders Ord
JOIN #UpdatedProducts Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID
GROUP BY Country
--ORDER BY TotalPtofit DESC
)
SELECT *
FROM ProfitPerRegion


CREATE VIEW ProfitPerRegion AS
-- ToTalSales Profit Per Region
SELECT Country , SUM(Sales) TotalSales,SUM(Profit) TotalPtofit
FROM Orders Ord
JOIN Products Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID
GROUP BY Country


SELECT *
FROM #UpdatedProducts


SELECT *
FROM Orders Ord
JOIN #UpdatedProducts Pro
	ON Ord.ProductID = Pro.ProductID
JOIN Customers Cus
	ON ord.CustomerID = Cus.CustomerID





SELECT *
FROM Orders

SELECT *
FROM Customers

