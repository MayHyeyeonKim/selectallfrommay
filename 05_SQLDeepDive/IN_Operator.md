# SQL IN Operator

The IN operator is a keyword used in SQL to check if a value matches any one of multiple values. IN is a bundle of OR conditions, allowing efficient filtering by simply replacing multiple OR conditions.

## Usage

```sql
SELECT column FROM table WHERE column IN (value1, value2, value3, ...);
```

- Specify a comma-separated list of values in parentheses.
- Returns TRUE if the column value matches any in the list.

## Advantages

- **Concise**: Can replace `WHERE column = value1 OR column = value2 OR ...` with `IN (value1, value2, ...)`.
- **Readable and maintainable**: Avoids long OR chains.
- Applies to various data types (numbers, strings, etc.).

## Examples

- Search for employee info with numbers 100001, 100006, 118:
  ```sql
  SELECT * FROM employees WHERE employee_number IN (100001, 100006, 118);
  ```
- People aged 51, 53, 57, 62:
  ```sql
  WHERE age IN (51, 53, 57, 62);
  ```

## Comparison

- Without IN: `WHERE employee_number = 100001 OR employee_number = 100006 OR employee_number = 118`
- With IN: `WHERE employee_number IN (100001, 100006, 118)`
