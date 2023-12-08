select *
from tab;

select * from employees;

--DESC(Describe): ���̺��� ����
DESC employees;
DESC departments;

SELECT *
FROM departments;

SELECT *
FROM employees;

SELECT department_id, location_id
FROM departments;

SELECT location_id, department_id
FROM departments;

SELECT department_id, department_id
FROM departments;

SELECT last_name, hire_date, salary
FROM employees;

--���������
SELECT last_name, salary, salary + 300
FROM employees;

SELECT last_name, salary, 12*salary+100
FROM employees;

SELECT last_name, salary, 12*(salary+100)
FROM employees;

SELECT last_name, job_id, salary, commission_pct
FROM employees;

SELECT last_name, 12*(salary*commission_pct)
FROM employees;

--NVL(Į��, ��) : �ش� Į������ �ΰ��� ��� ��ü�� ��
SELECT last_name, 12*salary*NVL(commission_pct, 0)
FROM employees;

SELECT last_name, 12*salary*NVL(commission_pct, 1)
FROM employees;

--AS : Į���� ��Ī(����ǥ ������ ���� �빮��)
SELECT last_name as name, commission_pct comm
FROM employees;

SELECT last_name "Name", salary*12 "Annual Salary"
FROM employees;

--�ѱ۵� AS ��Ī ����
SELECT last_name "�̸�", salary*12 "���ʽ�"
FROM employees;

--���Ῥ���� || : �� or ���ڿ��� �ٸ� ���� ����
SELECT last_name||job_id as "Employees"
FROM employees;

--��Ī�� �ҹ���, ���� �ִ� ��� ū����ǥ�� ����
SELECT last_name||' is a '||job_id AS "Employee Details"
FROM employees;

SELECT department_id
FROM employees;

--DISDINCT : �ߺ��� ���� => SELECT �ٷ� ������ �;���
SELECT DISTINCT department_id
FROM employees;

SELECT DISTINCT department_id, job_id
FROM employees;

--����1
--1
DESC departments;

--2
DESC employees;
SELECT employee_id, last_name, job_id, hire_date AS startdate
FROM employees;

--3
SELECT DISTINCT job_id
FROM employees;

--4
SELECT employee_id "Emp #", last_name "Employee", job_id "Job", hire_date "Hire Date"
FROM employees;

--5
SELECT job_id||', '||last_name "Employee and Title"
FROM employees;

--WHERE�� : ���� �����ϴ� �ุ �����ϵ��� ����
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 90;

--������ ���� ��ҹ��� �����ؾߵ�
SELECT last_name, job_id, department_id
FROM employees
WHERE last_name = 'Whalen';

--��¥ ���� �ý��� ��¥ ���Ŀ� �°� ����� ��
SELECT last_name
FROM employees
WHERE hire_date = '05/10/10';

SELECT last_name, hire_date
FROM employees;

--�񱳿�����
SELECT last_name, salary
FROM employees
WHERE salary <= 3000;

SELECT last_name, hire_date
FROM employees
WHERE hire_date < '05/01/01';

--BETWEEN ������ : BETWEEN �ּҰ� AND �ִ밪
-- => �ּҰ� �̻� �ִ밪 ����(����) �� ���� ��
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 2500 AND 3500;

--������ �ȶ����� �������� ���� �ʴ� ���� => ���� ����
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 3500 AND 2500;

--IN ������ : IN(a, b, c)
-- =>a, b, c���� �� ���� ��
SELECT employee_id, last_name, salary, manager_id
FROM employees
WHERE manager_id IN (100, 101, 201);

--LIKE ������ : ���ڿ� ������ �� ã�� 
--'S%' : �빮�� S�� �����ϴ� ���ڿ�
SELECT first_name
FROM employees
WHERE first_name LIKE 'S%';

--'%s' : �ҹ��� s�� �����ϴ� ���ڿ�
SELECT last_name
FROM employees
WHERE last_name LIKE '%s';

--��¥���� % ��� ����(�ý��� ��¥ ���� ����)
SELECT last_name, hire_date
FROM employees
WHERE hire_date LIKE '05%';

--'_'(�����) : �� ���� ��ü
--'_o%' : �ι�° ���ڰ� o�� �����ϴ� �ڷ�
SELECT last_name
FROM employees
WHERE last_name LIKE '_o%';

--
SELECT employee_id, last_name, job_id
FROM employees
WHERE job_id LIKE '%SA_%';

--
SELECT employee_id, last_name, job_id
FROM employees
WHERE job_id LIKE '%_M%';

SELECT employee_id, last_name, job_id
FROM employees
WHERE job_id LIKE '%\_M%' ESCAPE '\';

--IS NULL ������ : null �� ��ȸ
SELECT *
FROM employees
WHERE commission_pct IS NULL;

--AND ������ : ������ ��� true�� �͸� ��ȸ
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
AND job_id LIKE '%MAN%';

--OR ������ : ���� �� �ϳ��� true�� true
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
OR job_id LIKE '%MAN%';

--NOT ������ : ������ ������(�ٸ� �����ڿ� �Բ� ��� ����)
SELECT last_name, job_id
FROM employees
WHERE job_id
NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP');

--������ �켱���� : AND > OR
--�׳� ��ȣ�� �켱���� ���� ����
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = 'SA_REP'
OR job_id = 'AD_PRES'
AND salary > 15000;

SELECT last_name, job_id, salary
FROM employees
WHERE (job_id = 'SA_REP'
OR job_id = 'AD_PRES')
AND salary > 15000;

--����2
--1.
SELECT last_name, salary
FROM employees
WHERE salary > 12000;

--2.
SELECT last_name, department_id
FROM employees
WHERE employee_id = 176;

--3.
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 5000 and 12000;

--6.
SELECT last_name "Employee", salary "Monthly Salary"
FROM employees
WHERE salary BETWEEN 5000 and 12000
AND department_id IN (20, 50);

--7.
SELECT last_name, hire_date
FROM employees
--WHERE hire_date BETWEEN '05/01/01' and '05/12/31';
WHERE hire_date LIKE '05%';

--8.
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NULL;

--10.
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

--11.
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%'
AND last_name LIKE '%e%';


--12.
SELECT last_name, job_id, salary
FROM employees
WHERE job_id IN ('SA_REP', 'ST_CLERK')
AND salary NOT IN (2500, 3500, 7000);

--13.
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct = 0.2;
