-- =========================================
-- Hotel Analytics Dashboard SQL
-- Snowflake / Snowsight / BI-ready queries
-- =========================================

USE DATABASE HOTEL_DB;
USE SCHEMA PUBLIC;

-- =========================================
-- 1. KPI CARDS
-- =========================================

-- KPI: Total Revenue
SELECT
    SUM(total_amount) AS total_revenue
FROM GOLD_BOOKING_CLEAN;

-- KPI: Total Bookings
SELECT
    COUNT(*) AS total_bookings
FROM GOLD_BOOKING_CLEAN;

-- KPI: Total Guests
SELECT
    SUM(num_guests) AS total_guests
FROM GOLD_BOOKING_CLEAN;

-- KPI: Average Booking Value
SELECT
    AVG(total_amount) AS avg_booking_value
FROM GOLD_BOOKING_CLEAN;

-- KPI: Confirmed Bookings
SELECT
    COUNT(*) AS confirmed_bookings
FROM GOLD_BOOKING_CLEAN
WHERE UPPER(booking_status) = 'CONFIRMED';

-- KPI: Cancelled Bookings
SELECT
    COUNT(*) AS cancelled_bookings
FROM GOLD_BOOKING_CLEAN
WHERE UPPER(booking_status) = 'CANCELLED';

-- =========================================
-- 2. TREND CHARTS
-- =========================================

-- Daily Revenue Trend
SELECT
    booking_date,
    total_revenue
FROM GOLD_AGG_DAILY_BOOKING
ORDER BY booking_date;

-- Daily Booking Trend
SELECT
    booking_date,
    total_bookings
FROM GOLD_AGG_DAILY_BOOKING
ORDER BY booking_date;

-- Monthly Revenue Trend
SELECT
    DATE_TRUNC('MONTH', check_in_date) AS booking_month,
    SUM(total_amount) AS total_revenue
FROM GOLD_BOOKING_CLEAN
GROUP BY DATE_TRUNC('MONTH', check_in_date)
ORDER BY booking_month;

-- Monthly Booking Trend
SELECT
    DATE_TRUNC('MONTH', check_in_date) AS booking_month,
    COUNT(*) AS total_bookings
FROM GOLD_BOOKING_CLEAN
GROUP BY DATE_TRUNC('MONTH', check_in_date)
ORDER BY booking_month;

-- =========================================
-- 3. LOCATION / CITY ANALYSIS
-- =========================================

-- Top Cities by Revenue
SELECT
    hotel_city,
    total_revenue
FROM GOLD_AGG_HOTEL_CITY
WHERE total_revenue IS NOT NULL
ORDER BY total_revenue DESC
LIMIT 10;

-- Top Cities by Bookings
SELECT
    hotel_city,
    COUNT(*) AS total_bookings
FROM GOLD_BOOKING_CLEAN
GROUP BY hotel_city
ORDER BY total_bookings DESC
LIMIT 10;

-- Average Booking Value by City
SELECT
    hotel_city,
    AVG(total_amount) AS avg_booking_value
FROM GOLD_BOOKING_CLEAN
GROUP BY hotel_city
ORDER BY avg_booking_value DESC;

