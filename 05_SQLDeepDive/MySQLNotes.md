# My SQL Notes

## Learned SQL Commands

| Command/Function                 | Description                                   | Example                                                                                                           |
| -------------------------------- | --------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| SELECT \* FROM "table"           | Selects all columns from the specified table. | `SELECT * FROM "employees";`                                                                                      |
| CONCAT                           | Concatenates (joins) strings together.        | `SELECT CONCAT(first_name, ' ', last_name) FROM employees;`                                                       |
| SELECT SUM(salary) FROM salaries | Calculates the sum of salaries.               | `SELECT SUM(salary) FROM salaries;`                                                                               |
| SELECT MAX(salary) FROM salaries | Finds the maximum salary.                     | `SELECT MAX(salary) FROM salaries;`                                                                               |
| SELECT with WHERE                | Selects specific columns with conditions.     | `SELECT first_name, last_name FROM "public"."employees" WHERE first_name = 'Mayumi' AND last_name = 'Schueller';` |

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
- **MAX()**: Returns the maximum value.

## SQL Comments

Comments are used to add notes or explanations in SQL code without affecting execution.

- **Single-line comment**: Use `--` for comments on one line.
  - Example: `SELECT * FROM employees; -- This selects all employees`
- **Multi-line comment**: Use `/* */` for comments spanning multiple lines.
  - Example:
    ````
    /*
     * This is a multi-line comment.
     * It can span several lines.
     */
    SELECT name FROM users;
    ```
    ````

## How to Filter Data?

Filtering data is essential in SQL queries because it allows us to select specific subsets of data based on conditions.

**Basic filtering with WHERE**
The WHERE clause is used to filter rows based on a condition.
Example:

```sql
SELECT * FROM table WHERE role = 'manager';
```

**Increasing complexity in filtering**
Filtering becomes more powerful as we add multiple criteria, allowing us to answer complex questions such as salaries by age, gender, or hire date.

**Thinking of queries as questions**
Queries should be written to answer specific business or analytical questions, focusing only on the relevant subset of data.

**The importance of WHERE**
The WHERE clause is fundamental because most queries require filtering data to produce meaningful results.

**Simple example**
To retrieve all female employees:

```sqlㅍ
FROM employees
WHERE gender = 'F';
```

**Filtering with multiple criteria**
Multiple conditions can be combined using AND to create layered filters.
Example: filtering employees by both age and gender.

**Using NOT for negation**
The NOT operator negates a condition, selecting rows that do not meet the specified criteria.
Example: To retrieve all employees who are not female:

```sql
SELECT * FROM employees
WHERE NOT gender = 'F';
```

NOT can be combined with other operators like AND and OR for complex filtering.
Example: Employees who are not managers and not in the sales department:

```sql
SELECT * FROM employees
WHERE NOT role = 'manager' AND NOT department = 'sales';
```

Overall, advanced filtering builds on basic WHERE usage and enables answering more complex questions.
