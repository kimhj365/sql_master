--<�׷� �Լ�>

--�׷��Լ� : ����� ���� ���� => �ϳ��� ��� ��ȯ
--SUM : �հ�
--AVG : ���
--COUNT : ���� ����
--   COUNT(*) : NULL�� ���� (������ �Լ� NULL ����)
--   COUNT(DISTINCT ~) : NULL�� ����
--MAX : �ִ밪
--MIN : �ּҰ�
--=> NULL �� ����(Ư�� AVG)

SELECT AVG(salary), MAX(salary), 
       MIN(salary), SUM(salary)
FROM   employees
WHERE  job_id LIKE '%REP%';

--MAX, MIN : (����, ��¥ O)
--MIN : ���� ��¥ / MAX : ���� ��¥ 
SELECT MIN(hire_date), MAX(hire_date)
FROM   employees;

--MIN : �� ���� / MAX : �� ���� 
SELECT MIN(last_name), MAX(last_name)
FROM   employees;

--COUNT(*) : ���� ����(NULL ����)
SELECT COUNT(*)
FROM   employees;

SELECT COUNT(*)
FROM   employees
WHERE  department_id = 50;

--COUNT(expr) : ���� ����(NULL ����)
SELECT COUNT(commission_pct)
FROM   employees
WHERE  department_id = 80;

--DISTINCT : �ߺ��� ����
SELECT COUNT(DISTINCT department_id),
       COUNT(department_id) --106�� => 1�� NULL�� ����
FROM   employees;

SELECT DISTINCT department_id
FROM   employees;

--NVL : AVG�� NULL�� �����ϵ��� ����
SELECT AVG(NVL(commission_pct, 0)), --=>�ΰ� ����(0���� ����)
       AVG(commission_pct)          --=>�ΰ� ����
FROM   employees;

--<������ �׷�ȭ(GROUP BY)>
--���̺� ������ �� ���� �׷����� ������

--SELECT������ �׷��Լ� �ȿ� ���¿� => �ݵ�� GROUP BY���� ����(�ʼ�)
SELECT   department_id, AVG(salary)
FROM     employees
GROUP BY department_id;
--SELECT���� department_id���� �׷��Լ�(AVG) �ȿ� ����
-- => �ڡڡ�GROUP BY���� �ݵ�� �־������

--�ڡڡ�GROUP BY ���� �ִ� �� ����� SELECT���� �ȿ͵� ��(����)
SELECT   AVG(salary)
FROM     employees
GROUP BY department_id;
--salary : GROUP BY ���� ��� ��

--GROUP BY���� 2�� �̻� �� �־ ��
SELECT   department_id, job_id, SUM(salary)
FROM     employees
GROUP BY department_id, job_id
ORDER BY job_id;
--department_id(1�� �׷�) => job_id(2�� �׷�)

--GROUP BY + WHERE�� ����
SELECT   department_id, job_id, SUM(salary)
FROM     employees
WHERE    department_id > 40
GROUP BY department_id, job_id
ORDER BY department_id;

--�׷��Լ� + WHERE�� �Ұ���(����)
--WHERE�� : ���� �����͸� ������ => �׷� �Լ��� ���ѵ� ������ ����
--�׷� ���� ���ؼ��� HAVING �� ���

--<HAVING ��>
--WHERE ���� ���� ������� ǥ���� �׷��� ����
--HAVING���� �ݵ�� GROUP BY���� ��� ��밡�� 
SELECT   department_id, MAX(salary)
FROM     employees
GROUP BY department_id
HAVING   MAX(salary) > 10000;

--����
SELECT   job_id, SUM(salary) PAYROLL
FROM     employees
WHERE    job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING   SUM(salary) > 13000
ORDER BY SUM(salary); -- / 2 / PAYROLL

