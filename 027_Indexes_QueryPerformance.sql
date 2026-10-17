-- An index is a data structure that helps MySQL locate rows without necessarily scanning the entire table.
-- InnoDB indexes are typically implemented using B-tree structures

-- Why don't we index every column?
-- Indexes improve many reads, but they have costs:
-- - They consume disk space and memory.
-- - INSERT, UPDATE, and DELETE operations may need to maintain the indexes.
-- - Too many indexes can increase write overhead and complicate optimization.
-- The goal is not to maximize the number of indexes. It is to create the indexes that help your actual workload.

USE sql_part6;
/*
CREATE TABLE employees_index_demo (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    email VARCHAR(120) NOT NULL,
    status VARCHAR(20) NOT NULL
) ENGINE = InnoDB;

INSERT INTO employees_index_demo
    (employee_id, employee_name, department, city,
     salary, email, status)
VALUES
(1,  'Adnan',  'IT',      'Srinagar', 70000, 'adnan@example.com',  'Active'),
(2,  'Rohan',  'Finance', 'Delhi',    60000, 'rohan@example.com',  'Active'),
(3,  'Priya',  'HR',      'Mumbai',   45000, 'priya@example.com',  'Active'),
(4,  'Vikram', 'IT',      'Delhi',    85000, 'vikram@example.com', 'Active'),
(5,  'Sara',   'Finance', 'Srinagar', 55000, 'sara@example.com',   'Inactive'),
(6,  'Aman',   'IT',      'Mumbai',   72000, 'aman@example.com',   'Active'),
(7,  'Diya',   'HR',      'Delhi',    48000, 'diya@example.com',   'Active'),
(8,  'Arjun',  'Finance', 'Mumbai',   65000, 'arjun@example.com',  'Active'),
(9,  'Neha',   'IT',      'Srinagar', 90000, 'neha@example.com',   'Inactive'),
(10, 'Kabir',  'HR',      'Mumbai',   52000, 'kabir@example.com',  'Active'),
(11, 'Isha',   'IT',      'Delhi',    68000, 'isha@example.com',   'Active'),
(12, 'Rahul',  'Finance', 'Srinagar', 58000, 'rahul@example.com',  'Active'),
(13, 'Meera',  'HR',      'Delhi',    47000, 'meera@example.com',  'Inactive'),
(14, 'Zoya',   'IT',      'Mumbai',   76000, 'zoya@example.com',   'Active'),
(15, 'Karan',  'Finance', 'Delhi',    62000, 'karan@example.com',  'Active'),
(16, 'Anaya',  'HR',      'Srinagar', 50000, 'anaya@example.com',  'Active'),
(17, 'Farhan', 'IT',      'Delhi',    81000, 'farhan@example.com', 'Active'),
(18, 'Tara',   'Finance', 'Mumbai',   57000, 'tara@example.com',   'Inactive'),
(19, 'Yusuf',  'HR',      'Srinagar', 49000, 'yusuf@example.com',  'Active'),
(20, 'Nisha',  'IT',      'Mumbai',   73000, 'nisha@example.com',  'Active');
*/
SELECT * FROM employees_index_demo;




-- Primary Index : When you define a primary key: employee_id INT PRIMARY KEY. 
-- MySQL automatically creates a unique index for that primary key. 
-- You don't need to create another index on employee_id just to look up an employee by ID.


-- A secondary index is an additional index separate from the clustered primary-key index.
-- For example, if you frequently search employees by department, you could create:

-- CREATE INDEX idx_employee_department
-- ON employees_index_demo (department);
-- Then this query may benefit from the index:

SELECT *
FROM employees_index_demo
WHERE department = 'IT';

SHOW INDEX FROM employees_index_demo WHERE column_name = 'department';


-- CREATE INDEX idx_city
-- ON employees_index_demo(city);
SHOW INDEX FROM employees_index_demo WHERE column_name = "city";


