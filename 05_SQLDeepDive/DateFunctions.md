# Date Functions

## Overview

Date functions are essential for working with temporal data in SQL. They allow you to extract, manipulate, format, and calculate dates and times. Different database systems have varying implementations, but most share common functionality.

## Core Date Functions Comparison

| Function                     | Microsoft SQL Server                                | Oracle SQL                                          | MySQL                                              | PostgreSQL                                         |
| ---------------------------- | --------------------------------------------------- | --------------------------------------------------- | -------------------------------------------------- | -------------------------------------------------- |
| **Current Date**             | `GETDATE()` <br> `CURRENT_TIMESTAMP`                | `SYSDATE` <br> `CURRENT_DATE`                       | `NOW()` <br> `CURRENT_DATE()` <br> `CURDATE()`     | `CURRENT_DATE` <br> `NOW()` <br> `CURRENT_TIMESTAMP` |
| **Current Time**             | `GETDATE()` <br> `CURRENT_TIMESTAMP`                | `SYSTIMESTAMP` <br> `CURRENT_TIMESTAMP`             | `CURRENT_TIME()` <br> `CURTIME()`                  | `CURRENT_TIME` <br> `LOCALTIME`                    |
| **Extract Year**             | `YEAR(date)` <br> `DATEPART(YEAR, date)`            | `EXTRACT(YEAR FROM date)`                           | `YEAR(date)` <br> `EXTRACT(YEAR FROM date)`        | `EXTRACT(YEAR FROM date)` <br> `DATE_PART('year', date)` |
| **Extract Month**            | `MONTH(date)` <br> `DATEPART(MONTH, date)`          | `EXTRACT(MONTH FROM date)`                          | `MONTH(date)` <br> `EXTRACT(MONTH FROM date)`      | `EXTRACT(MONTH FROM date)` <br> `DATE_PART('month', date)` |
| **Extract Day**              | `DAY(date)` <br> `DATEPART(DAY, date)`              | `EXTRACT(DAY FROM date)`                            | `DAY(date)` <br> `EXTRACT(DAY FROM date)`          | `EXTRACT(DAY FROM date)` <br> `DATE_PART('day', date)` |
| **Date Arithmetic**          | `DATEADD(unit, number, date)`                       | `date + INTERVAL 'n' unit`                          | `DATE_ADD(date, INTERVAL n unit)`                  | `date + INTERVAL 'n unit'`                         |
| **Date Difference**          | `DATEDIFF(unit, date1, date2)`                      | `date1 - date2` (days)                              | `DATEDIFF(date1, date2)` (days)                    | `date1 - date2` <br> `AGE(date1, date2)`           |
| **Format Date**              | `FORMAT(date, 'format')`                            | `TO_CHAR(date, 'format')`                           | `DATE_FORMAT(date, 'format')`                      | `TO_CHAR(date, 'format')`                          |
| **Parse String to Date**     | `CONVERT(DATE, string)` <br> `CAST(string AS DATE)` | `TO_DATE(string, 'format')`                         | `STR_TO_DATE(string, 'format')`                    | `TO_DATE(string, 'format')` <br> `CAST(string AS DATE)` |

## Common Date Operations

### Getting Current Date and Time

#### Microsoft SQL Server
```sql
-- Current date and time
SELECT GETDATE();                    -- 2026-01-24 14:30:45.123
SELECT CURRENT_TIMESTAMP;            -- 2026-01-24 14:30:45.123
SELECT SYSDATETIME();                -- Higher precision

-- Current date only
SELECT CAST(GETDATE() AS DATE);      -- 2026-01-24
SELECT CONVERT(DATE, GETDATE());     -- 2026-01-24

-- Current time only
SELECT CAST(GETDATE() AS TIME);      -- 14:30:45.123
```

#### Oracle SQL
```sql
-- Current date and time
SELECT SYSDATE FROM DUAL;            -- 24-JAN-26
SELECT CURRENT_DATE FROM DUAL;       -- Session timezone
SELECT SYSTIMESTAMP FROM DUAL;       -- Higher precision

-- Current date only
SELECT TRUNC(SYSDATE) FROM DUAL;     -- Removes time component
```

