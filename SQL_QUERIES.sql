/* =========================================================================
   PROJECT: Logistics & Fulfillment Optimization
   PURPOSE: Database creation and supply chain analytics queries
   AUTHOR: Sarthak Maurya
========================================================================= */

-- =========================================================================
-- PART 1: DATABASE SCHEMA SETUP (Creating the Relational Database)
-- =========================================================================

CREATE TABLE Warehouses (
    WarehouseID INT PRIMARY KEY,
    City VARCHAR(50),
    Region VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Weight_kg DECIMAL(5,2)
);

CREATE TABLE Inventory (
    WarehouseID INT,
    ProductID INT,
    CurrentStock INT,
    ReorderThreshold INT,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Shipments (
    ShipmentID INT PRIMARY KEY,
    WarehouseID INT,
    DeliveryPartner VARCHAR(50),
    OrderDate DATE,
    PromisedDeliveryDate DATE,
    ActualDeliveryDate DATE,
    DeliveryStatus VARCHAR(20), 
    OrderValue_INR DECIMAL(10,2),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);

-- =========================================================================
-- PART 2: ANALYTICAL QUERIES (Business Insights)
-- =========================================================================

/* QUERY 1: On-Time Delivery Rate (OTDR) by Warehouse
DESCRIPTION: Uses conditional aggregation to calculate the percentage of 
shipments delivered on time, highlighting regional operational bottlenecks.
*/
SELECT 
    w.City,
    COUNT(s.ShipmentID) AS Total_Shipments,
    SUM(CASE WHEN s.DeliveryStatus = 'Delivered' THEN 1 ELSE 0 END) AS On_Time_Deliveries,
    ROUND((SUM(CASE WHEN s.DeliveryStatus = 'Delivered' THEN 1 ELSE 0 END) / COUNT(s.ShipmentID)) * 100, 2) AS On_Time_Rate_Pct
FROM 
    Shipments s
JOIN 
    Warehouses w ON s.WarehouseID = w.WarehouseID
GROUP BY 
    w.City
ORDER BY 
    On_Time_Rate_Pct ASC;


/* QUERY 2: Critical Inventory Alerts (Using Common Table Expressions)
DESCRIPTION: Identifies which products at which warehouses are below their 
safety stock levels to prevent fulfillment delays.
*/
WITH StockAlerts AS (
    SELECT 
        i.WarehouseID,
        i.ProductID,
        i.CurrentStock,
        i.ReorderThreshold,
        (i.ReorderThreshold - i.CurrentStock) AS Deficit
    FROM 
        Inventory i
    WHERE 
        i.CurrentStock < i.ReorderThreshold
)
SELECT 
    w.City,
    p.ProductName,
    p.Category,
    sa.CurrentStock,
    sa.Deficit AS Units_Needed_To_Restock
FROM 
    StockAlerts sa
JOIN 
    Warehouses w ON sa.WarehouseID = w.WarehouseID
JOIN 
    Products p ON sa.ProductID = p.ProductID
ORDER BY 
    sa.Deficit DESC;