-- Primary-key index	                                        Secondary index
-- Created automatically for the primary key	                Created separately
-- Enforces primary-key uniqueness	                            May or may not enforce uniqueness
-- Determines the clustered index in InnoDB	                Provides an alternative lookup path


-- >>> Unique index prevents duplicate indexed values.
-- Suppose every employee must have a different email address. We can enforce that rule with:

-- CREATE UNIQUE INDEX idx_email
-- ON employees_index_demo(email);
-- or when we create the table we can add a constrain email NOT NULL UNIQUE >>> then we dont need to mention unique here
-- Choose the approach that best communicates the database rule in your schema.
SHOW INDEX FROM employees_index_demo WHERE column_name = "email";

SELECT employee_id, employee_name, email
FROM employees_index_demo
WHERE email = 'adnan@example.com';

-- >>> the below query will throw an error becoz email: adnan@example.com already exists
-- INSERT INTO employees_index_demo 
--     (employee_id, employee_name, department, city,
--      salary, email, status)
-- VALUES
--     (21, 'Test User', 'IT', 'Delhi',
--      40000, 'adnan@example.com', 'Active');






-- >>> Composite index is an index containing two or more columns.
-- CREATE INDEX idx_city_email
-- ON employees_index_demo(city, email);
SHOW INDEX FROM employees_index_demo WHERE column_name = "email";

-- this index will help us with 
SELECT *
FROM employees_index_demo
WHERE department = 'IT';

SELECT *
FROM employees_index_demo
WHERE department = 'IT'
  AND city = 'Delhi';

SELECT *
FROM employees_index_demo
WHERE department = 'IT'
ORDER BY city;


-- But consider:
SELECT *
FROM employees_index_demo
WHERE city = 'Delhi';
-- The index begins with department, not city. 
-- MySQL generally cannot use the index as efficiently for a city-only lookup because city values are not globally grouped together.


