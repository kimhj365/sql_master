DESC   employees;

SELECT *
FROM   employees;

--<��������>
-- �� sql_labs�� cre_empl, cre_hrdata ���� ��� ��ũ��Ʈ ���� �� �ǽ�
-- �� sales_reps ���� ��� ��ũ��Ʈ ���� �� �ǽ�

--2. ������ ��������
--������ ��ȯ�ϴ� ��������
--������ ������ ���: IN, ANY, SOME

--ANY: ���� �������� ��ȯ�� ������ ��(OR)
--ALL: ���� �������� ��ȯ�� ��ο� ��(AND)

-- < ANY : ���ϰ��� �� �ִ밪���� ���� ������
--ex. ���ϰ� : 9000, 6000, 4200 => 9000���� ���� salary
SELECT employee_id, last_name, job_id, salary
FROM   employees
WHERE  salary < ANY (SELECT salary
                     FROM   employees
                     WHERE  job_id = 'IT_PROG')
AND    job_id <> 'IT_PROG';

-- < ALL : ���ϰ��� �� �ּҰ����� ���� ������
--ex. ���ϰ� : 9000, 6000, 4200 => 4200���� ���� salary
SELECT employee_id, last_name, job_id, salary
FROM   employees
WHERE  salary < ALL (SELECT salary
                     FROM   employees
                     WHERE  job_id = 'IT_PROG')
AND    job_id <> 'IT_PROG';


--3. ���߿� ��������

--(1)Nonpairwise Comparison(��-�ֺ�)
--   : �� ������ ���(AND, OR, ...) => ȥ�� WHERE���� ����
SELECT manager_id, department_id
FROM   empl_demo
WHERE  first_name = 'John';
--�̸��� 'John'�� ��� : 3��

SELECT employee_id, manager_id, department_id
FROM   empl_demo
WHERE  manager_id IN   (SELECT manager_id
                        FROM   empl_demo
                        WHERE  first_name = 'John')
AND    department_id IN (SELECT department_id
                        FROM   empl_demo
                        WHERE  first_name = 'John')
AND    first_name <> 'John';
-- => 3���� �Ŵ�����ȣ, �μ���ȣ�� ������ ������ 9���� ��� ������(3^2)
-- => (108, 123, 100) * (100, 50, 80)�� ��� ����

--(2)Pairwise Comparison(�ֺ�)
--   : ���߿� �������� ��� => ���� WHERE���� ����
SELECT employee_id, manager_id, department_id
FROM   empl_demo
WHERE  (manager_id, department_id) IN
                    (SELECT manager_id, department_id
                     FROM   empl_demo
                     WHERE  first_name = 'John')
AND    first_name <> 'John';
-- 3���� (�Ŵ�����ȣ, �μ���ȣ) ������ 3�� ��츸 ������
-- => (108, 100), (123, 50), (100, 80)


--<������ ���۾� DML>
--DML�� : INSERT / DELETE / UPDATE => Transaction

--1. INSERT ����
--���̺� �� �� �߰�(���ѹ��� �ϳ��� �ุ �߰�)
--����, ��¥ �� : ' '�� ����

--ex. departments ���̺� 370 ������ �ϳ� �߰�

SELECT *
FROM   departments;

INSERT INTO departments
           (department_id, department_name, manager_id, location_id)
VALUES     (370, 'Public Relations', 100, 1700);

--��� Į���� �� �Է��� ���� Į���� ����� ��
INSERT INTO departments
VALUES     (371, 'Public Relations', 100, 1700);

--Ư�� Į������ �� �Է��Ҷ��� Į���� �ݵ�� ����
--�Էµ��� ���� Į������ NULL��(�Ͻ��� NULL)
INSERT INTO departments
           (department_id, department_name)
VALUES     (330, 'Purchasing');

--NULL�� Ű���� ���� ����(����� NULL)
--����: 'NULL' �ƴ�
INSERT INTO departments
VALUES     (400, 'Finance', NULL, NULL);

--���ڿ��� ��� ''���� NULL�� ����� ���� ����
--����: ' '(space) �ƴ�
INSERT INTO departments
VALUES     (100, 'Finance', '', '');

