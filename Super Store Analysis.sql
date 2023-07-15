SELECT * FROM store;
-- Sales Total Calculation
SELECT SUM(SALES)
FROM STORE;

-- Order Count Calculation
SELECT COUNT(ORDERID)
FROM STORE;

-- Sales Analysis by Product Category
SELECT CATEGORY, SUM(SALES)
FROM STORE
GROUP BY CATEGORY;

-- Sales Analysis by Year
SELECT YEAR(STR_TO_DATE(OrderDate, '%d-%m-%Y')) AS Year, SUM(Sales) AS TotalSales, COUNT(*) AS TotalOrders
FROM store
GROUP BY Year
ORDER BY Year ASC;

-- Sales Analysis by Country
SELECT Country, SUM(Sales) AS TotalSales, COUNT(*) AS TotalOrders
FROM store
GROUP BY Country;

-- Profit Analysis by Customer
SELECT CustomerID, CustomerName, SUM(Profit) AS TotalProfit
FROM store
GROUP BY CustomerID, CustomerName;

-- Most Profitable Product Category Analysis
SELECT Category, SUM(Profit) AS TotalProfit
FROM STORE
GROUP BY Category
ORDER BY TotalProfit DESC
LIMIT 1;

-- Sales Analysis by Order Priority
SELECT OrderPriority, SUM(Sales) AS TotalSales, COUNT(*) AS TotalOrders
FROM Store
GROUP BY OrderPriority;

-- Average Discount Analysis by Product Category
SELECT Category, AVG(Discount) AS AverageDiscount, SUM(DISCOUNT)
FROM store
GROUP BY Category;

-- Shipping Analysis by Region
SELECT Region, COUNT(*) AS TotalShipments
FROM Store
GROUP BY Region;

-- Products with the highest sales
SELECT ProductName, SUM(Sales) AS TotalSales
FROM store
GROUP BY ProductName
ORDER BY TotalSales DESC
LIMIT 5;

-- Products with the lowest sales
SELECT ProductName, SUM(Sales) AS TotalSales
FROM store
GROUP BY ProductName
ORDER BY TotalSales ASC
LIMIT 5;

-- Monthly sales trends
SELECT MONTH(STR_TO_DATE(OrderDate, '%d-%m-%Y')) AS Month, SUM(Sales) AS TotalSales
FROM store
GROUP BY MONTH
ORDER BY MONTH;

-- Yearly sales trends
SELECT YEAR(STR_TO_DATE(OrderDate, '%d-%m-%Y')) AS Year, SUM(Sales) AS TotalSales
FROM STORE
GROUP BY YEAR
ORDER BY YEAR;

-- Customers with the highest number of purchases
SELECT CustomerName, COUNT(OrderID) AS PurchaseCount
FROM STORE
GROUP BY CustomerName
ORDER BY PurchaseCount DESC
LIMIT 5;

-- Customers generating the highest revenue
SELECT CustomerName, SUM(Sales) AS TotalRevenue
FROM STORE
GROUP BY CustomerName
ORDER BY TotalRevenue DESC
LIMIT 5;

-- Correlation between product price and sales quantity
SELECT ProductName, AVG(Sales) AS AveragePrice, SUM(Quantity) AS TotalSalesQuantity
FROM STORE
GROUP BY ProductName
ORDER BY AveragePrice, TotalSalesQuantity;

-- Number of customers based on segment
SELECT Segment, COUNT(DISTINCT CustomerID) AS CustomerCount
FROM store
GROUP BY Segment;

-- Number of customers based on region
SELECT Region, COUNT(DISTINCT CustomerID) AS CustomerCount
FROM store
GROUP BY Region;

-- Customer loyalty analysis
SELECT CustomerName, COUNT(DISTINCT OrderID) AS UniqueOrders
FROM store
GROUP BY CustomerName
ORDER BY UniqueOrders DESC;

-- Customers with the highest profit contribution
SELECT CustomerName, SUM(Profit) AS TotalProfit
FROM store
GROUP BY CustomerName
ORDER BY TotalProfit DESC
LIMIT 5;

