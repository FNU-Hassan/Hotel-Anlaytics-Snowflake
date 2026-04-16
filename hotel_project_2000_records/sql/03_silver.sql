CREATE OR REPLACE TABLE SILVER_HOTEL_BOOKINGS AS
SELECT
booking_id,
hotel_id,
INITCAP(TRIM(hotel_city)) AS hotel_city,
customer_id,
INITCAP(TRIM(customer_name)) AS customer_name,
LOWER(TRIM(customer_email)) AS customer_email,
TO_DATE(check_in_date) AS check_in_date,
TO_DATE(check_out_date) AS check_out_date,
room_type,
TO_NUMBER(num_guests) AS num_guests,
TO_NUMBER(total_amount) AS total_amount,
currency,
INITCAP(booking_status) AS booking_status
FROM BRONZE_HOTEL_BOOKING;
