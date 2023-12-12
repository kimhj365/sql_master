CREATE TABLE sales_reps (id, name, salary, commission_pct)
AS
  SELECT employee_id, last_name, salary, commission_pct
  FROM   employees
  WHERE  employee_id = 0;

CREATE TABLE copy_emp
AS
  SELECT *
  FROM   employees
  WHERE  employee_id = 0;
  