-- Total shipping costs
SELECT SUM(ShippingCost) AS TotalShippingCosts
FROM store;

-- Average shipping cost
SELECT AVG(ShippingCost) AS AverageShippingCost
FROM store;

-- Delayed shipments
SELECT *
FROM store
WHERE ShipDate > ShipMode;

-- Shipments not meeting scheduled deadline
SELECT *
FROM store
WHERE ShipDate > (OrderDate + INTERVAL 3 DAY);

-- Shipping method profitability analysis
SELECT ShipMode, SUM(Profit) AS TotalProfit
FROM store
GROUP BY ShipMode;

-- Product sub-category with the highest sales
SELECT SubCategory, SUM(Sales) AS TotalSales
FROM store
GROUP BY SubCategory
ORDER BY TotalSales DESC
LIMIT 5;

-- Best-selling products per category
SELECT Category, ProductName, SUM(Sales) AS TotalSales
FROM store
GROUP BY Category, ProductName
HAVING SUM(Sales) = (
SELECT MAX(TotalSales)
FROM (
SELECT Category, ProductName, SUM(Sales) AS TotalSales
FROM store
GROUP BY Category, ProductName
) AS temp
);
-- Best-selling products per sub-category
SELECT SubCategory, ProductName, SUM(Sales) AS TotalSales
FROM store
GROUP BY SubCategory, ProductName
HAVING SUM(Sales) = (
SELECT MAX(TotalSales)
FROM (
SELECT SubCategory, ProductName, SUM(Sales) AS TotalSales
FROM store
GROUP BY SubCategory, ProductName
) AS temp
);

-- Total profit per category
SELECT Category, SUM(Profit) AS TotalProfit
FROM store
GROUP BY Category;

-- Total profit per sub-category
SELECT SubCategory, SUM(Profit) AS TotalProfit
FROM store
GROUP BY SubCategory;

-- Region with the highest sales
SELECT Region, SUM(Sales) AS TotalSales
FROM store
GROUP BY Region
ORDER BY TotalSales DESC
LIMIT 1;

-- Region with the highest profitability
SELECT Region, SUM(Profit) AS TotalProfit
FROM store
GROUP BY Region
ORDER BY TotalProfit DESC
LIMIT 1;

-- Country with the highest sales
SELECT Country, SUM(Sales) AS TotalSales
FROM store
GROUP BY Country
ORDER BY TotalSales DESC
LIMIT 1;

-- Country with the highest profitability
SELECT Country, SUM(Profit) AS TotalProfit
FROM store
GROUP BY Country
ORDER BY TotalProfit DESC
LIMIT 1;

-- Sales differences among countries
SELECT Country, SUM(Sales) AS TotalSales
FROM store
GROUP BY Country
ORDER BY TotalSales DESC;

-- Sales differences among cities
SELECT City, SUM(Sales) AS TotalSales
FROM store
GROUP BY City
ORDER BY TotalSales DESC;

-- Market share per country
SELECT Country, (SUM(Sales) / (SELECT SUM(Sales) FROM store)) * 100 AS MarketShare
FROM store
GROUP BY Country
ORDER BY MarketShare DESC;

-- Market share per region
SELECT Region, (SUM(Sales) / (SELECT SUM(Sales) FROM store)) * 100 AS MarketShare
FROM store
GROUP BY Region
ORDER BY MarketShare DESC;

-- Calculating the average time between order date and shipping date
SELECT AVG(DATEDIFF(STR_TO_DATE(ShipDate, '%d-%m-%Y'), STR_TO_DATE(OrderDate, '%d-%m-%Y'))) AS AverageShippingTime
FROM store;

-- Determining the average order processing time
SELECT AVG(DATEDIFF(STR_TO_DATE(ShipDate, '%d-%m-%Y'), STR_TO_DATE(OrderDate, '%d-%m-%Y')) + 1) AS AverageProcessingTime
FROM store
WHERE OrderDate IS NOT NULL AND ShipDate IS NOT NULL
AND STR_TO_DATE(ShipDate, '%d-%m-%Y') >= STR_TO_DATE(OrderDate, '%d-%m-%Y');












