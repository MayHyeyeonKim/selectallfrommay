# Age Calculation

## The Problem

```sql
-- ❌ WRONG: Doesn't check if birthday occurred this year
SELECT DATEDIFF(YEAR, birth_date, CURRENT_DATE) AS age;

-- Example: Birth 2000-12-31, Today 2026-01-01
-- Result: 26 (WRONG! Person is still 25)
```

## Correct Methods by Database

### PostgreSQL (Simplest)

```sql
-- Using AGE function
SELECT AGE(DATE '1992-11-13', DATE '1800-01-01');
-- Result: 192 years 10 mons 12 days

-- Age from birth date to now
SELECT 
    birth_date,
    AGE(birth_date) AS age_interval,
    EXTRACT(YEAR FROM AGE(birth_date)) AS age_years
FROM people;
```

### MySQL

```sql
-- TIMESTAMPDIFF handles birthday logic correctly
SELECT 
    birth_date,
    TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age
FROM people;
```

### Microsoft SQL Server

```sql
-- Calculate year difference, then subtract 1 if birthday hasn't occurred
SELECT 
    birth_date,
    DATEDIFF(YEAR, birth_date, GETDATE()) - 
    CASE 
        WHEN DATEADD(YEAR, DATEDIFF(YEAR, birth_date, GETDATE()), birth_date) > GETDATE()
        THEN 1
        ELSE 0
    END AS age
FROM people;
```

### Oracle SQL

```sql
-- MONTHS_BETWEEN divided by 12
SELECT 
    birth_date,
    FLOOR(MONTHS_BETWEEN(SYSDATE, birth_date) / 12) AS age
FROM people;
```

## Common Use Cases

### Age Groups

```sql
-- PostgreSQL
SELECT 
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(birth_date)) < 18 THEN 'Minor'
        WHEN EXTRACT(YEAR FROM AGE(birth_date)) BETWEEN 18 AND 25 THEN '18-25'
        WHEN EXTRACT(YEAR FROM AGE(birth_date)) BETWEEN 26 AND 35 THEN '26-35'
        WHEN EXTRACT(YEAR FROM AGE(birth_date)) BETWEEN 36 AND 50 THEN '36-50'
        ELSE 'Senior (51+)'
    END AS age_group,
    COUNT(*) AS count
FROM people
GROUP BY age_group;
```

### Age as of Specific Date

```sql
-- MySQL: Age as of Dec 31, 2025
SELECT TIMESTAMPDIFF(YEAR, birth_date, '2025-12-31') AS age_end_of_2025
FROM people;

-- PostgreSQL
SELECT EXTRACT(YEAR FROM AGE(DATE '2025-12-31', birth_date)) AS age_end_of_2025
FROM people;
```

### Handle NULLs

```sql
-- Return 0 for NULL birth dates
SELECT COALESCE(TIMESTAMPDIFF(YEAR, birth_date, CURDATE()), 0) AS age
FROM people;
```

## Edge Cases

### Leap Year (Feb 29)

```sql
-- PostgreSQL
SELECT AGE(DATE '2026-02-28', DATE '2000-02-29');
-- Result: 25 years 11 mons 30 days (not yet 26)

SELECT AGE(DATE '2026-03-01', DATE '2000-02-29');
-- Result: 26 years 1 day (turned 26)
```

Most systems treat Feb 28 as the birthday in non-leap years.

## Best Practices

1. **Use DATE type, not DATETIME/VARCHAR** for birth dates
2. **Use built-in functions**: AGE() in PostgreSQL, TIMESTAMPDIFF() in MySQL
3. **Always handle NULLs** with COALESCE or WHERE clause
4. **Validate dates**: Reject future dates, flag ages > 120

## Quick Reference

| Database    | Recommended Function                                 |
| ----------- | ---------------------------------------------------- |
| PostgreSQL  | `EXTRACT(YEAR FROM AGE(birth_date))`                 |
| MySQL       | `TIMESTAMPDIFF(YEAR, birth_date, CURDATE())`         |
| SQL Server  | `DATEDIFF(YEAR, ...) - CASE WHEN ... END`            |
| Oracle      | `FLOOR(MONTHS_BETWEEN(SYSDATE, birth_date) / 12)`    |

## Related

- [DateFunctions](DateFunctions.md) - Date operations and formatting
- [NullHandling](NullHandling.md) - Working with NULL values
