# Timezone

## Timezone Command Comparison

| Feature                      | Microsoft SQL Server                                                               | Oracle SQL                                                                                                                                        | MySQL                                                                                                                                | PostgreSQL                                                                                                       |
| ---------------------------- | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------- |
| **View Current Timezone**    | `SELECT SYSDATETIMEOFFSET();` <br> `SELECT CURRENT_TIMEZONE();` (SQL Server 2022+) | `SELECT DBTIMEZONE FROM DUAL;` (Database timezone) <br> `SELECT SESSIONTIMEZONE FROM DUAL;` (Session timezone)                                    | `SELECT @@global.time_zone;` (Global) <br> `SELECT @@session.time_zone;` (Session) <br> `SHOW VARIABLES LIKE 'time_zone';`           | `SHOW TIMEZONE;` <br> `SELECT current_setting('TIMEZONE');`                                                      |
| **List Timezones**           | `SELECT * FROM sys.time_zone_info;`                                                | `SELECT TZNAME, TZABBREV FROM V$TIMEZONE_NAMES;`                                                                                                  | `SELECT * FROM mysql.time_zone_name;` <br> `SELECT name FROM mysql.time_zone_name ORDER BY name;`                                    | `SELECT * FROM pg_timezone_names;` <br> `SELECT name FROM pg_timezone_names ORDER BY name;`                      |
| **Change Session Timezone**  | `SET TIME ZONE 'UTC';` <br> `SET TIME ZONE 'Pacific Standard Time';`               | `ALTER SESSION SET TIME_ZONE = 'UTC';` <br> `ALTER SESSION SET TIME_ZONE = 'America/Los_Angeles';` <br> `ALTER SESSION SET TIME_ZONE = '-08:00';` | `SET time_zone = 'UTC';` <br> `SET time_zone = 'America/Los_Angeles';` <br> `SET time_zone = '-08:00';`                              | `SET TIMEZONE = 'UTC';` <br> `SET TIMEZONE = 'America/Los_Angeles';` <br> `SET TIME ZONE 'America/Los_Angeles';` |
| **Change Database Timezone** | Change in server settings (restart required)                                       | `ALTER DATABASE [dbname] SET TIME_ZONE = 'UTC';` (restart required)                                                                               | `SET GLOBAL time_zone = 'UTC';` (Global, admin privileges required) <br> Add `default-time-zone='-08:00'` to my.cnf file and restart | Change `timezone` parameter in PostgreSQL config file (postgresql.conf) and restart or reload                    |

## Detailed Explanation

### Microsoft SQL Server

#### View Current Timezone

```sql
-- System date and time with timezone offset
SELECT SYSDATETIMEOFFSET();

-- SQL Server 2022 and above
SELECT CURRENT_TIMEZONE();

-- Check timezone information
SELECT * FROM sys.time_zone_info WHERE name = CURRENT_TIMEZONE();
```

#### List Timezones

```sql
-- Query all available timezones
SELECT
    name,
    current_utc_offset,
    is_currently_dst
FROM sys.time_zone_info
ORDER BY name;
```

#### Change Timezone

```sql
-- Change session timezone
SET TIME ZONE 'Pacific Standard Time';
SET TIME ZONE 'UTC';

-- Convert specific time to different timezones
SELECT
    GETDATE() AS LocalTime,
    GETUTCDATE() AS UTCTime,
    SYSDATETIMEOFFSET() AS DateTimeOffset,
    SWITCHOFFSET(SYSDATETIMEOFFSET(), '-08:00') AS PacificTime;
```

### Oracle SQL

#### View Current Timezone

```sql
-- Database timezone
SELECT DBTIMEZONE FROM DUAL;

-- Session timezone
SELECT SESSIONTIMEZONE FROM DUAL;

-- Current timestamp with timezone
SELECT CURRENT_TIMESTAMP FROM DUAL;
```

#### List Timezones

```sql
-- Query all timezone names
SELECT TZNAME, TZABBREV
FROM V$TIMEZONE_NAMES
ORDER BY TZNAME;

-- Search for specific region timezones
SELECT *
FROM V$TIMEZONE_NAMES
WHERE TZNAME LIKE 'America%';
```

#### Change Timezone

```sql
-- Change session timezone (applies to current session only)
ALTER SESSION SET TIME_ZONE = 'America/Los_Angeles';
ALTER SESSION SET TIME_ZONE = '-08:00';
ALTER SESSION SET TIME_ZONE = 'UTC';

-- Convert specific column to different timezones
SELECT
    SYSTIMESTAMP,
    SYSTIMESTAMP AT TIME ZONE 'UTC' AS utc_time,
    SYSTIMESTAMP AT TIME ZONE 'America/Los_Angeles' AS pacific_time
FROM DUAL;
```

