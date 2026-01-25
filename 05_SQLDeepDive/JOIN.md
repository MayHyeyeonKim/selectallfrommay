# SQL JOIN

## What is JOIN?

JOIN is a core SQL feature that connects two or more tables to retrieve data. In relational databases, data is normalized and stored across multiple tables, so we need JOIN operations to combine the necessary data.

## JOIN and Set Theory

Understanding JOIN through set theory makes it easier to grasp:

### Intersection and Union

- **INNER JOIN = Intersection (A ∩ B)**
  - Returns only data that **exists in both** tables
- **FULL OUTER JOIN = Union (A ∪ B)**
  - Returns **all** data from both tables

- **LEFT JOIN = All of A**
  - All rows from the left table + matching rows from the right
  - A ∪ (A ∩ B) = A
- **RIGHT JOIN = All of B**
  - All rows from the right table + matching rows from the left
  - B ∪ (A ∩ B) = B

### Visual Example

```
Table A (employees): {1, 2, 3}  (Employee IDs)
Table B (departments): {2, 3, 4}  (Employee IDs in departments)

INNER JOIN        → {2, 3}         (Intersection - employees with departments)
FULL OUTER JOIN   → {1, 2, 3, 4}   (Union - all employees and departments)
LEFT JOIN         → {1, 2, 3}      (All employees)
RIGHT JOIN        → {2, 3, 4}      (All department assignments)
```

**Important:** LEFT/RIGHT OUTER JOIN are not complete unions, but rather **partial unions** based on one table.

## Types of JOIN

### 1. INNER JOIN

Returns only rows that satisfy the join condition from both tables. This is the most commonly used join type.

```sql
-- Explicit INNER JOIN
SELECT
    employees.name,
    departments.dept_name
FROM employees
INNER JOIN departments ON employees.dept_id = departments.id;

-- Implicit INNER JOIN (old syntax, not recommended)
SELECT
    employees.name,
    departments.dept_name
FROM employees, departments
WHERE employees.dept_id = departments.id;
```

**Characteristics:**

- Includes results only when matching data exists in both tables
- Non-matching rows are excluded from results

**Example:**

```
employees table:
| id | name       | dept_id |
|----|------------|---------|
| 1  | John Doe   | 10      |
| 2  | Jane Smith | 20      |
| 3  | Bob Lee    | NULL    |

departments table:
| id | dept_name   |
|----|-------------|
| 10 | Development |
| 20 | Sales       |
| 30 | HR          |

INNER JOIN result:
| name       | dept_name   |
|------------|-------------|
| John Doe   | Development |
| Jane Smith | Sales       |
```

### 2. LEFT JOIN (LEFT OUTER JOIN)

Returns all rows from the left (first) table and combines with matching rows from the right table. Returns NULL if there are no matching rows.

```sql
SELECT
    employees.name,
    departments.dept_name
FROM employees
LEFT JOIN departments ON employees.dept_id = departments.id;
```

**Characteristics:**

- All rows from the left table are included in results
- Filled with NULL if there's no matching data in the right table
- Useful for finding unmatched data from the left table

**Example result:**

```
| name       | dept_name   |
|------------|-------------|
| John Doe   | Development |
| Jane Smith | Sales       |
| Bob Lee    | NULL        |
```

**Use case - Finding employees without departments:**

```sql
SELECT
    employees.name
FROM employees
LEFT JOIN departments ON employees.dept_id = departments.id
WHERE departments.id IS NULL;
```

### 3. RIGHT JOIN (RIGHT OUTER JOIN)

Returns all rows from the right (second) table and combines with matching rows from the left table.

```sql
SELECT
    employees.name,
    departments.dept_name
FROM employees
RIGHT JOIN departments ON employees.dept_id = departments.id;
```

**Characteristics:**

- All rows from the right table are included in results
- Filled with NULL if there's no matching data in the left table
- The opposite concept of LEFT JOIN

**Example result:**