#### MySQL
```sql
-- Current date and time
SELECT NOW();                        -- 2026-01-24 14:30:45
SELECT CURRENT_TIMESTAMP();          -- 2026-01-24 14:30:45
SELECT SYSDATE();                    -- Real-time, changes during query

-- Current date only
SELECT CURDATE();                    -- 2026-01-24
SELECT CURRENT_DATE();               -- 2026-01-24

-- Current time only
SELECT CURTIME();                    -- 14:30:45
SELECT CURRENT_TIME();               -- 14:30:45
```

#### PostgreSQL
```sql
-- Current date and time
SELECT NOW();                        -- 2026-01-24 14:30:45.123-08
SELECT CURRENT_TIMESTAMP;            -- 2026-01-24 14:30:45.123-08
SELECT CLOCK_TIMESTAMP();            -- Real-time, changes during query

-- Current date only
SELECT CURRENT_DATE;                 -- 2026-01-24
SELECT NOW()::DATE;                  -- 2026-01-24

-- Current time only
SELECT CURRENT_TIME;                 -- 14:30:45.123-08
SELECT LOCALTIME;                    -- 14:30:45.123
```

### Extracting Date Parts

#### Microsoft SQL Server
```sql
-- Using specific functions
SELECT YEAR(GETDATE());              -- 2026
SELECT MONTH(GETDATE());             -- 1
SELECT DAY(GETDATE());               -- 24

-- Using DATEPART
SELECT DATEPART(YEAR, GETDATE());    -- 2026
SELECT DATEPART(QUARTER, GETDATE()); -- 1
SELECT DATEPART(WEEK, GETDATE());    -- 4
SELECT DATEPART(WEEKDAY, GETDATE()); -- 6 (Friday)
SELECT DATEPART(HOUR, GETDATE());    -- 14
SELECT DATEPART(MINUTE, GETDATE());  -- 30

-- Using DATENAME (returns string)
SELECT DATENAME(MONTH, GETDATE());   -- 'January'
SELECT DATENAME(WEEKDAY, GETDATE()); -- 'Friday'
```

#### Oracle SQL
```sql
-- Using EXTRACT
SELECT EXTRACT(YEAR FROM SYSDATE) FROM DUAL;     -- 2026
SELECT EXTRACT(MONTH FROM SYSDATE) FROM DUAL;    -- 1
SELECT EXTRACT(DAY FROM SYSDATE) FROM DUAL;      -- 24

-- Using TO_CHAR for formatting
SELECT TO_CHAR(SYSDATE, 'YYYY') FROM DUAL;       -- '2026'
SELECT TO_CHAR(SYSDATE, 'MM') FROM DUAL;         -- '01'
SELECT TO_CHAR(SYSDATE, 'DD') FROM DUAL;         -- '24'
SELECT TO_CHAR(SYSDATE, 'HH24') FROM DUAL;       -- '14'
SELECT TO_CHAR(SYSDATE, 'MI') FROM DUAL;         -- '30'
SELECT TO_CHAR(SYSDATE, 'DY') FROM DUAL;         -- 'FRI'
SELECT TO_CHAR(SYSDATE, 'MONTH') FROM DUAL;      -- 'JANUARY'
```

#### MySQL
```sql
-- Using specific functions
SELECT YEAR(NOW());                  -- 2026
SELECT MONTH(NOW());                 -- 1
SELECT DAY(NOW());                   -- 24
SELECT HOUR(NOW());                  -- 14
SELECT MINUTE(NOW());                -- 30
SELECT SECOND(NOW());                -- 45

-- Using EXTRACT
SELECT EXTRACT(YEAR FROM NOW());     -- 2026
SELECT EXTRACT(MONTH FROM NOW());    -- 1
SELECT EXTRACT(DAY FROM NOW());      -- 24
SELECT EXTRACT(HOUR FROM NOW());     -- 14

-- Week and quarter
SELECT WEEK(NOW());                  -- 4
SELECT QUARTER(NOW());               -- 1
SELECT DAYOFWEEK(NOW());             -- 6 (1=Sunday)
SELECT DAYOFYEAR(NOW());             -- 24
```

