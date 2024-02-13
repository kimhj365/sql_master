-- 20240213
-- PL/SQL 수업 전 테스트

-- 1. 비식별자 관계

-- 2. HAVING절

-- 3. player 테이블 중 선수영문명의 두번째 글자가 'A'인 데이터의 선수명과 선수영문명 

-- 4. 최소 3개 (그 이상 가능)

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
-- 제약조건(NOT NULL 빼고) 수정 불가 => DROP-ADD


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
    '총무팀',
    '본101호',
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
    '회계팀',
    '본102호',
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
    '영업팀',
    '본103호',
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
    '박민수',
    TO_DATE('2012-03-02', 'YYYY-MM-DD'),
    '대구',
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
    '박준식',
    TO_DATE('2010-09-01', 'YYYY-MM-DD'),
    '경산',
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
    '선아라',
    TO_DATE('2012-03-02', 'YYYY-MM-DD'),
    '대구',
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
    '이범수',
    TO_DATE('2011-03-02', 'YYYY-MM-DD'),
    '서울',
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
    '이융희',
    TO_DATE('2012-09-01', 'YYYY-MM-DD'),
    '부산',
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
-- NOT NULL 제약조건 추가시 해당 칼럼 데이터 NULL 있으면 안됨
ALTER TABLE employee
MODIFY empname NOT NULL;


-- 10.
-- 서브쿼리, 조인 둘 다 사용가능시 조인이 성능 좋음
-- 표준 조인 숙지(+ INNER JOIN, OUTER JOIN)
SELECT e.empname, 
       e.hiredate, 
       d.deptname 
FROM   employee e
       INNER JOIN department d
       ON (e.deptid = d.deptid)
WHERE  d.deptname = '총무팀';


-- 11.
DELETE employee
WHERE  addr = '대구';


-- 12.
UPDATE employee
SET    deptid = (SELECT deptid
                 FROM   department
                 WHERE  deptname = '회계팀')
WHERE  deptid = (SELECT deptid
                 FROM   department
                 WHERE  deptname = '영업팀');


-- 13.
-- 서브쿼리: 여러 절에서 사용 가능
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
-- VIEW는 ALTER 불가능(논리적 테이블 => 실제 데이터, 구조 없음)
-- CREATE OR REPLACE VIEW: 새로 생성 or 덮어쓰는지 안 알려줌
-- => 원 데이터 건들지 말기
-- 서브쿼리 사용시 별칭 달기
CREATE OR REPLACE VIEW emp_vu
AS 
   SELECT e.empname ename,
          e.addr eaddr,
          d.deptname dname
   FROM   employee e
          INNER JOIN department d
          ON (e.deptid = d.deptid)
   WHERE  d.deptname = '총무팀';

SELECT ename,
       eaddr,
       dname
FROM   emp_vu;


-- ※ 페이징
-- 서브쿼리 2번 요구(FROM절 먼저 실행)
-- 전체 조회시 ORDER BY 필수
-- ※ SELECT 문 실행 순서: 
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