# ORDER BY — Sorting Data

## Overview

ORDER BY sorts query results in ascending (ASC) or descending (DESC) order. Without ORDER BY, results are returned in an unpredictable order.

## Basic Syntax

```sql
SELECT column1, column2
FROM table_name
ORDER BY column1 [ASC|DESC], column2 [ASC|DESC];
```

- **ASC**: Ascending order (default, can be omitted)
- **DESC**: Descending order

## Single Column Sorting

```sql
-- Name alphabetically (A → Z)
SELECT name, age FROM employees
ORDER BY name;  -- ASC is default

SELECT name, age FROM employees
ORDER BY name ASC;  -- Explicit

-- Age descending (oldest first)
SELECT name, age FROM employees
ORDER BY age DESC;

-- Highest salary first
SELECT name, salary FROM employees
ORDER BY salary DESC;

-- Most recent orders
SELECT order_id, order_date FROM orders
ORDER BY order_date DESC;

-- Oldest records first
SELECT * FROM logs
ORDER BY created_at ASC;
```

## Multiple Column Sorting

Order matters! Results are sorted by first column, then by second column within same first column values, etc.

```sql
-- By department, then by salary within each department
SELECT name, department, salary FROM employees
ORDER BY department ASC, salary DESC;

-- By country, then city
SELECT country, city, customer_name FROM customers
ORDER BY country, city;

-- Complex sorting
SELECT product_name, category, price, stock FROM products
ORDER BY category ASC, stock DESC, price ASC;
```

**Example:**
```
-- ORDER BY department, salary DESC

name     | department | salary
---------|------------|--------
Alice    | HR         | 70000
Bob      | HR         | 60000
Charlie  | IT         | 90000
David    | IT         | 85000
Eve      | IT         | 80000
```

## Sort by Data Type

### Numbers

```sql
-- 1, 2, 3, 10, 100 (ASC)
SELECT * FROM products ORDER BY price ASC;

-- 100, 10, 3, 2, 1 (DESC)
SELECT * FROM products ORDER BY price DESC;
```

### Strings

```sql
-- A, B, C... Z (case-sensitive in some DBs)
SELECT * FROM customers ORDER BY name ASC;

-- Z, Y, X... A
SELECT * FROM customers ORDER BY name DESC;

-- Case-insensitive sorting
SELECT * FROM customers ORDER BY LOWER(name);
SELECT * FROM customers ORDER BY UPPER(name);
```

### Dates

```sql
-- Oldest to newest
SELECT * FROM orders ORDER BY order_date ASC;

-- Newest to oldest
SELECT * FROM orders ORDER BY order_date DESC;

-- By year and month
SELECT * FROM orders
ORDER BY 
    EXTRACT(YEAR FROM order_date) DESC,
    EXTRACT(MONTH FROM order_date) DESC;
```

## NULL Handling

NULL behavior varies by database. Generally, NULLs are sorted as the highest values.

```sql
-- PostgreSQL/MySQL: NULLs last by default on ASC
SELECT name, phone FROM customers
ORDER BY phone ASC;  -- NULL at the end

-- Force NULLs first
SELECT name, phone FROM customers
ORDER BY phone ASC NULLS FIRST;

-- Force NULLs last
SELECT name, phone FROM customers
ORDER BY phone ASC NULLS LAST;

-- Replace NULL for sorting
SELECT name, phone FROM customers
ORDER BY COALESCE(phone, '');  -- Treat NULL as empty string

SELECT name, phone FROM customers
ORDER BY COALESCE(phone, 'ZZZZZ');  -- NULLs at the end
```

**Database differences:**

| Database    | NULL Position (ASC) | NULLS FIRST/LAST Support |
| ----------- | ------------------- | ------------------------ |
| PostgreSQL  | Last                | ✅ Yes                   |
| MySQL       | First               | ❌ No (use workarounds)  |
| SQL Server  | First               | ❌ No (use workarounds)  |
| Oracle      | Last                | ✅ Yes                   |

## Sorting by Column Position

You can reference columns by their position in the SELECT list (1-based).

```sql
-- Sort by 3rd column (salary)
SELECT name, age, salary FROM employees
ORDER BY 3 DESC;

-- Multiple columns
SELECT name, department, salary FROM employees
ORDER BY 2, 3 DESC;  -- department ASC, salary DESC
```

**⚠️ Not Recommended:**
- Reduces readability
- Breaks if column order changes
- Use explicit column names instead