--�׷��Լ� ��ø
--�׷��Լ������� 2������ �ۿ� ��ø �Ұ�
--�׷��Լ����� ��ø�ÿ��� SELECT���� �Ϲ� Į�� �� �� ����
--ex. SELECT department_id, MAX(AVG(salary)) => ����
SELECT   MAX(AVG(salary))
FROM     employees
GROUP BY department_id;

--sql05 ����----------------------------------

--���� �� ������ ��ȿ���� �Ǻ��Ͽ� True �Ǵ� False�� ���Ͻÿ�.
--1. �׷� �Լ��� ���� �࿡ ����Ǿ� �׷� �� �ϳ��� ����� ����Ѵ�.  => TRUE
--2. �׷� �Լ��� ��꿡 ���� �����Ѵ�.                               => FALSE
--3. WHERE ���� �׷� ��꿡 ��(row)�� ���Խ�Ű�� ���� ���� �����Ѵ�. => TRUE

--4. ��� ����� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ǥ���Ͻÿ�. 
--   �� ���̺��� ���� Maximum, Minimum, Sum �� Average�� �����ϰ� 
--   ����� ������ �ݿø��ϵ��� �ۼ��Ͻÿ�.
SELECT ROUND(MAX(salary)) "Maximum", 
       ROUND(MIN(salary)) "Minimum",
       ROUND(SUM(salary)) "Sum",
       ROUND(AVG(salary)) "Average"
FROM   employees;

--5. ���� ���Ǹ� �����Ͽ� �� ���� ����(job_id)���� 
--   �޿� �ְ��, ������, �Ѿ� �� ��վ��� ǥ���Ͻÿ�. 
SELECT   job_id,
         ROUND(MAX(salary)) "Maximum",
         ROUND(MIN(salary)) "Minimum",
         ROUND(SUM(salary)) "Sum",
         ROUND(AVG(salary)) "Average"
FROM     employees
GROUP BY job_id;

--6. ������ ��� ���� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT   job_id, COUNT(*) --COUNT �ȿ� �⺻Ű �־ ��
FROM     employees
GROUP BY job_id;

--7. ������ ���� Ȯ���Ͻÿ�. �� ���̺��� Number of Managers�� �����Ͻÿ�. 
--   (��Ʈ: MANAGER_ID ���� ���)
SELECT COUNT (DISTINCT manager_id) "Number of Managers"
FROM   employees;

--8. �ְ� �޿��� ���� �޿��� ������ ǥ���ϴ� ���Ǹ� �ۼ��ϰ� 
--   �� ���̺��� DIFFERENCE�� �����Ͻÿ�.
SELECT MAX(salary) - MIN(salary) DIFFERENCE
FROM   employees;

--9. ������ ��ȣ �� �ش� �����ڿ� ���� ����� ���� �޿��� ǥ���Ͻÿ�. 
--   �����ڸ� �� �� ���� ��� �� ���� �޿��� 6,000 �̸��� �׷��� ���ܽ�Ű�� 
--   ����� �޿��� ���� ������������ �����Ͻÿ�.
SELECT   manager_id, MIN(salary)
FROM     employees
WHERE    manager_id IS NOT NULL
GROUP BY manager_id
HAVING   MIN(salary) >= 6000
ORDER BY MIN(salary) DESC;


--------------------------------------------------------------------------------

--<�ڡڡڡڡ�JOIN ����(����Ŭ)>
--JOIN : 2�� �̻��� ���̺��� ������ ��������
SELECT employee_id, last_name, department_id
FROM   employees;
--department_id : Foreign Key

--Cartesian Product(����)
--��� ����� ���� �� �������� ��(n * m) => ũ�ν� ����
--���� ���� �����ų� ���� �߸��� ��� �߻�
-- => (ORACLE�� ��쿡��) �׻� WHERE ���� �ùٸ� ���� ���� ���
SELECT count(*)
FROM   employees, departments;

--���� ����
--Oracle ���� ����
--�ڡڡڡڡ� n�� ���̺� ���� => �ּ� n-1�� ���� ���ǹ� �ʿ�

