in a DB we do CRUD operations (create, read, update, delete)

Data >>> raw info >>> when we process data we can get info
requirements of data:
1. Integrity
2. Availablity
3. Security
4. Independent of Application
5. Concurrency


databases are costly
so why not use files >>>
1. dependency of program on physical structure of data
2. complex process to retrieve data
3. loss of data on concurrent access
4. inability to give access based on record(Security)
5. Data redundancy

use cases for files >>>
1. on device access(offline access)
2. storing frequent incoming data
3. storing not so important data


Database >>>. shared collection of logically related data and desc of this data.
system used to store, retrieve, organise data

DBMS >>> Database Management system
sftwr system that enables users to define, create, miantain, control, access data

Functions of DBMS >>>
1. Data Management >>> CRUD
2. Integrity >>> maintain accuracy of data
3. Security >>> access to authorized users only
4. Concurrency >>> simultaneous data access for multiple users
5. Transaction >>> any changes in db must be successful or should not happen at Availablity
6. Utilities >>> data import/export, user Management, backup, logging


Types of databases
1. Hierarchical DB >>> old ones
2. Relational DB >>> MySQL, Oracle, MS Acess, PostgreSQL
3. NoSQL DB 
4. Network DB (graph)


Relational Model:
table == Relation 
column == attribute/field
rows == tuples/record
no of rows == cardinality of Relation
no of columns == degree of Relation
no value == NULL




Data Integrity and Constrains
Data integrity refers to the overall accuracy, completeness, and consistency of data stored in a database over its entire lifecycle.
Constraints are the rules enforced at the database level to ensure this integrity. If an action violates a constraint, the database rejects the operation.


Types of integrity:
1. Entity Integrity: Guarantees that each row in a table is uniquely identifiable and not duplicated.
2. Domain Integrity: Ensures that values in a column conform to a defined format, type, and valid range.
3. Referential Integrity: Ensures relationships between tables stay synchronized (no child record points to a non-existent parent record).


Database Keys: DBMS key is an attribute (column or a set og columns) which helps use uniquely identify a row in a relation
why >>>
1. uniquely identify a row
2. enfore data integrity
3. establish relationship between tables/relationship

Types of keys:

1. super key: Any set of attributes that uniquely identifies a tuple (row) in a relation. May contain extra, redundant columns.
Example: In a table with (ID, Email, Name), both {ID} and {Email} and {ID, Name} and {ID, Email} and {Email, Name}are super keys.

2. candidate key: min number of column to become a primary key {ID}, {Email}

3. primary key: the candidate key that we select to become our diffirentiator between the columns
must be always unique, must never be null
A relation can have only one primary key
Good to have criteria >>> numeric, as small as possible

4. Alternate key: (secondary key) any candidate key that was not selected as primary key

5. Foreign key: An attribute in one table that references the primary key (or candidate key) of another table.
Establishes relationships and enforces referential integrity.
Can accept duplicate values and NULL values (unless restricted by NOT NULL).

6. Composite Key: A key that consists of two or more attributes combined together to uniquely identify a record.
Used when no single column is sufficient on its own.
Example: In an Enrollments table, {student_id, course_id} together form the primary key.

7. Compound Key: A specific type of composite key where every attribute that makes up the key is a foreign key in its own right.

8. Surrogate key: An artificial, system-generated identifier with no business meaning (e.g., an AUTO_INCREMENT integer id or a UUID).
Used when natural keys are too long, complex, or prone to change.
 



Entity Relation model (ER Model):
graphical representation of entitie and their relationships which helps in understanding data independent of the actual database implemenetation
entity: real worl objects which have an independent existence and about which we intend to collect data
attribute: a property that decribes an entity


cardinality of relationship:
is the number of instances in one entity which is associated to the number of instance in another
1:1 -> one to one 
1:M -> one to many
M:M -> many to many


crow foot notation
![alt text](image.png)

NOTE: to make a M:M relation we need three tables


SQL Queries:
1. DDL (Data Definition Language)
CREATE
ALTER
DROP
TRUNCATE

2. DML (Data Manipulation Language)
INSERT
UPDATE
DELETE
SELECT

3. TCL (Transaction Control Language)
COMMIT
ROLLBACK

4. DCL (Data Control Language)
GRANT
REVOKE

Schema: A schema describes the structure and organization of a database's objects, such as tables, columns, views, and relationships.

Data Types:
(w3schools) >>> MySQL data types

Operators:
w3school

Comments:
-- This is a comment
/*
this is a multi line comment
*/

                            PART 3 — PHASE 5: NORMALIZATION