--�Լ� ����ؼ� �� �Է�(SYSDATE)
SELECT *
FROM   employees;

INSERT INTO employees
VALUES      (113, 'Louis', 'Popp', 'LPOPP', '515.124.4567',
             SYSDATE, 'AC_ACCOUNT', 6900, NULL, 205, 110);

--��¥ ���� ���缭 �Է�(TO_DATE)
INSERT INTO employees
VALUES     (114, 'Den', 'Raphaely', 'DRAPHAEL', '515.127.4561', 
            TO_DATE('FEB 3, 1999', 'MON DD, YYYY'),
            'SA_REP', 11000, 0.2, 100, 60);

--ġȯ���� &���� �� �Է¹޾Ƽ� �߰� ����
INSERT INTO departments
           (department_id, department_name, location_id)
VALUES     (&department_id, '&department_name', &location);

--sales_reps ����: ������ ���� ���̺� 2�� ����
SELECT *
FROM   sales_reps;

SELECT *
FROM   copy_emp;

--SELECT�� ���� ���� ����� �����ͷ� �߰�
INSERT INTO sales_reps
            SELECT employee_id, last_name, salary, commission_pct
            FROM   employees
            WHERE  job_id LIKE '%REP%';

--���̺� ��ü�� ����
INSERT INTO copy_emp
            SELECT *
            FROM   employees;

--�ֿ� ���� 1: �⺻Ű ���� ����
INSERT INTO departments(department_id, department_name)
VALUES      ('YEDAM');
--�⺻Ű NULL�� ����

INSERT INTO departments(department_id, department_name)
VALUES      (10, 'YEDAM');
--�⺻Ű �ߺ��� ����

INSERT INTO departments(department_id, department_name)
VALUES      (120, 'YEDAM');
--�⺻Ű �ߺ���, �ΰ�X => ���� �߰�

--�ֿ� ���� 2: NOT NULL �������� ����
INSERT INTO departments(department_id)
VALUES      (130);
--department_id�� NOT NULL �������� �ɷ��ִ� Į��
-- => NULL�� �Է½� ����

--�ֿ� ���� 3: �ܷ�Ű ���� ����
INSERT INTO departments(department_id, department_name, manager_id)
VALUES      (130, 'YD', 1);
--�ܷ�Ű manager_id�� employees ���̺��� employee_id Į�� ����
-- => employee_id Į���� ���� manager_id �Է� �� ����

--2. UPDATE ����
-- : ���̺��� ���� ������ ����
--   �ѹ��� ������ �� ���� ����
--   WHERE�� �������� Ư�� �� ������ ����(������ ��� ���� ������)

UPDATE employees
set    department_id = 50
WHERE  employee_id = 113;

SELECT *
FROM   employees;

--���� : WHERE�� ������ ��� ���� ������
UPDATE copy_emp
SET    department_id = 110;

SELECT *
FROM   copy_emp;

--���� ���� ������ ����: SET expr1, expr2, ...
UPDATE employees
SET    job_id = 'IT_PROG',
       commission_pct = NULL
WHERE  employee_id = 114;

--Transcation
--DML������ �۾��Ѱ� ���
ROLLBACK;

--3. DELETE
--WHERE�� �����Ͽ� Ư�� �� ����
--�ڡ����� : WHERE�� ���� ���ϸ� ���̺��� ��� �� ������

--�����ϰ� �ִ� ���̺��� ������ ���� �ȵ�
DELETE employees;

SELECT *
FROM   employees;

--�� ���̺� �����ؼ� �ǽ�
INSERT INTO copy_emp
            SELECT *
            FROM   employees;

--���� ��Ȳ ����
COMMIT;            

--���̺� ��ü ����
DELETE copy_emp;

SELECT *
FROM   copy_emp;

--�ѹ��ϸ� COMMIT�� �������� ���ư�
ROLLBACK;

--WHERE���� ���� ������ ����
DELETE FROM departments
WHERE  department_name = 'Finance';

SELECT *
FROM   departments;

--�񱳿����ڸ� Ȱ���� ����
DELETE departments
WHERE  department_id IN (30, 40);