--1. Equi Join
--  : '=' ���� ����(��ġ�ϴ� �� ���� ����)
SELECT e.employee_id, e.last_name, e.department_id, 
       d.department_id, d.location_id, d.department_name
FROM   employees e, departments d --���̺� alias
WHERE  e.department_id = d.department_id;

--���̺� ���ξ�(alias) �ٿ��� ���� ����
SELECT employee_id, last_name, e.department_id, 
       d.department_id, location_id, department_name
FROM   employees e, departments d --���̺� alias
WHERE  e.department_id = d.department_id;

SELECT d.department_id, d.department_name,
       d.location_id, l.city
FROM   departments d, locations l
WHERE  d.location_id = l.location_id;

--�߰� ����: AND�� ����
SELECT d.department_id, d.department_name, l.city
FROM   departments d, locations l
WHERE  d.location_id = l.location_id
       AND d.department_id IN(20, 50);
       
--2. Non-Equi JOIN
-- '=' �ƴ� ������ ������ ����
SELECT *
FROM   job_grades;

SELECT e.last_name, e.salary, j.grade_level
FROM   employees e, job_grades j
WHERE  e.salary 
       BETWEEN j.lowest_sal AND j.highest_sal;

--3. Outer JOIN
--���ο� ���Ե��� �ʴ� �൵ �� �� ���
--ex. 190 �μ� �Ҽ� ��� ������ �μ� ��ȣ ���������
--'(+)' ������ WHERE�� ���� ���� / �����ʿ� ���(�� �� X)
--Left / Right Outer Join
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id(+) = d.department_id;
--Left Outer Join
-- => �μ��� �߿� �Ҽ� ����� ���� �μ��� ���� ������

SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+);
--Right Outer Join
-- => ����� �߿� �μ� ���� ����� ���� ������

--4. Self JOIN
--���� ���̺� �ȿ��� ����
--�� ���̺� �ȿ� �������� �ִ� Į���� �ִ� ���
SELECT employee_id, last_name, manager_id
FROM   employees;

--�� ���̺� ���� �ٸ� ���̺� alias �ο� => ������ ���̺�� �ν�
SELECT worker.last_name 
       || ' works for ' 
       || manager.last_name
FROM   employees worker, employees manager
WHERE  worker.manager_id = manager.employee_id;
--employee_id : Primary Key
--manager_id  : employee_id �����ϴ� Foreign Key

--<�ڡڡڡڡ�JOIN ����(SQL-1999 ANSI)>
--1. CROSS JOIN
-- (= ī�׽þ� ���δ�Ʈ)
SELECT last_name, department_name
FROM   employees CROSS JOIN departments;

--2. NATURAL JOIN
--�� ���̺��� ������ �̸����� �� ���� ����(������ Ÿ�� ���ƾ� ��)
--���� �̸� Į�� ������ �������� �� ����
DESC departments;
DESC locations; -- =>location_id ���� ����

SELECT department_id, department_name, location_id, city
FROM   departments NATURAL JOIN locations;

--3. USING�� JOIN
--������ ���� ��ġ���� �ʴ� ���� �̸� ���� ���� ������
--���� �� Į�� ������ �� ����
--NATURAL JOIN�̶� ���� ��� �Ұ���
--USING���� Į��/���̺� alias ��� �Ұ���
SELECT employee_id, last_name,
       location_id, department_id
FROM   employees JOIN departments
                      USING (department_id);

--USING�� ����� WHERE������ Į��/���̺� alias ��� �Ұ���                     
SELECT l.city, d.department_name
FROM   locations l JOIN departments d
                        USING (location_id)
WHERE  d.location_id = 1400;

--4. �ڡڡ�ON�� JOIN
--ON���� ���� ���� ����(= ORACLE SQL WHERE��)
SELECT e.employee_id, e.last_name, e. department_id,
       d.department_id, d.location_id
FROM   employees e JOIN departments d
                        ON (e.department_id = d.department_id);

-- => ORACLE JOIN ���� ��ȯ
SELECT e.employee_id, e.last_name, e. department_id,
       d.department_id, d.location_id
