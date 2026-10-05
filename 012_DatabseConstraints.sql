-- >>> PRIMARY KEY uniquely identifies every row in a table.
/*
Must contain unique values
Cannot contain NULL
A table can have only one primary key
That primary key can consist of one or multiple columns
*/

CREATE TABLE IF NOT EXISTS employees(
    id INT PRIMARY KEY,
    name VARCHAR(50)
);
--  we can also do this
CREATE TABLE IF NOT EXISTS employees(
    id INT,
    name VARCHAR(50),
    PRIMARY KEY(id)
);

-- >>> AUTO_INCREMENT: automatically generates the next numeric value when a row is inserted.
-- usually used with primary key
CREATE TABLE IF NOT EXISTS employees(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);
-- now we can just insert name without inserting the CACHE INDEX
INSERT INTO employees(name) VALUES("Adnan");
-- NOTE: AUTO_INCREMENT does not guarantee that numbers will never have gaps. it can sometimes be 1,2,4,6,8...
/*
Common causes of gaps
Rolled-back transactions: If a transaction reserves ID 3 and then fails or runs ROLLBACK, ID 3 is discarded permanently. The next insert gets 4.
Deleted rows: Deleting row 2 leaves a permanent gap between 1 and 3. The database will not shift existing IDs down or reuse 2.
Failed inserts: If an insert violates a constraint (e.g., duplicate unique email or foreign key failure), the generated ID is consumed and thrown away.
Database restarts or server crashes: Many database engines (such as MySQL InnoDB) cache batches of auto-increment values in memory. An unexpected restart can discard the unused numbers in that batch.
Bulk inserts: When inserting multiple rows at once, the engine often allocates a block of numbers in advance. Any unused numbers in that pre-allocated range are skipped.
*/


-- >>> NOT NULL means a column must have a value.
CREATE TABLE employees(
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);


-- >>> UNIQUE ensures that values in a column cannot be duplicated.
CREATE TABLE employees(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE
);



-- >>> DEFAULT provides a value automatically when the user doesn't provide one.
CREATE TABLE employees(
    id INT,
    name VARCHAR(50),
    company_name VARCHAR(50) DEFAULT 'ACCENTURE'
);



-- >>> CHECK ensures that data satisfies a specified condition.
CREATE TABLE employees(
    id INT,
    name VARCHAR(50),
    age INT CHECK (age>=18)
);

-- >>> FOREIGN KEY, ON DELETE, ON UPDATE
/*
REFER TO >>> 012.1_ForeignKey.sql
*/


-- >>> Composite Primary Keys: A composite primary key uses multiple columns together to uniquely identify a row. usually when there is not a unique row independently
CREATE TABLE table1(
    id INT,
    name VARCHAR(50),
    age INT,
    PRIMARY KEY(id, name)
);




