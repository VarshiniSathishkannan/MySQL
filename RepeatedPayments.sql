-- Sometimes, payment transactions are repeated by accident; it could be due to user error, API failure or a retry error that causes a credit card to be charged twice.

-- Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. Count such repeated payments.

-- Assumptions:

-- The first transaction of such payments should not be counted as a repeated payment. This means, if there are two transactions performed by a merchant with the same credit card and for the same amount within 10 minutes, there will only be 1 repeated payment.

-- transactions Table:
-- Column Name	Type
-- transaction_id	integer
-- merchant_id	integer
-- credit_card_id	integer
-- amount	integer
-- transaction_timestamp	datetime
-- transactions Example Input:
-- transaction_id	merchant_id	credit_card_id	amount	transaction_timestamp
-- 1	101	1	100	09/25/2022 12:00:00
-- 2	101	1	100	09/25/2022 12:08:00
-- 3	101	1	100	09/25/2022 12:28:00
-- 4	102	2	300	09/25/2022 12:00:00
-- 6	102	2	400	09/25/2022 14:00:00
-- Example Output:
-- payment_count
-- 1
-- Explanation
-- Within 10 minutes after Transaction 1, Transaction 2 is conducted at Merchant 1 using the same credit card for the same amount. This is the only instance of repeated payment in the given sample data.

-- Since Transaction 3 is completed after Transactions 2 and 1, each of which occurs after 20 and 28 minutes, respectively hence it does not meet the repeated payments' conditions. Whereas, Transactions 4 and 6 have different amounts.

-- The dataset you are querying against may have different input & output - this is just an example!

CREATE TABLE transactions_repeat (
    transaction_id INT PRIMARY KEY,
    merchant_id INT,
    credit_card_id INT,
    amount DECIMAL(10,2),
    transaction_timestamp DATETIME
);

INSERT INTO transactions_repeat (transaction_id, merchant_id, credit_card_id, amount, transaction_timestamp) VALUES
(1, 101, 1, 100.00, STR_TO_DATE('09/25/2022 12:00:00', '%m/%d/%Y %H:%i:%s')),
(2, 101, 1, 100.00, STR_TO_DATE('09/25/2022 12:08:00', '%m/%d/%Y %H:%i:%s')),
(3, 101, 1, 100.00, STR_TO_DATE('09/25/2022 12:28:00', '%m/%d/%Y %H:%i:%s')),
(4, 102, 2, 300.00, STR_TO_DATE('09/25/2022 12:00:00', '%m/%d/%Y %H:%i:%s')),
(6, 102, 2, 400.00, STR_TO_DATE('09/25/2022 14:00:00', '%m/%d/%Y %H:%i:%s'));


select count(*) as payment_count from (
select TIMESTAMPDIFF(MINUTE,a.current,a.next) as lesserThan10 from 
(
select transaction_timestamp as current, lead(transaction_timestamp)
over (partition by 
merchant_id,credit_card_id,amount 
order by transaction_timestamp) as next from transactions_repeat
) as a where a.next is not null) as b where lesserThan10<10;