FROM   employees e, departments d
WHERE  e.department_id = d.department_id;

--ON���� 3-way JOIN : �� ���̺� ����
--�� ���̺� ������ ���� �ٽ� �ٸ� ���̺�� ����
SELECT employee_id, city, department_name
FROM   employees e JOIN departments d
                        ON d.department_id = e.department_id
                   JOIN locations l
                        ON d.location_id = l.location_id;

-- => ORACLE JOIN ���� ��ȯ
SELECT employee_id, city, department_name
FROM   employees e, departments d, locations l
WHERE  d.department_id = e.department_id
AND    d.location_id = l.location_id;

--5. OUTER JOIN
--(1)LEFT OUTER JOIN
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e LEFT OUTER JOIN departments d
                      ON (e.department_id = d.department_id);
--��� �߿��� �μ��� ���� ����� ���������

-- => ORACLE JOIN ���� ��ȯ
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+);

--(2)RIGHT OUTER JOIN
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e RIGHT OUTER JOIN departments d
                      ON (e.department_id = d.department_id);
--�μ� �߿��� ����� ���� �μ��� ���������

-- => ORACLE JOIN ���� ��ȯ
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id(+) = d.department_id;

--(3)FULL OUTER JOIN
--���� Outer ���� �� ������
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e FULL OUTER JOIN departments d
                      ON (e.department_id = d.department_id);
--����Ŭ�� ����X
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id(+) = d.department_id(+); -- => ������

--���� �߰��� AND
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e JOIN departments d
                        ON  (e.department_id = d.department_id)
                        AND e.manager_id = 149;

--WHERE�ε� ���� �߰� ����
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e JOIN departments d
                        ON (e.department_id = d.department_id)
WHERE  e.manager_id = 149;

--sql06 ����--------------------------------------------------------------------

--1. LOCATIONS �� COUNTRIES ���̺��� ����Ͽ� 
--   ��� �μ��� �ּҸ� �����ϴ� query�� �ۼ��Ͻÿ�. 
--   ��¿� ��ġID(location_id), �ּ�(street_address), 
--   ��/��(city), ��/��(state_province) �� ����(country_name)�� ǥ���Ͻÿ�.

DESC locations;
DESC countries;

--Oracle
SELECT l.location_id, l.street_address, l.city, l.state_province,
       c.country_name
FROM   locations l, countries c
WHERE  l.country_id = c.country_id;

--ANSI
SELECT l.location_id, l.street_address, l.city, l.state_province,
       c.country_name
FROM   locations l JOIN countries c
                        ON l.country_id = c.country_id;

--2. ��� ����� �̸�, �Ҽ� �μ���ȣ �� �μ� �̸��� ǥ���ϴ� query�� �ۼ��Ͻÿ�.

--Oracle
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id;

--ANSI
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e JOIN departments d
                        ON  e.department_id = d.department_id;

--3. Toronto�� �ٹ��ϴ� ����� ���� ������ �ʿ�� �մϴ�. 
--   toronto���� �ٹ��ϴ� ��� ����� 
--   �̸�, ����, �μ���ȣ �� �μ� �̸��� ǥ���Ͻÿ�.

--Oracle
SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id
       AND d.location_id = l.location_id
       AND LOWER(l.city) = 'toronto';

--ANSI
SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM   employees e JOIN departments d 
                        ON  e.department_id = d.department_id
                   JOIN locations l
                        ON  d.location_id = l.location_id
                        AND LOWER(l.city) = 'toronto';
--WHERE LOWER(l.city) = 'toronto';

--4. ����� �̸� �� ��� ��ȣ�� 
--   �ش� �������� �̸� �� ������ ��ȣ�� �Բ� ǥ���ϴ� ������ �ۼ��ϴµ�,
--   �� ���̺��� ���� Employee, Emp#, Manager �� Mgr#���� �����Ͻÿ�.

