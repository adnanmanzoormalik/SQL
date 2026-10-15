-- CREATE DATABASE sql_part6;
USE sql_part6;
/*
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(50) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL
) ENGINE = InnoDB;
-- InnoDB is the default storage engine in MySQL (since MySQL 5.5). 
-- Writing it explicitly in a CREATE TABLE statement simply guarantees the table uses InnoDB even if the server's default configuration was changed.

INSERT INTO accounts
    (account_id, account_holder, balance)
VALUES
    (1, 'Adnan', 5000.00),
    (2, 'Rahul', 2000.00);
*/
SELECT * FROM accounts;


START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE account_id = 2;

ROLLBACK;
COMMIT;

SELECT * FROM accounts;
-- START TRANSACTION	Begins a transaction
-- COMMIT	            Saves the transaction's changes
-- ROLLBACK	            Cancels the transaction's uncommitted changes

-- Common mistake: You cannot use ROLLBACK to undo a transaction after it has been committed. Once committed, you'd generally need a new transaction to perform a compensating change.
-- Also, certain SQL statements in MySQL cause implicit commits, so not every operation can be undone with ROLLBACK. We'll be careful to use transactional DML in our exercises.




-- SAVEPOINT
-- Sometimes you don't want to cancel an entire transaction. You only want to undo part of it.
-- That's what SAVEPOINT is for.
-- Think of a savepoint as a named checkpoint inside a transaction.
SELECT * FROM accounts; -- 1

START TRANSACTION;

UPDATE accounts
SET balance = balance - 100
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 100
WHERE account_id =2;

SELECT * FROM accounts; -- 2

SAVEPOINT after_transaction;

UPDATE accounts
SET balance = balance + 99
WHERE account_id = 2;

SELECT * FROM accounts; -- 3

ROLLBACK TO SAVEPOINT after_transaction;
COMMIT;

SELECT * FROM accounts;

-- SAVEPOINT name                      creates a checkpoint.
-- ROLLBACK TO SAVEPOINT name          undoes changes after that checkpoint.
-- RELEASE SAVEPOINT name              removes the checkpoint.
-- COMMIT                              ends the transaction and removes its savepoints.
-- ROLLBACK                            without a savepoint rolls back the entire uncommitted transaction.




/*
ACID properties
ACID describes four important properties of reliable database transactions.
A - Atomicity:      All the operations in a transaction succeed together, or their uncommitted changes are rolled back together.
                    Example: A bank transfer must not debit the sender without crediting the receiver.
C - Consistency:    A transaction must preserve the database's defined integrity rules when it succeeds.
                    Example: Account balances must satisfy the rules your database enforces, such as a nonnegative balance constraint if one is defined.
I - Isolation:      Concurrent transactions should not interfere with one another in ways prohibited by the chosen isolation level.
                    Example: One transaction shouldn't read another transaction's uncommitted changes under the default MySQL isolation level.
D - Durability:     Once a transaction is committed, its changes are designed to survive failures, subject to the database's configuration and storage guarantees.
                    Example: A committed payment should not disappear simply because the application disconnects.

An easy way to remember ACID
- A — Atomicity: All or nothing.
- C — Consistency: Rules remain satisfied.
- I — Isolation: Transactions are appropriately separated.
- D — Durability: Committed changes persist.
These are not four SQL commands. They are four properties that a transactional database system aims to provide.
*/








-- >>> Isolation levels control what one transaction can observe about other concurrent transactions.

-- MySQL InnoDB supports four standard isolation levels.
-- Isolation level	            Main idea
-- READ UNCOMMITTED	        Can permit dirty reads
-- READ COMMITTED	            Reads only committed data; repeated reads can differ
-- REPEATABLE READ	            Provides consistent repeated reads; InnoDB also uses locking and MVCC to manage concurrency
-- SERIALIZABLE	            Strongest standard isolation; restricts concurrent behavior more heavily

-- In MySQL InnoDB, REPEATABLE READ is the default isolation level in typical configurations.

-- How to check your isolation level
SELECT @@transaction_isolation;

-- How to check your global isolation level
SELECT @@global.transaction_isolation;

-- The session variable describes your current connection; the global variable describes the default used by new sessions.


-- How to change it
-- For your current session:
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;




-- >>> Dirty Read: happens when one transaction reads a value written by another transaction that has not committed.
-- Transaction A changes a row but hasn't committed yet. 
-- Transaction B reads that uncommitted row. If Transaction A rolls back, Transaction B operated on "dirty" data that never officially existed.
-- Use READ COMMITTED or a stronger isolation level. 
-- InnoDB does not expose another transaction's uncommitted changes through ordinary consistent reads at these levels.

-- SESSION 1: 
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
UPDATE accounts
SET balance = balance - 77
WHERE account_id = 1;
SELECT * FROM accounts
WHERE account_id = 1;

-- SESSION 2:
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; -- this helps us to prevent dirty reads
SELECT * FROM accounts WHERE account_id =1;

-- Remember that READ UNCOMMITTED is unusual for applications that need reliable financial or business data.





-- Non-repeatable read: A transaction reads the same row twice but gets different committed values because another transaction updates that row between the reads.
-- Transaction A reads a row. Transaction B modifies or deletes that row and commits. Transaction A reads the exact same row again and gets different data.
-- REPEATABLE READ


-- Phantom read: A phantom read occurs when the same range query returns a different set of rows on a later execution because another transaction inserted or deleted matching rows and committed.
-- Transaction A reads a set of rows matching a WHERE condition (e.g., salary > 50000). 
-- Transaction B inserts new rows matching that condition and commits. Transaction A repeats the query and sees new "phantom" rows in the result set.
-- SERIALIZATION




-- Basic deadlock concepts: A deadlock occurs when two or more transactions are waiting for locks held by one another, so none can proceed without intervention.--- 
-- A deadlock occurs when two or more transactions each hold a lock that the other needs, causing both to freeze indefinitely in a circular wait. 
-- MySQL’s InnoDB engine automatically detects this cycle, aborts the cheaper transaction with ERROR 1213, and rolls it back so the other can finish. 
-- You prevent them by locking rows in a consistent order, using proper indexes, and keeping transactions short.




