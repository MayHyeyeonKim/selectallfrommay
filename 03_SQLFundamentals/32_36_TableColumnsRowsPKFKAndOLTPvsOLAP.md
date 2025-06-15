## 1. Table

- A structured collection of rows and columns, like an Excel sheet.
- Represents a single entity (e.g., user, student).

## 2. Column

- Represents an attribute or property in a table.
- Each column has a name, data type, and constraints.
- Domain: Defines allowed values or type (e.g., date, string).
- Constraints: `NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT`.
- Degree: Number of columns in a table.

## 3. Row or Tuple

- A complete record of data for all columns.
- Must follow the domain and constraints of each column.
- Cardinality: The number of rows in a table.

## 4. Primary Key

- Uniquely identifies each row in a table.
- Must be unique and not null.
- Example: `id` column in a user table.

## 5. Foreign Key

- Refers to the primary key of another table.
- Represents relationships between tables.
- Example: `class_id` in Student table refers to `id` in Class table.

## 6. Relationships

- Formed by linking tables via foreign keys.
- Core of the relational model; ensures data consistency.

## 7. OLTP vs OLAP

### OLTP (Online Transaction Processing)

- Focused on real-time data operations
- Example: orders, logins, payments
- Optimized for fast reads/writes

### OLAP (Online Analytical Processing)

- Focused on analytical queries and reports
- Example: trends, reports, business insights
- Designed for aggregation and large-scale analysis
