# Three-Valued Logic (3VL) in SQL

In SQL, due to the presence of NULL values, logical operations can have three values: TRUE, FALSE, and UNKNOWN. This is called Three-Valued Logic (3VL).

### NOT Operation

- NOT TRUE = FALSE
- NOT FALSE = TRUE
- NOT UNKNOWN = UNKNOWN

### AND Operation

| A       | B       | A AND B |
| ------- | ------- | ------- |
| TRUE    | TRUE    | TRUE    |
| TRUE    | FALSE   | FALSE   |
| TRUE    | UNKNOWN | UNKNOWN |
| FALSE   | TRUE    | FALSE   |
| FALSE   | FALSE   | FALSE   |
| FALSE   | UNKNOWN | FALSE   |
| UNKNOWN | TRUE    | UNKNOWN |
| UNKNOWN | FALSE   | FALSE   |
| UNKNOWN | UNKNOWN | UNKNOWN |

### OR Operation

| A       | B       | A OR B  |
| ------- | ------- | ------- |
| TRUE    | TRUE    | TRUE    |
| TRUE    | FALSE   | TRUE    |
| TRUE    | UNKNOWN | TRUE    |
| FALSE   | TRUE    | TRUE    |
| FALSE   | FALSE   | FALSE   |
| FALSE   | UNKNOWN | UNKNOWN |
| UNKNOWN | TRUE    | TRUE    |
| UNKNOWN | FALSE   | UNKNOWN |
| UNKNOWN | UNKNOWN | UNKNOWN |

## Examples

- `NULL = 1` → UNKNOWN
- `NULL IS NULL` → TRUE
- `NULL IS NOT NULL` → FALSE
