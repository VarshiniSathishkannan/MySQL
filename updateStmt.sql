1. Update statement with case

UPDATE employees 
SET salary = 
CASE
WHEN department_id = 101 
THEN salary * 1.10 
WHEN department_id = 102 
THEN salary * 1.05 
ELSE salary
END;