ROLLBACK;

--DDL ��ɾ�� ������ �����ϸ� �ѹ����� ���� �Ұ���
TRUNCATE TABLE copy_emp;

ROLLBACK;

SELECT *
FROM   copy_emp;

--sql07 ����--------------------------------------------------------------------

--1. Zlotkey�� ������ �μ��� ���� ��� ����� 
--   �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
--   Zlotkey�� ������� �����Ͻÿ�.
SELECT last_name, hire_date
FROM   employees
WHERE  department_id = (SELECT department_id
                        FROM   employees
                        WHERE  LOWER(last_name) = 'zlotkey')
AND LOWER(last_name) != 'zlotkey';

--2. �޿��� ��� �޿����� ���� ��� ����� 
--   ��� ��ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� 
--   ����� �޿��� ���� ������������ �����Ͻÿ�.
SELECT   employee_id, last_name
FROM     employees
WHERE    salary > (SELECT AVG(salary)
                   FROM   employees)
ORDER BY salary;

--3. �̸��� u�� ���Ե� ����� ���� �μ����� ���ϴ� 
--   ��� ����� ��� ��ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� 
--   ���Ǹ� �����Ͻÿ�.
SELECT employee_id, last_name
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   employees
                         WHERE  LOWER(last_name) LIKE '%u%');
--�������� ��� : 50, 60 => ������ ��������

--4. �μ� ��ġ ID(location_id)�� 1700�� 
--   ��� ����� �̸�, �μ� ��ȣ �� ���� ID�� ǥ���Ͻÿ�.
SELECT *
FROM   departments;

SELECT *
FROM   employees;

SELECT last_name, department_id, job_id
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   departments
                         WHERE  location_id = 1700);

--5. King���� �����ϴ�(manager�� King) 
--   ��� ����� �̸��� �޿��� ǥ���Ͻÿ�.
SELECT last_name, salary
FROM   employees
WHERE  manager_id = (SELECT employee_id
                     FROM   employees
                     WHERE  LOWER(last_name) = 'king');

--6. Executive �μ��� ��� ����� ���� 
--   �μ� ��ȣ, �̸� �� ���� ID�� ǥ���Ͻÿ�.
SELECT department_id, last_name, job_id
FROM   employees
WHERE  department_id = (SELECT department_id
                        FROM   departments
                        WHERE  LOWER(department_name) = 'executive');

--7. ��� �޿����� ���� �޿��� �ް� �̸��� u�� ���Ե� ����� 
--   ���� �μ����� �ٹ��ϴ� ��� ����� ��� ��ȣ, �̸� �� �޿��� ǥ���Ͻÿ�.
SELECT employee_id, last_name, salary
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   employees
                         WHERE  salary > (SELECT avg(salary)
                                         FROM   employees)
                         AND    LOWER(last_name) LIKE '%u%');

--------------------------------------------------------------------------------

--sql08 ����--------------------------------------------------------------------

--1. ������ ���� �ǽ��� ����� MY_EMPLOYEE ���̺��� �����Ͻÿ�.
CREATE TABLE my_employee
  (id         NUMBER(4) NOT NULL,
   last_name  VARCHAR2(25),
   first_name VARCHAR2(25),
   userid     VARCHAR2(8),
   salary     NUMBER(9,2));

--2. MY_EMPLOYEE ���̺��� ������ ǥ���Ͽ� �� �̸��� �ĺ��Ͻÿ�.
DESC my_employee;

--3. ���� ���� �����͸� MY_EMPLOYEE ���̺� �߰��Ͻÿ�.
--ID	LAST_NAME 	FIRST_NAME 	USERID 	SALARY
--1  	Patel 		Ralph 		Rpatel 	895
--2 	Dancs 		Betty 		Bdancs 	860
--3 	Biri 		Ben 		Bbiri 	1100
INSERT INTO my_employee
VALUES      (1, 'Patel', 'Ralph', 'Rpatel', 895);
INSERT INTO my_employee
VALUES      (2, 'Dancs', 'Betty', 'Bdancs', 860);  
INSERT INTO my_employee
VALUES      (3, 'Biri', 'Ben', 'Bbiri', 1100);
--INSERT INTO my_employee
--VALUES      (&id, '&last_name', '&first_name', '&userid', &salary);

