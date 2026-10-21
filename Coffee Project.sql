CREATE SCHEMA coffee_project;

SET search_path TO coffee_project;


CREATE TABLE coffee (
    coffee_id SERIAL PRIMARY KEY,
    coffee_name VARCHAR(100) UNIQUE
);

CREATE TABLE payment (
    payment_id SERIAL PRIMARY KEY,
    payment_type VARCHAR(50) UNIQUE
);

CREATE TABLE date_dim (
    date_id SERIAL PRIMARY KEY,
    date DATE UNIQUE,
    weekday VARCHAR(20),
    month_name VARCHAR(20),
    weekdaysort INT,
    monthsort INT
);

CREATE TABLE time_dim (
    time_id SERIAL PRIMARY KEY,
    time TIME UNIQUE,
    hour_of_day INT,
    time_of_day VARCHAR(20)
);


CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE
);

CREATE TABLE coffee_category (
    coffee_id INT,
    category_id INT,
    PRIMARY KEY (coffee_id, category_id),
    FOREIGN KEY (coffee_id) REFERENCES coffee(coffee_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);


CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    amount DECIMAL(10,2),
    coffee_id INT,
    payment_id INT,
    date_id INT,
    time_id INT,
    FOREIGN KEY (coffee_id) REFERENCES coffee(coffee_id),
    FOREIGN KEY (payment_id) REFERENCES payment(payment_id),
    FOREIGN KEY (date_id) REFERENCES date_dim(date_id),
    FOREIGN KEY (time_id) REFERENCES time_dim(time_id)
);

-- 5. staging table


CREATE TABLE staging_coffee (
    hour_of_day INT,
    cash_type VARCHAR(50),
    money DECIMAL(10,2),
    coffee_name VARCHAR(100),
    time_of_day VARCHAR(20),
    weekday VARCHAR(20),
    month_name VARCHAR(20),
    weekdaysort INT,
    monthsort INT,
    date VARCHAR(50),
    time VARCHAR(50)
);