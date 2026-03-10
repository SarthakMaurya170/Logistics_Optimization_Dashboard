# Logistics & Fulfillment Operations Analytics

##  Project Overview
In the fast-paced e-commerce and healthcare delivery sectors, supply chain efficiency is critical. This project is an end-to-end data analytics solution designed to track inventory health, monitor delivery partner performance, and optimize the **On-Time Delivery Rate (OTDR)** across multiple regional fulfillment centers. 

This repository contains the complete workflow: from generating a massive synthetic dataset with Python, to structuring a relational database with SQL, to building an interactive, enterprise-grade Power BI dashboard.

##  Tech Stack
* **Python (Pandas, NumPy):** Automated the generation of a 5,000+ row realistic dataset encompassing order dates, delivery statuses, and partner assignments.
* **MySQL:** Designed a multi-table relational schema (`Warehouses`, `Products`, `Inventory`, `Shipments`) and utilized Common Table Expressions (CTEs) and conditional aggregations to extract operational bottlenecks.
* **Power BI:** Handled complex data modeling (One-to-Many relationships), wrote advanced DAX measures for KPI tracking, and designed a UI/UX-focused interactive dashboard.

##  The Dashboard
*(Insert a screenshot of your Power BI dashboard here. You can do this by dragging and dropping your image file directly into the GitHub text editor!)*

##  Key Business Insights Discovered
* **Delivery Partner Bottlenecks:** Identified that **[Insert Partner Name, e.g., BlueDart]** was responsible for **[Insert %]** of all delayed shipments, indicating a need for contract renegotiation or route optimization.
* **Regional Performance:** The **[Insert City, e.g., Mumbai]** fulfillment center struggled the most, operating at an On-Time Delivery Rate of only **[Insert %]**.
* **Critical Inventory Alerts:** Uncovered a severe stock deficit of **[Insert number]** units in the **[Insert Category, e.g., Consumables]** category, automatically flagging it for immediate replenishment to avoid stockouts.

##  Repository Contents
* `Massive_Shipments_Data.csv`: The 5,000-row generated dataset used for the analysis.
* `logistics_analysis_queries.sql`: The SQL script containing the database schema and analytical queries.
* `data_generator.py`: The Python script used to build the randomized, time-series data.
* `Logistics_Optimization_Dashboard.pbix`: The raw Power BI file containing the data model and visual report. *(See screenshot above for the live view)*.

##  How to Run
1. Review the SQL logic in `logistics_analysis_queries.sql`.
2. Download the `.pbix` file and open it in Power BI Desktop to interact with the dynamic slicers and DAX measures.