--4. ���̺� �߰��� �׸��� Ȯ���Ͻÿ�.
SELECT *
FROM   my_employee;

--6. ��� 3�� ���� Drexler�� �����Ͻÿ�.
UPDATE my_employee
SET    last_name = 'Drexler'
WHERE  id = 3;

--7. �޿��� 900 �̸��� ��� ����� �޿��� 1000���� �����ϰ� 
--   ���̺��� ���� ������ Ȯ���Ͻÿ�.
UPDATE my_employee
SET    salary = 1000
WHERE  salary < 900;

SELECT *
FROM   my_employee;

--8. MY_EMPLOYEE ���̺��� ��� 3�� �����ϰ� ���̺��� ���� ������ Ȯ���Ͻÿ�.
DELETE my_employee
WHERE  id = 3;

SELECT *
FROM   my_employee;

--11. ���̺��� ������ ��� �����ϰ� ���̺� ������ ��� �ִ��� Ȯ���Ͻÿ�.
DELETE my_employee;             --DML
--TRUNCATE TABLE my_employee;   --DDL

SELECT *
FROM   my_employee;

--------------------------------------------------------------------------------

--<Ʈ����� ����(Transaction Control Language, TCL)>
--Ʈ������ : ������ ���� �� ���뼺 �� ���� ���, ������ ������ �ϰ��� ����
--����(Session) : �α��� �� ���� �α׾ƿ� ������
--                ���� ���� Ʈ���������� ������

--Ʈ����� ���� : ���� ������ ù��° SQL�� ���� ��
--Ʈ������ ���� : 
--   Ŀ�� / �ѹ� ��
--   DDL, DCL ���� ���� ��(�ڵ� Ŀ��)
--   ����� ����
--   �ý��� crash(�ڵ� �ѹ�)

--TCL : ������ Ʈ����� �����ϴ� ��ɾ�
--(1)COMMIT : ������ ������� Ŀ��, ���� Ʈ����� ����
--(2)SAVEPOINT : Ʈ����� ������ �ѹ� ���� ����(�߰� ���� ����)
--(3)ROLLBACK : ������ ������� ��� �ǵ���, ���� Ʈ����� ����

--1. Ŀ��/�ѹ� �� : 
--������ ���� ����
--���� ����� SELECT������ DML �۾� ����
--�� ��� => �ٸ� ����ڰ� ������� ���ų� ���� �Ұ�
COMMIT;

UPDATE employees
SET    salary = 99999
WHERE  employee_id = 176;

SELECT *
FROM   employees
WHERE  employee_id = 176;

--2. Ŀ�� ���� : 
--���泻�� DB�� ���� ���� = > ���� ���� ���, SAVEPOINT ����
--�� ��� Ǯ�� => �ٸ� ����ڰ� ���� ���� ����
COMMIT;

--DDL�� ���� �ϳ��ϳ��� Ʈ����� => �ڵ� Ŀ��
TRUNCATE TABLE aa;

--3. �ѹ� ���� : 
--������ ���� ���, ���� ���� ����
--�� ��� Ǯ��


--<������ ���Ǿ�(Data Definition Language, DDL)>
--<DDL - ��ü ����>

--���̺�
--����� ���̺�: ����ڰ� ����, ����
--������ ��ųʸ�: ����Ŭ ������ ����, ����
SELECT table_name
FROM   user_tables;

SELECT DISTINCT object_type
FROM   user_objects;

SELECT *
FROM   user_catalog;
-- => ������ ��ųʸ� ����

--CREATE TABLE�� : ���̺� ����
--��Ű��: ����� ������
CREATE TABLE hire_dates
       (id        NUMBER(8),
        hire_date DATE DEFAULT SYSDATE);

--DEFAULT�� ����(����� NULL�� ���� ����)
INSERT INTO hire_dates
           (id)
VALUES     (35);

SELECT *
FROM   hire_dates;

INSERT INTO hire_dates
VALUES     (45, NULL);

