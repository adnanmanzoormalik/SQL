CREATE DATABASE IF NOT EXISTS college;
SHOW DATABASES;
USE college;

-- CREATE TABLE table_name; >>> A table stores data in rows and columns. When creating one, you specify its column names and data types.
CREATE TABLE IF NOT EXISTS students(
    id INT,
    name VARCHAR(255),
    age INT,
    email VARCHAR(255),
    admission_date DATE
);

/*
INT                 Whole numbers                   25
VARCHAR(n)          Variable-length text            'Adnan'
TEXT                Longer text                     A description or review
DATE                Calendar date                   '2026-10-02'
DECIMAL(p,s)        Exact decimal values            499.99          e.g DECIMAL(10,2) means 10 digits and 2 decimal values like this 12345678.90
BOOLEAN             True/false values               TRUE
*/

SHOW TABLES; -- shows tables in currently using database

-- DESCRIBE table_name; or DESC table_name; >>> The DESCRIBE command shows a table's structure, including its column names, data types, whether NULL is allowed, key information, and default values.
DESC students;


SHOW CREATE TABLE students; -- >>> Show the SQL definition used to create the table
SELECT DATABASE(); -- >>> shows which DB we are using