```sql
-- ❌ Unclear
ORDER BY 2, 3 DESC

-- ✅ Clear
ORDER BY department ASC, salary DESC
```

## Sorting by Expression

```sql
-- Calculated value
SELECT name, price, quantity, (price * quantity) AS total
FROM order_items
ORDER BY price * quantity DESC;

-- Or use alias
SELECT name, price, quantity, (price * quantity) AS total
FROM order_items
ORDER BY total DESC;

-- String length
SELECT name FROM customers
ORDER BY LENGTH(name) DESC;

-- Absolute value
SELECT temperature FROM weather_data
ORDER BY ABS(temperature);

-- Date difference
SELECT name, birth_date FROM employees
ORDER BY AGE(birth_date) DESC;

-- Random order
SELECT * FROM products
ORDER BY RANDOM();  -- PostgreSQL
-- ORDER BY RAND();     -- MySQL
-- ORDER BY NEWID();    -- SQL Server
```

## Conditional Sorting with CASE

```sql
-- Custom priority order
SELECT name, status FROM tasks
ORDER BY 
    CASE status
        WHEN 'urgent' THEN 1
        WHEN 'high' THEN 2
        WHEN 'normal' THEN 3
        WHEN 'low' THEN 4
    END;

-- Specific values first, then alphabetically
SELECT product_name, category FROM products
ORDER BY 
    CASE 
        WHEN category = 'Featured' THEN 1
        WHEN category = 'New' THEN 2
        ELSE 3
    END,
    product_name;

-- Custom business logic
SELECT customer_name, total_spent FROM customers
ORDER BY
    CASE
        WHEN total_spent > 10000 THEN 1  -- VIP first
        WHEN total_spent > 5000 THEN 2   -- Premium
        ELSE 3                            -- Regular
    END,
    total_spent DESC;
```

## ORDER BY with LIMIT/OFFSET

```sql
-- Top 10 highest salaries
SELECT name, salary FROM employees
ORDER BY salary DESC
LIMIT 10;

-- Rank 11-20
SELECT name, salary FROM employees
ORDER BY salary DESC
LIMIT 10 OFFSET 10;

-- Latest 5 orders
SELECT * FROM orders
ORDER BY order_date DESC
LIMIT 5;

-- Pagination: Page 3, 20 items per page
SELECT * FROM products
ORDER BY product_id
LIMIT 20 OFFSET 40;  -- (3-1) * 20 = 40
```

**Note:** SQL Server uses `TOP` instead of `LIMIT`:
```sql
-- SQL Server
SELECT TOP 10 name, salary FROM employees
ORDER BY salary DESC;

-- With OFFSET (SQL Server 2012+)
SELECT name, salary FROM employees
ORDER BY salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
```

## ORDER BY with DISTINCT

```sql
-- Unique categories, sorted
SELECT DISTINCT category FROM products
ORDER BY category;

-- ⚠️ Be careful: ORDER BY column must be in SELECT when using DISTINCT
SELECT DISTINCT category FROM products
ORDER BY price;  -- ❌ Error in strict mode (PostgreSQL)

-- ✅ Solution: Include price in SELECT
SELECT DISTINCT category, price FROM products
ORDER BY price;
```

## ORDER BY with Aggregation

```sql
-- Top 5 customers by total purchases
SELECT customer_id, SUM(total) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- Average salary by department
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

-- Product count by category
SELECT category, COUNT(*) AS product_count
FROM products
GROUP BY category
ORDER BY product_count DESC, category ASC;
```

## Performance Optimization

### Use Indexes

```sql
-- ✅ Fast: Indexed column
CREATE INDEX idx_orders_date ON orders(order_date);
SELECT * FROM orders ORDER BY order_date DESC;

-- ✅ Fast: Composite index matches ORDER BY
CREATE INDEX idx_emp_dept_salary ON employees(department, salary DESC);
SELECT * FROM employees ORDER BY department, salary DESC;

-- ❌ Slow: No index
SELECT * FROM orders ORDER BY customer_name;

-- ❌ Slow: Function breaks index usage
SELECT * FROM customers ORDER BY UPPER(name);

-- ✅ Solution: Function-based index (PostgreSQL, Oracle)
CREATE INDEX idx_upper_name ON customers(UPPER(name));
SELECT * FROM customers ORDER BY UPPER(name);
```

### Avoid Sorting Large Results

```sql
-- ❌ Slow: Sorting millions of rows
SELECT * FROM huge_table ORDER BY some_column;

-- ✅ Better: Filter first, then sort
SELECT * FROM huge_table
WHERE created_date > '2026-01-01'
ORDER BY some_column
LIMIT 100;

-- ✅ Better: Use indexed columns for sorting
SELECT * FROM huge_table
ORDER BY id  -- id is indexed
LIMIT 100;
```

