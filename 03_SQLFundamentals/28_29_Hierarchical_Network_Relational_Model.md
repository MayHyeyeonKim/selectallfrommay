# Summary of Database Models

## 1. Hierarchical Model

- Organizes data in a tree structure
- A parent can have multiple children, but each child has only one parent
- Child nodes are tightly coupled to their parent (deleting a parent deletes all children)
- Difficult to represent many-to-many relationships such as co-authors
- Example structure: XML
- Limitations: low flexibility, no data duplication allowed, poor relationship modeling

## 2. Network Model

- An extension of the hierarchical model
- A child node can be linked to multiple parent nodes
- Supports many-to-many relationships
- Requires manual management of relationships, making it complex
- Improved relationship modeling but harder to maintain

## 3. Relational Model

- Organizes data into tables (rows and columns)
- Each table has a unique name and a primary key
- Relationships between tables are represented using foreign keys
- Eliminates redundancy, maintains consistency, and allows flexible relationships
- Uses SQL (Structured Query Language) for querying and data manipulation
- Currently the most widely used database model

## Key Comparison

| Model        | Structure  | Relationship Support | Flexibility | Drawbacks                              |
| ------------ | ---------- | -------------------- | ----------- | -------------------------------------- |
| Hierarchical | Tree       | One-to-many (1:N)    | Low         | No M:N relationships, no redundancy    |
| Network      | Graph-like | Many-to-many (M:N)   | Moderate    | Complex implementation and maintenance |
| Relational   | Tables     | 1:1, 1:N, M:N        | High        | Requires normalization                 |
