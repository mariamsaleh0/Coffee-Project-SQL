SET search_path TO coffee_project;

-- 1. LOAD CSV DATA
TRUNCATE TABLE coffee_project.staging_coffee;
INSERT INTO staging_coffee
SELECT *
FROM s26a_db0050.staging_coffee;

-- CHECK ROWS
SELECT COUNT(*) AS staging_rows FROM staging_coffee;


INSERT INTO coffee (coffee_name)
SELECT DISTINCT coffee_name
FROM staging_coffee;

INSERT INTO payment (payment_type)
SELECT DISTINCT cash_type
FROM staging_coffee;

INSERT INTO date_dim (date, weekday, month_name, weekdaysort, monthsort)
SELECT DISTINCT 
    date::DATE,
    weekday,
    month_name,
    weekdaysort,
    monthsort
FROM staging_coffee;

INSERT INTO time_dim (time, hour_of_day, time_of_day)
SELECT DISTINCT
    time::TIME,
    hour_of_day,
    time_of_day
FROM staging_coffee;


INSERT INTO category (category_name)
SELECT DISTINCT 'Coffee'
FROM staging_coffee
LIMIT 1;


INSERT INTO sales (
    amount,
    coffee_id,
    payment_id,
    date_id,
    time_id
)
SELECT
    s.money,
    c.coffee_id,
    p.payment_id,
    d.date_id,
    t.time_id
FROM staging_coffee s
JOIN coffee c ON s.coffee_name = c.coffee_name
JOIN payment p ON s.cash_type = p.payment_type
JOIN date_dim d ON s.date::DATE = d.date
JOIN time_dim t ON s.time::TIME = t.time;

--VIEW
CREATE OR REPLACE VIEW coffee_sales_view AS
SELECT 
    sa.sale_id,
    c.coffee_name,
    p.payment_type,
    d.date,
    d.weekday,
    t.time,
    sa.amount
FROM sales sa
JOIN coffee c ON sa.coffee_id = c.coffee_id
JOIN payment p ON sa.payment_id = p.payment_id
JOIN date_dim d ON sa.date_id = d.date_id
JOIN time_dim t ON sa.time_id = t.time_id;


-- 5. proof queries

SELECT COUNT(*) FROM coffee_project.coffee;
SELECT COUNT(*) FROM coffee_project.payment;
SELECT COUNT(*) FROM coffee_project.date_dim;
SELECT COUNT(*) FROM coffee_project.time_dim;
SELECT COUNT(*) FROM coffee_project.sales;
SELECT COUNT(*) FROM coffee_project.staging_coffee;

SELECT * FROM coffee_project.coffee LIMIT 1;
SELECT * FROM coffee_project.payment LIMIT 1;
SELECT * FROM coffee_project.date_dim LIMIT 1;
SELECT * FROM coffee_project.time_dim LIMIT 1;
SELECT * FROM coffee_project.sales LIMIT 1;
SELECT * FROM coffee_project.staging_coffee LIMIT 1;

SELECT COUNT(*) FROM coffee_project.coffee_sales_view;
SELECT * FROM coffee_project.coffee_sales_view limit 1;

select coffee_name, COUNT(*) 
from coffee_project.staging_coffee
group by coffee_name
order by COUNT(*) desc;

SELECT SUM(row_count) AS total_rows
FROM (
    SELECT COUNT(*) AS row_count FROM coffee_project.coffee
    UNION ALL
    SELECT COUNT(*) FROM coffee_project.payment
    UNION ALL
    SELECT COUNT(*) FROM coffee_project.date_dim
    UNION ALL
    SELECT COUNT(*) FROM coffee_project.time_dim
    UNION ALL
    SELECT COUNT(*) FROM coffee_project.category
    UNION ALL
    SELECT COUNT(*) FROM coffee_project.coffee_category
    UNION ALL
    SELECT COUNT(*) FROM coffee_project.sales
    UNION ALL
    SELECT COUNT(*) FROM coffee_project.staging_coffee
) counts;