#### PostgreSQL
```sql
-- Using EXTRACT
SELECT EXTRACT(YEAR FROM NOW());     -- 2026
SELECT EXTRACT(MONTH FROM NOW());    -- 1
SELECT EXTRACT(DAY FROM NOW());      -- 24
SELECT EXTRACT(HOUR FROM NOW());     -- 14
SELECT EXTRACT(MINUTE FROM NOW());   -- 30

-- Using DATE_PART
SELECT DATE_PART('year', NOW());     -- 2026
SELECT DATE_PART('month', NOW());    -- 1
SELECT DATE_PART('day', NOW());      -- 24
SELECT DATE_PART('hour', NOW());     -- 14

-- Other useful extractions
SELECT EXTRACT(DOW FROM NOW());      -- Day of week (0=Sunday)
SELECT EXTRACT(DOY FROM NOW());      -- Day of year
SELECT EXTRACT(QUARTER FROM NOW());  -- Quarter
SELECT EXTRACT(WEEK FROM NOW());     -- Week number
```

### Date Arithmetic

#### Microsoft SQL Server
```sql
-- Add/subtract intervals using DATEADD
SELECT DATEADD(DAY, 7, GETDATE());           -- Add 7 days
SELECT DATEADD(MONTH, 3, GETDATE());         -- Add 3 months
SELECT DATEADD(YEAR, 1, GETDATE());          -- Add 1 year
SELECT DATEADD(HOUR, -5, GETDATE());         -- Subtract 5 hours
SELECT DATEADD(MINUTE, 30, GETDATE());       -- Add 30 minutes

-- Calculate difference using DATEDIFF
SELECT DATEDIFF(DAY, '2026-01-01', GETDATE());       -- Days between
SELECT DATEDIFF(MONTH, '2025-01-01', GETDATE());     -- Months between
SELECT DATEDIFF(YEAR, '2020-01-01', GETDATE());      -- Years between
SELECT DATEDIFF(HOUR, '2026-01-23', GETDATE());      -- Hours between

-- Examples with data
SELECT 
    order_date,
    DATEADD(DAY, 7, order_date) AS delivery_date,
    DATEDIFF(DAY, order_date, GETDATE()) AS days_since_order
FROM orders;
```

#### Oracle SQL
```sql
-- Add/subtract intervals
SELECT SYSDATE + 7 FROM DUAL;                        -- Add 7 days
SELECT SYSDATE - 7 FROM DUAL;                        -- Subtract 7 days
SELECT SYSDATE + INTERVAL '3' MONTH FROM DUAL;       -- Add 3 months
SELECT SYSDATE + INTERVAL '1' YEAR FROM DUAL;        -- Add 1 year
SELECT SYSDATE + INTERVAL '5' HOUR FROM DUAL;        -- Add 5 hours
SELECT SYSDATE + 1/24 FROM DUAL;                     -- Add 1 hour (fraction of day)

-- Calculate difference
SELECT SYSDATE - TO_DATE('2026-01-01', 'YYYY-MM-DD') FROM DUAL;  -- Days between

-- Using ADD_MONTHS function
SELECT ADD_MONTHS(SYSDATE, 3) FROM DUAL;             -- Add 3 months
SELECT ADD_MONTHS(SYSDATE, -2) FROM DUAL;            -- Subtract 2 months

-- MONTHS_BETWEEN function
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2025-01-01', 'YYYY-MM-DD')) FROM DUAL;
```

#### MySQL
```sql
-- Add/subtract intervals using DATE_ADD and DATE_SUB
SELECT DATE_ADD(NOW(), INTERVAL 7 DAY);              -- Add 7 days
SELECT DATE_ADD(NOW(), INTERVAL 3 MONTH);            -- Add 3 months
SELECT DATE_ADD(NOW(), INTERVAL 1 YEAR);             -- Add 1 year
SELECT DATE_SUB(NOW(), INTERVAL 5 HOUR);             -- Subtract 5 hours

-- Alternative syntax with + and -
SELECT NOW() + INTERVAL 7 DAY;                       -- Add 7 days
SELECT NOW() - INTERVAL 3 MONTH;                     -- Subtract 3 months

-- Calculate difference using DATEDIFF (returns days)
SELECT DATEDIFF(NOW(), '2026-01-01');                -- Days between
SELECT DATEDIFF('2026-01-01', NOW());                -- Negative if future

-- TIMESTAMPDIFF for more precision
SELECT TIMESTAMPDIFF(SECOND, '2026-01-01', NOW());   -- Seconds between
SELECT TIMESTAMPDIFF(MINUTE, '2026-01-01', NOW());   -- Minutes between
SELECT TIMESTAMPDIFF(HOUR, '2026-01-23', NOW());     -- Hours between
SELECT TIMESTAMPDIFF(DAY, '2026-01-01', NOW());      -- Days between
SELECT TIMESTAMPDIFF(MONTH, '2025-01-01', NOW());    -- Months between
SELECT TIMESTAMPDIFF(YEAR, '2020-01-01', NOW());     -- Years between
```