### MySQL

#### View Current Timezone

```sql
-- Check global timezone
SELECT @@global.time_zone;

-- Check session timezone
SELECT @@session.time_zone;

-- Check all timezone variables
SHOW VARIABLES LIKE 'time_zone';
SHOW VARIABLES LIKE '%time_zone%';

-- Current time (UTC)
SELECT UTC_TIMESTAMP();

-- Current time (server timezone)
SELECT NOW();
SELECT CURRENT_TIMESTAMP();
```

#### List Timezones

```sql
-- Check if timezone table is loaded
SELECT COUNT(*) FROM mysql.time_zone_name;

-- Query all timezone names
SELECT * FROM mysql.time_zone_name
ORDER BY name;

-- Query only timezone names
SELECT name FROM mysql.time_zone_name
ORDER BY name;

-- Search for specific region timezones
SELECT name
FROM mysql.time_zone_name
WHERE name LIKE 'America%'
ORDER BY name;

-- Load timezone data if not available (Linux/Mac)
-- Run in terminal: mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -p mysql
```

#### Change Timezone

```sql
-- Change current session timezone
SET time_zone = 'America/Los_Angeles';
SET time_zone = 'UTC';
SET time_zone = 'America/New_York';

-- Specify offset with numbers
SET time_zone = '-08:00';
SET time_zone = '-05:00';

-- Change global timezone (requires admin privileges, applies to all new connections)
SET GLOBAL time_zone = 'America/Los_Angeles';

-- Use system timezone
SET time_zone = 'SYSTEM';

-- Convert specific time to different timezones
SELECT
    NOW() AS current_time,
    UTC_TIMESTAMP() AS utc_time,
    CONVERT_TZ(NOW(), 'America/Los_Angeles', 'UTC') AS converted_utc,
    CONVERT_TZ(NOW(), 'America/Los_Angeles', 'America/New_York') AS ny_time;
```

### PostgreSQL

#### View Current Timezone

```sql
-- Check current timezone
SHOW TIMEZONE;

-- Or
SELECT current_setting('TIMEZONE');

-- Current time with timezone
SELECT NOW();
SELECT CURRENT_TIMESTAMP;
```

#### List Timezones

```sql
-- Query all timezones
SELECT * FROM pg_timezone_names
ORDER BY name;

-- Query only timezone names
SELECT name FROM pg_timezone_names
ORDER BY name;

-- Search for specific region timezones
SELECT name, abbrev, utc_offset
FROM pg_timezone_names
WHERE name LIKE 'America%'
ORDER BY name;

-- Search by abbreviation
SELECT * FROM pg_timezone_abbrevs
ORDER BY abbrev;
```

#### Change Timezone

```sql
-- Change current session timezone
SET TIMEZONE = 'America/Los_Angeles';
SET TIME ZONE 'UTC';
SET TIME ZONE 'America/New_York';

-- Specify offset with numbers
SET TIME ZONE '-08:00';
SET TIME ZONE INTERVAL '-08:00' HOUR TO MINUTE;

-- Convert specific time to different timezones
SELECT
    NOW() AS current_time,
    NOW() AT TIME ZONE 'UTC' AS utc_time,
    NOW() AT TIME ZONE 'America/Los_Angeles' AS pacific_time;
```

## Timezone-Aware Data Types

| Database                 | Timezone-Supported Data Types                                                                                                |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------- |
| **Microsoft SQL Server** | `DATETIMEOFFSET`                                                                                                             |
| **Oracle SQL**           | `TIMESTAMP WITH TIME ZONE` <br> `TIMESTAMP WITH LOCAL TIME ZONE`                                                             |
| **MySQL**                | `TIMESTAMP` (Stored in UTC, converted to session timezone on retrieval) <br> `DATETIME` (Stored as-is without timezone info) |
| **PostgreSQL**           | `TIMESTAMP WITH TIME ZONE` (or `TIMESTAMPTZ`) <br> `TIME WITH TIME ZONE` (or `TIMETZ`)                                       |

## Example: Timezone Conversion

### Microsoft SQL Server

```sql
DECLARE @dt DATETIMEOFFSET = '2026-01-23 14:30:00 -08:00';
SELECT
    @dt AS OriginalTime,
    SWITCHOFFSET(@dt, '+00:00') AS UTCTime,
    SWITCHOFFSET(@dt, '-05:00') AS NYTime;
```

