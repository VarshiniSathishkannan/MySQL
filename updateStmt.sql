✅ 1. Basic UPDATE
Update one or more columns in a table.


UPDATE employees
SET salary = 60000
WHERE employee_id = 101;


🔁 2. UPDATE Multiple Columns
Update multiple fields in a single statement.


UPDATE products
SET price = 19.99,
    stock = 50
WHERE product_id = 200;

📌 3. UPDATE Without WHERE (All Rows)
Be careful! This updates every row in the table.


UPDATE orders
SET status = 'Shipped';

🔗 4. UPDATE with JOIN
Update one table based on data from another table (syntax varies by RDBMS).

✅ In PostgreSQL / SQL Server / Oracle:

UPDATE e
SET e.salary = e.salary * 1.10
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE d.name = 'Engineering';

✅ In MySQL:

UPDATE employees e
JOIN departments d ON e.department_id = d.id
SET e.salary = e.salary * 1.10
WHERE d.name = 'Engineering';

🧠 5. UPDATE Using a Subquery
You can pull values from another query.


UPDATE employees
SET salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = 3
)
WHERE department_id = 2;

🔄 6. UPDATE with CASE Statement
Conditional logic within the update.


UPDATE orders
SET status = CASE
    WHEN delivery_date < CURRENT_DATE THEN 'Delivered'
    WHEN delivery_date IS NULL THEN 'Pending'
    ELSE 'Shipped'
END;

💥 7. UPDATE with LIMIT (MySQL)
Limit how many rows are updated (useful for batch updates).


UPDATE users
SET is_active = 0
ORDER BY last_login
LIMIT 100;
Note: Not supported in all SQL dialects (e.g., not standard SQL or PostgreSQL).