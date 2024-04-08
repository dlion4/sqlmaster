-- Active: 1712521498825@@127.0.0.1@3306@coffee
-- Employes
-- SELECT ALL THE EMPLOYEE FROM THE EMPLLYEES ABLES
SELECT * FROM employees;
-- RETURN THE EMPLOYEE COUNT
SELECT COUNT(*) FROM employees;
-- SELECT ALL COLUMNS AND ROWS OF EMPLOYEES BASED ON SALARY AND THNE RETURN THE FIRST 20 ELOYES WHO ARE HIGHLY PAID

SELECT *
FROM employees
WHERE
    salary > 8990
ORDER BY salary DESC
LIMIT 20;

-- SELECT EMPLOYEE AND THE GROUP THEN BY THE ESHOP IN WHICH THERY ARE WORKING FROM
-- this return the number of employes in each shop
SELECT coffeeshop_id, COUNT(*) as employee_count
FROM employees
GROUP BY
    coffeeshop_id;

-- group employes per shop and based also on gender

SELECT
    coffeeshop_id,
    gender,
    COUNT(*) as gender_count
FROM employees
GROUP BY
    coffeeshop_id,
    gender;

-- SELECT THE FEMALS PER SHO AND RETURN THE TOP TEN PASID FEMAL EMPLOYEES
SELECT coffeeshop_id, COUNT(*), gender
FROM employees
WHERE
    gender = 'F'
GROUP BY
    coffeeshop_id
ORDER BY MAX(salary) DESC
LIMIT 3;

SELECT * FROM employees WHERE gender = 'F';

-- SELCT THE NUMBER OF FEMALS J EACH SHOP

SELECT
    coffeeshop_id,
    gender,
    COUNT(*) as gender_cont
FROM employees
WHERE
    gender = 'F'
GROUP BY
    coffeeshop_id,
    gender;

-- SELCT THE NUMBER OF MALES J EACH SHOP

SELECT
    coffeeshop_id,
    gender,
    COUNT(*) as gender_cont
FROM employees
WHERE
    gender = 'M'
GROUP BY
    coffeeshop_id,
    gender;

-- FIND THE HIGLKY PASI EMPLOYESS PER SHOP

SELECT
    employee_id,
    coffeeshop_id,
    first_name,
    last_name,
    email,
    hire_date,
    gender,
    salary
FROM employees
ORDER BY salary ASC
LIMIT 50;

-- SUPLIERS

SELECT * FROM suppliers;
-- SELECT SPECIFI SUPPLIR BASED ON THE NAME

SELECT * FROM suppliers WHERE supplier_name = "Beans and Barley";

-- ALL SUPLIERS EXCEPT Beans and Barley

SELECT *
FROM suppliers
WHERE
    NOT supplier_name = "Beans and Barley";

-- selct the coffee type arabica or robusta

SELECT *
FROM suppliers
WHERE
    coffee_type = "Robusta"
    OR coffee_type = "Arabica";

-- all coffe type tht ar not robusta or arabica

SELECT *
FROM suppliers
WHERE
    coffee_type not IN("Robusta", 'Arabica');

-- all empliess with missing emails

SELECT * FROM employees WHERE email is NULL;

-- selct all the employees with emails|email not missing

SELECT *
FROM employees
WHERE
    NOT email IS NULL
ORDER BY first_name;

-- select empoyess based on a particulart salary range

SELECT *
FROM employees
WHERE
    salary BETWEEN 50000 AND 56000
ORDER BY salary DESC;

-- top 10mpadi employees

SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    gender,
    coffeeshop_id
from employees
ORDER BY salary DESC
LIMIT 10;

SELECT
    email,
    email as email_address,
    first_name,
    last_name,
    CONCAT(first_name, " ", last_name) AS full_name
FROM employees
WHERE
    not email is NULL
LIMIT 10;
-- select only unique items
SELECT DISTINCT coffeeshop_id from employees;

-- extrating informaton from the column in a table AND THEN ORDER THE RESULT BASED ON THE YEAR
SELECT hire_date, EXTRACT(
        YEAR
        FROM hire_date
    ) as year, EXTRACT(
        MONTH
        FROM hire_date
    ) as month, EXTRACT(
        DAY
        FROM hire_date
    ) as day
FROM employees
ORDER BY YEAR DESC;

SELECT hire_date from employees;

-- string manipulation
-- UPPER LOWER && TRIM

SELECT
    first_name,
    UPPER(first_name) as first_name_upper,
    last_name,
    UPPER(last_name) as last_name_upper
