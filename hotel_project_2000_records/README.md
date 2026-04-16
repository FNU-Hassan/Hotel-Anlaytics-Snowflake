# Hotel Analytics Project (2000 Records)

## Overview
This is a Snowflake data engineering project using a 2000-record dataset.

## Layers
- Bronze: Raw data load
- Silver: Cleaned data
- Gold: Customer summary

## Dataset
Located in `/data/hotel_bookings_2000.csv`

## Steps
1. Upload CSV to Snowflake stage
2. Run SQL scripts in order
3. Build analytics tables

## Output
Customer summary table with:
- total bookings
- total revenue
- avg booking value

## Dashboard Images

### KPI Summary
![KPI Summary](dashboard_images/kpi_summary.png)

### Daily Revenue Trend
![Daily Revenue Trend](dashboard_images/daily_revenue_trend.png)

### Daily Booking Trend
![Daily Booking Trend](dashboard_images/daily_booking_trend.png)

### Top Cities by Revenue
![Top Cities by Revenue](dashboard_images/top_cities_by_revenue.png)

### Bookings by Status
![Bookings by Status](dashboard_images/bookings_by_status.png)

### Bookings by Room Type
![Bookings by Room Type](dashboard_images/bookings_by_room_type.png)
