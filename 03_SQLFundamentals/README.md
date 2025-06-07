In this course, I’ll use **DB Fiddle** with PostgreSQL 12 to demonstrate SQL queries.  
It’s an online playground where I can test ideas without installing anything locally.

> https://www.db-fiddle.com/

# What is SQL?

SQL is a programming language for requesting and manipulating data, and databases are essential for managing large, structured datasets.  
With SQL, I write queries—commands that ask the database to return or modify data.

# What is a query?

A query is a request for data—like asking a question to the database.  
I use `SELECT` statements to choose what I want, and `WHERE` clauses to filter results.  
Each part of a query (like `SELECT`, `FROM`, and `WHERE`) is called a clause, and together they form a powerful, declarative command.

> https://www.db-fiddle.com/f/ogAiTgZPjwvDxwVHiVK3Ek/0

## 🏗️ Schema SQL

```sql
CREATE TABLE "User" (
  id varchar(255) NOT NULL,
  name varchar(255) NOT NULL,
  lastName varchar(255) NOT NULL,
  dob date NOT NULL,
  sex varchar(1) NOT NULL,
  role varchar(255) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO "User"
VALUES ('u1', 'George', 'Jacobson', '1992-01-01', 'm', 'manager');

INSERT INTO "User"
VALUES ('u2', 'Macy', 'Waterson', '1992-01-01', 'f', 'employee');

INSERT INTO "User"
VALUES ('u3', 'Bill', 'Peters', '1992-01-01', 'm', 'employee');

INSERT INTO "User"
VALUES ('u4', 'Janine', 'Wilson', '1992-01-01', 'f', 'manager');

INSERT INTO "User"
VALUES ('u5', 'Jason', 'Lipton', '1992-01-01', 'm', 'manager');
```

```sql
-- do not remove double quotes around "User"! They are required for the query to work properly
SELECT * FROM "User";
```

**Schema SQL:** The "setup step" where I create the table and insert data

**Query SQL:** The "query step" where I ask questions to the prepared database
