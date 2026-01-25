# USING Clause

> **📌 Quick Note:**  
> - **Use USING**: Only when column names are **completely identical** in both tables  
> - **Use ON**: In most cases - it's safer and more flexible  
> - **When in doubt**: Just use ON 👍

## What is USING?

The USING clause is a simplified syntax for joining tables when the join columns have **identical names** in both tables. It provides a more concise alternative to the ON clause.

## Basic Syntax

```sql
-- Using ON clause
SELECT *
FROM table1
JOIN table2 ON table1.column_name = table2.column_name;

-- Using USING clause (more concise)
SELECT *
FROM table1
JOIN table2 USING (column_name);
```

## Key Differences: ON vs USING

### 1. Column Name Requirement

**ON Clause:**
- Can join columns with different names
- More flexible

```sql
SELECT *
FROM employees e
JOIN departments d ON e.emp_dept_id = d.dept_id;
```

**USING Clause:**
- Requires identical column names in both tables
- Only works when column names match exactly

```sql
SELECT *
FROM employees
JOIN departments USING (dept_id);
-- Both tables must have a column named 'dept_id'
```

### 2. Result Columns

**ON Clause:**
- Join columns appear twice in the result (once from each table)

```sql
SELECT *
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;
-- Result includes both employees.dept_id and departments.dept_id
```

**USING Clause:**
- Join column appears only once in the result
- Cleaner output

```sql
SELECT *
FROM employees
JOIN departments USING (dept_id);
-- Result includes dept_id only once
```

## Practical Examples

### Example 1: Simple Join

```sql
-- Traditional ON syntax
SELECT 
    e.employee_id,
    e.name,
    d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- USING syntax (simpler)
SELECT 
    employee_id,
    name,
    dept_name
FROM employees
JOIN departments USING (dept_id);
```

### Example 2: Multiple Column Join

You can specify multiple columns in the USING clause:

```sql
SELECT *
FROM orders
JOIN order_details USING (order_id, product_id);

-- Equivalent to:
SELECT *
FROM orders o
JOIN order_details od 
    ON o.order_id = od.order_id 
    AND o.product_id = od.product_id;
```

### Example 3: Multiple Table Joins

```sql
SELECT 
    customer_name,
    order_date,
    product_name
FROM customers
JOIN orders USING (customer_id)
JOIN order_details USING (order_id)
JOIN products USING (product_id);
```

### Example 4: With WHERE Clause

```sql
SELECT 
    e.name,
    d.dept_name,
    e.salary
FROM employees e
JOIN departments d USING (dept_id)
WHERE e.salary > 50000;
```

## Advantages of USING

### 1. **Conciseness**
- Less verbose than ON clause
- Easier to read and write

```sql
-- USING: Clean and simple
USING (dept_id)

-- ON: More verbose
ON e.dept_id = d.dept_id
```

### 2. **Avoids Ambiguity**
- No need to specify table aliases for join columns
- Join column appears only once in results

```sql
-- With USING - no ambiguity
SELECT dept_id, name, dept_name
FROM employees
JOIN departments USING (dept_id);

-- With ON - must specify which dept_id
SELECT d.dept_id, e.name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;
```

### 3. **Cleaner SELECT ***
When using SELECT *, USING produces cleaner results:

```sql
-- USING: dept_id appears once
SELECT *
FROM employees
JOIN departments USING (dept_id);

-- ON: dept_id appears twice
SELECT *
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;
```

## Limitations of USING

### 1. **Requires Identical Column Names**
Cannot use when column names differ:

```sql
-- ❌ Won't work - column names don't match
SELECT *
FROM employees
JOIN departments USING (dept_id);
-- If employees has 'department_id' instead of 'dept_id'

-- ✅ Must use ON instead
SELECT *
FROM employees e
JOIN departments d ON e.department_id = d.dept_id;
```

### 2. **Cannot Use Complex Conditions**
USING only supports equality:

```sql
-- ❌ Cannot do this with USING
SELECT *
FROM employees e
JOIN salary_grades s 
    ON e.salary BETWEEN s.low_salary AND s.high_salary;

-- ❌ Cannot add additional conditions
SELECT *
FROM employees e
JOIN departments d 
    ON e.dept_id = d.dept_id AND e.hire_date > d.created_date;
```

### 3. **Less Common in Practice**
- Many databases don't enforce naming conventions
- Developers often prefer explicit ON clause for clarity

