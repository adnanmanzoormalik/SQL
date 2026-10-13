USE joins;
-- /*
-- -- Create authors table
-- CREATE TABLE authors (
--     author_id INT PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     birth_year INT
-- );

-- -- Create books table
-- CREATE TABLE books (
--     book_id INT PRIMARY KEY,
--     title VARCHAR(100),
--     author_id INT,
--     publication_year INT,
--     price DECIMAL(6,2)
-- );

-- -- Insert data into authors table
-- INSERT INTO authors (author_id, first_name, last_name, birth_year)
-- VALUES
--     (1, 'Jane', 'Austen', 1775),
--     (2, 'George', 'Orwell', 1903),
--     (3, 'Ernest', 'Hemingway', 1899),
--     (4, 'Agatha', 'Christie', 1890),
--     (5, 'J.K.', 'Rowling', 1965);

-- -- Insert data into books table
-- INSERT INTO books (book_id, title, author_id, publication_year, price)
-- VALUES
--     (101, 'Pride and Prejudice', 1, 1813, 12.99),
--     (102, '1984', 2, 1949, 14.50),
--     (103, 'Animal Farm', 2, 1945, 11.75),
--     (104, 'The Old Man and the Sea', 3, 1952, 10.99),
--     (105, 'Murder on the Orient Express', 4, 1934, 13.25),
--     (106, 'Death on the Nile', 4, 1937, 12.50),
--     (107, 'Emma', 1, 1815, 11.99),
--     (108, 'For Whom the Bell Tolls', 3, 1940, 15.75);
-- */
-- SELECT * FROM authors;
-- SELECT * FROM books;

-- -- retrieve books with their author info
-- SELECT b.title, a.first_name, a.last_name, a.birth_year
-- FROM authors AS a
-- JOIN books AS b
--     ON a.author_id = b.author_id WHERE b.publication_year > 1948 ORDER BY birth_year DESC; -- if we dont mention table here sql checks both tables for the column 
--                                                                                            -- if there is only one there will be no error and if there are two column of the same name there will be an error

-- -- how many books each author has written
-- SELECT first_name, COUNT(*) AS num_of_books FROM authors AS a
-- JOIN books as b
--     ON a.author_id = b.author_id
-- GROUP BY a.author_id;

-- /*
-- CREATE TABLE categories (
--     category_id INT PRIMARY KEY,
--     category_name VARCHAR(50)
-- );

-- INSERT INTO categories (category_id, category_name)
-- VALUES
--     (1, 'Fiction'),
--     (2, 'Classic'),
--     (3, 'Romance'),
--     (4, 'Political'),
--     (5, 'Mystery'),
--     (6, 'Adventure');
-- */
-- SELECT * FROM categories;

-- -- JUNCTION TABLE
-- /*
-- CREATE TABLE book_categories (
--     book_id INT,
--     category_id INT,
--     PRIMARY KEY (book_id, category_id)
-- );

-- INSERT INTO book_categories (book_id, category_id)
-- VALUES
--     (101, 1), (101, 2), (101, 3), -- Pride and Prejudice: Fiction, Classic, Romance
--     (102, 1), (102, 2), (102, 4), -- 1984: Fiction, Classic, Political
--     (103, 1), (103, 2), (103, 4), -- Animal Farm: Fiction, Classic, Political
--     (104, 1), (104, 2), (104, 6), -- The Old Man and the Sea: Fiction, Classic, Adventure
--     (105, 1), (105, 5),          -- Murder on the Orient Express: Fiction, Mystery
--     (106, 1), (106, 5),          -- Death on the Nile: Fiction, Mystery
--     (107, 1), (107, 2), (107, 3), -- Emma: Fiction, Classic, Romance
--     (108, 1), (108, 2), (108, 6); -- For Whom the Bell Tolls: Fiction, Classic, Adventure
-- */

-- SELECT * FROM book_categories;


-- -- get books with their authors and categories
-- SELECT b.title, a.first_name, GROUP_CONCAT(c.category_name SEPARATOR '|') AS categories  FROM books b
-- JOIN authors AS a 
--     ON b.author_id = a.author_id
-- JOIN book_categories AS bc
--     ON b.book_id = bc.book_id
-- JOIN categories as c
--     ON c.category_id = bc.category_id
-- GROUP BY b.book_id;


-- -- return books published before 1950 by athors born before 1900
-- SELECT b.title, a.birth_year, b.publication_year FROM books AS b
-- JOIN authors AS a
--     ON a.author_id = b.author_id
--     AND b.publication_year < 1950 -- filtering before joining
--     AND a.birth_year < 1900;

-- SELECT b.title, a.birth_year, b.publication_year FROM books AS b
-- JOIN authors AS a
--     ON a.author_id = b.author_id
-- WHERE b.publication_year < 1950 AND a.birth_year < 1900; -- filitering after joining