#### PostgreSQL
```sql
-- Add/subtract intervals
SELECT NOW() + INTERVAL '7 days';                    -- Add 7 days
SELECT NOW() + INTERVAL '3 months';                  -- Add 3 months
SELECT NOW() + INTERVAL '1 year';                    -- Add 1 year
SELECT NOW() - INTERVAL '5 hours';                   -- Subtract 5 hours
SELECT NOW() + INTERVAL '30 minutes';                -- Add 30 minutes

-- Combining intervals
SELECT NOW() + INTERVAL '1 year 2 months 3 days';
SELECT NOW() + INTERVAL '1 hour 30 minutes';

-- Calculate difference (returns interval)
SELECT NOW() - '2026-01-01'::DATE;                   -- Returns interval
SELECT '2026-12-31'::DATE - CURRENT_DATE;            -- Days until end of year

-- AGE function for human-readable intervals
SELECT AGE(NOW(), '2020-01-01');                     -- e.g., '6 years 23 days'
SELECT AGE('2020-01-01');                            -- Age from given date to now

-- Extract days from interval
SELECT EXTRACT(DAY FROM (NOW() - '2026-01-01'::DATE));
```

### Formatting Dates

#### Microsoft SQL Server
```sql
-- Using FORMAT (SQL Server 2012+)
SELECT FORMAT(GETDATE(), 'yyyy-MM-dd');              -- 2026-01-24
SELECT FORMAT(GETDATE(), 'MM/dd/yyyy');              -- 01/24/2026
SELECT FORMAT(GETDATE(), 'MMMM dd, yyyy');           -- January 24, 2026
SELECT FORMAT(GETDATE(), 'dddd, MMMM dd, yyyy');     -- Friday, January 24, 2026
SELECT FORMAT(GETDATE(), 'HH:mm:ss');                -- 14:30:45

-- Using CONVERT with style codes
SELECT CONVERT(VARCHAR, GETDATE(), 101);             -- 01/24/2026 (mm/dd/yyyy)
SELECT CONVERT(VARCHAR, GETDATE(), 103);             -- 24/01/2026 (dd/mm/yyyy)
SELECT CONVERT(VARCHAR, GETDATE(), 120);             -- 2026-01-24 14:30:45
SELECT CONVERT(VARCHAR, GETDATE(), 23);              -- 2026-01-24
```

#### Oracle SQL
```sql
-- Using TO_CHAR
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;           -- 2026-01-24
SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') FROM DUAL;           -- 01/24/2026
SELECT TO_CHAR(SYSDATE, 'Month DD, YYYY') FROM DUAL;       -- January 24, 2026
SELECT TO_CHAR(SYSDATE, 'Day, Month DD, YYYY') FROM DUAL;  -- Friday, January 24, 2026
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;           -- 14:30:45
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS AM') FROM DUAL;          -- 02:30:45 PM

-- Common format patterns
SELECT TO_CHAR(SYSDATE, 'YYYY') FROM DUAL;                 -- Year: 2026
SELECT TO_CHAR(SYSDATE, 'MM') FROM DUAL;                   -- Month: 01
SELECT TO_CHAR(SYSDATE, 'DD') FROM DUAL;                   -- Day: 24
SELECT TO_CHAR(SYSDATE, 'DY') FROM DUAL;                   -- Day abbr: FRI
SELECT TO_CHAR(SYSDATE, 'DAY') FROM DUAL;                  -- Day name: FRIDAY
SELECT TO_CHAR(SYSDATE, 'MON') FROM DUAL;                  -- Month abbr: JAN
```