--���̺� ����
CREATE TABLE dept
            (deptno      NUMBER(2),
             dname       VARCHAR2(14),
             loc         VARCHAR2(13),
             create_date DATE DEFAULT SYSDATE);
             
SELECT *
FROM   dept;

--������ ��ųʸ�: ����ڰ� ������ ���̺� ������
SELECT table_name
FROM   user_tables;

--�������� �̿��� ���̺� ����
--ex. �μ���ȣ�� 80�� ����� ���̺� ����
--����: Į�� �̸��� ���� ������ ���� �ȵ� => Į�� Alias ���� �ʼ�
CREATE TABLE dept80
     AS
        SELECT employee_id, last_name,
               salary*12 ANNSAL, hire_date
        FROM   employees
        WHERE  department_id = 80;

SELECT *
FROM   dept80;

--<DDL - ��ü ����>
--ALTER TABLE : ��ü ���� DDL
--1. ADD : ��(Į��) �߰�

--�߰��� Į���� �� => �ΰ�
ALTER TABLE dept80
ADD        (job_id VARCHAR2(9));

--�߰��� ���� �ప DEFAULT�� ���� ����
ALTER TABLE dept80
ADD        (hdate DATE DEFAULT SYSDATE);

--2. MODIFY : Į�� ����
ALTER TABLE dept80
MODIFY     (last_name VARCHAR2(30));

--������ ũ�� ���� ����
--������ ���� ����, ���Ҵ� ���� ������ ���� ������
ALTER TABLE dept80
MODIFY     (last_name VARCHAR2(10));

ALTER TABLE dept80
MODIFY     (last_name VARCHAR2(5)); -- => ����

--������ Ÿ�� ���� ����(�ΰ��� ��������)
ALTER TABLE dept80
MODIFY      (job_id NUMBER(15));

--�̹� �����Ͱ� ������ Ÿ�� ���� �Ұ���
ALTER TABLE dept80
MODIFY      (last_name NUMBER(15));

--3. DROP: �� ����
--������ �����ص� ��������
--Į�� ������ �� �ּ� �Ѱ��� Į�� �����־�� ��(�ϳ��� ������ ���̺� �����Ǵϱ�)
--����: ���� ���� �ѹ� �� �ȹ�� / ������ �� ���� �Ұ���
ALTER TABLE dept80
DROP       (job_id);

--4. SET UNUSED: �� ������(������ ���Ŵ� X)
--Į���� ����ε� ġ�� �� => �ٵ� �ٽ� ���� ����(= DROP)
--���� ����: ����� ������ �̸� ���Ƶΰ� ����� ������ �ٷ� ������ �� �ְ�
ALTER TABLE   dept80
SET   UNUSED (last_name);

--DROP UNUSED COLUMNS: UNUSED�� Į�� �ѹ��� �� ����
ALTER TABLE dept80
DROP UNUSED COLUMNS;

--<��Ÿ ������ ���Ǿ�>
--1. DROP TABLE: ���̺� ����
--��, �ó�� : ������ ��� �Ұ� / �ε��� : ���� ������
--Ʈ����� ��� Ŀ�Ե�
--����: ���� Ȯ�� ���� �ٷ� ���� / ����(ROLLBACK) �Ұ���
DROP TABLE dept80;

--����Ŭ ������ ���: ���̺� ������ ������ ��� ����
SELECT object_name, original_name, type
FROM   user_recyclebin;

--FLASHBACK TABLE: DROP �� ���·� ���̺� ����
FLASHBACK TABLE dept80 TO BEFORE DROP;

SELECT *
FROM   dept80;

--DROP TABLE ~ PURGE: ��������(���������� ���� �Ұ���) => ������
DROP TABLE dept80 PURGE;

--PURGE RECYCLEBIN: ������ ���� => ������

--2. RENAME: ��ü �̸� ����
RENAME dept TO dept80;

SELECT *
FROM   dept80;

--3. TRUNCATE: ���̺� ����
--���̺��� ��� �� ���� / �ѹ� �Ұ���
TRUNCATE TABLE dept80;

--4. COMMENT: �ּ��ޱ�
--���̺�/���� �ּ� �߰