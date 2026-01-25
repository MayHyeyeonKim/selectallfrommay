# DISTINCT

## Overview

DISTINCT removes duplicate rows from query results. Use it to get unique values from one or more columns.

## Basic Syntax

```sql
SELECT DISTINCT column1, column2, ...
FROM table_name;
```

## Single Column

```sql
-- Without DISTINCT (with duplicates)
SELECT city FROM customers;
-- Result: Seoul, Seoul, Busan, Seoul, Tokyo, Busan, Seoul ...

-- With DISTINCT (unique values only)
SELECT DISTINCT city FROM customers;
-- Result: Seoul, Busan, Tokyo
```

### Common Examples

```sql
-- All unique countries
SELECT DISTINCT country FROM customers;

-- All unique job titles
SELECT DISTINCT job_title FROM employees;

-- All unique categories
SELECT DISTINCT category FROM products;

-- All unique order statuses
SELECT DISTINCT status FROM orders;
```

## Multiple Columns

When using DISTINCT with multiple columns, it returns unique **combinations** of those columns.

```sql
-- Unique country and city combinations
SELECT DISTINCT country, city FROM customers;

-- Result:
-- country  | city
-- ---------|--------
-- Korea    | Seoul
-- Korea    | Busan
-- Japan    | Tokyo
-- Japan    | Osaka
-- USA      | New York
```

```sql
-- Unique product and supplier combinations
SELECT DISTINCT product_id, supplier_id FROM inventory;

-- Unique year and month combinations from orders
SELECT DISTINCT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month
FROM orders
ORDER BY year, month;
```

## DISTINCT with COUNT

```sql
-- Total number of orders
SELECT COUNT(*) FROM orders;                        -- 1000

-- Number of unique customers who ordered
SELECT COUNT(DISTINCT customer_id) FROM orders;     -- 250

-- Number of unique products sold
SELECT COUNT(DISTINCT product_id) FROM order_items; -- 75

-- Multiple DISTINCT counts in one query
SELECT 
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT product_id) AS unique_products,
    COUNT(*) AS total_orders
FROM orders;
```

## DISTINCT with WHERE

```sql
-- Unique customers who ordered in last 30 days
SELECT DISTINCT customer_id 
FROM orders 
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days';

-- Unique categories with stock available
SELECT DISTINCT category 
FROM products 
WHERE stock > 0;

-- Unique suppliers for a specific product
SELECT DISTINCT supplier_id
FROM inventory
WHERE product_id = 123;
```

## DISTINCT vs GROUP BY

Both can return unique values, but they serve different purposes.

### Same Result

```sql
-- These produce the same result
SELECT DISTINCT city FROM customers;

SELECT city FROM customers GROUP BY city;
```

### When to Use Which

```sql
-- ✅ Use DISTINCT: Just need unique values
SELECT DISTINCT category FROM products;

-- ✅ Use GROUP BY: Need aggregation
SELECT category, COUNT(*) AS product_count
FROM products
GROUP BY category;

-- ✅ Use GROUP BY: Multiple aggregations
SELECT 
    city,
    COUNT(*) AS customer_count,
    AVG(total_spent) AS avg_spent
FROM customers
GROUP BY city;
```

**Rule of thumb:**
- **DISTINCT**: Only unique values, no aggregation
- **GROUP BY**: Unique values + aggregation (COUNT, SUM, AVG, etc.)

## DISTINCT with ORDER BY

```sql
-- Order unique cities alphabetically
SELECT DISTINCT city 
FROM customers 
ORDER BY city;

-- Order by a column not in SELECT (some databases allow this)
SELECT DISTINCT customer_id
FROM orders
ORDER BY order_date DESC;  -- May not work in all databases

-- Safe approach: Include ordering column
SELECT DISTINCT customer_id, order_date
FROM orders
ORDER BY order_date DESC;
```

## DISTINCT ON (PostgreSQL Only)

PostgreSQL has a special `DISTINCT ON` clause for getting the first row of each group.

```sql
-- Get the latest order for each customer
SELECT DISTINCT ON (customer_id)
    customer_id,
    order_date,
    total_amount
FROM orders
ORDER BY customer_id, order_date DESC;

-- Get the most expensive product in each category
SELECT DISTINCT ON (category)
    category,
    product_name,
    price
FROM products
ORDER BY category, price DESC;
```

## NULL Handling

DISTINCT treats NULL as a unique value - only one NULL appears in results.

```sql
-- If phone column has: NULL, NULL, '123-4567', NULL, '123-4567', '999-0000'
SELECT DISTINCT phone FROM customers;
-- Result: NULL, '123-4567', '999-0000' (only 1 NULL)

-- Count NULL as separate value
SELECT COUNT(DISTINCT phone) FROM customers;  -- Includes NULL as 1 unique value

-- Exclude NULLs
SELECT DISTINCT phone 
FROM customers 
WHERE phone IS NOT NULL;
```

## Performance Considerations

### DISTINCT is Expensive

```sql
-- ❌ Slow on large tables (requires sorting/hashing)
SELECT DISTINCT category FROM products;  -- 10 million rows

-- ✅ Better: Use index on category column
CREATE INDEX idx_products_category ON products(category);
SELECT DISTINCT category FROM products;
```

### Avoid Unnecessary DISTINCT