### Oracle SQL

```sql
SELECT
    TIMESTAMP '2026-01-23 14:30:00 America/Los_Angeles' AS original_time,
    FROM_TZ(TIMESTAMP '2026-01-23 14:30:00', 'America/Los_Angeles')
        AT TIME ZONE 'UTC' AS utc_time,
    FROM_TZ(TIMESTAMP '2026-01-23 14:30:00', 'America/Los_Angeles')
        AT TIME ZONE 'America/New_York' AS ny_time
FROM DUAL;
```

### MySQL

```sql
SET @dt = '2026-01-23 14:30:00';
SELECT
    @dt AS original_time,
    CONVERT_TZ(@dt, 'America/Los_Angeles', 'UTC') AS utc_time,
    CONVERT_TZ(@dt, 'America/Los_Angeles', 'America/New_York') AS ny_time;

-- Or using offset
SELECT
    @dt AS original_time,
    CONVERT_TZ(@dt, '-08:00', '+00:00') AS utc_time,
    CONVERT_TZ(@dt, '-08:00', '-05:00') AS ny_time;
```

### PostgreSQL

```sql
SELECT
    '2026-01-23 14:30:00-08'::TIMESTAMPTZ AS original_time,
    '2026-01-23 14:30:00-08'::TIMESTAMPTZ AT TIME ZONE 'UTC' AS utc_time,
    '2026-01-23 14:30:00-08'::TIMESTAMPTZ AT TIME ZONE 'America/New_York' AS ny_time;
```

## Important Notes

1. **Timezone Naming Differences**: Each database may have different timezone name formats.
   - SQL Server: 'Pacific Standard Time'
   - Oracle, MySQL & PostgreSQL: 'America/Los_Angeles'
   - MySQL may require loading timezone data separately

2. **Session vs Database Timezone**:
   - Session timezone applies only to the current connection
   - Database timezone applies to the entire database (requires admin privileges)

3. **Timezone Storage**:
   - Appropriate data types are required to store timezone information
   - TIMESTAMP does not store timezone information
   - Recommend using TIMESTAMP WITH TIME ZONE or DATETIMEOFFSET

4. **Performance Considerations**:
   - Timezone conversion requires additional computation, consider performance impact when processing large amounts of data
   - Recommend storing in UTC when possible and converting at the application level

## ISO-8601 Standard

ISO-8601 is the international standard for representing dates and times in a consistent, unambiguous format.

### Key Features:

- **Purpose**: Express date/time clearly and consistently
- **Advantage**: Can be interpreted identically regardless of country or language
- **Sortability**: String sorting automatically maintains chronological order

### Basic Format:

**Date**: `YYYY-MM-DD`

- Example: `2026-01-23`

**Time**: `HH:MM:SS`

- Example: `14:30:00`

**Date + Time**: `YYYY-MM-DDTHH:MM:SS`

- Example: `2026-01-23T14:30:00`
- `T` is the delimiter separating date and time

**With Timezone**:

- UTC: `2026-01-23T14:30:00Z` (Z indicates UTC)
- Offset: `2026-01-23T14:30:00-08:00` (Pacific Time)
- Offset: `2026-01-23T14:30:00+09:00` (Korea Time)

### Using ISO-8601 in SQL:

```sql
-- PostgreSQL
SELECT '2026-01-23T14:30:00-08:00'::TIMESTAMPTZ;
SELECT TIMESTAMP '2026-01-23 14:30:00-08:00';

-- MySQL
SELECT TIMESTAMP('2026-01-23T14:30:00');
SELECT STR_TO_DATE('2026-01-23T14:30:00', '%Y-%m-%dT%H:%i:%s');

-- Oracle
SELECT TIMESTAMP '2026-01-23 14:30:00';
SELECT TO_TIMESTAMP('2026-01-23T14:30:00', 'YYYY-MM-DD"T"HH24:MI:SS') FROM DUAL;

-- SQL Server
SELECT CAST('2026-01-23T14:30:00-08:00' AS DATETIMEOFFSET);
SELECT CONVERT(DATETIMEOFFSET, '2026-01-23T14:30:00-08:00');
```

### Why ISO-8601 is Important:

1. **Clarity**: No confusion about whether 2/3/2026 means February 3rd or March 2nd
2. **Sortability**: Alphabetical sorting automatically produces chronological order
3. **International Standard**: Universally understood worldwide
4. **Programming**: Supported by most programming languages and databases
5. **Data Exchange**: Standard format for APIs, JSON, XML, and data interchange
