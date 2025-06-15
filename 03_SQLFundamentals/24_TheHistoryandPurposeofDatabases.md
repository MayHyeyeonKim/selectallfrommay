# The History and Purpose of Databases

## 1. What is a Database?

- A **structured collection of data**.
- Designed to **store, retrieve, and manage** large volumes of information efficiently.
- Enables organizations to work with large-scale, structured data.

## 2. Before Databases: File Processing Systems

### What Was the File Processing System?

- Data was stored in separate files such as `customers.txt`, `sales.txt`, etc.
- Each program had its own structure and format.

### Limitations of File Processing:

- **Data duplication**: Same information had to be copied in many places.
- **Inconsistency**: Changing one value (e.g. address) didn’t update all records.
- **No relationships**: Files couldn’t reference or connect to each other.
- **No standard model**: Every system was custom-built and hard to maintain.
- **High cost**: Required unique software per use case, often written in low-level languages.

## 3. Why Relational Databases Were Invented

### The Relational Model Solved These Problems:

- **Structured format**: Tables with rows and columns.
- **Reduced redundancy**: Foreign keys allowed linking instead of copying.
- **Standardized querying**: SQL (Structured Query Language) became universal.
- **System integration**: Applications could share and reuse data more easily.

## 4. Conclusion

> File processing systems served their purpose early on,  
> but as data became more complex and interconnected, they reached their limits.  
> **Relational databases emerged as a modern, standardized solution.**

## One-sentence Summary

> **Relational databases were created to solve problems of duplication, inconsistency, and isolation by organizing data in a structured, connected, and standardized way.**
