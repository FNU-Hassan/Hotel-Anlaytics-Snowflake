-- =========================================
-- GOLD LAYER SQL
-- Hotel Analytics Project
-- =========================================

USE DATABASE HOTEL_DB;
USE SCHEMA PUBLIC;

-- =========================================
-- 1. BUSINESS-READY CLEAN TABLE
-- =========================================
CREATE OR REPLACE TABLE GOLD_BOOKING_CLEAN AS
SELECT
    booking_id,
    hotel_id,
    hotel_city,
    customer_id,
    customer_name,
    customer_email,
    check_in_date,
    check_out_date,
    room_type,
    num_guests,
    total_amount,
    currency,
    booking_status
FROM SILVER_HOTEL_BOOKINGS;

-- =========================================
-- 2. DAILY BOOKING SUMMARY
-- =========================================
CREATE OR REPLACE TABLE GOLD_AGG_DAILY_BOOKING AS
SELECT
    check_in_date AS booking_date,
    COUNT(*) AS total_bookings,
    SUM(total_amount) AS total_revenue,
    SUM(num_guests) AS total_guests,
    AVG(total_amount) AS avg_booking_value
FROM SILVER_HOTEL_BOOKINGS
GROUP BY check_in_date
ORDER BY booking_date;

-- =========================================
-- 3. CITY-LEVEL REVENUE SUMMARY
-- =========================================
CREATE OR REPLACE TABLE GOLD_AGG_HOTEL_CITY AS
SELECT
    hotel_city,
    COUNT(*) AS total_bookings,
    SUM(total_amount) AS total_revenue,
    SUM(num_guests) AS total_guests,
    AVG(total_amount) AS avg_booking_value
FROM SILVER_HOTEL_BOOKINGS
GROUP BY hotel_city
ORDER BY total_revenue DESC;

-- =========================================
-- 4. ROOM TYPE SUMMARY
-- =========================================
CREATE OR REPLACE TABLE GOLD_AGG_ROOM_TYPE AS
SELECT
    room_type,
    COUNT(*) AS total_bookings,
    SUM(total_amount) AS total_revenue,
    SUM(num_guests) AS total_guests,
    AVG(total_amount) AS avg_booking_value
FROM SILVER_HOTEL_BOOKINGS
GROUP BY room_type
ORDER BY total_revenue DESC;

-- =========================================
-- 5. BOOKING STATUS SUMMARY
-- =========================================
CREATE OR REPLACE TABLE GOLD_AGG_BOOKING_STATUS AS
SELECT
    booking_status,
    COUNT(*) AS total_bookings,
    SUM(total_amount) AS total_revenue,
    SUM(num_guests) AS total_guests
FROM SILVER_HOTEL_BOOKINGS
GROUP BY booking_status
ORDER BY total_bookings DESC;

-- =========================================
-- 6. CUSTOMER SUMMARY
-- =========================================
CREATE OR REPLACE TABLE GOLD_CUSTOMER_SUMMARY AS
SELECT
    customer_id,
    customer_name,
    COUNT(*) AS total_bookings,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_booking_value,
    SUM(num_guests) AS total_guests,
    MAX(check_in_date) AS latest_booking_date
FROM SILVER_HOTEL_BOOKINGS
GROUP BY customer_id, customer_name
ORDER BY total_revenue DESC;

-- =========================================
-- 7. MONTHLY SUMMARY
-- =========================================
CREATE OR REPLACE TABLE GOLD_AGG_MONTHLY_BOOKING AS
SELECT
    DATE_TRUNC('MONTH', check_in_date) AS booking_month,
    COUNT(*) AS total_bookings,
    SUM(total_amount) AS total_revenue,
    SUM(num_guests) AS total_guests,
    AVG(total_amount) AS avg_booking_value
FROM SILVER_HOTEL_BOOKINGS
GROUP BY DATE_TRUNC('MONTH', check_in_date)
ORDER BY booking_month;

-- =========================================
-- 8. LENGTH OF STAY SUMMARY
-- =========================================
CREATE OR REPLACE TABLE GOLD_AGG_LENGTH_OF_STAY AS
SELECT
    DATEDIFF('DAY', check_in_date, check_out_date) AS length_of_stay,
    COUNT(*) AS total_bookings,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_booking_value
FROM SILVER_HOTEL_BOOKINGS
GROUP BY DATEDIFF('DAY', check_in_date, check_out_date)
ORDER BY length_of_stay;

-- =========================================
-- 9. VALIDATION QUERIES
-- =========================================

-- Check clean gold table
SELECT * FROM GOLD_BOOKING_CLEAN LIMIT 20;

-- Check daily summary
SELECT * FROM GOLD_AGG_DAILY_BOOKING ORDER BY booking_date;

-- Check city summary
SELECT * FROM GOLD_AGG_HOTEL_CITY ORDER BY total_revenue DESC;

-- Check room type summary
SELECT * FROM GOLD_AGG_ROOM_TYPE ORDER BY total_revenue DESC;

-- Check booking status summary
SELECT * FROM GOLD_AGG_BOOKING_STATUS ORDER BY total_bookings DESC;

-- Check customer summary
SELECT * FROM GOLD_CUSTOMER_SUMMARY ORDER BY total_revenue DESC LIMIT 20;

-- Check monthly summary
SELECT * FROM GOLD_AGG_MONTHLY_BOOKING ORDER BY booking_month;

-- Check length of stay summary
SELECT * FROM GOLD_AGG_LENGTH_OF_STAY ORDER BY length_of_stay;
