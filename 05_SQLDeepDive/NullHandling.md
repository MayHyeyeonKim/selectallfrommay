# Understanding Null

## Loose Equality (==)

- `1 == 1` → `true`  
  Loose comparison. It attempts automatic type conversion to match types.

- `1 != 1` → `false`  
  The opposite of the above. Also loose comparison.

- `null == null` → `true`  
  Since the values are the same, it's obviously true.

## Comparison Operators

- `null < > null` → `null`  
  Comparison operators return `null` when comparing null values.

## Null in SQL

### Definition

- `null` represents the absence of a value or an unknown value in SQL databases.
- It is different from an empty string (`''`) or zero (`0`).

### Comparisons with Null

- `null = null` → `false` (not `true` as in loose equality; use `IS NULL` instead).
- `null <> null` → `false`.
- To check for null: Use `IS NULL` or `IS NOT NULL`.
  - Example: `SELECT * FROM table WHERE column IS NULL;`

### Handling Null Values

- **COALESCE**: Returns the first non-null value from a list.
  - Example: `COALESCE(column1, 'default_value')`
- **NULLIF**: Returns null if two expressions are equal, otherwise returns the first expression.
  - Example: `NULLIF(column1, column2)`
- **NVL** (in Oracle) or **ISNULL** (in SQL Server): Replaces null with a specified value.
  - Example: `ISNULL(column, 'replacement')`

### Important Notes

- Null values can lead to unexpected results in queries, aggregations, and joins.
- Always handle nulls explicitly to avoid errors or incorrect data.

## Null in Operations and Aggregations

- Any operation involving null (subtraction, division, equality checks, etc.) will result in null.
- Aggregations like averages with null values can return null or produce unexpected results.
- Null can be a "nasty side effect" in calculations and data processing.