-- -- return books published more than 70 years ago
-- SELECT b.title, a.last_name, b.publication_year FROM books AS b
-- JOIN authors AS a
--     ON a.author_id = b.author_id
--     AND b.publication_year < (YEAR(CURDATE())-70);

-- -- INNER JOIN DOESNT RETURN rows WITH NULL VALUES

-- -- find authors who have written more than one book
-- SELECT a.first_name, COUNT(*) as count_of_books FROM authors AS a
-- JOIN books AS b
--     ON a.author_id = b.author_id
-- GROUP BY a.first_name
-- HAVING COUNT(*) > 1;







-- -- LEFT JOIN (LEFT OUTER JOIN): retrieves all records from left table and matching records from right TABLE
-- /*
-- -- Create customers table
-- CREATE TABLE customers (
--     customer_id INT PRIMARY KEY,
--     customer_name VARCHAR(100) NOT NULL,
--     email VARCHAR(100),
--     city VARCHAR(50)
-- );

-- -- Create orders table with foreign key
-- CREATE TABLE orders (
--     order_id INT PRIMARY KEY,
--     customer_id INT,
--     order_date DATE NOT NULL,
--     total_amount DECIMAL(10, 2),
--     FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
-- );

-- -- Insert sample customer data
-- INSERT INTO customers (customer_id, customer_name, email, city)
-- VALUES 
--     (1, 'John Smith', 'john@example.com', 'New York'),
--     (2, 'Jane Doe', 'jane@example.com', 'Los Angeles'),
--     (3, 'Robert Johnson', 'robert@example.com', 'Chicago'),
--     (4, 'Emily Davis', 'emily@example.com', 'Houston'),
--     (5, 'Michael Brown', 'michael@example.com', 'Phoenix');

-- -- Insert sample order data
-- INSERT INTO orders (order_id, customer_id, order_date, total_amount)
-- VALUES 
--     (101, 1, '2023-01-15', 150.75),
--     (102, 3, '2023-01-16', 89.50),
--     (103, 1, '2023-01-20', 45.25),
--     (104, 2, '2023-01-25', 210.30),
--     (105, 3, '2023-02-01', 75.00);
-- */

-- SELECT * FROM customers;
-- SELECT * FROM orders;

-- -- return all customers and their associated orders (do some filtering)
-- SELECT * FROM customers AS c
-- LEFT JOIN orders AS o
--     ON c.customer_id = o.customer_id;

-- SELECT * FROM customers AS c
-- LEFT JOIN orders AS o
--     ON c.customer_id = o.customer_id
-- WHERE o.order_id IS NULL;


-- SELECT c.customer_id, c.customer_name, COUNT(o.customer_id),IFNULL(SUM(o.total_amount), 0) AS spent_amt FROM customers AS c
-- LEFT JOIN orders AS o
--     ON c.customer_id = o.customer_id
-- GROUP BY c.customer_id;

-- /*
-- -- Create shipping table for multiple joins example
-- CREATE TABLE shipping (
--     shipping_id INT PRIMARY KEY,
--     order_id INT,
--     shipping_date DATE,
--     carrier VARCHAR(50),
--     tracking_number VARCHAR(50),
--     FOREIGN KEY (order_id) REFERENCES orders(order_id)
-- );

-- -- Insert sample shipping data
-- INSERT INTO shipping (shipping_id, order_id, shipping_date, carrier, tracking_number)
-- VALUES 
--     (1001, 101, '2023-01-16', 'FedEx', 'FDX123456789'),
--     (1002, 104, '2023-01-26', 'UPS', 'UPS987654321'),
--     (1003, 105, '2023-02-02', 'USPS', 'USPS456789123');
-- */


-- -- get customers, their orders and shipping information
-- SELECT 
--     c.customer_name,
--     o.order_id,
--     o.order_date,
--     o.total_amount,
--     s.carrier,
--     s.tracking_number
-- FROM 
--     customers AS c
-- LEFT JOIN 
--     orders AS o ON c.customer_id = o.customer_id
-- LEFT JOIN
--     shipping AS s ON s.order_id = o.order_id;


-- -- analyze new york customers and their order history
-- SELECT 
--     c.customer_id, 
--     c.customer_name,
--     c.city,
--     GROUP_CONCAT(o.order_id) as order_ids,
--     GROUP_CONCAT(o.order_date) as order_dates
-- FROM (SELECT * FROM customers WHERE city = "New York") AS c
-- LEFT JOIN orders AS o
--     ON o.customer_id = c.customer_id
-- GROUP BY c.customer_id;



-- -- return customers who havent ordered anything in last 30 days

-- SELECT c.customer_id, c.customer_name, MAX(o.order_date) AS last_order_date FROM customers AS c
-- LEFT JOIN orders AS o
--     ON c.customer_id = o.customer_id
-- GROUP BY c.customer_id, c.customer_name
-- HAVING last_order_date < DATE_SUB(CURDATE(), INTERVAL 30 DAY) OR last_order_date IS NULL;