```
| name       | dept_name   |
|------------|-------------|
| John Doe   | Development |
| Jane Smith | Sales       |
| NULL       | HR          |
```

**Note:** RIGHT JOIN can be expressed as LEFT JOIN by switching table order, so LEFT JOIN is more commonly used.

### 4. FULL OUTER JOIN

Returns all rows from both tables. Fills with NULL if there are no matching rows.

```sql
SELECT
    employees.name,
    departments.dept_name
FROM employees
FULL OUTER JOIN departments ON employees.dept_id = departments.id;
```

**Characteristics:**

- All rows from both left and right tables are included in results
- Non-matching parts are filled with NULL
- Equivalent to combining LEFT JOIN and RIGHT JOIN

**Example result:**

```
| name       | dept_name   |
|------------|-------------|
| John Doe   | Development |
| Jane Smith | Sales       |
| Bob Lee    | NULL        |
| NULL       | HR          |
```

**MySQL Note:**
MySQL does not directly support FULL OUTER JOIN. It can be implemented using UNION:

```sql
SELECT employees.name, departments.dept_name
FROM employees
LEFT JOIN departments ON employees.dept_id = departments.id

UNION

SELECT employees.name, departments.dept_name
FROM employees
RIGHT JOIN departments ON employees.dept_id = departments.id;
```

### 5. CROSS JOIN

Returns the Cartesian Product of two tables. In other words, combines each row from the first table with all rows from the second table.

```sql
SELECT
    products.name,
    colors.color_name
FROM products
CROSS JOIN colors;

-- or
SELECT
    products.name,
    colors.color_name
FROM products, colors;
```

**Characteristics:**

- No join condition
- Result row count = Left table row count × Right table row count
- Useful for generating all combinations (e.g., all combinations of products and colors)

**Example:**

```
products table:
| id | name   |
|----|--------|
| 1  | T-Shirt|
| 2  | Pants  |

colors table:
| id | color_name |
|----|------------|
| 1  | Red        |
| 2  | Blue       |
| 3  | Black      |

CROSS JOIN result (2 × 3 = 6 rows):
| name    | color_name |
|---------|------------|
| T-Shirt | Red        |
| T-Shirt | Blue       |
| T-Shirt | Black      |
| Pants   | Red        |
| Pants   | Blue       |
| Pants   | Black      |
```

### 6. SELF JOIN

Joins a table with itself. Uses table aliases to distinguish between the instances.

```sql
-- Query employees and their managers
SELECT
    e1.name AS employee_name,
    e2.name AS manager_name
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.id;
```

**Use cases:**

- Employee and manager relationships in organizational charts
- Product comparisons within the same category
- Querying hierarchical structure data

**Example:**

```
employees table:
| id | name       | manager_id |
|----|------------|------------|
| 1  | CEO Kim    | NULL       |
| 2  | Director L | 1          |
| 3  | Manager P  | 2          |
| 4  | Staff C    | 2          |

SELF JOIN result:
| employee_name | manager_name |
|---------------|--------------|
| CEO Kim       | NULL         |
| Director L    | CEO Kim      |
| Manager P     | Director L   |
| Staff C       | Director L   |
```

## Multiple Table JOIN

You can join three or more tables:

```sql
SELECT
    e.name AS employee_name,
    d.dept_name,
    p.project_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id
INNER JOIN projects p ON e.project_id = p.id;
```

**Chained joins:**

```sql
SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    od.quantity
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.id;
```

## JOIN Conditions

### Equi Join

The most common join using the equality operator (=):

```sql
SELECT *
FROM table1 t1
JOIN table2 t2 ON t1.id = t2.id;
```

### Non-Equi Join

Uses comparison operators other than equality:

```sql
SELECT
    e.name,
    s.grade
FROM employees e
JOIN salary_grades s ON e.salary BETWEEN s.low_salary AND s.high_salary;
```

### Composite Join Conditions

Multiple conditions can be combined:

