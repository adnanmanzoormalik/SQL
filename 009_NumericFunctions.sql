-- >>> ROUND() rounds a number to the nearest integer or to a specified number of decimal places.
SELECT ROUND(12.567);
SELECT ROUND(12.56, 2);
SELECT ROUND(50000.00, 0); -- >>> to omit decimals from salary
-- You can also use negative decimal places to round to tens, hundreds, and so on.
SELECT ROUND(1245, -1); -- >>> nearest 10
SELECT ROUND(1245, -2);  -- >>> nearest 100
SELECT ROUND(1245.45, -2); -- >> nearest 100

-- >>> CEIL() (short for ceiling) returns the smallest integer that is greater than or equal to the given number.
SELECT CEIL(12.4);
SELECT CEIL(12.9);
SELECT CEIL(12.0);
SELECT CEIL(-12.3);
SELECT CEIL(101/10) AS boxes;-- >>> Practical example: If 101 items must be packed into boxes that each hold 10 items, you need 11 boxes.


-- >>> FLOOR() returns the greatest integer that is less than or equal to the given number.
SELECT FLOOR(12.1);
SELECT FLOOR(12.9);
SELECT FLOOR(12.0);
SELECT FLOOR(-12.3);
SELECT FLOOR(29/10); -- >>> If you have 29 students and each bus can carry 10 students, this calculates how many completely filled buses you can make.

-- >>> ABS() returns the absolute value of a number, meaning its non-negative magnitude.
SELECT ABS(-12.5);
SELECT ABS(12.5);
SELECT ABS(40000-45000) AS salary_diff; -- >>> practical use case


-- >>> MOD() returns the remainder when one number is divided by another.
SELECT MOD(10, 3);
SELECT MOD(20, 2);
-- >>> use case checking even and odd number ids
USE college;
SELECT * FROM employees;
SELECT id, name FROM employees WHERE MOD(id,2)=0;


-- Combining numeric functions
SELECT (ROUND(ABS(-12.17), 2));






