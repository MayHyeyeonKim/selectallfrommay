# SQL LIKE and ILIKE Operators

The LIKE operator performs pattern matching for partial matching searches in SQL. It is useful for filtering based on partial strings rather than exact values. ILIKE is a variant of LIKE that is case-insensitive.

## LIKE Usage

```sql
SELECT column FROM table WHERE column LIKE 'pattern';
```

- Use wildcards in the pattern.
- In PostgreSQL, it applies only to text types; other types require CAST (e.g., `CAST(column AS TEXT)` or `column::TEXT`).

## Wildcards

- **%**: Matches zero or more characters (e.g., 'M%' → strings starting with M).
- **\_**: Matches exactly one character (e.g., 'M\_' → strings starting with M and 2 characters long).

## Pattern Examples

- 'M%': Values starting with M.
- '%2': Values ending with 2.
- '%200%': Values containing 200.
- '\_00%': Values with 0 as the second and third characters (e.g., 2000, 20000).
- '2\_%': Values starting with 2 and at least 3 characters long.
- '2\_\_\_\_3': 5-character values starting with 2 and ending with 3.

## ILIKE Usage

```sql
SELECT column FROM table WHERE column ILIKE 'pattern';
```

- Same as LIKE but case-insensitive.
- Example: 'g%' → matches values starting with 'G' or 'g'.

## Examples

- Employees whose first name starts with 'G': `WHERE first_name LIKE 'G%'`
- Employees whose first name ends with 'R': `WHERE first_name LIKE '%R'`
- Employees whose first name contains 'ETR': `WHERE first_name LIKE '%ETR%'`
- Case-insensitive search: `WHERE first_name ILIKE 'g%'`

## Notes

- LIKE works only for text comparisons. Numbers or dates require CAST.
- ILIKE is more flexible due to case-insensitivity but may impact performance.(case-Insensitive LIKE)

LIKE and ILIKE enhance the WHERE clause for partial matching.