#### MySQL
```sql
-- Using DATE_FORMAT
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d');                -- 2026-01-24
SELECT DATE_FORMAT(NOW(), '%m/%d/%Y');                -- 01/24/2026
SELECT DATE_FORMAT(NOW(), '%M %d, %Y');               -- January 24, 2026
SELECT DATE_FORMAT(NOW(), '%W, %M %d, %Y');           -- Friday, January 24, 2026
SELECT DATE_FORMAT(NOW(), '%H:%i:%s');                -- 14:30:45
SELECT DATE_FORMAT(NOW(), '%h:%i:%s %p');             -- 02:30:45 PM

-- Common format specifiers
-- %Y = Year (4 digits), %y = Year (2 digits)
-- %M = Month name, %m = Month (numeric)
-- %D = Day with suffix (1st, 2nd, 3rd), %d = Day (numeric)
-- %W = Weekday name, %a = Weekday abbr
-- %H = Hour (24), %h = Hour (12)
-- %i = Minutes, %s = Seconds
```

#### PostgreSQL
```sql
-- Using TO_CHAR
SELECT TO_CHAR(NOW(), 'YYYY-MM-DD');                  -- 2026-01-24
SELECT TO_CHAR(NOW(), 'MM/DD/YYYY');                  -- 01/24/2026
SELECT TO_CHAR(NOW(), 'Month DD, YYYY');              -- January 24, 2026
SELECT TO_CHAR(NOW(), 'Day, Month DD, YYYY');         -- Friday, January 24, 2026
SELECT TO_CHAR(NOW(), 'HH24:MI:SS');                  -- 14:30:45
SELECT TO_CHAR(NOW(), 'HH:MI:SS AM');                 -- 02:30:45 PM

-- Common format patterns
SELECT TO_CHAR(NOW(), 'YYYY');                        -- 2026
SELECT TO_CHAR(NOW(), 'MM');                          -- 01
SELECT TO_CHAR(NOW(), 'DD');                          -- 24
SELECT TO_CHAR(NOW(), 'Dy');                          -- Fri
SELECT TO_CHAR(NOW(), 'Day');                         -- Friday
SELECT TO_CHAR(NOW(), 'Mon');                         -- Jan
SELECT TO_CHAR(NOW(), 'Month');                       -- January
```

### Parsing Strings to Dates

#### Microsoft SQL Server
```sql
-- Using CAST
SELECT CAST('2026-01-24' AS DATE);
SELECT CAST('2026-01-24 14:30:45' AS DATETIME);

-- Using CONVERT
SELECT CONVERT(DATE, '2026-01-24');
SELECT CONVERT(DATETIME, '01/24/2026', 101);          -- mm/dd/yyyy format

-- Using TRY_CAST (returns NULL if conversion fails)
SELECT TRY_CAST('invalid' AS DATE);                   -- NULL
SELECT TRY_CAST('2026-01-24' AS DATE);                -- 2026-01-24
```

#### Oracle SQL
```sql
-- Using TO_DATE
SELECT TO_DATE('2026-01-24', 'YYYY-MM-DD') FROM DUAL;
SELECT TO_DATE('01/24/2026', 'MM/DD/YYYY') FROM DUAL;
SELECT TO_DATE('24-JAN-2026', 'DD-MON-YYYY') FROM DUAL;
SELECT TO_DATE('2026-01-24 14:30:45', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
```

#### MySQL
```sql
-- Using STR_TO_DATE
SELECT STR_TO_DATE('2026-01-24', '%Y-%m-%d');
SELECT STR_TO_DATE('01/24/2026', '%m/%d/%Y');
SELECT STR_TO_DATE('24-Jan-2026', '%d-%b-%Y');
SELECT STR_TO_DATE('2026-01-24 14:30:45', '%Y-%m-%d %H:%i:%s');

-- Using CAST
SELECT CAST('2026-01-24' AS DATE);
SELECT CAST('2026-01-24 14:30:45' AS DATETIME);
```

#### PostgreSQL
```sql
-- Using TO_DATE
SELECT TO_DATE('2026-01-24', 'YYYY-MM-DD');
SELECT TO_DATE('01/24/2026', 'MM/DD/YYYY');
SELECT TO_DATE('24-Jan-2026', 'DD-Mon-YYYY');

-- Using TO_TIMESTAMP
SELECT TO_TIMESTAMP('2026-01-24 14:30:45', 'YYYY-MM-DD HH24:MI:SS');

-- Using CAST (works with ISO format)
SELECT CAST('2026-01-24' AS DATE);
SELECT CAST('2026-01-24 14:30:45' AS TIMESTAMP);

-- Using :: operator
SELECT '2026-01-24'::DATE;
SELECT '2026-01-24 14:30:45'::TIMESTAMP;
```

