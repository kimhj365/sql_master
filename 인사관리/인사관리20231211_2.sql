COMMIT;

SELECT *
FROM   employees
WHERE  employee_id = 176;

--다른 사용자가 이미 조작중이면 조작 불가능
UPDATE employees
SET    salary = 77777
WHERE  employee_id = 176;

COMMIT;