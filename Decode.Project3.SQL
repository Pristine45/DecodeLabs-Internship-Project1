ALTER TABLE capstone_project.cleaneddatasetforproject3
DROP COLUMN MyUnknownColumn;
UPDATE cleaneddatasetforproject3
SET Total_Price = CAST(
REPLACE(REPLACE(Total_Price, '$', ''),',', '')
AS DECIMAL(10, 2));

UPDATE cleaneddatasetforproject3
SET Unit_Price = CAST(
REPLACE(REPLACE(Unit_Price, '$', ''),',', '')
AS DECIMAL(10, 2));

-- BASIC SELECT Query
SELECT * FROM cleaneddatasetforproject3;

-- Orders that are shipped
SELECT Order_ID, Customer_ID, Total_Price, Order_Status
FROM cleaneddatasetforproject3
WHERE Order_Status = 'Shipped';

-- Orders above 3350
SELECT Order_ID, Total_Price
FROM cleaneddatasetforproject3
WHERE Total_Price > 3350;

-- ORDER BY 
-- Sort by highest total price
SELECT Order_ID, Total_Price
FROM cleaneddatasetforproject3
ORDER BY Total_Price DESC;

-- Sort by earliest order date, first 5
SELECT Order_ID, Order_Date
FROM cleaneddatasetforproject3
ORDER BY Order_Date ASC
LIMIT 5;

-- GROUP BY + COUNT
-- Total number of orders per payment method
SELECT Payment_Method, COUNT(*) AS total_order
FROM cleaneddatasetforproject3
GROUP BY Payment_Method;

-- Number of orders per order status
SELECT Order_Status, COUNT(*) AS Total_orders
FROM cleaneddatasetforproject3
GROUP BY Order_Status;

-- GROUP BY + SUM
-- Total revenue by product
SELECT Product, SUM(Total_Price)
FROM cleaneddatasetforproject3
GROUP BY Product
ORDER BY Product DESC;

-- Total revenue by payment method
SELECT Payment_Method, SUM(Total_Price) AS revenue
FROM cleaneddatasetforproject3
GROUP BY Payment_Method
ORDER BY revenue ASC;

-- GROUP BY + AVG
-- Average order value by customer 
SELECT Customer_ID, AVG(Total_Price) AS avg_order_value
FROM cleaneddatasetforproject3
GROUP BY Customer_ID;

-- Average unit price per product
SELECT Product, AVG(unit_price) AS avg_price
FROM cleaneddatasetforproject3
GROUP BY Product;

-- Combined Query (Real Insight)
-- Top 5 best selling products
SELECT Product, SUM(Quantity) AS total_quantity_sold
FROM cleaneddatasetforproject3
GROUP BY Product
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- Revenue by Referral source
SELECT Referral_Source, SUM(Total_Price) AS revenue
FROM cleaneddatasetforproject3
GROUP BY Referral_Source
ORDER BY revenue DESC;

-- Filtering + Aggregation 
-- Revenue from delivered orders only
SELECT SUM(Total_Price) AS total_completed_revenue
FROM cleaneddatasetforproject3
WHERE Order_Status = 'Delivered';

-- Average order value for customers using coupons
SELECT AVG(Total_Price) AS avg_coupon_orders
FROM cleaneddatasetforproject3
WHERE Coupon_Code != 'No Coupon';

-- Multiple Conditions (Advanced WHERE)
-- High-value completed orders
SELECT Order_ID, Total_Price, Payment_Method
FROM cleaneddatasetforproject3
WHERE Order_Status = 'Delivered'
AND Total_Price > 3000
ORDER BY Total_Price DESC;

-- Full Insight Query
-- Customer spending summary
SELECT Customer_ID,
COUNT(Order_ID) AS total_orders,
SUM(Total_Price) AS total_spent,
AVG(Total_Price) AS avg_order_value
FROM cleaneddatasetforproject3
GROUP BY Customer_ID
ORDER BY total_spent DESC;