### Date Literals vs String Conversion

SQL provides different ways to represent dates. Understanding the difference helps write clearer, more portable code.

#### Date Literal Syntax (ANSI SQL Standard)

```sql
-- DATE literal - explicit type declaration
SELECT DATE '2026-01-24';                    -- ANSI SQL standard
SELECT TIME '14:30:45';                      -- Time literal
SELECT TIMESTAMP '2026-01-24 14:30:45';      -- Timestamp literal
```

**Advantages:**
- **Type-safe**: Compiler knows it's a date at parse time
- **Standard**: ANSI SQL standard, portable across databases
- **No ambiguity**: Format must be ISO 8601 (YYYY-MM-DD)
- **Performance**: No runtime conversion needed

**Limitations:**
- Must use ISO format (YYYY-MM-DD)
- Not all databases support all literal types

#### String Conversion (Implicit)

```sql
-- String that gets implicitly converted to date
SELECT '2026-01-24';                         -- Depends on database settings
SELECT '01/24/2026';                         -- Format interpretation varies
```

**Disadvantages:**
- **Format-dependent**: Interpretation depends on database/session settings
- **Ambiguous**: Is '01/02/2026' January 2nd or February 1st?
- **Runtime conversion**: Overhead for type conversion
- **Locale-sensitive**: Different regions have different date formats

#### Comparison Example

```sql
-- These are different in behavior:

-- 1. Date literal (recommended for constants)
SELECT DATE '1800-01-01';                    -- Always interpreted correctly
                                             -- Type is DATE from the start
                                             
-- 2. String (requires conversion)
SELECT '1800/01/01';                         -- Just a string!
                                             -- Needs conversion to DATE type
                                             -- Format interpretation varies

-- 3. Explicit conversion (clear intent)
SELECT CAST('1800-01-01' AS DATE);           -- Explicit, clear, safe
SELECT TO_DATE('1800/01/01', 'YYYY/MM/DD');  -- Format specified explicitly
```

#### Database Support

| Database         | DATE Literal | TIME Literal | TIMESTAMP Literal |
| ---------------- | ------------ | ------------ | ----------------- |
| PostgreSQL       | ✅ Yes       | ✅ Yes       | ✅ Yes            |
| Oracle SQL       | ✅ Yes       | ✅ Yes       | ✅ Yes            |
| MySQL            | ✅ Yes       | ✅ Yes       | ✅ Yes            |
| SQL Server       | ❌ No*       | ❌ No*       | ❌ No*            |

*SQL Server doesn't support ANSI date literals; use CAST/CONVERT instead

#### Best Practices

```sql
-- ✅ Good: Date literal for ISO format constants
SELECT * FROM events WHERE event_date = DATE '2026-01-24';

-- ✅ Good: Explicit conversion with format
SELECT TO_DATE('01/24/2026', 'MM/DD/YYYY');

-- ✅ Good: CAST for clarity
SELECT CAST('2026-01-24' AS DATE);

-- ❌ Bad: Relying on implicit conversion
SELECT * FROM events WHERE event_date = '2026-01-24';  -- Works, but less clear

-- ❌ Bad: Ambiguous format
SELECT * FROM events WHERE event_date = '01/02/2026';  -- Jan 2 or Feb 1?
```

#### Summary

| Method                  | Type Safety | Portability | Format Flexibility | Recommended |
| ----------------------- | ----------- | ----------- | ------------------ | ----------- |
| `DATE '2026-01-24'`     | ✅ High     | ✅ High     | ❌ ISO only        | ✅ Yes      |
| `'2026-01-24'`          | ❌ Low      | ⚠️ Medium   | ⚠️ Depends         | ❌ No       |
| `CAST('...' AS DATE)`   | ✅ High     | ✅ High     | ⚠️ DB-specific     | ✅ Yes      |
| `TO_DATE('...', '...')` | ✅ High     | ⚠️ Medium   | ✅ High            | ✅ Yes      |

## Common Use Cases

### Calculate Age

#### Microsoft SQL Server
```sql
-- Calculate age in years
SELECT 
    birth_date,
    DATEDIFF(YEAR, birth_date, GETDATE()) AS age_years
FROM employees;

-- More accurate age calculation
SELECT 
    birth_date,
    DATEDIFF(YEAR, birth_date, GETDATE()) - 
    CASE 
        WHEN DATEADD(YEAR, DATEDIFF(YEAR, birth_date, GETDATE()), birth_date) > GETDATE()
        THEN 1
        ELSE 0
    END AS accurate_age
FROM employees;
```

