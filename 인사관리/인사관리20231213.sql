--<���� ����>
--�������� : ������ �ϰ��� �������� ����
--           ���Ӽ� �����ϴ� ���̺� ���� ����
--(2)UNIQUE : ������ ��
--(3)PRIMARY KEY : �⺻Ű, ���̺��� �� �����ϰ� �ĺ�(��X, �ߺ�X)
--(4)FOREIGN KEY : �ܷ�Ű, �ٸ� ���̺� �⺻Ű ����
--(5)CHECK : ��(TRUE)�����ϴ� ���� ����
--=> NOT NULL, �⺻Ű ���� �ΰ� ���� ����

--��: ���̺� ���� �ּ�ȭ�ϱ�

--�� ����: ��� ���Ἲ �������� ���� ���� ����
--���̺� ����: NOT NULL ���� �Ұ�

--1. NOT NULL : 
--   �ΰ� X, �� ���������� ���� ����(���̺� ����X)
 CREATE TABLE emp_test (
        empid     NUMBER(5),
        empname   VARCHAR2(10) NOT NULL,
        duty      VARCHAR2(9),
        sal       NUMBER(7, 2),
        bonus     NUMBER(7, 2),
        mgr       NUMBER(5),
        hire_date DATE,
        deptid    NUMBER(2));

--NOT NULL ���� ���� NULL ������ ����
INSERT INTO emp_test(empid, empname)
VALUES      (10, NULL);

INSERT INTO emp_test(empid, empname)
VALUES      (10, 'YD');

SELECT *
FROM   emp_test;

--2. UNIQUE :
--   ��/�� ������ ��� ���� �����ϰ� �� => �� 2�� �̻� ���� ����(����Ű)
--   UNIQUE���� NULL�� ���� ����
CREATE TABLE dept_test(
        deptid NUMBER(2),
        dname  VARCHAR2(14),
        loc    VARCHAR2(13),
        UNIQUE(dname));
        
INSERT INTO dept_test(deptid, dname)
VALUES     (10, NULL);
INSERT INTO dept_test(deptid, dname)
VALUES     (20, 'YD');
INSERT INTO dept_test(deptid, dname)
VALUES     (20, 'YD');

SELECT *
FROM   dept_test;

--�ڡڡ�3. �⺻Ű(Primary Key)
--UNIQUE(������) + NOT NULL(�ΰ�X)
--���ϼ�O + �ּҼ�O => �ĺ�Ű(Candidate Key)
--���ϼ�O + �ּҼ�X => ����Ű(Super Key)
--�ĺ�Ű �߿� �⺻Ű ���� / ���þȵ� �ĺ�Ű => ��üŰ(Alternate Key)

DROP TABLE dept_test;
CREATE TABLE dept_test(
        deptid NUMBER(2) PRIMARY KEY,
        dname  VARCHAR2(14),
        loc    VARCHAR2(13),
        UNIQUE(dname));
        
INSERT INTO dept_test
VALUES     (10, 'YD', 'Daegu');

INSERT INTO dept_test
VALUES     (20, 'YD1', 'Daegu');

--�⺻Ű ������X ����
INSERT INTO dept_test
VALUES     (20, 'YD2', 'Daegu');

--�⺻Ű �ΰ� ����
INSERT INTO dept_test
VALUES     (NULL, 'YD3', 'Daegu'); 

SELECT *
FROM   dept_test;

--4. �ܷ�Ű(FOREIGN KEY)
--��/������ �ܷ�Ű ����
--���� ���̺�/�ٸ� ���̺��� �⺻Ű/����Ű�� ���輳��
--�θ� ���̺��� �⺻ ���� ��ġ/NULL
DROP TABLE emp_test;

