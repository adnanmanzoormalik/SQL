/*
Create the Database & Table:
Create a database named bookstore_db and switch to using it.
Create a table named books with these columns:
book_id (integer)
title (text up to 150 characters)
author (text up to 100 characters)
price (decimal with 2 decimal places, e.g., 19.99)
published_date (date)
in_stock (boolean)
Insert Data:
Insert at least two rows into books in a single INSERT statement.
Modify the Schema:
Add a new column named genre (text up to 50 characters) to the books table.
Retrieve Data:
Write a query to select only the title (aliased as Book_Title) and price for books, displaying only the first 3 results.
*/

CREATE DATABASE IF NOT EXISTS bookstore_db;
USE bookstore_db;

CREATE TABLE IF NOT EXISTS books(
    book_id INT,
    title VARCHAR(150),
    author VARCHAR(100),
    price DECIMAL(10,2),
    published_date DATE,
    in_stock BOOLEAN
);

INSERT INTO books(book_id, title, author, price, published_date, in_stock) VALUES
    (1, 'Python', 'Adnan', 254.32, '2022-08-30', TRUE),
    (2, 'Java', 'Jasleen', 320.10, '2023-10-15', TRUE)
;

ALTER TABLE books
ADD COLUMN genre VARCHAR(50);

SELECT title AS Book_Title, price FROM books LIMIT 3;




/*
Write the SQL queries for the following tasks:
Update Data:
Set the genre to 'Programming' and increase the price by 10.00 for the book with book_id = 1.
Update all books where published_date is before '2023-01-01' to mark in_stock = FALSE.
Delete Data:
Delete the book with title = 'Java'.
Check the Table:
Write a query to inspect the table structure (its columns and types) to confirm the columns are still intact.
Paste your SQL queries when you are ready!
*/

UPDATE books
SET genre='Programming', price=price+10.00
WHERE book_id = 1;

UPDATE books
SET in_stock = FALSE
WHERE published_date<'2023-01-01';

DELETE FROM books WHERE title='Java';

SHOW CREATE TABLE books;