#### PostgreSQL
```sql
-- Using AGE function
SELECT 
    birth_date,
    AGE(birth_date) AS age_interval,
    EXTRACT(YEAR FROM AGE(birth_date)) AS age_years
FROM employees;
```

#### MySQL
```sql
-- Calculate age in years
SELECT 
    birth_date,
    TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age_years
FROM employees;
```

### Find Records Within Date Range

```sql
-- Orders in the last 30 days
SELECT * FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days';

-- Events this month (PostgreSQL/Oracle)
SELECT * FROM events
WHERE EXTRACT(YEAR FROM event_date) = EXTRACT(YEAR FROM CURRENT_DATE)
  AND EXTRACT(MONTH FROM event_date) = EXTRACT(MONTH FROM CURRENT_DATE);

-- Events this year
SELECT * FROM events
WHERE EXTRACT(YEAR FROM event_date) = EXTRACT(YEAR FROM CURRENT_DATE);

-- Between specific dates
SELECT * FROM sales
WHERE sale_date BETWEEN '2026-01-01' AND '2026-01-31';
```

### Get Start/End of Period

#### Microsoft SQL Server
```sql
-- Start of current month
SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0);

-- End of current month
SELECT DATEADD(DAY, -1, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, 0));

-- Start of current year
SELECT DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0);
```

#### PostgreSQL
```sql
-- Start of current month
SELECT DATE_TRUNC('month', CURRENT_DATE);

-- End of current month
SELECT (DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month' - INTERVAL '1 day')::DATE;

-- Start of current year
SELECT DATE_TRUNC('year', CURRENT_DATE);

-- Start of current week
SELECT DATE_TRUNC('week', CURRENT_DATE);
```

#### MySQL
```sql
-- Start of current month
SELECT DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

-- Last day of current month
SELECT LAST_DAY(CURRENT_DATE);

-- Start of current year
SELECT DATE_FORMAT(CURRENT_DATE, '%Y-01-01');
```

### Working Days Calculation

```sql
-- Example: Count weekdays between two dates (simplified)
-- This is database-specific and often requires a calendar table
-- for accurate calculations excluding holidays

-- PostgreSQL example using generate_series
SELECT COUNT(*)
FROM generate_series(
    '2026-01-01'::DATE,
    '2026-01-31'::DATE,
    '1 day'::INTERVAL
) AS d
WHERE EXTRACT(DOW FROM d) NOT IN (0, 6);  -- Exclude Sunday (0) and Saturday (6)
```

## Best Practices

1. **Use DATE types** - Store dates as DATE/DATETIME types, not as strings
2. **Be timezone aware** - Use timezone-aware types (TIMESTAMPTZ in PostgreSQL) for applications across timezones
3. **Index date columns** - Add indexes to frequently queried date columns for better performance
4. **Avoid functions in WHERE clauses** - Use date ranges instead of extracting parts
   ```sql
   -- Bad (can't use index)
   WHERE YEAR(order_date) = 2026
   
   -- Good (can use index)
   WHERE order_date >= '2026-01-01' AND order_date < '2027-01-01'
   ```
5. **Handle NULLs** - Use COALESCE for default dates when needed
6. **Consistent format** - Use ISO 8601 format (YYYY-MM-DD) for portability
7. **Validate user input** - Use TRY_CAST or equivalent to handle invalid dates gracefully

## Common Pitfalls

1. **Implicit conversions** - Be careful with automatic string-to-date conversions
2. **Timezone confusion** - Know the difference between local time and UTC
3. **Daylight saving time** - Be aware of DST transitions when calculating intervals
4. **Month arithmetic** - Adding months can give unexpected results (Jan 31 + 1 month)
5. **BETWEEN with timestamps** - `BETWEEN '2026-01-01' AND '2026-01-31'` might miss records at 23:59:59
   ```sql
   -- Better approach
   WHERE date >= '2026-01-01' AND date < '2026-02-01'
   ```

## Related Topics

- [Timezone](Timezone.md) - Working with timezones
- [NullHandling](NullHandling.md) - Handling NULL dates
- [COALESCE](COALESCE.md) - Providing default values for NULL dates
