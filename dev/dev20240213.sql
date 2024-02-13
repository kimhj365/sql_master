-- 20240213
-- PL/SQL 수업 전 테스트

-- 1. 비식별자 관계

-- 2. HAVING절

-- 3. player 테이블 중 선수영문명의 두번째 글자가 'A'인 데이터의 선수명과 선수영문명 

-- 4. 3개

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
        , '총무팀'
        , '본101호'
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
        , '회계팀'
        , '본102호'
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
        , '영업팀'
        , '본103호'
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
        , '박민수'
        , '20120302'
        , '대구'
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
        , '박준식'
        , '20100901'
        , '경산'
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
        , '선아라'
        , '20120302'
        , '대구'
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
        , '이범수'
        , '20110302'
        , '서울'
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
        , '이융희'
        , '20120901'
        , '부산'
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
WHERE  d.deptname = '총무팀';


-- 11.
DELETE employee
WHERE  addr = '대구';


-- 12.
UPDATE employee
SET    deptid = (
                 SELECT deptid
                 FROM   department
                 WHERE  deptname = '회계팀'
                )
WHERE  deptid = (
                 SELECT deptid
                 FROM   department
                 WHERE  deptname = '영업팀'
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
   WHERE  d.deptname = '총무팀';

SELECT *
FROM   chongmu;