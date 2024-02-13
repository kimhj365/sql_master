-- 20240213
-- PL/SQL ���� �� �׽�Ʈ

-- 1. ��ĺ��� ����

-- 2. HAVING��

-- 3. player ���̺� �� ������������ �ι�° ���ڰ� 'A'�� �������� ������� ���������� 

-- 4. �ּ� 3�� (�� �̻� ����)

-- 5. Inline View

-- 6.
CREATE TABLE department
    (
    deptid   NUMBER(10),
    deptname VARCHAR2(10),
    location VARCHAR2(10),
    tel      VARCHAR2(15),
    PRIMARY KEY (deptid)
    );

DESC department;

CREATE TABLE employee
    (
    empid    NUMBER(10),
    empname  VARCHAR2(10),
    hiredate DATE,
    addr     VARCHAR2(12),
    tel      VARCHAR2(15),
    deptid   NUMBER(10),
    PRIMARY KEY (empid),
    CONSTRAINT emp_dept_deptid_FK FOREIGN KEY (deptid) 
    REFERENCES department(deptid)
    );

DESC employee;


-- 7.
ALTER TABLE employee
ADD birthday DATE;
-- MODIFY, DROP
-- ��������(NOT NULL ����) ���� �Ұ� => DROP-ADD


-- 8.
-- department
INSERT INTO department
(
    deptid,
    deptname,
    location,
    tel
)
VALUES 
(
    1001,
    '�ѹ���',
    '��101ȣ',
    '053-777-8777'
);

INSERT INTO department
(
    deptid,
    deptname,
    location,
    tel
)
VALUES 
(
    1002,
    'ȸ����',
    '��102ȣ',
    '053-888-9999'
);

INSERT INTO department
(
    deptid,
    deptname,
    location,
    tel
)
VALUES 
(
    1003,
    '������',
    '��103ȣ',
    '053-222-3333'
);

SELECT 
    deptid,
    deptname,
    location,
    tel
FROM   department;

-- employee
INSERT INTO employee
(
    empid,
    empname,
    hiredate,
    addr,
    tel,
    deptid
)
VALUES 
(
    20121945,
    '�ڹμ�',
    TO_DATE('2012-03-02', 'YYYY-MM-DD'),
    '�뱸',
    '010-1111-1234',
    '1001'
);

INSERT INTO employee
(
    empid,
    empname,
    hiredate,
    addr,
    tel,
    deptid
)
VALUES 
(
    20101817,
    '���ؽ�',
    TO_DATE('2010-09-01', 'YYYY-MM-DD'),
    '���',
    '010-2222-1234',
    '1003'
);

INSERT INTO employee
(
    empid,
    empname,
    hiredate,
    addr,
    tel,
    deptid
)
VALUES 
(
    20122245,
    '���ƶ�',
    TO_DATE('2012-03-02', 'YYYY-MM-DD'),
    '�뱸',
    '010-3333-1222',
    '1002'
);

INSERT INTO employee
(
    empid,
    empname,
    hiredate,
    addr,
    tel,
    deptid
)
VALUES 
(
    20121729,
    '�̹���',
    TO_DATE('2011-03-02', 'YYYY-MM-DD'),
    '����',
    '010-3333-4444',
    '1001'
);

INSERT INTO employee
(
    empid,
    empname,
    hiredate,
    addr,
    tel,
    deptid
)
VALUES 
(
    20121646,
    '������',
    TO_DATE('2012-09-01', 'YYYY-MM-DD'),
    '�λ�',
    '010-1234-2222',
    '1003'
);

SELECT 
    empid,
    empname,
    hiredate,
    addr,
    tel,
    deptid,
    birthday
FROM   employee;


-- 9.
-- NOT NULL �������� �߰��� �ش� Į�� ������ NULL ������ �ȵ�
ALTER TABLE employee
MODIFY empname NOT NULL;


-- 10.
-- ��������, ���� �� �� ��밡�ɽ� ������ ���� ����
-- ǥ�� ���� ����(+ INNER JOIN, OUTER JOIN)
SELECT e.empname, 
       e.hiredate, 
       d.deptname 
FROM   employee e
       INNER JOIN department d
       ON (e.deptid = d.deptid)
WHERE  d.deptname = '�ѹ���';


-- 11.
DELETE employee
WHERE  addr = '�뱸';


-- 12.
UPDATE employee
SET    deptid = (SELECT deptid
                 FROM   department
                 WHERE  deptname = 'ȸ����')
WHERE  deptid = (SELECT deptid
                 FROM   department
                 WHERE  deptname = '������');


-- 13.
-- ��������: ���� ������ ��� ����
SELECT e.empid, 
       e.empname, 
       e.birthday, 
       d.deptname
FROM   employee e
       INNER JOIN department d
       ON (e.deptid = d.deptid)
WHERE  e.hiredate > (SELECT hiredate
                     FROM   employee
                     WHERE  empid = 20121729);


-- 14.
-- VIEW�� ALTER �Ұ���(���� ���̺� => ���� ������, ���� ����)
-- CREATE OR REPLACE VIEW: ���� ���� or ������� �� �˷���
-- => �� ������ �ǵ��� ����
-- �������� ���� ��Ī �ޱ�
CREATE OR REPLACE VIEW emp_vu
AS 
   SELECT e.empname ename,
          e.addr eaddr,
          d.deptname dname
   FROM   employee e
          INNER JOIN department d
          ON (e.deptid = d.deptid)
   WHERE  d.deptname = '�ѹ���';

SELECT ename,
       eaddr,
       dname
FROM   emp_vu;


-- �� ����¡
-- �������� 2�� �䱸(FROM�� ���� ����)
-- ��ü ��ȸ�� ORDER BY �ʼ�
-- �� SELECT �� ���� ����: 
-- (5) SELECT 
-- (1) FROM
-- (2) WHERE
-- (3) GROUP BY
-- (4) HAVING
-- (6) ORDER BY
SELECT b.*
FROM   (
        SELECT ROWNUM rn, a.*
        FROM   (
                SELECT   * 
                FROM     employees
                ORDER BY 1
               ) a
        ) b
WHERE rn > (1-1)*5 and rn <= 1*5;

COMMIT;