/*
# SQL PART 6 — PHASE 2
## Topics 5–9: Indexes and Query Performance

### TOPIC 5: Clustered vs. Secondary Indexes in InnoDB

**1. Clustered Index**
- In InnoDB, table rows are stored in the clustered index structure.
- The PRIMARY KEY is normally the clustered index.
- Rows are organized according to the primary-key index.
- If no primary key exists, InnoDB uses a suitable non-NULL unique index if available; otherwise, it creates a hidden clustered index.

**2. Secondary Index**
- An additional index created on columns other than the clustered primary key.
- Stores indexed column values and the corresponding primary-key values.
- When a query uses a secondary index but needs additional columns, MySQL may perform another lookup in the clustered index. This is called a bookmark lookup or back-to-table lookup.

Example:

```sql
CREATE INDEX idx_salary
ON employees_index_demo(salary);
```

```sql
SELECT *
FROM employees_index_demo
WHERE salary = 90000;
```

MySQL can find the matching salary in the secondary index, obtain the employee's primary key, and retrieve the full row from the clustered index.

**3. Covering Index**
- An index is covering when it contains all the columns needed by a query.
- A covering index may allow MySQL to answer the query without accessing the full table row.

Example:

```sql
SELECT employee_id, salary
FROM employees_index_demo
WHERE salary = 90000;
```

The index on `salary` contains both the indexed salary and the primary key, so it can potentially cover this query.

**Key difference:**
- Clustered index: organizes the table's rows.
- Secondary index: provides an additional lookup path and stores the primary key with its entries.

---

### TOPIC 6: Index Selectivity

**Definition:** Selectivity measures how well a column's values distinguish between rows. A column with more distinct values generally has higher selectivity.

Formula:

Selectivity = Number of distinct values / Total number of rows

Example with 20 employees:

| Column | Distinct values | Selectivity |
|---|---:|---:|
| employee_id | 20 | 1.00 |
| email | 20 | 1.00 |
| department | 3 | 0.15 |
| status | 2 | 0.10 |

Calculate selectivity using:

```sql
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT department) AS distinct_departments,
    COUNT(DISTINCT status) AS distinct_statuses,
    COUNT(DISTINCT email) AS distinct_emails
FROM employees_index_demo;
```

**Important points:**
- Higher selectivity generally means a column is more useful for narrowing down rows.
- Primary keys and unique email columns typically have high selectivity.
- Columns such as status or gender often have low selectivity.
- Low-selectivity columns are not automatically unsuitable for indexing. An index may still help when the matching rows are a small fraction of a large table.
- MySQL considers selectivity, the number of matching rows, table size, query requirements, and estimated execution cost when choosing a plan.

**Remember:** Selectivity helps evaluate an index; it does not guarantee that MySQL will use it.

---

### TOPIC 7: Column Order in Composite Indexes

A **composite index** contains two or more columns in a specific order.

Example:

```sql
CREATE INDEX idx_dept_city_salary
ON employees_index_demo(department, city, salary);
```

The index order is:
1. department
2. city
3. salary

**Leftmost-Prefix Rule**

MySQL can generally use the leading column or a consecutive leftmost prefix of a composite index efficiently.

For an index on `(department, city, salary)`:

| Query conditions | Expected usefulness |
|---|---|
| department | Good candidate |
| department + city | Good candidate |
| department + city + salary | Good candidate |
| city only | Cannot efficiently use the leading prefix |
| salary only | Cannot efficiently use the leading prefix |

The optimizer may still consider other access methods, but the index is not naturally ordered for city-only or salary-only lookups.

**Equality and Range Conditions**

Columns frequently used for equality conditions are often placed before range conditions.

Example query:

```sql
SELECT *
FROM employees_index_demo
WHERE department = 'IT'
  AND salary > 70000;
```

Suitable candidate index:

```sql
CREATE INDEX idx_department_salary
ON employees_index_demo(department, salary);
```

This allows MySQL to narrow the search by department and then scan the relevant salary range.

**Choosing Column Order**
- Consider common WHERE conditions.
- Consider equality filters, range filters, JOIN conditions, and ORDER BY clauses.
- Consider which columns most effectively narrow down the search.
- Build indexes around actual query patterns rather than every possible combination.

**Important:** Column order matters. An index on `(department, city)` is not equivalent to an index on `(city, department)`.

---

### TOPIC 8: When to Use Indexes

Indexes are especially useful for:

**1. Frequent lookups**

```sql
SELECT *
FROM employees_index_demo
WHERE email = 'adnan@example.com';
```

**2. Filtering and sorting**

```sql
SELECT employee_id, employee_name, salary
FROM employees_index_demo
WHERE department = 'IT'
ORDER BY salary DESC;
```

A candidate index is:

```sql
CREATE INDEX idx_department_salary
ON employees_index_demo(department, salary);
```

**3. JOIN conditions**
- Indexes on join columns can help MySQL find matching rows efficiently.
- Primary keys and foreign-key requirements also influence index design.

**4. Range queries**

```sql
SELECT *
FROM employees_index_demo
WHERE salary BETWEEN 60000 AND 80000;
```

An index on `salary` may help locate the matching range.

**5. Enforcing uniqueness**

```sql
CREATE UNIQUE INDEX idx_employee_email
ON employees_index_demo(email);
```

A unique index both supports lookups and prevents duplicate non-NULL email values.

**General rule:** Create indexes for frequently executed queries, important filtering and sorting patterns, JOIN conditions, and data-integrity requirements.

---

### TOPIC 9: When Indexes Can Hurt Performance

Indexes have costs and should not be created unnecessarily.

**1. Slower INSERT, UPDATE, and DELETE**
- MySQL must maintain relevant indexes when data changes.
- More indexes generally mean additional write overhead.

**2. Extra Storage**
- Indexes consume disk space and may use memory that could otherwise cache table or index data.

**3. Low-Value Indexes**
- An index on a column with few distinct values may not help when a query returns most of the table.
- For example, indexing `status` may not improve a query that returns nearly every employee.

**4. Redundant Indexes**
- Multiple indexes with overlapping columns can increase storage and maintenance costs.
- An index on `(department, city)` can also support many queries filtering by `department`, so a separate index on `department` may be redundant depending on the workload.
- Review actual usage before removing an index.

**5. Expressions on Indexed Columns**
A normal index may not be used efficiently when a function or expression is applied to the indexed column.

Less index-friendly example:

```sql
SELECT *
FROM employees_index_demo
WHERE salary * 12 > 900000;
```

Equivalent condition:

```sql
SELECT *
FROM employees_index_demo
WHERE salary > 75000;
```

The rewritten condition compares the indexed column directly.

Other cases that can limit index usage include:
- Leading wildcards, such as `LIKE '%adnan'`.
- Implicit type conversions.
- Functions applied to indexed columns.

**Important points:**
- Indexes do not guarantee faster queries.
- A full table scan can be more efficient when most rows are required or the table is small.
- Do not create an index on every column.
- Evaluate indexes using actual queries, execution plans, and workload performance.

---

## QUICK REVISION

- **Clustered index:** Organizes InnoDB table rows; normally based on the primary key.
- **Secondary index:** Stores indexed values with the primary key and provides an additional lookup path.
- **Covering index:** Contains all columns required by a query.
- **Selectivity:** Distinct values divided by total rows.
- **Composite index:** An index containing multiple ordered columns.
- **Leftmost-prefix rule:** Composite indexes are most naturally useful starting from their leftmost column.
- **Index usage:** Most useful when it reduces work for filtering, joins, sorting, ranges, or uniqueness enforcement.
- **Index drawbacks:** Extra storage, write overhead, and potentially redundant or low-value structures.

**Best practice:** Design indexes around actual workload requirements, inspect execution plans, and measure performance before and after changes.
*/