## USING with Different JOIN Types

### LEFT JOIN with USING

```sql
SELECT 
    e.name,
    d.dept_name
FROM employees e
LEFT JOIN departments d USING (dept_id);
```

### RIGHT JOIN with USING

```sql
SELECT 
    e.name,
    d.dept_name
FROM employees e
RIGHT JOIN departments d USING (dept_id);
```

### INNER JOIN with USING

```sql
SELECT 
    e.name,
    d.dept_name
FROM employees e
INNER JOIN departments d USING (dept_id);
```

### FULL OUTER JOIN with USING

```sql
SELECT 
    e.name,
    d.dept_name
FROM employees e
FULL OUTER JOIN departments d USING (dept_id);
```

## Real-World Example

### Scenario: E-commerce Database

```sql
-- Get order details with customer and product information
SELECT 
    order_id,
    customer_name,
    product_name,
    quantity,
    price
FROM orders
JOIN customers USING (customer_id)
JOIN order_details USING (order_id)
JOIN products USING (product_id)
WHERE order_date >= '2025-01-01';
```

**Equivalent with ON clause:**

```sql
SELECT 
    o.order_id,
    c.customer_name,
    p.product_name,
    od.quantity,
    p.price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE o.order_date >= '2025-01-01';
```

## Best Practices

### ✅ Use USING When:
1. Column names are identical in both tables
2. Using simple equality joins
3. You want cleaner, more concise code
4. You're using SELECT * and want to avoid duplicate columns

### ✅ Use ON When:
1. Column names differ between tables
2. Need complex join conditions (BETWEEN, >, <, etc.)
3. Need multiple conditions with AND/OR
4. Want explicit control over which columns to compare
5. Working with legacy databases with inconsistent naming

## Database Support

USING is supported by most major databases:

- ✅ PostgreSQL
- ✅ MySQL
- ✅ MariaDB
- ✅ Oracle
- ✅ SQLite
- ✅ SQL Server (2016+)

## Common Mistakes

### Mistake 1: Using with Different Column Names

```sql
-- ❌ Wrong - column names must match
SELECT *
FROM employees
JOIN departments USING (emp_dept_id);
-- Error: departments doesn't have 'emp_dept_id'

-- ✅ Correct
SELECT *
FROM employees e
JOIN departments d ON e.emp_dept_id = d.dept_id;
```

### Mistake 2: Trying to Add Conditions

```sql
-- ❌ Wrong - USING doesn't support additional conditions
SELECT *
FROM employees
JOIN departments USING (dept_id AND status = 'active');

-- ✅ Correct
SELECT *
FROM employees e
JOIN departments d USING (dept_id)
WHERE e.status = 'active';
```

### Mistake 3: Forgetting Parentheses

```sql
-- ❌ Wrong - parentheses required
SELECT *
FROM employees
JOIN departments USING dept_id;

-- ✅ Correct
SELECT *
FROM employees
JOIN departments USING (dept_id);
```

## Performance Considerations

**USING vs ON Performance:**
- No significant performance difference
- Both compile to the same execution plan
- Choice is purely stylistic and for readability

```sql
-- These have identical performance:
SELECT * FROM employees JOIN departments USING (dept_id);
SELECT * FROM employees e JOIN departments d ON e.dept_id = d.dept_id;
```

**Optimization Tips:**
1. Ensure indexes exist on join columns
2. Use the same approach throughout your codebase for consistency
3. Choose based on readability for your team

## Summary

| Feature              | USING                           | ON                                    |
| -------------------- | ------------------------------- | ------------------------------------- |
| Column names         | Must be identical               | Can be different                      |
| Syntax               | More concise                    | More verbose                          |
| Result columns       | Join column appears once        | Join column appears twice             |
| Complex conditions   | Not supported                   | Fully supported                       |
| Multiple conditions  | Not supported                   | Supported with AND/OR                 |
| Common usage         | Less common                     | More common                           |
| Readability          | Clean for simple joins          | More explicit                         |
| Flexibility          | Limited                         | Highly flexible                       |

## Key Takeaways

1. **USING is a shorthand** for ON when column names match exactly
2. **Simplifies code** and produces cleaner results with SELECT *
3. **Only works for equality joins** with identical column names
4. **ON is more flexible** and handles all scenarios
5. **Choose based on your needs**: Use USING for simplicity when possible, ON for flexibility
6. **No performance difference** - it's a matter of style and readability
