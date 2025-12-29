drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent Numeric(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock Boolean,
quantity INTEGER
)

--data exploration
--check all data
select * from zepto limit 10;

--check every row imported or not
select count(*) from zepto;

--null values
select * from zepto 
where name IS NULL
or
category IS NULL
or
mrp IS NULL
or
discountPercent IS NULL
or
availableQuantity IS NULL
or
weightInGms IS NULL
or
outOfStock IS NULL
or
quantity IS NULL;


-- different product category
SELECT DISTINCT category
FROM zepto
order by category;


-- product in stock vs. out of stock
SELECT outOfStock, Count(sku_id)
FROM zepto
group by outOfStock;

--product names present multiple time
SELECT name, COUNT(sku_id) as "Number of SKUs"
from zepto
group by name
HAVING count(sku_id)>1
order by count(sku_id) desc;

--data cleaning

-- check products with price = 0

SELECT * from zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

-- delete products with mrp = 0
DELETE from zepto
WHERE mrp = 0;

-- convert mrp from paise to rupees
UPDATE zepto
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

SELECT mrp, discountedSellingPrice from zepto;


--Answer Business Questions

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
Order by discountPercent Desc
LIMIT 10;

-- Q2. What are the Products with High MRP but Out of Stock.
SELECT DISTINCT name, mrp
from zepto
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp DESC;

-- Q3. Calculate Estimated Revenue for each category.
SELECT category,
sum(discountedSellingPrice * availableQuantity) As total_revenue
FROM zepto
group by category
order by  total_revenue;

-- Q4. Find all the products where MRP is greater than 500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
Where mrp > 500 AND discountPercent < 10
Order by mrp desc, discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category, ROUND(AVG(discountPercent),2) as avg_discount
from zepto
group by category
order by avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
from zepto
WHERE weightInGms >= 100
ORDER by price_per_gram;

-- Q7. Group the products into categories like LOW, Medium, Bulk a/c to its weight.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightINGMs < 5000 then 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto;


-- Q8. What is the total Inventory Weight Per Category.
SELECT category, SUM(weightInGms *availableQuantity) As total_weight
from zepto
group by category
order by total_weight;

