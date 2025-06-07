# What is a Database?

## Definition

- A **database** is a structured collection of data, and also the method by which I can access and manipulate that data.
- It allows me to **capture**, **store**, and **use** data efficiently.
- Though often shown as complex cylinders, databases are essentially **software running on computers** (hardware).

## Why Are Databases Important?

- **Data is the most valuable asset in the modern world**  
  → Companies like Amazon, Google, Facebook, and Alibaba thrive on data.
- **I generate data every day**  
  → Through apps, websites, drones, CCTVs, self-driving cars, and more.
- **More data was generated in the past 2 years than in all of human history combined.**
  - Estimated: 500 quintillion bytes per year
  - Globally stored data: about 44 zettabytes

## Analogy

- Data without capture is like **oil in the ground—useless unless extracted**.
- If I don’t **store or process** the data, it’s wasted potential.
- No data = No Facebook, Instagram, Google, or autonomous vehicles.

## What I’ll Do in This Course

1. **Install database software**  
   → I’ll turn my computer into a functioning database server.
2. **Create and use databases**  
   → I’ll add data, start querying, and analyze it.
3. **Practice using databases anywhere**  
   → I can use a desktop, laptop, or even mobile devices.

## Key Message

> A database is not just about storing data.  
> It’s about **making data useful**.

## Why is a Database Icon Always a Cylinder?

The classic cylinder icon for a database comes from the physical shape of early data storage devices:

- **Drum Memory**: One of the earliest forms of computer memory, shaped like a literal drum.
- **Hard Disk Drives (HDDs)**: Use stacked, spinning circular platters to store data—cylindrical in form.
- **Disk Packs**: Replaceable storage units composed of stacked platters, forming a cylinder.

This historical hardware design inspired the modern cylinder icon, which visually suggests "data stored on disks." It's become a widely accepted visual metaphor in software architecture diagrams.

> Source: [Stack Overflow – Why is a database always represented with a cylinder?](https://stackoverflow.com/questions/2822650/why-is-a-database-always-represented-with-a-cylinder)

## Real-World Use of Databases

Databases are just computers with software that store and manage data—like Excel, but more powerful and scalable.  
When data volume or complexity grows beyond what spreadsheets can handle, companies use real databases to ensure integrity, access control, and performance.  
From product managers to marketers, developers, analysts, and engineers, everyone in a modern company uses databases differently to make decisions and build products.  
This course helps me understand and interact with databases effectively, no matter which role I pursue.

## Understanding Database Terminology

Before I dive into hands-on practice, it’s important for me to understand the core terms used in database systems.  
A **DBMS (Database Management System)** is software that lets me store, retrieve, update, and delete data.  
Most companies use **RDBMS (Relational DBMS)** like PostgreSQL or MySQL, which organize data into related tables.  
To interact with these systems, I’ll use **SQL (Structured Query Language)** — a powerful tool I can learn to ask questions and retrieve insights from data.

## From Spreadsheets to Real Databases

In the early days, even companies like Amazon started by tracking orders with pen and paper, then spreadsheets.  
As data grew and customer needs became complex, spreadsheets became messy and error-prone.  
This is where real databases shine — organizing data into structured, related tables with accuracy and efficiency.  
In this course, I’ll simulate a mini-Amazon system to see exactly how databases solve real-world problems.

> [SQL Playground](https://www.w3schools.com/sql/trysql.asp?filename=trysql_op_in)

```sql

-- This query selects all rows from the Customers table
-- where the City is either 'Paris' or 'London'.
-- The result includes 8 customer records matching those cities.

SELECT * FROM Customers
WHERE City IN ('Paris', 'London');
```

```sql

-- The IN operator in SQL checks whether a value matches any value in a given list.
-- It selects rows where the City is either 'Paris' or 'London'.

-- Method 1: Using IN
WHERE City IN ('Paris', 'London')

-- Method 2: Using OR
WHERE City = 'Paris' OR City = 'London'
```

| CustomerID | CustomerName          | ContactName       | Address                      | City   | PostalCode | Country |
| ---------- | --------------------- | ----------------- | ---------------------------- | ------ | ---------- | ------- |
| 4          | Around the Horn       | Thomas Hardy      | 120 Hanover Sq.              | London | WA1 1DP    | UK      |
| 11         | B's Beverages         | Victoria Ashworth | Fauntleroy Circus            | London | EC2 5NT    | UK      |
| 16         | Consolidated Holdings | Elizabeth Brown   | Berkeley Gardens 12 Brewery  | London | WX1 6LT    | UK      |
| 19         | Eastern Connection    | Ann Devon         | 35 King George               | London | WX3 6FW    | UK      |
| 53         | North/South           | Simon Crowther    | South House 300 Queensbridge | London | SW7 1RZ    | UK      |
| 57         | Paris spécialités     | Marie Bertrand    | 265, boulevard Charonne      | Paris  | 75012      | France  |
| 72         | Seven Seas Imports    | Hari Kumar        | 90 Wadhurst Rd.              | London | OX15 4NB   | UK      |
| 74         | Spécialités du monde  | Dominique Perrier | 25, rue Lauriston            | Paris  | 75016      | France  |

## Relational Databases: How I Organize My Data

As my data grows, I move from spreadsheets to a real database—like PostgreSQL.  
I break my data into multiple related tables: Customers, Products, and Orders—each with its own unique ID.  
This structure helps me reduce duplication and makes my updates more accurate and scalable.  
By linking these tables through relationships (like customer IDs), I can manage complex data more efficiently and logically.

## Comparing Different Types of Databases

There are hundreds of database systems out there, but most of the time, I’ll work with just a few.  
In this course, I’ll get familiar with 5 major types of databases:

1. **Relational** (like PostgreSQL, MySQL) — stores data in tables, great for structured data and supports SQL.
2. **Document-based** (like MongoDB, Firebase) — stores data in flexible, JSON-like documents, great for scalability.
3. **Key-Value** (like Redis, DynamoDB) — super fast and simple, best for caching and lookups.
4. **Graph** (like Neo4j) — useful for highly connected data like social networks.
5. **Wide-Column** (like Cassandra, Bigtable) — great for massive, distributed systems.

> Source: [Prisma - Comparing Database Types](https://www.prisma.io/dataguide/intro/comparing-database-types)