FROM employees
LIMIT 10;

SELECT
    LENGTH("    Hello    ") as length_count_b4_trim,
    LENGTH("Hello") as length_count_without_whitespace,
    LENGTH(TRIM("    Hello    ")) as length_count_after_trim,
    LOWER(TRIM("    Hello    ")) as trimmed_lower_text;

-- CONCAT WITH || dont ork in the newer versions of sql

SELECT
    first_name,
    last_name,
    first_name || last_name as full_name
FROM employees;

SELECT CONCAT(
        first_name, " ", last_name, " makes ", "$", salary
    ) as payments
FROM employees;
-- create a boolean column in whihc the payment is lesstha n or more than 50k
SELECT
    first_name,
    CONCAT(
        first_name, " ", last_name, " makes ", "$", salary
    ) as payments,
    salary,
    (salary < 50000) as less_than_50k -- will return 1 true or 0 false
FROM employees;

-- we can futher modify this to return for femals

SELECT
    first_name,
    CONCAT(
        first_name, " ", last_name, " makes ", "$", salary
    ) as payments,
    salary,
    gender,
    (
        salary < 50000
        and gender = "F"
    ) as less_than_50k -- will return 1 true or 0 false
FROM employees;

-- using the wildcat for find and alidating emeils

SELECT email, (email LIKE "%.com%") as valid_email FROM employees;
-- this fill flag emails without then dotcom as not valid and will rtun the true, currently 1 or 0 if not valid, NULL values wont be validated and will retun NULL

-- valid email will alsway have the @ symbol

SELECT email, (email LIKE "%@%") as valid_email FROM employees;

-- use when creatin a table ie

CREATE Table EmailField (
    id INT PRIMARY KEY AUTO_INCREMENT, email VARCHAR(255) not NULL UNIQUE, CONSTRAINT valid_email CHECK (email LIKE "%@")
);
--- THIS WILL ENSURE THAT YOU CANT CREATE AEMAIL WITHOUT THE @ symbol in the email

-- FURTHER STRING MANIPULATON

SELECT email, SUBSTR(
        email
        FROM 5
    ) AS extracted
FROM employees
WHERE
    NOT email is NULL;

-- position
SELECT email, POSITION("@" IN email) as email_position
from employees;

-- we can extractthe company of the employees based on the emails for example
-- this extract the company and the n genrate the company website from the emails
-- we also exclude those without email address
SELECT
    first_name,
    email,
    SUBSTR(
        email
        FROM POSITION("@" IN email) + 1
    ) as organizatioon,
    CONCAT(
        "www", ".", SUBSTR(
            email
            FROM POSITION("@" IN email) + 1
        )
    ) as website
from employees
WHERE
    not email IS NULL
ORDER by first_name;

-- fllng n missin values with custom values| you dont need to fulter the null values, the coalease method
-- will find the null vlues and uypdated the mssing values according to the
SELECT email, COALESCE(
        email, CONCAT(
            LOWER(first_name), "@", "example.com"
        )
    ) as updated_email
from employees;

-- select the min salary and the maz sal

SELECT ROUND(SUM(salary)) from employees;

SELECT COUNT(*) from employees;

SELECT coffeeshop_id, COUNT(employee_id) as employees
from employees
GROUP BY
    coffeeshop_id;

SELECT
    coffeeshop_id,
    SUM(salary) as shop_total_employee_salary
FROM employees
GROUP BY
    coffeeshop_id
ORDER BY SUM(salary) DESC;

-- LITLTE ADVANCED QUERY

SELECT
    coffeeshop_id,
    COUNT(*) as num_of_employees,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary) as min_salary,
    MAX(salary) as max_salary,
    SUM(salary) total_salary
from employees
GROUP BY
    coffeeshop_id
ORDER BY num_of_employees DESC;

-- usign having
-- thi will rturnthe rows or coffeshop with employees more than the hanving clausie exmaple count(*)

SELECT
    coffeeshop_id,
    COUNT(*) as num_of_employees,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary) as min_salary,
    MAX(salary) as max_salary,
    SUM(salary) total_salary
from employees
GROUP BY
    coffeeshop_id
HAVING
    COUNT(*) > 40
ORDER BY num_of_employees DESC;

SELECT
    coffeeshop_id,
    COUNT(*) as num_of_employees,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary) as min_salary,
    MAX(salary) as max_salary,
    SUM(salary) total_salary
