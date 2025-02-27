create table orders
(
    order_date date,
    revenue int
);

INSERT INTO orders (order_date, revenue) VALUES ('2025-02-01', '100');
INSERT INTO orders (order_date, revenue) VALUES ('2025-02-01', '50');
INSERT INTO orders (order_date, revenue) VALUES ('2025-02-02', '200');
INSERT INTO orders (order_date, revenue) VALUES ('2025-02-03', '150');
INSERT INTO orders (order_date, revenue) VALUES ('2025-02-03', '50');

select order_date, sum(revenue) over (order by order_date) from orders;