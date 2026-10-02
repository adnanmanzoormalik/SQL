USE college;
SELECT DATABASE();
-- >>> SELECT statement retrieves data from a table.
-- SELECT col_name FROM table_name;
SELECT * FROM students;
SELECT name, age FROM students;
-- The asterisk (*) means all columns.

-- >>> using alias for column name
SELECT age AS age_1 FROM students;
SELECT name AS first_name, age AS age_1 from students;
SELECT 100 * 2 AS total;  -- >>> we can use alias for an expression also

-- >>> DISTINCT removes duplicate combinations from the query result.
SELECT DISTINCT name FROM students;  -- >>> this will show unique names from college that means if a name is present multiple times it ll show was that name only once


-- >>> LIMIT restricts the number of rows returned. 
SELECT age FROM students LIMIT 3;  -- >>> this will retutn at most first 3 rows from the table
SELECT age FROM students ORDER BY age ASC LIMIT 3;  -- >>> this will return three rows with lowest three ages

-- >>> OFFSET specifies how many rows to skip before returning results.
SELECT name FROM students OFFSET 3; -- >>> this will skip first three rows
SELECT name FROM students LIMIT 3 OFFSET 2;
SELECT name FROM students LIMIT 2,3; -- >>> this means limit 3 offset 2
/*
It is commonly used for pagination, where data is split across multiple pages.
For example, if each page displays 10 students:
Page Query
Page 1                  LIMIT 10 OFFSET 0
Page 2                  LIMIT 10 OFFSET 10
Page 3                  LIMIT 10 OFFSET 20
In a real application, use a consistent ORDER BY when paginating so that records have a predictable order.
*/







