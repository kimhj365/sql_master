-- 20240213
-- PL/SQL ���� �� �׽�Ʈ

-- 1. ��ĺ��� ����

-- 2. HAVING��

-- 3. player ���̺� �� ������������ �ι�° ���ڰ� 'A'�� �������� ������� ���������� 

-- 4. 3��

-- 5. Inline View

-- 6.
CREATE TABLE department(
    deptid   NUMBER(10) NOT NULL,
    deptname VARCHAR2(10),
    location VARCHAR2(10),
    tel      VARCHAR2(15),
    PRIMARY KEY (deptid)
);

CREATE TABLE employee(
    empid    NUMBER(10) NOT NULL,
    empname  VARCHAR2(10),
    hiredate DATE,
    addr     VARCHAR2(12),
    tel      VARCHAR2(15),
    deptid   NUMBER(10),
    PRIMARY KEY (empid),
    FOREIGN KEY (deptid) REFERENCES department(deptid)
);

DESC department;

DESC employee;


-- 7.
ALTER TABLE employee
ADD birthday DATE;


-- 8.
INSERT INTO department
            (
              deptid
            , deptname
            , location
            , tel
            )
VALUES (
          1001
        , '�ѹ���'
        , '��101ȣ'
        , '053-777-8777'
);

INSERT INTO department
            (
              deptid
            , deptname
            , location
            , tel
            )
VALUES (
          1002
        , 'ȸ����'
        , '��102ȣ'
        , '053-888-9999'
);

INSERT INTO department
            (
              deptid
            , deptname
            , location
            , tel
            )
VALUES (
          1003
        , '������'
        , '��103ȣ'
        , '053-222-3333'
);

SELECT *
FROM   department;

INSERT INTO employee
            (
              empid
            , empname
            , hiredate
            , addr
            , tel
            , deptid
            )
VALUES (
          '20121945'
        , '�ڹμ�'
        , '20120302'
        , '�뱸'
        , '010-1111-1234'
        , '1001'
);

INSERT INTO employee
            (
              empid
            , empname
            , hiredate
            , addr
            , tel
            , deptid
            )
VALUES (
          '20101817'
        , '���ؽ�'
        , '20100901'
        , '���'
        , '010-2222-1234'
        , '1003'
);

INSERT INTO employee
            (
              empid
            , empname
            , hiredate
            , addr
            , tel
            , deptid
            )
VALUES (
          '20122245'
        , '���ƶ�'
        , '20120302'
        , '�뱸'
        , '010-3333-1222'
        , '1002'
);

INSERT INTO employee
            (
              empid
            , empname
            , hiredate
            , addr
            , tel
            , deptid
            )
VALUES (
          '20121729'
        , '�̹���'
        , '20110302'
        , '����'
        , '010-3333-4444'
        , '1001'
);

INSERT INTO employee
            (
              empid
            , empname
            , hiredate
            , addr
            , tel
            , deptid
            )
VALUES (
          '20121646'
        , '������'
        , '20120901'
        , '�λ�'
        , '010-1234-2222'
        , '1003'
);

SELECT *
FROM   employee;


-- 9.
ALTER TABLE employee
MODIFY empname NOT NULL;


-- 10.
SELECT e.empname, e.hiredate, d.deptname 
FROM   employee e
INNER JOIN   department d
ON     e.deptid = d.deptid
WHERE  d.deptname = '�ѹ���';


-- 11.
DELETE employee
WHERE  addr = '�뱸';


-- 12.
UPDATE employee
SET    deptid = (
                 SELECT deptid
                 FROM   department
                 WHERE  deptname = 'ȸ����'
                )
WHERE  deptid = (
                 SELECT deptid
                 FROM   department
                 WHERE  deptname = '������'
                );
      
                 
-- 13.
SELECT e.empid, e.empname, e.birthday, d.deptname
FROM   employee e
INNER JOIN   department d
ON     e.deptid = d.deptid
WHERE  e.hiredate > (
                     SELECT hiredate
                     FROM   employee
                     WHERE  empid = '20121729'
                    );
      
                     
-- 14.
CREATE VIEW chongmu
AS SELECT e.empname, e.addr, d.deptname
   FROM   employee e
   INNER JOIN   department d
   ON     e.deptid = d.deptid
   WHERE  d.deptname = '�ѹ���';

SELECT *
FROM   chongmu;