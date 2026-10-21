SET search_path TO coffee_project;

--1. What are all the different types of coffee sold?
SELECT coffee_name
FROM coffee
ORDER BY coffee_name;

--2. What payment methods are used in transactions?
SELECT payment_type
FROM payment;

--3. What is the total revenue from all sales?
SELECT SUM(amount) AS total_revenue
FROM sales;

--4. What is the total revenue for each day?
SELECT 
    d.date,
    SUM(s.amount) AS total_revenue
FROM sales s
JOIN date_dim d 
    ON s.date_id = d.date_id
GROUP BY d.date
ORDER BY d.date;

--5. What is the total revenue for each month?
SELECT 
    d.month_name,
    SUM(s.amount) AS total_revenue
FROM sales s
JOIN date_dim d
    ON s.date_id = d.date_id
GROUP BY d.month_name, d.monthsort
ORDER BY d.monthsort;

--6. Which coffee drinks were sold on a specific date?
SELECT 
    c.coffee_name,
    d.date
FROM sales s
JOIN coffee c 
    ON s.coffee_id = c.coffee_id
JOIN date_dim d 
    ON s.date_id = d.date_id
WHERE d.date = '2024-03-01';

--7. What transactions occurred in the morning?
SELECT 
    s.sale_id,
    c.coffee_name,
    s.amount,
    t.time_of_day
FROM sales s
JOIN coffee c 
    ON s.coffee_id = c.coffee_id
JOIN time_dim t 
    ON s.time_id = t.time_id
WHERE t.time_of_day = 'Morning';

--8. What is the highest transaction amount?
SELECT MAX(amount) AS highest_transaction
FROM sales;

--9. What is the lowest transaction amount?
SELECT MIN(amount) AS lowest_transaction
FROM sales;

--10. Which coffee drinks generate the highest revenue during different times of day?
SELECT 
    t.time_of_day,
    c.coffee_name,
    SUM(s.amount) AS total_revenue
FROM sales s
JOIN coffee c
    ON s.coffee_id = c.coffee_id
JOIN time_dim t
    ON s.time_id = t.time_id
GROUP BY t.time_of_day, c.coffee_name
ORDER BY t.time_of_day, total_revenue DESC;

--11. What are the busiest weekdays for coffee sales during morning hours?
SELECT 
    d.weekday,
    COUNT(*) AS total_transactions,
    SUM(s.amount) AS total_revenue
FROM sales s
JOIN date_dim d
    ON s.date_id = d.date_id
JOIN time_dim t
    ON s.time_id = t.time_id
WHERE t.time_of_day = 'Morning'
GROUP BY d.weekday, d.weekdaysort
ORDER BY total_transactions DESC;

--12. What are all transactions sorted by time?
SELECT 
    s.sale_id,
    c.coffee_name,
    s.amount,
    d.date,
    t.time
FROM sales s
JOIN coffee c 
    ON s.coffee_id = c.coffee_id
JOIN date_dim d 
    ON s.date_id = d.date_id
JOIN time_dim t 
    ON s.time_id = t.time_id
ORDER BY t.time;

--13. What days of the week have the most transactions?
SELECT 
    d.weekday,
    COUNT(*) AS total_transactions
FROM sales s
JOIN date_dim d 
    ON s.date_id = d.date_id
GROUP BY d.weekday, d.weekdaysort
ORDER BY total_transactions DESC;

--14. What hours of the day have recorded sales?
SELECT DISTINCT
    t.hour_of_day
FROM sales s
JOIN time_dim t
    ON s.time_id = t.time_id
ORDER BY t.hour_of_day;

--15. Which coffee types appear most frequently?
SELECT 
    c.coffee_name,
    COUNT(*) AS total_sales
FROM sales s
JOIN coffee c
    ON s.coffee_id = c.coffee_id
GROUP BY c.coffee_name
ORDER BY total_sales DESC;

--16. Which coffee type generates the highest total revenue?
SELECT 
    c.coffee_name,
    SUM(s.amount) AS total_revenue
FROM sales s
JOIN coffee c
    ON s.coffee_id = c.coffee_id
GROUP BY c.coffee_name
ORDER BY total_revenue DESC;

--17. What is the average spending per transaction?
SELECT 
    AVG(amount) AS average_spending
FROM sales;

--18. What time of day has the highest number of sales?
SELECT 
    t.time_of_day,
    COUNT(*) AS total_sales
FROM sales s
JOIN time_dim t
    ON s.time_id = t.time_id
GROUP BY t.time_of_day
ORDER BY total_sales DESC;

--19. Which weekday generates the most revenue?
SELECT 
    d.weekday,
    SUM(s.amount) AS total_revenue
FROM sales s
JOIN date_dim d
    ON s.date_id = d.date_id
GROUP BY d.weekday, d.weekdaysort
ORDER BY total_revenue DESC;

--20. What is the most popular coffee for each month?
SELECT 
    month_name,
    coffee_name,
    total_sales
FROM (
    SELECT 
        d.month_name,
        d.monthsort,
        c.coffee_name,
        COUNT(*) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY d.month_name
            ORDER BY COUNT(*) DESC
        ) AS rank
    FROM sales s
    JOIN coffee c
        ON s.coffee_id = c.coffee_id
    JOIN date_dim d
        ON s.date_id = d.date_id
    GROUP BY d.month_name, d.monthsort, c.coffee_name
) ranked_coffee
WHERE rank = 1
ORDER BY monthsort;



--21. full transaction table 
SELECT 
    s.sale_id,
    c.coffee_name,
    p.payment_type,
    d.date,
    d.weekday,
    t.time,
    t.time_of_day,
    s.amount
FROM sales s
JOIN coffee c
    ON s.coffee_id = c.coffee_id
JOIN payment p
    ON s.payment_id = p.payment_id
JOIN date_dim d
    ON s.date_id = d.date_id
JOIN time_dim t
    ON s.time_id = t.time_id
ORDER BY d.date, t.time;

--22. Highest revenue coffee by payment type
SELECT 
    c.coffee_name,
    p.payment_type,
    SUM(s.amount) AS total_revenue
FROM sales s
JOIN coffee c
    ON s.coffee_id = c.coffee_id
JOIN payment p
    ON s.payment_id = p.payment_id
JOIN date_dim d
    ON s.date_id = d.date_id
GROUP BY c.coffee_name, p.payment_type
ORDER BY total_revenue DESC;


--23. Sales trends by month and time of day
SELECT 
    d.month_name,
    t.time_of_day,
    COUNT(*) AS total_transactions,
    SUM(s.amount) AS total_revenue
FROM sales s
JOIN date_dim d
    ON s.date_id = d.date_id
JOIN time_dim t
    ON s.time_id = t.time_id
JOIN coffee c
    ON s.coffee_id = c.coffee_id
GROUP BY d.month_name, d.monthsort, t.time_of_day
ORDER BY d.monthsort;





--4.1.6 - 5 rows from each table 
SELECT * FROM coffee LIMIT 5;
SELECT * FROM payment LIMIT 5;
SELECT * FROM date_dim LIMIT 5;
SELECT * FROM time_dim LIMIT 5;
SELECT * FROM sales LIMIT 5;

--4.1.7 row counts
SELECT COUNT(*) FROM coffee;
SELECT COUNT(*) FROM payment;
SELECT COUNT(*) FROM date_dim;
SELECT COUNT(*) FROM time_dim;
SELECT COUNT(*) FROM sales;
SELECT COUNT(*) FROM staging_coffee;