from employees
GROUP BY
    coffeeshop_id
HAVING
    MAX(salary) < 65000
ORDER BY num_of_employees DESC;

-- CASE STATEMENTS
-- THESE ARE LIKE THE IF STATEMENTS
-- EXMAPLE

SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary < 50000 THEN "low pay"
        WHEN salary >= 50000 THEN 'high pay'
        ELSE 'no pay'
    END
from employees
ORDER BY salary DESC;

SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary < 40000 THEN "low pay"
        WHEN salary BETWEEN 45000 AND 61000  THEN 'high pay'
        WHEN salary >= 61001 THEN 'Perfect pay'
        ELSE 'no pay'
    END as payment_category
FROM employees
ORDER BY salary DESC;

-- subqueies

SELECT a.pay_category, COUNT(*)
FROM (
        SELECT
            employee_id, first_name, last_name, salary, CASE
                WHEN salary < 2000 THEN "low pay"
                WHEN salary BETWEEN 20000 AND 50000  THEN "Fair pay"
                WHEN salary > 50001 THEN "high pay"
                ELSE "no pay"
            END as pay_category
        FROM employees
        ORDER BY salary DESC
    ) a
GROUP BY
    a.pay_category;

-- transposition turning rows into columns

SELECT
    SUM(
        CASE
            WHEN salary < 20000 THEN 1
            ELSE 0
        END
    ) as low_pay,
    SUM(
        CASE
            WHEN salary BETWEEN 20000 and 50000  THEN 1
            ELSE 0
        END
    ) as medium_pay,
    SUM(
        CASE
            WHEN salary > 50000 THEN 1
            ELSE 0
        END
    ) as high_pay
FROM employees;

-- joinign tables

SELECT * from locations;

SELECT * FROM shops;

SELECT s.coffeeshop_name, l.city, l.country
FROM shops s
    INNER JOIN locations l ON s.city_id = l.city_id;

SELECT s.coffeeshop_name, l.city, l.country
FROM shops s
    JOIN locations l ON s.city_id = l.city_id;

-- left join
SELECT s.coffeeshop_name, l.city, l.country
FROM shops s
    LEFT JOIN locations l ON s.city_id = l.city_id;

SELECT s.coffeeshop_name, l.city, l.country
FROM shops s
    RIGHT JOIN locations l ON s.city_id = l.city_id;

-- sub queris

SELECT *
FROM (
        SELECT *
        from employees
        WHERE
            coffeeshop_id IN (3, 5)
    ) a;

SELECT a.first_name, a.last_name
FROM (
        SELECT *
        from employees
        WHERE
            coffeeshop_id IN (3, 5)
    ) a;

SELECT
    first_name,
    last_name,
    salary,
    (
        SELECT MAX(salary)
        from employees
        LIMIT 1
    ) as max_salary
FROM employees;

SELECT
    first_name,
    last_name,
    salary,
    salary - (
        SELECT ROUND(AVG(salary), 2)
        from employees
        LIMIT 1
    ) as salary_mean
from employees;

-- filter shops based on location using subquiry

SELECT *
FROM shops
WHERE
    city_id IN (
        SELECT city_id
        FROM locations
        WHERE
            country = "united states"
    );

-- select all the employees from the us
-- from uk
SELECT *
FROM employees
WHERE
    coffeeshop_id IN (
        SELECT coffeeshop_id
        FROM shops
        WHERE
            city_id in (
                SELECT city_id
                FROM locations
                WHERE
                    country = "United Kingdom"
            )
    );

-- from us
SELECT *
FROM employees
WHERE
    coffeeshop_id IN (
        SELECT coffeeshop_id
        FROM shops
        WHERE
            city_id in (
                SELECT city_id
                FROM locations
                WHERE
                    country = "United states"
            )
    );

-- select uses who work in the us and makemmore than 60k
SELECT *
from employees
WHERE
    salary > 60000
    and coffeeshop_id IN (
        SELECT coffeeshop_id
        FROM shops
        WHERE
            city_id IN (
                SELECT city_id
                FROM locations
                WHERE
                    country = "United States"
            )
    );

-- 30 day movng total pay
SELECT e1.hire_date, salary, (
        SELECT SUM(e2.salary)
        FROM employees e2
        WHERE
            e2.hire_date BETWEEN DATE_SUB(e1.hire_date, INTERVAL 30 DAY) AND e1.hire_date
    ) as pay_pattern
FROM employees e1
ORDER BY e1.hire_date ASC;