--Oracle
SELECT w.last_name "Employee", w.employee_id "Emp#", 
       m.last_name "Manager", m.employee_id "Mgr#"
FROM   employees w, employees m
WHERE  w.manager_id = m.employee_id;

--ANSI
SELECT w.last_name "Employee", w.employee_id "Emp#", 
       m.last_name "Manager", m.employee_id "Mgr#"
FROM   employees w JOIN employees m
                        ON  w.manager_id = m.employee_id;

--5. King�� ���� �ش� �����ڰ� �������� ���� ����� ǥ���ϵ��� 
--   4�� ������ �����մϴ�. 
--   ��� ��ȣ������ ����� �����Ͻÿ�. 

--Oracle
SELECT   e.last_name "Employee", e.employee_id "Emp#", 
         m.last_name "Manager", m.employee_id "Mgr#"
FROM     employees e, employees m
WHERE    e.manager_id = m.employee_id(+)
ORDER BY e.employee_id;

--ANSI
SELECT   e.last_name "Employee", e.employee_id "Emp#", 
         m.last_name "Manager", m.employee_id "Mgr#"
FROM     employees e LEFT OUTER JOIN employees m
                        ON  e.manager_id = m.employee_id
ORDER BY e.employee_id;
                        
--6. ���� ��� �� �޿��� ���� ������ �ʿ�� �մϴ�. 
--   ���� JOB_GRADES ���̺��� ������ ǥ���� ���� 
--   ��� ����� �̸�, ����, �μ� �̸�, �޿� �� ����� ǥ���ϴ� 
--   query�� �ۼ��Ͻÿ�.
--   �� job_grades ���� ��� ��ũ��Ʈ ���� �� �ǽ�

DESC   job_grades;

--Oracle
SELECT e.last_name, e.job_id, d.department_name, e.salary, j.grade_level
FROM   employees e, departments d, job_grades j
WHERE  e.department_id = d.department_id
       AND e.salary BETWEEN j.lowest_sal AND j.highest_sal;

--ANSI
SELECT e.last_name, e.job_id, d.department_name, e.salary, j.grade_level
FROM   employees e JOIN departments d
                        ON e.department_id = d.department_id
                   JOIN job_grades j
                        ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;

--------------------------------------------------------------------------------

--<�ڡڡڡڼ��� ����>
--SELECT��(��������) ���� SELECT��(��������)
--�������� ����� ������������ ���

--1. ���� �� ��������
--�ϳ��� �ุ ��ȯ, ������ �񱳿����� ���
--ex. 'IT' �μ� ������ �̸�, �Ի���
SELECT last_name, hire_date
FROM   employees
WHERE  department_id = (SELECT department_id
                        FROM   departments
                        WHERE  department_name = 'IT');
                        
--ex. 'Abel' ���� �޿� �� ���� ���
SELECT last_name, salary
FROM   employees
WHERE  salary > (SELECT salary
                 FROM   employees
                 WHERE  last_name = 'Abel');

--ex. 141�� ����� ���� ������ ��� ��ȸ(141�� ��� ����)
SELECT employee_id, last_name, job_id
FROM   employees
WHERE  job_id = (SELECT job_id
                 FROM   employees
                 WHERE  employee_id = 141)
       AND employee_id != 141;

--ex. 'Abel'�� ���� ���� 'Abel'���� �޿� ���� ���
SELECT last_name, job_id, salary
FROM   employees
WHERE  job_id = (SELECT job_id
                 FROM   employees
                 WHERE  last_name = 'Abel')
AND    salary > (SELECT salary
                 FROM   employees
                 WHERE  last_name = 'Abel');

SELECT last_name, job_id, salary
FROM   employees
WHERE  salary = (SELECT MIN(salary)
                 FROM   employees);

--HAVING������ �������� ��� ����
SELECT   department_id, MIN(salary)
FROM     employees
GROUP BY department_id
HAVING   MIN(salary) > (SELECT MIN(salary)
                        FROM employees
                        WHERE department_id = 50);
                        