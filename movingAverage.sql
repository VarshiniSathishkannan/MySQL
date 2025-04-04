https://learnsql.com/blog/sql-window-functions-rows-clause/


CREATE TABLE moveAvg (
    transaction_date VARCHAR(512),
    product_id VARCHAR(512),
    amount INT
);


INSERT INTO moveAvg (transaction_date, product_id, amount) VALUES ('2025-01-01', 'A', '100');
INSERT INTO moveAvg (transaction_date, product_id, amount) VALUES ('2025-01-02', 'A', '150');
INSERT INTO moveAvg (transaction_date, product_id, amount) VALUES ('2025-01-03', 'A', '200');
INSERT INTO moveAvg (transaction_date, product_id, amount) VALUES ('2025-01-04', 'A', '250');
INSERT INTO moveAvg (transaction_date, product_id, amount) VALUES ('2025-01-05', 'A', '300');
INSERT INTO moveAvg (transaction_date, product_id, amount) VALUES ('2025-01-06', 'A', '350');
INSERT INTO moveAvg (transaction_date, product_id, amount) VALUES ('2025-01-07', 'A', '400');
INSERT INTO moveAvg (transaction_date, product_id, amount) VALUES ('2025-01-08', 'A', '450');
INSERT INTO moveAvg (transaction_date, product_id, amount) VALUES ('2025-01-09', 'A', '500');


SELECT 
    product_id,
    transaction_date,
    amount,
    AVG(amount) OVER (
        PARTITION BY product_id 
        ORDER BY transaction_date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7_day
FROM 
    moveAvg
ORDER BY 
    product_id, transaction_date;