```sql
SELECT *
FROM table1 t1
JOIN table2 t2 ON t1.id = t2.id
    AND t1.status = t2.status
    AND t1.created_date >= t2.start_date;
```

## USING Clause

When join columns have the same name in both tables, you can use USING:

```sql
-- Using ON
SELECT *
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- Using USING (more concise)
SELECT *
FROM employees
JOIN departments USING (dept_id);
```

## NATURAL JOIN

Automatically joins on all columns with the same name:

```sql
SELECT *
FROM employees
NATURAL JOIN departments;
```

**Caution:**

- Risky as unexpected columns may be joined
- Using explicit join conditions is recommended

## JOIN 성능 최적화 팁

### 1. 인덱스 활용

조인에 사용되는 컬럼에 인덱스를 생성하세요:

```sql
CREATE INDEX idx_dept_id ON employees(dept_id);
```

### 2. 조건 필터링 먼저

WHERE 조건으로 데이터를 먼저 필터링한 후 JOIN:

```sql
SELECT e.name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.id
WHERE e.salary > 50000;  -- Filter before joining
```

### 3. Select Only Needed Columns

Select specific columns instead of SELECT \*:

```sql
SELECT e.name, d.dept_name  -- Only needed columns
FROM employees e
JOIN departments d ON e.dept_id = d.id;
```

### 4. Smaller Tables First

Generally, it's more efficient to join smaller tables first.

### 5. Use EXPLAIN

Analyze query execution plans for optimization:

```sql
EXPLAIN SELECT e.name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.id;
```

## Common Mistakes and Solutions

### 1. Using Implicit Joins

```sql
-- ❌ Bad example
SELECT e.name, d.dept_name
FROM employees e, departments d
WHERE e.dept_id = d.id;

-- ✅ Good example
SELECT e.name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.id;
```

### 2. Missing Join Conditions

```sql
-- ❌ No condition - becomes CROSS JOIN
SELECT *
FROM employees, departments;

-- ✅ Explicit condition
SELECT *
FROM employees e
JOIN departments d ON e.dept_id = d.id;
```

### 3. Inadequate NULL Handling

```sql
-- Consider NULL values in LEFT JOIN
SELECT
    e.name,
    COALESCE(d.dept_name, 'Unassigned') AS dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id;
```

## Practical Examples

### Example 1: Query Orders and Customer Information

```sql
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.email
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_date >= '2025-01-01'
ORDER BY o.order_date DESC;
```

### Example 2: Employee Count by Department

```sql
SELECT
    d.dept_name,
    COUNT(e.id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.id = e.dept_id
GROUP BY d.dept_name
ORDER BY employee_count DESC;
```

### Example 3: Products with Category and Supplier

```sql
SELECT
    p.product_name,
    c.category_name,
    s.supplier_name,
    p.price
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE p.price > 10000
ORDER BY p.price DESC;
```

### Example 4: Find Customers Without Orders

```sql
SELECT
    c.customer_name,
    c.email
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

## Summary

| JOIN Type       | Description                                    | When to Use                                    |
| --------------- | ---------------------------------------------- | ---------------------------------------------- |
| INNER JOIN      | Only matching data from both tables            | When only exact matches are needed             |
| LEFT JOIN       | All data from left table + matching from right | When all data from left table is needed        |
| RIGHT JOIN      | All data from right table + matching from left | When all data from right table is needed       |
| FULL OUTER JOIN | All data from both tables                      | When all data must be included                 |
| CROSS JOIN      | All combinations                               | When Cartesian product is needed               |
| SELF JOIN       | Join within the same table                     | For hierarchical or self-referencing relations |

## Key Takeaways

1. **INNER JOIN**: Intersection - only what exists in both
2. **LEFT JOIN**: All of left + matches from right
3. **RIGHT JOIN**: All of right + matches from left
4. **FULL OUTER JOIN**: Union - everything
5. **Always use explicit JOIN syntax** (with ON clause)
6. **Create indexes on join columns** for performance improvement
7. **Be careful with NULL values** (especially in OUTER JOINs)