```sql
-- ❌ Unnecessary: id is PRIMARY KEY (already unique)
SELECT DISTINCT id FROM users;

-- ❌ Unnecessary: Query already returns unique results
SELECT DISTINCT u.user_id 
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE u.user_id = 123;  -- Single user, already unique

-- ✅ Necessary: Multiple orders per user
SELECT DISTINCT user_id 
FROM orders 
WHERE order_date > '2026-01-01';
```

### DISTINCT with Large Result Sets

```sql
-- ❌ Slow: DISTINCT on many columns with large dataset
SELECT DISTINCT 
    customer_id, 
    product_id, 
    order_date, 
    quantity, 
    price
FROM order_history;  -- Millions of rows

-- ✅ Better: Be specific about what needs to be unique
SELECT DISTINCT customer_id, product_id
FROM order_history;
```

## Common Patterns

### Find Duplicates

```sql
-- Find cities that appear more than once
SELECT city, COUNT(*) as count
FROM customers
GROUP BY city
HAVING COUNT(*) > 1;

-- Find customers with multiple orders
SELECT customer_id, COUNT(*) as order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

### Deduplicate Before JOIN

```sql
-- Get unique active users before joining
SELECT o.order_id, u.name
FROM orders o
JOIN (
    SELECT DISTINCT user_id, name 
    FROM users 
    WHERE status = 'active'
) u ON o.user_id = u.user_id;
```

### Multi-Table Unique Values

```sql
-- Unique emails from multiple sources
SELECT DISTINCT email FROM customers
UNION
SELECT DISTINCT email FROM newsletter_subscribers;

-- Or use UNION (which already removes duplicates)
SELECT email FROM customers
UNION
SELECT email FROM newsletter_subscribers;
```

## DISTINCT in Subqueries

```sql
-- Customers who ordered distinct products
SELECT customer_id
FROM (
    SELECT DISTINCT customer_id, product_id
    FROM orders
) AS unique_orders
GROUP BY customer_id
HAVING COUNT(*) > 5;  -- Ordered more than 5 different products

-- Products not in any order
SELECT product_id, product_name
FROM products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id 
    FROM order_items
);
```

## Best Practices

1. **Use only when needed**
   ```sql
   -- ❌ Don't use if data is already unique
   SELECT DISTINCT id FROM users;  -- id is PRIMARY KEY
   
   -- ✅ Use when duplicates exist
   SELECT DISTINCT category FROM products;
   ```

2. **Index columns used with DISTINCT**
   ```sql
   CREATE INDEX idx_category ON products(category);
   SELECT DISTINCT category FROM products;  -- Much faster
   ```

3. **Be specific with columns**
   ```sql
   -- ❌ Too many columns
   SELECT DISTINCT * FROM large_table;
   
   -- ✅ Only necessary columns
   SELECT DISTINCT category, brand FROM products;
   ```

4. **Consider GROUP BY for complex queries**
   ```sql
   -- ❌ DISTINCT with additional logic is unclear
   SELECT DISTINCT user_id FROM orders WHERE total > 100;
   
   -- ✅ GROUP BY is clearer when you might add aggregations later
   SELECT user_id 
   FROM orders 
   WHERE total > 100
   GROUP BY user_id;
   ```

5. **Handle NULLs explicitly**
   ```sql
   -- Be clear about NULL handling
   SELECT DISTINCT COALESCE(category, 'Uncategorized') AS category
   FROM products;
   ```

## Common Mistakes

### 1. DISTINCT Placement

```sql
-- ❌ WRONG: DISTINCT applies to entire SELECT
SELECT name, DISTINCT age FROM people;  -- Syntax error

-- ✅ CORRECT: DISTINCT after SELECT
SELECT DISTINCT name, age FROM people;
```

### 2. DISTINCT with Aggregate Functions

```sql
-- ❌ WRONG: DISTINCT outside aggregate
SELECT DISTINCT COUNT(*) FROM orders;  -- Meaningless

-- ✅ CORRECT: DISTINCT inside aggregate
SELECT COUNT(DISTINCT customer_id) FROM orders;
```

### 3. Expecting DISTINCT on One Column Only

```sql
-- ❌ WRONG EXPECTATION: This doesn't give unique cities only
SELECT DISTINCT city, customer_name FROM customers;
-- Returns unique (city, customer_name) combinations, not unique cities

-- ✅ CORRECT: For unique cities only
SELECT DISTINCT city FROM customers;
```

## Database Differences

| Database    | DISTINCT | DISTINCT ON | NULL Handling      |
| ----------- | -------- | ----------- | ------------------ |
| PostgreSQL  | ✅ Yes   | ✅ Yes      | 1 NULL in results  |
| MySQL       | ✅ Yes   | ❌ No       | 1 NULL in results  |
| SQL Server  | ✅ Yes   | ❌ No       | 1 NULL in results  |
| Oracle      | ✅ Yes   | ❌ No       | 1 NULL in results  |

All major databases support basic DISTINCT. Only PostgreSQL has DISTINCT ON.

## Related Topics

- [NullHandling](NullHandling.md) - How DISTINCT treats NULL values
- [OperatorPrecedence](OperatorPrecedence.md) - Query execution order
- [SQLCOMMANDS](SQLCOMMANDS.md) - Other SQL commands
