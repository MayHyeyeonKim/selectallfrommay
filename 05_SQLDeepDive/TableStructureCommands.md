# Table Structure Commands

Different DBMS use different methods to view table structure (column names, data types, NULL constraints, etc.).

---

## MySQL / MariaDB

### DESC / DESCRIBE

```sql
DESC table_name;
-- OR
DESCRIBE table_name;
```

**Example:**

```sql
DESC employees;
```

**Result:**

```
+-------------+-------------+------+-----+---------+----------------+
| Field       | Type        | Null | Key | Default | Extra          |
+-------------+-------------+------+-----+---------+----------------+
| id          | int(11)     | NO   | PRI | NULL    | auto_increment |
| name        | varchar(50) | YES  |     | NULL    |                |
| email       | varchar(100)| NO   | UNI | NULL    |                |
| created_at  | datetime    | YES  |     | NULL    |                |
+-------------+-------------+------+-----+---------+----------------+
```

### SHOW COLUMNS

```sql
SHOW COLUMNS FROM table_name;
```

### Using Information Schema

```sql
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_KEY,
    COLUMN_DEFAULT,
    EXTRA
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'database_name'
  AND TABLE_NAME = 'table_name';
```

---

## PostgreSQL

PostgreSQL **does not support the DESC command**. Use the following methods instead.

### psql Meta-command

```sql
\d table_name
```

**Example:**

```sql
\d employees
```

**Result:**

```
                        Table "public.employees"
   Column   |          Type          | Collation | Nullable | Default
------------+------------------------+-----------+----------+---------
 id         | integer                |           | not null | nextval('employees_id_seq'::regclass)
 name       | character varying(50)  |           |          |
 email      | character varying(100) |           | not null |
 created_at | timestamp              |           |          |
Indexes:
    "employees_pkey" PRIMARY KEY, btree (id)
    "employees_email_key" UNIQUE CONSTRAINT, btree (email)
```

### More Detailed Information

```sql
\d+ table_name
```

### Using Information Schema

```sql
SELECT
    column_name,
    data_type,
    is_nullable,
    column_default,
    character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'table_name';
```

### Using System Catalog

```sql
SELECT
    a.attname AS column_name,
    pg_catalog.format_type(a.atttypid, a.atttypmod) AS data_type,
    a.attnotnull AS not_null,
    a.atthasdef AS has_default
FROM pg_catalog.pg_attribute a
WHERE a.attrelid = 'table_name'::regclass
  AND a.attnum > 0
  AND NOT a.attisdropped
ORDER BY a.attnum;
```

---

## Oracle SQL

### DESC / DESCRIBE

```sql
DESC table_name;
-- OR
DESCRIBE table_name;
```

**Example:**

```sql
DESC employees;
```

**Result:**

```
Name        Null?    Type
----------- -------- ------------
ID          NOT NULL NUMBER(10)
NAME                 VARCHAR2(50)
EMAIL       NOT NULL VARCHAR2(100)
CREATED_AT           DATE
```

### Using ALL_TAB_COLUMNS

```sql
SELECT
    column_name,
    data_type,
    data_length,
    nullable,
    data_default
FROM all_tab_columns
WHERE table_name = 'EMPLOYEES'
  AND owner = 'schema_name';
```

### Using USER_TAB_COLUMNS (Current User's Tables)

```sql
SELECT
    column_name,
    data_type,
    data_length,
    nullable
FROM user_tab_columns
WHERE table_name = 'EMPLOYEES'
ORDER BY column_id;
```

---

## Microsoft SQL Server (MS SQL)

### sp_help

```sql
EXEC sp_help 'table_name';
```

**Example:**

```sql
EXEC sp_help 'employees';
```

### sp_columns

```sql
EXEC sp_columns 'table_name';
```

### INFORMATION_SCHEMA.COLUMNS

```sql
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    CHARACTER_MAXIMUM_LENGTH,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'employees';
```

### Using sys.columns

```sql
SELECT
    c.name AS column_name,
    t.name AS data_type,
    c.max_length,
    c.is_nullable,
    c.is_identity
FROM sys.columns c
JOIN sys.types t ON c.user_type_id = t.user_type_id
WHERE c.object_id = OBJECT_ID('table_name');
```

---

## SQLite

### PRAGMA

```sql
PRAGMA table_info(table_name);
```

**Example:**

```sql
PRAGMA table_info(employees);
```

**Result:**

```
cid  name        type         notnull  dflt_value  pk
---  ----------  -----------  -------  ----------  --
0    id          INTEGER      1        NULL        1
1    name        VARCHAR(50)  0        NULL        0
2    email       VARCHAR(100) 1        NULL        0
3    created_at  DATETIME     0        NULL        0
```

### .schema Command (SQLite CLI)

```sql
.schema table_name
```

---

## Summary Comparison

| DBMS              | Primary Command                 | Notes                                           |
| ----------------- | ------------------------------- | ----------------------------------------------- |
| **MySQL/MariaDB** | `DESC table_name`               | DESCRIBE, SHOW COLUMNS also available          |
| **PostgreSQL**    | `\d table_name`                 | Only in psql, DESC not supported                |
| **Oracle**        | `DESC table_name`               | Used in SQL\*Plus                               |
| **SQL Server**    | `sp_help 'table_name'`          | sp_columns, INFORMATION_SCHEMA also available   |
| **SQLite**        | `PRAGMA table_info(table_name)` | .schema command also available                  |

---

## Notes

- Only **MySQL and Oracle** natively support the `DESC` or `DESCRIBE` command.
- **PostgreSQL** uses the `\d` meta-command (only in psql client).
- **SQL Server** uses stored procedures `sp_help` or `sp_columns`.
- All DBMS can query table structure through the standard SQL `INFORMATION_SCHEMA.COLUMNS`.
