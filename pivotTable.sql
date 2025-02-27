CREATE TABLE pivot_t (
    transaction_date VARCHAR(512),
    amount INT,
    product_id VARCHAR(512)
);

INSERT INTO pivot_t (transaction_date, amount, product_id) VALUES ('2025-01-05', '100', 'A');
INSERT INTO pivot_t (transaction_date, amount, product_id) VALUES ('2025-01-15', '200', 'A');
INSERT INTO pivot_t (transaction_date, amount, product_id) VALUES ('2025-02-10', '150', 'A');
INSERT INTO pivot_t (transaction_date, amount, product_id) VALUES ('2025-03-25', '300', 'B');
INSERT INTO pivot_t (transaction_date, amount, product_id) VALUES ('2025-03-30', '250', 'B');
INSERT INTO pivot_t (transaction_date, amount, product_id) VALUES ('2025-03-15', '500', 'C');
INSERT INTO pivot_t (transaction_date, amount, product_id) VALUES ('2025-12-31', '400', 'A');

SELECT 
    product_id,
    SUM(CASE WHEN EXTRACT(MONTH FROM transaction_date) = 1 THEN amount ELSE 0 END) AS January,
    SUM(CASE WHEN EXTRACT(MONTH FROM transaction_date) = 2 THEN amount ELSE 0 END) AS February,
    SUM(CASE WHEN EXTRACT(MONTH FROM transaction_date) = 3 THEN amount ELSE 0 END) AS March,
    SUM(CASE WHEN EXTRACT(MONTH FROM transaction_date) = 4 THEN amount ELSE 0 END) AS April,
    SUM(CASE WHEN EXTRACT(MONTH FROM transaction_date) = 5 THEN amount ELSE 0 END) AS May,
    SUM(CASE WHEN EXTRACT(MONTH FROM transaction_date) = 6 THEN amount ELSE 0 END) AS June,
    SUM(CASE WHEN EXTRACT(MONTH FROM transaction_date) = 7 THEN amount ELSE 0 END) AS July,
    SUM(CASE WHEN EXTRACT(MONTH FROM transaction_date) = 8 THEN amount ELSE 0 END) AS August,
    SUM(CASE WHEN EXTRACT(MONTH FROM transaction_date) = 9 THEN amount ELSE 0 END) AS September,
    SUM(CASE WHEN EXTRACT(MONTH FROM transaction_date) = 10 THEN amount ELSE 0 END) AS October,
    SUM(CASE WHEN EXTRACT(MONTH FROM transaction_date) = 11 THEN amount ELSE 0 END) AS November,
    SUM(CASE WHEN EXTRACT(MONTH FROM transaction_date) = 12 THEN amount ELSE 0 END) AS December
FROM 
    pivot_t
GROUP BY 
    product_id
ORDER BY 
    product_id;