--(1)���̺� ������ FOREIGN KEY ����
--�ܷ�Ű�� ��� ���̺��� ��� Į�� �����ϴ��� ������� ��(REFERENCES)
CREATE TABLE emp_test (
        empid     NUMBER(5),
        empname   VARCHAR2(10) NOT NULL,
        duty      VARCHAR2(9),
        sal       NUMBER(7, 2),
        bonus     NUMBER(7, 2),
        mgr       NUMBER(5),
        hire_date DATE,
        deptid    NUMBER(2),
        FOREIGN KEY(deptid) REFERENCES dept_test(deptid));
        
--(2)Į�� ������ FOREIGN KEY ����
--FOREIGN KEY ������ REFERENCES ���� ����
CREATE TABLE emp_test (
        empid     NUMBER(5),
        empname   VARCHAR2(10) NOT NULL,
        duty      VARCHAR2(9),
        sal       NUMBER(7, 2),
        bonus     NUMBER(7, 2),
        mgr       NUMBER(5),
        hire_date DATE,
        deptid    NUMBER(2) REFERENCES dept_test(deptid));

INSERT INTO emp_test(empid, empname, deptid)
VALUES     (100, 'YD1', 10);

--�ܷ�Ű�� NULL�� ���� ����
INSERT INTO emp_test(empid, empname, deptid)
VALUES     (200, 'YD2', NULL);

--�θ� ���̺��� �����ϴ� Į���� �� ������ ����
INSERT INTO emp_test(empid, empname, deptid)
VALUES     (300, 'YD3', 30);

--�ܷ�Ű �ɼ� Ű����
--ON DELETE CASCADE: �θ����̺� ���� => �ڽ����̺��� ������ ����
--ON DELETE SET NULL: �θ����̺� ���� => �ڽ����̺��� ������ NULL��
-- => �� �� ������ : ������ �ϰ���, ���Ἲ ���Ѿ��ؼ�
DROP TABLE emp_test;

CREATE TABLE emp_test (
        empid     NUMBER(5),
        empname   VARCHAR2(10) NOT NULL,
        duty      VARCHAR2(9),
        sal       NUMBER(7, 2),
        bonus     NUMBER(7, 2),
        mgr       NUMBER(5),
        hire_date DATE,
        deptid    NUMBER(2) REFERENCES dept_test(deptid) ON DELETE SET NULL);
        
INSERT INTO emp_test(empid, empname, deptid)
VALUES     (100, 'YD1', 10);

INSERT INTO emp_test(empid, empname, deptid)
VALUES     (200, 'YD2', NULL);

SELECT *
FROM   emp_test;

--�θ� ���̺��� �� ���� => �ڽ� ���̺��� �����ϴ� �� NULL������ ��ȯ
DELETE dept_test
WHERE  deptid = 10;

SELECT *
FROM   dept_test;

--5. CHECK ��������
--   : ���� ���� ���� ������ ���� �����ϰ� ������

DROP TABLE emp_test;

--���̺� ������ CHECK
CREATE TABLE emp_test (
        empid     NUMBER(5),
        empname   VARCHAR2(10) NOT NULL,
        duty      VARCHAR2(9),
        sal       NUMBER(7, 2),
        bonus     NUMBER(7, 2),
        mgr       NUMBER(5),
        hire_date DATE,
        deptid    NUMBER(2),
        CHECK    (deptid BETWEEN 10 and 99),
        FOREIGN KEY(deptid) REFERENCES dept_test(deptid));
        
--Į�� ������ CHECK
CREATE TABLE emp_test (
        empid     NUMBER(5),
        empname   VARCHAR2(10) NOT NULL,
        duty      VARCHAR2(9),
        sal       NUMBER(7, 2),
        bonus     NUMBER(7, 2),
        mgr       NUMBER(5),
        hire_date DATE,
        deptid    NUMBER(2) CHECK (deptid BETWEEN 10 and 99),
        FOREIGN KEY(deptid) REFERENCES dept_test(deptid));
        
--<�������� ����>
--�̹� ����� ���� ���̺� �������� �����ϴ� ���

--1. �������� �߰�
--(1)ALTER TABLE + ADD : ���̺� ������ ��������
--�⺻Ű ����
ALTER TABLE emp_test
ADD         PRIMARY KEY(empid);

