# 📊 Zepto Product Data Analysis using SQL (PostgreSQL)

## 📌 Overview

This project focuses on analyzing **Zepto product data** using **SQL in PostgreSQL** to derive meaningful business insights.
The analysis answers real-world business questions related to **pricing, discounts, inventory, and category performance**, demonstrating strong SQL and data analytics skills.

---

## 🗂️ Dataset

* Source: [Zepto product inventory data](https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset?resource=download)
* Format: CSV (imported into PostgreSQL)
* Table Name: `zepto_v2.csv`
* Records include:

  * Size: 3731 Records * 9 Columns
  * Product name & category
  * MRP & discounted price
  * Discount percentage
  * Stock availability
  * Product weight & quantity

---

## 🛠️ Tools & Technologies

* **PostgreSQL** – Database & querying
* **SQL** – Data cleaning, aggregation & analysis
* **pgAdmin / psql** – Query execution
* **CSV Dataset** – Raw data source

---

## ⚙️ Project Workflow

1. Created PostgreSQL table schema
2. Imported dataset into PostgreSQL
3. Performed data exploration & validation
4. Cleaned pricing inconsistencies
5. Executed business-driven SQL queries
6. Extracted KPIs and insights

---

## 🧹 Data Cleaning & Preparation

```sql
-- Remove invalid pricing records
DELETE FROM zepto
WHERE mrp = 0;

-- Convert prices from paise to rupees
UPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;
```

---

## 📈 Key KPIs & Business Insights

### 🔹 1. Top 10 Best Value Products (Highest Discount)

```sql
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;
```

**Insight:** Identifies products offering maximum savings to customers.

---

### 🔹 2. High-MRP Products That Are Out of Stock

```sql
SELECT DISTINCT name, mrp
FROM zepto
WHERE outOfStock = TRUE AND mrp > 300
ORDER BY mrp DESC;
```

**Insight:** Highlights potential **revenue loss** due to stock unavailability.

---

### 🔹 3. Estimated Revenue by Category (KPI)

```sql
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;
```

**KPI:** 📌 *Category-wise Revenue Contribution*

---

### 🔹 4. Premium Products with Low Discounts

```sql
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC;
```

**Insight:** Identifies premium products with minimal promotional offers.

---

### 🔹 5. Top 5 Categories with Highest Average Discount

```sql
SELECT category,
ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;
```

**KPI:** 📌 *Average Discount % by Category*

---

### 🔹 6. Best Value Products by Price per Gram

```sql
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;
```

**Insight:** Helps customers identify **cost-effective bulk purchases**.

---

### 🔹 7. Product Segmentation by Weight

```sql
SELECT DISTINCT name, weightInGms,
CASE
  WHEN weightInGms < 1000 THEN 'Low'
  WHEN weightInGms < 5000 THEN 'Medium'
  ELSE 'Bulk'
END AS weight_category
FROM zepto;
```

**Insight:** Useful for inventory and logistics planning.

---

### 🔹 8. Total Inventory Weight per Category (KPI)

```sql
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight DESC;
```

**KPI:** 📌 *Inventory Load Distribution*

---

## ▶️ How to Run the Project

1. Install **PostgreSQL**
2. Create a database
3. Run the table creation script
4. Import the CSV dataset
5. Execute the SQL queries provided
6. Analyze the results

---

## 🎯 Skills Demonstrated

* Advanced SQL querying
* PostgreSQL database handling
* Data cleaning & validation
* KPI calculation & business insights
* Analytical problem-solving

---