-- EXPLAIN lets us inspect the execution plan that MySQL intends to use for a query. For example:
EXPLAIN
SELECT *
FROM employees_index_demo
WHERE employee_id = 10;

-- id	            Identifier for a query block
-- select_type	    Type of SELECT operation
-- table	        Table accessed
-- type	            Access method chosen by the optimizer
-- possible_keys	Indexes that might be applicable
-- key	            Index actually chosen
-- rows	            Estimated number of rows examined
-- filtered	        Estimated percentage of examined rows that satisfy the condition
-- Extra	        Additional information about the plan

-- Access type	        General meaning
-- const	            A table can be read as a constant, typically through a unique-key lookup
-- eq_ref	            A unique-key lookup for each combination of rows from preceding tables
-- ref	                Lookup using a nonunique index
-- range	            Range scan over an index
-- index	            Full index scan
-- ALL	                Full table scan

-- Unlike ordinary EXPLAIN, this actually executes the query and reports measured execution information, including actual rows and timing for plan operators.
-- Use it thoughtfully because it executes the statement. 
-- For data-changing statements, prefer ordinary EXPLAIN unless you specifically understand the implications of executing the operation.
EXPLAIN ANALYZE
SELECT *
FROM employees_index_demo
WHERE employee_id = 10;



-- >>> BASICS OF QUERY OPTIMIZATION

-- 1. Find employees by department and salary
SELECT employee_id, department, salary FROM employees_index_demo
WHERE salary > 70000; 
-- for this query a good candidate index will be this
-- CREATE INDEX dept_sal 
-- ON employees_index_demo(department, salary);



-- 2. Avoid fetching unnecessary columns
SELECT * FROM employees_index_demo;
-- lets we need only employee_id and employee_name, instead of the above query we ll write
SELECT employee_id, employee_name FROM employees_index_demo;


-- 3. Avoid unnecessary sorting
SELECT employee_id, department, salary FROM employees_index_demo
ORDER BY department, salary;
-- we wont do wht we did above becoz the index we earlier created ""
SELECT employee_id, department, salary FROM employees_index_demo;