--���� ���̺� �⺻Ű �־�� �ܷ�Ű ���� ����
ALTER TABLE emp_test
ADD         FOREIGN KEY(mgr) REFERENCES emp_test(empid);

--(2)ALTER TABLE + MODIFY : Į�� ������ ��������
--ex. NOT NULL ������ ������ Į������(but ���� �����Ϳ� �ΰ� �������)
ALTER TABLE emp_test
MODIFY     (duty NOT NULL);

--2. �������� ����
--ALTER TABLE + DROP �������� �̸�
--�������� �̸� ã�� �� �̿��� Ȯ���ؼ� �����ؾ���
SELECT constraint_name, constraint_type,
       search_condition
FROM   user_constraints;

SELECT constraint_name, column_name
FROM   user_cons_columns;

DESC   user_cons_columns;

SELECT constraint_name, table_name, column_name
FROM   user_cons_columns
WHERE  table_name = 'EMP_TEST';
-- mgr Į�� �������� => SYS_C007024

--SYS_C007024 �������� ����
ALTER TABLE emp_test
DROP  CONSTRAINT SYS_C007024;

--3. �������� ��Ȱ��ȭ
--ALTER TABLBE + DISABLE : ��Ȱ��ȭ
--ALTER TABLBE + ENABLE  : Ȱ��ȭ   
-- ==> �Ⱦ�

--<��(View)>
--��: �� ���̺�(���� ���̺�X)/ ���������͸� ���� ��� ����
--��� ���� :  ���� ����, ���� ����ȭ, ������ ������ ��

--�� ���� : CREATE VIEW ~ AS ~
--���������� �ִ� ���� = ��
CREATE VIEW empvu80
    AS SELECT employee_id, last_name, salary
       FROM employees
       WHERE department_id = 90;

--���̺�ó�� ���� ��ȸ �� �� ����
SELECT *
FROm   empvu80;

--�� �����ϴ� ���������� ���� SELECT ���� ��밡��(����, �׷�, �������� ��)
--BUT ���������� ORDER BY ���� �Ұ�
--��� ALTER ��ɾ�� �����Ұ� => OR REPLACE�� ������ ��(��ü)
--���� Į���� alias ���� ���� / Į���� ���ĵ��� ������ alias �����ؾ���

--Į�� alias ���� ��� 1
CREATE VIEW salvu50
    AS SELECT employee_id ID_NUMBER, last_name NAME,
              salary*12 ANN_SALARY
       FROM   employees
       WHERE  department_id = 50;

--Į�� alias ���� ��� 2
CREATE VIEW salvu50(ID_NUMBER, NAME, ANN_SALARY)
    AS SELECT employee_id, last_name, salary*12 
       FROM   employees
       WHERE  department_id = 50;   
   
SELECT *
FROM   salvu50;

CREATE OR REPLACE VIEW empvu80(id_number, name, sal, department_id)
    AS SELECT employee_id, first_name || ' ' || last_name, 
              salary, department_id
       FROM   employees
       WHERE  department_id = 80;

SELECT *
FROM   empvu80;

--������ ������ ��� ���� ������ ��ȸ ����
CREATE OR REPLACE VIEW dept_sum_vu(name, minsal, maxsal, avgsal)
    AS SELECT   d.department_name, 
                MIN(e.salary), MAX(e.salary), AVG(e.salary)
       FROM     employees e JOIN departments d
       ON       (e.department_id = d.department_id)
       GROUP BY d.department_name;

SELECT *
FROM   dept_sum_vu;

--�ڡڡں� ���ؼ��� DML�� ���۰��� => ���� ������ ����(���� ����)
--DELETE �Ұ����� ��� : �׷��Լ�, GROUP BY��(���������� �������ϱ�), 
--                      DINTINCT, ROWNUM Ű���� �ִ� ��

SELECT ROWNUM employee_id
FROM   employees;