### ORDER BY Position in Query

ORDER BY is executed **after** WHERE, GROUP BY, and HAVING:

```sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
WHERE status = 'active'           -- 1. Filter rows
GROUP BY department               -- 2. Group
HAVING AVG(salary) > 50000        -- 3. Filter groups
ORDER BY avg_salary DESC          -- 4. Sort results
LIMIT 10;                         -- 5. Limit output
```

## Common Patterns

### Latest Records

```sql
-- Most recent 10 users
SELECT * FROM users
ORDER BY created_at DESC
LIMIT 10;

-- Latest order per customer
SELECT DISTINCT ON (customer_id)
    customer_id, order_date, total
FROM orders
ORDER BY customer_id, order_date DESC;  -- PostgreSQL only
```

### Top N

```sql
-- Top 5 most expensive products
SELECT * FROM products
ORDER BY price DESC
LIMIT 5;

-- Bottom 10 performers
SELECT employee_id, sales_total FROM sales_summary
ORDER BY sales_total ASC
LIMIT 10;
```

### Alphabetical Listing

```sql
-- All customers alphabetically
SELECT * FROM customers
ORDER BY last_name, first_name;

-- Case-insensitive
SELECT * FROM customers
ORDER BY LOWER(last_name), LOWER(first_name);
```

### Priority/Urgency

```sql
-- Urgent items first, then by date
SELECT * FROM tasks
ORDER BY
    CASE priority
        WHEN 'urgent' THEN 1
        WHEN 'high' THEN 2
        WHEN 'medium' THEN 3
        WHEN 'low' THEN 4
    END,
    due_date ASC;
```

## Best Practices

1. **Always specify sort direction explicitly**
   ```sql
   -- ❌ Implicit
   ORDER BY category, price
   
   -- ✅ Explicit
   ORDER BY category ASC, price DESC
   ```

2. **Use column names, not positions**
   ```sql
   -- ❌ Hard to read
   ORDER BY 2, 3 DESC
   
   -- ✅ Clear
   ORDER BY department, salary DESC
   ```

3. **Index frequently sorted columns**
   ```sql
   CREATE INDEX idx_created_at ON orders(created_at);
   ```

4. **Limit results when sorting large tables**
   ```sql
   -- Always use LIMIT for large datasets
   SELECT * FROM huge_table
   ORDER BY created_at DESC
   LIMIT 100;
   ```

5. **Be consistent with NULL handling**
   ```sql
   -- Define how NULLs should be sorted
   ORDER BY column NULLS LAST
   ```

## Common Mistakes

### 1. Forgetting ORDER BY

```sql
-- ❌ Unpredictable order
SELECT * FROM products;

-- ✅ Predictable order
SELECT * FROM products ORDER BY product_id;
```

### 2. ORDER BY After LIMIT (Some DBs)

```sql
-- ❌ Wrong order (SQL Server specific syntax)
SELECT TOP 10 * FROM products ORDER BY price;  -- OK in SQL Server

-- ✅ Standard SQL
SELECT * FROM products ORDER BY price LIMIT 10;
```

### 3. Sorting by Non-Selected Column with DISTINCT

```sql
-- ❌ Error in strict mode
SELECT DISTINCT category FROM products ORDER BY price;

-- ✅ Include in SELECT
SELECT DISTINCT category, price FROM products ORDER BY price;
```

### 4. Not Considering NULL Values

```sql
-- ❌ Unexpected NULL positions
SELECT * FROM customers ORDER BY phone;

-- ✅ Handle NULLs explicitly
SELECT * FROM customers ORDER BY phone NULLS LAST;
```

## SQL Execution Order

Remember the logical query execution order:

1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. **ORDER BY** ← Happens near the end
7. LIMIT/OFFSET

This is why you can ORDER BY columns not in SELECT, but can ORDER BY aliases from SELECT.

```sql
-- ✅ Works: created_at not in SELECT
SELECT name FROM users ORDER BY created_at;

-- ✅ Works: total_price is a SELECT alias
SELECT price * quantity AS total_price FROM items ORDER BY total_price;
```

## Related Topics

- [DISTINCT](DISTINCT.md) - Removing duplicates
- [DateFunctions](DateFunctions.md) - Sorting by date calculations
- [NullHandling](NullHandling.md) - NULL behavior in sorting
