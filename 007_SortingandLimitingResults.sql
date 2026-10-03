USE college;
SELECT * FROM employees;

-- >>> ORDER BY: sorts the rows returned by a query based on one or more columns.
SELECT * FROM employees ORDER BY salary; -- >>> when we dont mention ASC or DESC it by default takes ASC
-- ORDER BY changes the order of the query results, not the permanent order of the records in the table.
/*
ASC — Ascending
Numbers: smallest to largest
Text: alphabetical order, according to the applicable collation
Dates: oldest to newest

DESC — Descending
Numbers: largest to smallest
Text: reverse collation order
Dates: newest to oldest
*/
SELECT * FROM employees ORDER BY age DESC;
SELECT * FROM employees ORDER BY name ASC;

-- >>> Sorting by multiple columns
-- MySQL sorts using the first column. When multiple rows have the same value in that column, it uses the next column to order those tied rows.
SELECT * FROM employees ORDER BY department ASC; -- >>> this wont be able to order the columns with tied department names
SELECT * FROM employees ORDER BY department ASC, salary DESC; -- >>> so we use the second column to break the tie



-- >>> LIMIT restricts how many rows a query returns.
SELECT * FROM employees LIMIT 3;
SELECT * FROM employees ORDER BY name DESC LIMIT 3;
SELECT * FROM EMPLOYEES ORDER BY salary DESC LIMIT 3; -- >>> top 3 paid employees


-- >>> OFFSET tells MySQL how many rows to skip before returning results. It is commonly combined with LIMIT.
SELECT * FROM employees LIMIT 2 OFFSET 3;
SELECT * FROM employees LIMIT 3,2; -- >>> this is the same as the above query (skip 3 and then give 4 rows)
SELECT * FROM employees ORDER BY salary DESC LIMIT 1 OFFSET 1; -- >>> second highest salary


-- >>> Pagination means splitting a large result set into smaller pages.
-- For example, imagine an employee table with 100 records. Instead of displaying all 100 on one page, an application could show 10 records per page.
SELECT * FROM employees ORDER BY salary ASC LIMIT 2 OFFSET 0;
SELECT * FROM employees ORDER BY salary ASC LIMIT 2 OFFSET 2;
SELECT * FROM employees ORDER BY salary ASC LIMIT 2 OFFSET 4;



