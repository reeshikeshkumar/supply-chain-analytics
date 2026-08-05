# Supply Chain Analytics Dashboard

##  Project Overview

This project analyzes supply chain operations to uncover insights related to revenue performance, order trends, and logistics efficiency. The goal is to identify key business drivers and operational bottlenecks that impact overall performance.

---

## Objective

The main objective of this project is to:

* Analyze revenue distribution across products and regions
* Evaluate shipping performance and delivery delays
* Identify patterns in order trends over time
* Provide actionable insights to improve supply chain efficiency

---

##  Dataset Overview

* Dataset: Supply Chain dataset
* Records: ~100,000+ transactions
* Data includes:

  * Order information
  * Product details
  * Customer data
  * Shipping and delivery metrics

---

## Tools & Technologies

* **Python (Pandas)** → Data cleaning and feature engineering
* **SQL (SQLite)** → Business query analysis
* **Tableau** → Interactive dashboard visualization

---

## Data Processing

The dataset was cleaned and prepared using Python:

* Removed duplicate records
* Converted date fields into proper datetime format
* Created new features such as:

  * `shipping_delay` (actual vs scheduled delivery difference)
  * `is_late` (late delivery indicator)
* Standardized column names for better usability

The cleaned dataset was stored in a SQLite database for efficient querying and integration with Tableau.

---

##  Analysis Areas

### 1. Revenue Analysis

* Total revenue generated across all orders
* Revenue contribution by product category
* Top-performing products by sales

### 2. Order Trends

* Monthly order volume trends
* Identification of peak and low demand periods

### 3. Logistics Performance

* Average shipping time vs scheduled time
* Shipping delay analysis across regions
* Performance comparison by shipping mode

### 4. Late Delivery Analysis

* Overall late delivery rate
* Late deliveries segmented by region and shipping mode

---

## Dashboard Features

The Tableau dashboard includes:

* **Key KPIs**:

  * Total Revenue
  * Total Orders
  * Late Delivery Percentage

* **Visualizations**:

  * Monthly order trend (time series)
  * Revenue by product category
  * Orders by region
  * Shipping delay by shipping mode
  * Late delivery rate comparison

* **Interactivity**:

  * Filters for Region, Shipping Mode, and Category
  * Dynamic exploration of data across multiple dimensions

---

##  Key Insights

* A small number of product categories contribute a significant portion of total revenue
* Certain shipping modes show consistently higher delivery delays
* Some regions experience higher late delivery rates, indicating logistical inefficiencies
* Order volume shows clear trends over time, suggesting seasonality or demand patterns

---

##  Conclusion

This analysis highlights critical areas for improving supply chain performance:

* Optimize underperforming shipping modes
* Focus on high-revenue product categories
* Improve logistics operations in regions with high delay rates

The dashboard provides a comprehensive and interactive tool for monitoring and improving supply chain efficiency.

---

##  Future Improvements

* Incorporate predictive modeling for demand forecasting
* Add real-time data integration
* Perform customer segmentation for deeper insights

---
