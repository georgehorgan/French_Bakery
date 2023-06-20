SELECT * FROM french_bakery
ORDER BY date ASC
LIMIT 1000;

'Total number of sales per day'
SELECT date, CAST(SUM(euros) AS numeric(10, 2)) AS total_sales
FROM french_bakery
GROUP BY date
ORDER BY date;

'Average daily earnings'
SELECT CAST(SUM(euros) / COUNT(DISTINCT date) AS numeric(10, 2))  AS average_daily_sales
FROM french_bakery;

'Busiest time of day'
SELECT time, COUNT(ticket_number) AS ticket_count
FROM french_bakery
GROUP BY time
ORDER BY ticket_count DESC
LIMIT 10;

'Top selling products'
SELECT product, SUM(quantity) AS total_quantity
FROM french_bakery
GROUP BY product
ORDER BY total_quantity DESC;

'Average sales per ticket number'
SELECT ticket_number, CAST(AVG(euros) AS numeric(10, 2)) AS average_sales
FROM french_bakery
GROUP BY ticket_number
ORDER BY average_sales DESC;

'Monthly revenue trend'
SELECT EXTRACT(MONTH FROM date) AS month, SUM(euros) AS total_sales
FROM french_bakery
GROUP BY month
ORDER BY month;

'Weekdays revenue vs weekend revenue'
SELECT 
    CASE
        WHEN EXTRACT(ISODOW FROM date) < 6 THEN 'Weekday'
        ELSE 'Weekend'
    END AS day_type,
    CAST(AVG(daily_revenue) AS numeric(10, 2)) AS average_daily_revenue
FROM (
    SELECT 
        date,
        SUM(euros) AS daily_revenue
    FROM french_bakery
    GROUP BY date
) AS subquery
GROUP BY day_type;


'Product popularity over time'
SELECT date, SUM(quantity) AS total_quantity
FROM french_bakery
WHERE product = 'TRADITIONAL BAGUETTE'
GROUP BY date
ORDER BY date;


