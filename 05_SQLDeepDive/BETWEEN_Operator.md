# SQL BETWEEN Operator

BETWEEN is a simple and readable syntax for range searches in SQL. It is one of the filtering tools, useful for searching within a specific range of values.

## Usage

```sql
SELECT column FROM table WHERE column BETWEEN X AND Y;
```

- This is equivalent to `column >= X AND column <= Y`.
- Returns values between X and Y (inclusive).
- Applies to various data types such as numbers and dates.

## Advantages

- **Readable and maintainable**: Reads like a sentence, e.g., `WHERE age BETWEEN 20 AND 30`.
- **Concise**: Write the column only once.
- Can replace combinations of `>=` and `<=`.

## Notes

- Sensitive to argument order: X must be less than Y in `BETWEEN X AND Y`.
- The range is inclusive.

## Examples

- Search for people aged between 20 and 30: `WHERE age BETWEEN 20 AND 30`
- Salaries between 120 and 180: `WHERE salary BETWEEN 120 AND 180`