-- RIGHT OUTER JOIN
/*
CREATE TABLE apartments (
    apartment_id INT PRIMARY KEY,
    apartment_number VARCHAR(10) NOT NULL,
    floor_number INT NOT NULL,
    wing_name CHAR(1) NOT NULL
);

-- Create residents table with foreign key to apartments
CREATE TABLE residents (
    resident_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    occupation VARCHAR(100),
    apartment_id INT,
    FOREIGN KEY (apartment_id) REFERENCES apartments(apartment_id)
);

-- Insert sample apartment data
INSERT INTO apartments (apartment_id, apartment_number, floor_number, wing_name) VALUES
(1, '101', 1, 'A'),
(2, '102', 1, 'A'),
(3, '201', 2, 'A'),
(4, '202', 2, 'A'),
(5, '301', 3, 'A'),
(6, '302', 3, 'A'),
(7, '401', 4, 'A'),
(8, '402', 4, 'A'),
(9, '501', 5, 'B'),
(10, '502', 5, 'B');

-- Insert sample resident data
INSERT INTO residents (resident_id, first_name, last_name, occupation, apartment_id) VALUES
(1, 'Jethalal', 'Gada', 'Electronics Shop Owner', 1),
(2, 'Daya', 'Gada', 'Housewife', 1),
(3, 'Taarak', 'Mehta', 'Writer', 2),
(4, 'Anjali', 'Mehta', 'Teacher', 2),
(5, 'Popatlal', 'Pandey', 'Reporter', 3),
(6, 'Bhide', 'Aatmaram', 'School Teacher', 4),
(7, 'Madhavi', 'Bhide', 'Housewife', 4),
(8, 'Dr', 'Hathi', 'Doctor', 5),
(9, 'Komal', 'Hathi', 'Housewife', 5);
-- Note: We've left some apartments without residents
*/
-- Basic SELECT query to view all aprtments and residents
SELECT * FROM apartments;
SELECT * FROM residents;
SELECT * FROM maintenance_requests;

SELECT * FROM residents as r
RIGHT JOIN apartments as a
    ON r.apartment_id = a.apartment_id;

/*
CREATE TABLE maintenance_requests (
    request_id INT PRIMARY KEY,
    apartment_id INT,
    request_date DATE NOT NULL,
    description TEXT NOT NULL,
    status ENUM('Pending', 'In Progress', 'Completed') DEFAULT 'Pending',
    FOREIGN KEY (apartment_id) REFERENCES apartments(apartment_id)
);

INSERT INTO maintenance_requests (request_id, apartment_id, request_date, description, status) VALUES
    (1, 1, '2023-01-15', 'Leaky faucet in kitchen', 'Completed'),
    (2, 1, '2023-02-20', 'Broken window handle', 'Completed'),
    (3, 2, '2023-03-10', 'Electricity fluctuation', 'In Progress'),
    (4, 4, '2023-03-15', 'Ceiling fan not working', 'Pending'),
    (5, 5, '2023-04-01', 'Bathroom door lock broken', 'Completed'),
    (6, 8, '2023-04-10', 'Water seepage in wall', 'In Progress');
*/

-- Find unoccupied apartmens
SELECT a.apartment_id FROM residents AS r
RIGHT JOIN apartments AS a
    ON r.apartment_id = a.apartment_id
WHERE r.apartment_id IS NULL;

-- Count the number of residents per apartments
SELECT a.apartment_id, a.apartment_number, COUNT(r.apartment_id) FROM residents AS r
RIGHT JOIN apartments AS a
    ON a.apartment_id = r.apartment_id
GROUP BY a.apartment_id;

-- list all apartments with their residents and maintainance request status
SELECT a.apartment_id, r.resident_id, mr.status FROM residents AS r
RIGHT JOIN apartments AS a 
    ON a.apartment_id = r.apartment_id
RIGHT JOIN maintenance_requests AS mr
    ON a.apartment_id = mr.apartment_id;

-- write a query to find the floor with most unoccupied apartments
SELECT 
    floor_number,
    wing_name,
    COUNT(*) AS unoccupied_count
FROM 
    apartments a
LEFT JOIN 
    residents r ON a.apartment_id = r.apartment_id
WHERE 
    r.resident_id IS NULL
GROUP BY 
    floor_number, wing_name
ORDER BY 
    unoccupied_count DESC
LIMIT 1;


-- write a query to list all apartments along with the total number of maintenance requests
SELECT 
    a.apartment_id, 
    COUNT(mr.apartment_id) 
FROM apartments AS a
LEFT JOIN maintenance_requests AS mr
    ON a.apartment_id = mr.apartment_id
GROUP BY a.apartment_id;





















