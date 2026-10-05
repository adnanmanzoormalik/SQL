-- >>> A one-to-one (1:1) relationship means:
-- One row in Table A is associated with one row in Table B, and vice versa.
CREATE TABLE persons (
    person_id INT PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE passports (
    passport_id INT PRIMARY KEY,
    passport_number VARCHAR(20) UNIQUE,
    person_id INT UNIQUE, -- >>> the UNIQUE we have written here ensures that the tables have 1:1 relation

    FOREIGN KEY (person_id)
        REFERENCES persons(person_id)
);


-- >>> ONE-TO-MANY RELATIONSHIP: This is probably the most common relationship you'll use. 
-- One row in Table A can be related to many rows in Table B. But each row in B belongs to one row in A.
CREATE TABLE persons (
    person_id INT PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE passports (
    passport_id INT PRIMARY KEY,
    passport_number VARCHAR(20) UNIQUE,
    person_id INT,
    FOREIGN KEY (person_id)
        REFERENCES persons(person_id)
);


-- >>> many-to-many (M:N) relationship means: One row in A can relate to many rows in B, and one row in B can also relate to many rows in A.
-- The core problem is that relational databases cannot directly link two tables in a many-to-many relationship using a simple foreign key.


-- >>> JUNCTION TABLE: A junction table is a table used to implement a many-to-many relationship.
CREATE TABLE students(
    s_id INT PRIMARY KEY,
    name VARCHAR(50)
);
CREATE TABLE courses(
    c_id INT PRIMARY KEY,
    name VARCHAR(50)
);
CREATE TABLE stu_cour(
    stu_id INT,
    cour_id INT,
    PRIMARY KEY(stu_id, cour_id), -- >>> we used this composite so that the stu_id and cour_id remains unique so any students cant be admitted in a course twice

    FOREIGN KEY (stu_id)
        REFERENCES students(s_id),

    FOREIGN KEY (cour_id)
        REFERENCES courses(c_id)
);


-- >>> ENTITY RELATIONSHIP DIAGRAMS: ERD (Entity Relationship Diagram) is a visual representation of your database structure.
/*
It shows:
- Tables/entities - Columns/attributes - Primary keys - Foreign keys - Relationships
┌──────────────────┐
│   departments    │
├──────────────────┤
│ PK department_id │
│    name          │
└────────┬─────────┘
         │
         │ 1
         │
         │
         │ MANY
         ↓
┌──────────────────┐
│    employees     │
├──────────────────┤
│ PK employee_id   │
│    name          │
│ FK department_id │
└──────────────────┘

ERD terminology
Entity: Usually represents something important in your system. like students, courses etc These generally become tables.
Attributes: A property of an entity. like for a student: stu_id, stu_name etc. These become columns.
Relationship: Describes how entities are connected. like students -> enrolled in -> courses 
*/



-- >>> CANDIDATE KEYS: A candidate key is a column or combination of columns that could uniquely identify each row.
-- A table can have multiple candidate keys, but only one is selected as the primary key.
CREATE TABLE students(
    stu_id INT PRIMARY KEY,
    email VARCHAR(50) UNIQUE,
    phone INT UNIQUE
); -- >>> in this table stu_id, email, phone all can be unique and possible identifiers of table but we can only select one as a primary key and we selected stu_id



-- >>> NATURAL KEYS VS SURROGATE KEYS
-- Natural Key: a key that has actual meaning in the real world. like phone_number, email, adhaar EXECUTE
-- Surrogate Key: an artificial identifier created specifically for the database
-- >>> NOTE: In many application databases, a surrogate primary key is commonly preferred. becoz real world values can change like i can change my email or phone 
CREATE TABLE emps(
    serial_number INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    phone_number INT -- Natural Key
);