--UPDATE �Ұ����� ��� : (+) ǥ�������� ���� �� ��
--INSERT �Ұ����� ��� : (+) NOT NULL ��������

COMMIT;

SELECT *
FROM   empvu80;

--�並 ���� ���� => ���� ���̺��� �����͵� ������
DELETE empvu80
WHERE  id_number = 176;

SELECT *
FROM   empvu80;

SELECT *
FROM   employees;

SELECT *
FROM   dept_sum_vu;

--�� �����Ϳ� �׷��Լ� ������ ���� �Ұ���
DELETE dept_sum_vu
WHERE  name = 'IT';

CREATE VIEW test_vu
    AS SELECT department_name
       FROM   departments;
       
SELECT *
FROM   test_vu;

--NOT NULL �������� �ִ� ������ ���� �Ұ���
INSERT INTO test_vu
VALUES      ('YD');

--�� ����: DROP VIEW;

--<�ε���>
--������ ��� => �˻��ӵ� ���
--���̺� ������ �ε����� ���� ������

--�ε��� ����
--�ڵ� : PRIMARY KEY, UNIQUE ���� ������
--���� : CREATE INDEX ~ ON ~

--�ε��� �����ؾ� �� ���
--(1)���� WHERE��, ���� ���ǿ��� ���� ���� ��
--(2)���� �������� ���� ���Ե� ���
--(3)NULL���� ���� �� ��

--�ε��� �����ϸ� �ȵǴ� ���
-- : ���̺��� ���� ���ŵǴ� ���
--   (���� ������ �����ͷ� �ε��� ����� ����) => �׷��� �� �Ⱦ�

--<������>
--����Ŭ DB���� �ڵ���ȣ �ѹ��� �Ҷ� ��
--�⺻Ű�� ������ �� ���
CREATE SEQUENCE dept_deptid_seq
                INCREMENT BY 10     
                START WITH 120
                MAXVALUE 9999
                NOCACHE
                NOCYCLE;           --�ִ밪 ��� �ٽ� ���ƿ�

--NEXTVAL : ��밡���� ���� ������ ��
--CURRVAL : ���� ������ ��
INSERT INTO departments
            (department_id, department_name, location_id)
VALUES      (dept_deptid_seq.NEXTVAL, 'Support', 2500);

SELECT *
FROM   departments;

--�ѹ� �Ŀ��� �ѹ��� ������ => GAP �߻�
ROLLBACK;

SELECT *
FROM   departments;

--���� ������ �� ��ȸ
SELECT dept_deptid_seq.CURRVAL
FROM   dual;

--������ ���� : ALTER SEQUENCE
--������ ���� : DROP SEQUENCE

--<���Ǿ�(Synonym)>
--���� �״�� �ְ� �� �ٸ� �̸��� ����� �ִ� ��
--���Ǿ� �߰� : CREATE SYNONYM ~ FOR ~
CREATE SYNONYM d_sum
FOR    dept_sum_vu;

SELECT *
FROM   d_sum;

SELECT *
FROM   dept_sum_vu;


--<������ ����(DCL)>
--�ý��� ����: DB�� �׼��� ����

--�ý��� ���� Ȯ��
SELECT *
FROM system_privilege_map;

--����� ���� ����: CREATE USER => ������ �������� ����

--��ü ����: DB ��ü ���� ���� ����
--��ü ���� �ο� : CREATE SELECT ~ ON ~
--��ü ���� öȸ : REVOKE ~ ON ~ FROM ~

--������ ����
--TOP-DOWN
SELECT     LEVEL, 
           employee_id, last_name, manager_id
FROM       employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;

--BOTTOM-UP
SELECT     LEVEL, 
           employee_id, last_name, manager_id
FROM       employees
START WITH manager_id IS NULL
CONNECT BY PRIOR manager_id = employee_id;

SELECT     LEVEL, 
           LPAD(' ', 4*(LEVEL-1))||employee_id employee,
           last_name, manager_id
FROM       employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;