1. What is Normalization?
Normalization is the process of organizing data into well-structured tables to:
- Reduce data redundancy
- Prevent data anomalies
- Improve data consistency
- Make relationships between data clearer
The main normal forms we need to know:
1NF → 2NF → 3NF → BCNF
2. Data Redundancy
Redundancy means storing the same information unnecessarily multiple times.
Example:
student_id | student_name | course
-----------|--------------|--------
1          | Adnan        | SQL
1          | Adnan        | Python
1          | Adnan        | Java

Adnan is repeated multiple times.
Too much redundancy can cause problems when data needs to be inserted, updated, or deleted.
3. Data Anomalies
Normalization helps prevent three major anomalies.
A. Update Anomaly
The same information is stored in multiple rows, so updating it requires changing multiple places.
Example:
student_id | student_name | course
-----------|--------------|--------
1          | Adnan        | SQL
1          | Adnan        | Python

If Adnan's name changes, multiple rows need to be updated.
If one row is missed, the database becomes inconsistent.
B. Insert Anomaly
You cannot insert some information without also providing unrelated information.
Example:
student_id | student_name | course
-----------|--------------|--------
1          | Adnan        | SQL

Suppose you want to add a new student who hasn't enrolled in any course.
This table may make it difficult to store the student without also providing a course.
C. Delete Anomaly
Deleting one piece of information accidentally removes another important piece of information.
Example:
student_id | student_name | course
-----------|--------------|--------
1          | Adnan        | SQL

If you delete Adnan's SQL enrollment and this is his only row, you may also lose the information that Adnan exists.
4. First Normal Form — 1NF
A table is in 1NF when:
- Each cell contains a single/atomic value
- There are no multiple values in one cell
- There are no repeating groups
❌ Not 1NF
student_id | name  | courses
-----------|-------|-------------------
1          | Adnan | SQL, Python, Java

The courses column contains multiple values.
✅ 1NF
student_id | name  | course
-----------|-------|--------
1          | Adnan | SQL
1          | Adnan | Python
1          | Adnan | Java

Remember:
1NF = Atomic values
5. Second Normal Form — 2NF
A table is in 2NF when:
1. It is already in 1NF
2. There are no partial dependencies
Partial dependency mainly matters when the table has a composite primary key.
Example
student_id | course_id | student_name | course_name | grade
-----------|-----------|--------------|-------------|------
1          | 101       | Adnan        | SQL         | A
1          | 102       | Adnan        | Python      | B
2          | 101       | Rahul        | SQL         | A

Primary key:
PRIMARY KEY (student_id, course_id)

But:
student_id → student_name
course_id  → course_name

student_name depends only on student_id, not the entire composite key.
course_name depends only on course_id, not the entire composite key.
These are partial dependencies.
Better design
students
---------
student_id
student_name

courses
---------
course_id
course_name

student_courses
---------------
student_id
course_id
grade

Remember:
2NF = 1NF + No Partial Dependency
6. Third Normal Form — 3NF
A table is in 3NF when:
1. It is already in 2NF
2. There are no transitive dependencies
A transitive dependency happens when a non-key column depends on another non-key column.
Example
employee_id | employee_name | department_id | department_name
------------|---------------|---------------|----------------
1           | Adnan         | 10            | IT
2           | Rahul         | 10            | IT
3           | Sara          | 20            | HR

Here:
employee_id → department_id
department_id → department_name

Therefore:
employee_id → department_name

department_name depends indirectly on employee_id through department_id.
This is a transitive dependency.

Better design:

employees
---------
employee_id
employee_name
department_id

departments
-----------
department_id
department_name

Remember:
3NF = 2NF + No Transitive Dependency

7. 2NF vs 3NF
Normal Form	Main Problem Removed
1NF	Multiple values in one cell
2NF	Partial dependency
3NF	Transitive dependency
BCNF	Stronger version of 3NF


Easy way to remember:
1NF → Atomic
2NF → No Partial Dependency
3NF → No Transitive Dependency

8. BCNF — Boyce-Codd Normal Form
BCNF is a stronger version of 3NF.
Basic rule:
Every determinant must be a candidate key.

For our current level, understand the concept rather than memorizing complex examples.
3NF → Standard practical normalization
BCNF → Stronger form of 3NF

9. Normalization vs Denormalization
Normalization
Split data into related tables.
Advantages:
- Less redundancy
- Better consistency
- Fewer update anomalies
- Cleaner database structure
Disadvantage:
- More tables
- More JOINs may be required
Denormalization
Intentionally keep some redundant data to improve:
- Read performance
- Reporting
- Analytics
- Query simplicity
Example:
Instead of always joining:
employees
departments

you might intentionally store:
employee_id | employee_name | department_id | department_name

This creates redundancy, but can sometimes make reading data faster or simpler.

