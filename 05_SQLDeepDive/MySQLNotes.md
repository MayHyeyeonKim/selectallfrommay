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

**Using NOT EQUAL TO for inequality**
The NOT EQUAL TO operator (!= or <>) selects rows where the value does not match the specified value.
Example: To retrieve all employees whose salary is not 50000:

```sql
SELECT * FROM employees
WHERE salary != 50000;
```

You can also use <> instead of != for the same purpose.
Example:

```sql
SELECT * FROM employees
WHERE department <> 'HR';
```

**Using Greater Than for comparison**
The Greater Than operator (>) selects rows where the value is greater than the specified value.
Example: To retrieve all employees whose salary is greater than 50000:

```sql
SELECT * FROM employees
WHERE salary > 50000;
```

This can be combined with other conditions for more precise filtering.
Example: Employees with salary greater than 50000 and hired after 2020:

```sql
SELECT * FROM employees
WHERE salary > 50000 AND hire_date > '2020-01-01';
```

Greater Than also works with strings, comparing them lexicographically (alphabetical order).
Example: To retrieve names that come after 'abc' in alphabetical order:

```sql
SELECT * FROM employees
WHERE name > 'abc';
```

(Note: 'abc' > 'ace' would be false since 'a' comes before 'c' in 'ace'.)

**Using Greater Than or Equal To for comparison**
The Greater Than or Equal To operator (>=) selects rows where the value is greater than or equal to the specified value.
Example: To retrieve all employees whose salary is 50000 or more:

```sql
SELECT * FROM employees
WHERE salary >= 50000;
```

This works with strings as well, comparing lexicographically.
Example: Names that are 'abc' or come after it in alphabetical order:

```sql
SELECT * FROM employees
WHERE name >= 'abc';
```

**Using Less Than or Equal To for comparison**
The Less Than or Equal To operator (<=) selects rows where the value is less than or equal to the specified value.
Example: To retrieve all employees whose salary is 50000 or less:

```sql
SELECT * FROM employees
WHERE salary <= 50000;
```

This works with strings as well, comparing lexicographically.
Example: Names that are 'abc' or come before it in alphabetical order:

```sql
SELECT * FROM employees
WHERE name <= 'abc';
```

Overall, advanced filtering builds on basic WHERE usage and enables answering more complex questions.
