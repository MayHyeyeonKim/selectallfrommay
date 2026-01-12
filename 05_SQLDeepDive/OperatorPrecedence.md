# SQL Operator Precedence

SQL operators have a specific order of precedence that determines the sequence in which they are evaluated in expressions. Understanding operator precedence is crucial for writing correct and predictable SQL queries.

## What is Operator Precedence?

Operator precedence is like the order of operations in math (PEMDAS). Just like how `2 + 3 × 4` equals `14` (not `20`) because multiplication happens before addition, SQL has rules about which operations happen first.

## Complete Precedence Order (Highest to Lowest)

| Precedence  | Operator/Element                        | Associativity | Description                                 | Example                                  |
| ----------- | --------------------------------------- | ------------- | ------------------------------------------- | ---------------------------------------- |
| 1 (Highest) | `.`                                     | Left          | Table/column name separator                 | `employees.first_name`                   |
| 2           | `::`                                    | Left          | PostgreSQL-style typecast                   | `'123'::integer`                         |
| 3           | `[]`                                    | Left          | Array element selection                     | `array_col[1]`                           |
| 4           | `+` `-` (unary)                         | Right         | Unary plus, unary minus                     | `-salary`, `+bonus`                      |
| 5           | `^`                                     | Left          | Exponentiation                              | `2^3` (equals 8)                         |
| 6           | `*` `/` `%`                             | Left          | Multiplication, division, modulo            | `salary * 1.1`, `total / count`          |
| 7           | `+` `-` (binary)                        | Left          | Addition, subtraction                       | `base_salary + bonus`                    |
| 8           | (other operators)                       | Left          | All other native and user-defined operators |                                          |
| 9           | `BETWEEN` `IN` `LIKE` `ILIKE` `SIMILAR` |               | Range/set/string matching                   | `age BETWEEN 25 AND 65`                  |
| 10          | `<` `>` `<=` `>=` `<>` `=`              |               | Comparison operators                        | `salary > 50000`                         |
| 11          | `IS` `ISNULL` `NOTNULL`                 |               | NULL checks, boolean tests                  | `email IS NOT NULL`                      |
| 12          | `NOT`                                   | Right         | Logical negation                            | `NOT active`                             |
| 13          | `AND`                                   | Left          | Logical conjunction (both must be true)     | `age > 25 AND salary > 40000`            |
| 14 (Lowest) | `OR`                                    | Left          | Logical disjunction (either can be true)    | `department = 'IT' OR department = 'HR'` |

## Understanding Associativity

- **Left**: Operations of the same precedence are evaluated from left to right
  - Example: `10 - 5 - 2` = `(10 - 5) - 2` = `3`
- **Right**: Operations of the same precedence are evaluated from right to left
  - Example: `NOT NOT TRUE` = `NOT (NOT TRUE)` = `TRUE`

## Common Mistakes and How to Avoid Them

### 1. Mixing AND and OR without parentheses

```sql
-- ❌ CONFUSING: What does this really mean?
SELECT * FROM employees
WHERE department = 'IT' OR department = 'HR' AND salary > 50000;

-- ✅ CLEAR: Use parentheses to show intent
SELECT * FROM employees
WHERE (department = 'IT' OR department = 'HR') AND salary > 50000;

-- OR if you meant something different:
SELECT * FROM employees
WHERE department = 'IT' OR (department = 'HR' AND salary > 50000);
```

### 2. Arithmetic operations in conditions

```sql
-- ❌ This might not do what you expect
SELECT * FROM products WHERE price * quantity + tax > 1000;

-- ✅ Clearer with parentheses
SELECT * FROM products WHERE (price * quantity) + tax > 1000;
```

### 3. NOT operator placement

```sql
-- ❌ CONFUSING: NOT has higher precedence than AND
SELECT * FROM employees WHERE NOT active AND department = 'IT';
-- This means: (NOT active) AND (department = 'IT')

-- ✅ CLEAR: Use parentheses if you want different meaning
SELECT * FROM employees WHERE NOT (active AND department = 'IT');
```

## Practical Examples

### Example 1: Complex filtering

```sql
-- Without understanding precedence, this is confusing:
SELECT * FROM employees
WHERE age > 30 AND salary > 50000 OR department = 'IT' AND active = true;

-- With parentheses to show the actual evaluation:
SELECT * FROM employees
WHERE ((age > 30 AND salary > 50000) OR department = 'IT') AND active = true;

-- What you might have intended:
SELECT * FROM employees
WHERE (age > 30 AND salary > 50000) OR (department = 'IT' AND active = true);
```

### Example 2: Complex Priority and Direction Example

Let's analyze this complex WHERE clause step by step:

```sql
(
  salary > 10000 AND state = 'NY'
  OR
  (age > 20 AND age < 30)
  AND salary <= 20000
)
AND gender = 'F'
```

**How SQL evaluates this (following precedence rules):**

1. **First**: Comparison operators (`>`, `=`, `<`, `<=`)
   - `salary > 10000`
   - `state = 'NY'`
   - `age > 20`
   - `age < 30`
   - `salary <= 20000`
   - `gender = 'F'`

2. **Second**: AND operators (higher precedence than OR)
   - `salary > 10000 AND state = 'NY'`
   - `age > 20 AND age < 30` (already in parentheses)
   - `(age > 20 AND age < 30) AND salary <= 20000`

3. **Third**: OR operator (lowest precedence)
   - `(salary > 10000 AND state = 'NY') OR ((age > 20 AND age < 30) AND salary <= 20000)`

4. **Finally**: The outermost AND
   - `((salary > 10000 AND state = 'NY') OR ((age > 20 AND age < 30) AND salary <= 20000)) AND gender = 'F'`

**In plain English, this selects female employees who either:**
- Have salary > 10000 AND live in NY, **OR**
- Are between 20-30 years old AND have salary <= 20000

**Key Learning Points:**
- AND has higher precedence than OR
- Parentheses override the default precedence
- Complex conditions should always use parentheses for clarity
- The direction flows from inner parentheses outward

### Example 3: Arithmetic with comparisons

```sql
-- The multiplication happens first, then comparison
SELECT * FROM orders WHERE quantity * price > 1000;
-- Evaluates as: quantity * price, then compares result > 1000

-- Exponentiation has higher precedence than multiplication
SELECT power_level FROM characters WHERE base_power * 2^level > 1000;
-- Evaluates as: base_power * (2^level), then > 1000
```

## Best Practices

1. **Always use parentheses** when combining multiple operators, even if not strictly necessary
2. **Write code for humans** - make your intentions clear
3. **Test complex expressions** to ensure they behave as expected
4. **Break down complex conditions** into smaller, readable parts

Remember: When in doubt, add parentheses! They make your SQL more readable and prevent unexpected results.
