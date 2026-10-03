USE college;
/*
CREATE TABLE emps1 (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE
);
INSERT INTO emps1 (id, first_name, last_name, email) VALUES
(1, 'Adnan', 'Malik', 'adnan@gmail.com'),
(2, 'AISHA', 'Khan', 'aisha@gmail.com'),
(3, 'Rahul', 'Sharma', 'rahul@gmail.com'),
(4, 'Sara', 'Ali', 'sara@gmail.com');
*/
SELECT * FROM emps1;


-- >>> CONCAT() combines two or more strings into a single string.
SELECT CONCAT(first_name," ", last_name) AS full_name FROM emps1;
SELECT CONCAT("EMPLOYEE ", id,": ", first_name) AS employee_label FROM emps1;
-- In MySQL, CONCAT() returns NULL if any argument is NULL.

-- If you want to treat missing values as empty strings, you can use COALESCE() >>> to be studied in future

-- >>> LENGTH() returns the number of bytes in utf8mb4 in a string, not necessarily the number of characters.
SELECT first_name, LENGTH(first_name) AS name_length FROM emps1;
-- LENGTH(): number of bytes 
-- CHAR_LENGTH(): number of characters
SELECT LENGTH("é") AS number_of_bytes, CHAR_LENGTH("é") AS number_of_chars; 


-- >>> UPPER() converts lowercase letters to uppercase. UPPER() changes the query output, not the stored value.
SELECT UPPER(first_name) AS uppercase_name FROM emps1;


-- >>> LOWER() converts uppercase letters to lowercase. LOWER() in a query does not automatically update stored email values
SELECT first_name, LOWER(email) AS email from emps1;

-- >>> TRIM() removes unwanted characters from the beginning and end of a string. By default, it removes ordinary space characters.
SELECT TRIM("     Adnan     ");
SELECT TRIM(first_name) AS name FROM emps1;
SELECT TRIM("-" FROM "-----Adnan----");
-- TRIM() does not remove every kind of whitespace in every situation. Tabs and newline characters may require other functions or explicit replacements.
-- Also, TRIM() in a SELECT statement doesn't permanently clean the stored column. Updating the data requires a separate statement.

-- >>> SUBSTRING() extracts part of a string.
SELECT SUBSTRING("Adnan Manzoor", 1, 5) AS firstName; -- >>> 1 is the starting position and inclusive and 5 is the number of characters
SELECT SUBSTRING("Adnan Manzoor Malik", 7, 7) AS middleName; -- >>> 7 is the starting position and 7 is the no of characters
SELECT SUBSTRING("Adnan Manzoor Malik",7) AS name; -- >>> if we omit the number of characters it starts from 7 to the end
SELECT SUBSTRING(email, 1, 5) AS name FROM emps1; 


-- >>> REPLACE() replaces every occurrence of a specified substring with another string.
-- This displays modified email strings in the query result. It does not update the values stored in the database.
SELECT REPLACE("Adnan Malik", "Malik", "Manzoor") AS chnaged_name;
SELECT REPLACE(email, "gmail", "yahoo") AS changed_email FROM emps1;
SELECT REPLACE("123-456-7890", "-", " ") AS new_phone;


-- >>> combining string functions
SELECT UPPER(TRIM("   adnan manzoor    ")) AS upper_trim_name;
SELECT LOWER(CONCAT(first_name, " ",last_name)) AS lower_concat_name FROM emps1;


