# My SQL Notes

## Learned SQL Commands

| Command/Function       | Description                                   | Example                                                     |
| ---------------------- | --------------------------------------------- | ----------------------------------------------------------- |
| SELECT \* FROM "table" | Selects all columns from the specified table. | `SELECT * FROM "employees";`                                |
| CONCAT                 | Concatenates (joins) strings together.        | `SELECT CONCAT(first_name, ' ', last_name) FROM employees;` |

## Notes

- SELECT \* is useful for quick data overview but avoid in production for performance.
- CONCAT can combine multiple strings with separators.

## SQL Function Types

### Scalar Functions

👉 Applies to each row (Operates on a single value per row and returns a single value.)

- **CONCAT()**: Concatenates strings.
- **UPPER()**: Converts string to uppercase.
- **LOWER()**: Converts string to lowercase.
- **LENGTH()**: Returns the length of a string.
- **ROUND()**: Rounds a number to a specified decimal places.

### Aggregate Functions

👉 Aggregates multiple rows (Operates on multiple rows and returns a single aggregated value.)

- **COUNT()**: Counts the number of rows.
- **SUM()**: Calculates the sum of a numeric column.
- **AVG()**: Calculates the average of a numeric column.
- **MIN()**: Returns the minimum value.
- **MAX()**: Returns the maximum value.</content>
