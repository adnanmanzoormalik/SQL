-- >>> CURDATE() — Current date
SELECT CURDATE();

-- >>> NOW() — Current date and time
SELECT NOW();

-- >>> DATEDIFF() — Difference between dates
-- Returns the number of days between two dates. MySQL calculates the first date minus the second date, ignoring their time portions.
SELECT DATEDIFF("2026-10-02", "2025-09-25");
SELECT DATEDIFF("2026-10-02", "2027-10-02"); -- >>> this will give diff in day and in negative
SELECT DATEDIFF(CURDATE(), "2004-09-08") AS "age in days <3";

-- >>> DATE_ADD() - Adds a specified interval to a date.
SELECT DATE_ADD(CURDATE(), INTERVAL 7 DAY) AS after_a_week;
SELECT DATE_ADD("2000-10-02", INTERVAL 2 MONTH);
SELECT DATE_ADD(DATE_ADD(DATE_ADD(CURDATE(), INTERVAL 1 YEAR), INTERVAL 1 MONTH), INTERVAL 1 DAY);
-- >>> Common interval units include DAY, MONTH, YEAR.

SELECT CURDATE() + INTERVAL 1 YEAR + INTERVAL 1 MONTH + INTERVAL 1 DAY; -- >>> we can also do this


-- >>> DATE_SUB() - Subtracts a specified interval from a date.
SELECT DATE_SUB(CURDATE(), INTERVAL 26 YEAR);
SELECT DATE_SUB(DATE_SUB(DATE_SUB("2026-10-03", INTERVAL 26 YEAR), INTERVAL 5 MONTH), INTERVAL 19 DAY) AS birhtday;



-- >>> Extract year, month, and day
SELECT YEAR("2026-10-03");
SELECT MONTH(CURDATE());
SELECT DAY(NOW());
SELECT HOUR(NOW());
SELECT MINUTE(NOW());
SELECT SECOND(NOW());
