--<제약 조건>
--제약조건 : 데이터 일관성 유지위한 조건
--           종속성 존재하는 테이블 삭제 방지
--(2)UNIQUE : 고유한 값
--(3)PRIMARY KEY : 기본키, 테이블의 행 고유하게 식별(널X, 중복X)
--(4)FOREIGN KEY : 외래키, 다른 테이블 기본키 참조
--(5)CHECK : 참(TRUE)여야하는 조건 지정
--=> NOT NULL, 기본키 빼고 널값 지정 가능

--팁: 테이블 조건 최소화하기

--열 레벨: 모든 무결성 제약조건 유형 정의 가능
--테이블 레벨: NOT NULL 지정 불가

--1. NOT NULL : 
--   널값 X, 열 레벨에서만 지정 가능(테이블 레벨X)
 CREATE TABLE emp_test (
        empid     NUMBER(5),
        empname   VARCHAR2(10) NOT NULL,
        duty      VARCHAR2(9),
        sal       NUMBER(7, 2),
        bonus     NUMBER(7, 2),
        mgr       NUMBER(5),
        hire_date DATE,
        deptid    NUMBER(2));

--NOT NULL 조건 열에 NULL 지정시 오류
INSERT INTO emp_test(empid, empname)
VALUES      (10, NULL);

INSERT INTO emp_test(empid, empname)
VALUES      (10, 'YD');

SELECT *
FROM   emp_test;

--2. UNIQUE :
--   열/열 집합의 모든 값이 고유하게 함 => 열 2개 이상에 지정 가능(복합키)
--   UNIQUE에도 NULL값 지정 가능
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

--★★★3. 기본키(Primary Key)
--UNIQUE(고유함) + NOT NULL(널값X)
--유일성O + 최소성O => 후보키(Candidate Key)
--유일성O + 최소성X => 슈퍼키(Super Key)
--후보키 중에 기본키 선택 / 선택안된 후보키 => 대체키(Alternate Key)

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

--기본키 고유값X 오류
INSERT INTO dept_test
VALUES     (20, 'YD2', 'Daegu');

--기본키 널값 오류
INSERT INTO dept_test
VALUES     (NULL, 'YD3', 'Daegu'); 

SELECT *
FROM   dept_test;

--4. 외래키(FOREIGN KEY)
--열/열조합 외래키 지정
--동일 테이블/다른 테이블의 기본키/고유키와 관계설정
--부모 테이블의 기본 값과 일치/NULL
DROP TABLE emp_test;

--(1)테이블 레벨의 FOREIGN KEY 지정
--외래키는 어느 테이블의 어느 칼럼 참조하는지 적어줘야 함(REFERENCES)
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
        
--(2)칼럼 레벨의 FOREIGN KEY 지정
--FOREIGN KEY 빠지고 REFERENCES 부터 기입
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

--외래키에 NULL값 지정 가능
INSERT INTO emp_test(empid, empname, deptid)
VALUES     (200, 'YD2', NULL);

--부모 테이블의 참조하는 칼럼에 값 없으면 오류
INSERT INTO emp_test(empid, empname, deptid)
VALUES     (300, 'YD3', 30);

--외래키 옵션 키워드
--ON DELETE CASCADE: 부모테이블 삭제 => 자식테이블의 종속행 삭제
--ON DELETE SET NULL: 부모테이블 삭제 => 자식테이블의 종속행 NULL값
-- => 둘 다 쓰지마 : 데이터 일관성, 무결성 지켜야해서
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

--부모 테이블의 행 삭제 => 자식 테이블의 참조하는 행 NULL값으로 변환
DELETE dept_test
WHERE  deptid = 10;

SELECT *
FROM   dept_test;

--5. CHECK 제약조건
--   : 위의 조건 말고 나머지 조건 지정하고 싶을때

DROP TABLE emp_test;

--테이블 레벨의 CHECK
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
        
--칼럼 레벨의 CHECK
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
        
--<제약조건 수정>
--이미 만들어 놓은 테이블에 제약조건 지정하는 방법

--1. 제약조건 추가
--(1)ALTER TABLE + ADD : 테이블 레벨의 제약조건
--기본키 지정
ALTER TABLE emp_test
ADD         PRIMARY KEY(empid);

--참조 테이블에 기본키 있어야 외래키 지정 가능
ALTER TABLE emp_test
ADD         FOREIGN KEY(mgr) REFERENCES emp_test(empid);

--(2)ALTER TABLE + MODIFY : 칼럼 레벨의 제약조건
--ex. NOT NULL 조건은 무조건 칼럼레벨(but 기존 데이터에 널값 없어야함)
ALTER TABLE emp_test
MODIFY     (duty NOT NULL);

--2. 제약조건 삭제
--ALTER TABLE + DROP 제약조건 이름
--제약조건 이름 찾는 뷰 이용해 확인해서 삭제해야함
SELECT constraint_name, constraint_type,
       search_condition
FROM   user_constraints;

SELECT constraint_name, column_name
FROM   user_cons_columns;

DESC   user_cons_columns;

SELECT constraint_name, table_name, column_name
FROM   user_cons_columns
WHERE  table_name = 'EMP_TEST';
-- mgr 칼럼 제약조건 => SYS_C007024

--SYS_C007024 제약조건 삭제
ALTER TABLE emp_test
DROP  CONSTRAINT SYS_C007024;

--3. 제약조건 비활성화
--ALTER TABLBE + DISABLE : 비활성화
--ALTER TABLBE + ENABLE  : 활성화   
-- ==> 안씀

--<뷰(View)>
--뷰: 논리 테이블(실제 테이블X)/ 원본데이터를 보는 방법 지정
--사용 목적 :  접근 제어, 쿼리 간소화, 데이터 독립성 등

--뷰 생성 : CREATE VIEW ~ AS ~
--서브쿼리에 있는 내용 = 뷰
CREATE VIEW empvu80
    AS SELECT employee_id, last_name, salary
       FROM employees
       WHERE department_id = 90;

--테이블처럼 내용 조회 할 수 있음
SELECT *
FROm   empvu80;

--뷰 정의하는 서브쿼리에 복합 SELECT 구문 사용가능(조인, 그룹, 서브쿼리 등)
--BUT 서브쿼리에 ORDER BY 지정 불가
--뷰는 ALTER 명령어로 수정불가 => OR REPLACE로 덮어써야 함(대체)
--뷰의 칼럼에 alias 지정 가능 / 칼럼명에 수식들어가면 무조건 alias 지정해야함

--칼럼 alias 생성 방법 1
CREATE VIEW salvu50
    AS SELECT employee_id ID_NUMBER, last_name NAME,
              salary*12 ANN_SALARY
       FROM   employees
       WHERE  department_id = 50;

--칼럼 alias 생성 방법 2
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

--복잡한 쿼리문 뷰로 만들어서 간단히 조회 가능
CREATE OR REPLACE VIEW dept_sum_vu(name, minsal, maxsal, avgsal)
    AS SELECT   d.department_name, 
                MIN(e.salary), MAX(e.salary), AVG(e.salary)
       FROM     employees e JOIN departments d
       ON       (e.department_id = d.department_id)
       GROUP BY d.department_name;

SELECT *
FROM   dept_sum_vu;

--★★★뷰 통해서도 DML문 조작가능 => 원본 데이터 조작(예외 있음)
--DELETE 불가능한 경우 : 그룹함수, GROUP BY절(원본데이터 가져오니까), 
--                      DINTINCT, ROWNUM 키워드 있는 뷰

SELECT ROWNUM employee_id
FROM   employees;

--UPDATE 불가능한 경우 : (+) 표현식으로 정의 된 열
--INSERT 불가능한 경우 : (+) NOT NULL 제약조건

COMMIT;

SELECT *
FROM   empvu80;

--뷰를 통한 삭제 => 원본 테이블의 데이터도 삭제됨
DELETE empvu80
WHERE  id_number = 176;

SELECT *
FROM   empvu80;

SELECT *
FROM   employees;

SELECT *
FROM   dept_sum_vu;

--뷰 데이터에 그룹함수 있으면 삭제 불가능
DELETE dept_sum_vu
WHERE  name = 'IT';

CREATE VIEW test_vu
    AS SELECT department_name
       FROM   departments;
       
SELECT *
FROM   test_vu;

--NOT NULL 제약조건 있는 데이터 삭제 불가능
INSERT INTO test_vu
VALUES      ('YD');

--뷰 삭제: DROP VIEW;

--<인덱스>
--포인터 사용 => 검색속도 향상
--테이블 삭제시 인덱스도 같이 삭제됨

--인덱스 생성
--자동 : PRIMARY KEY, UNIQUE 조건 지정시
--수동 : CREATE INDEX ~ ON ~

--인덱스 생성해야 할 경우
--(1)열이 WHERE절, 조인 조건에서 자주 사용될 때
--(2)열에 광범위한 값이 포함된 경우
--(3)NULL값이 많은 열 등

--인덱스 생성하면 안되는 경우
-- : 테이블이 자주 갱신되는 경우
--   (현재 시점의 데이터로 인덱스 만들기 때문) => 그래서 잘 안씀

--<시퀀스>
--오라클 DB에서 자동번호 넘버링 할때 씀
--기본키값 생성할 때 사용
CREATE SEQUENCE dept_deptid_seq
                INCREMENT BY 10     
                START WITH 120
                MAXVALUE 9999
                NOCACHE
                NOCYCLE;           --최대값 찍고 다시 돌아옴

--NEXTVAL : 사용가능한 다음 시퀀스 값
--CURRVAL : 현재 시퀀스 값
INSERT INTO departments
            (department_id, department_name, location_id)
VALUES      (dept_deptid_seq.NEXTVAL, 'Support', 2500);

SELECT *
FROM   departments;

--롤백 후에도 넘버링 유지됨 => GAP 발생
ROLLBACK;

SELECT *
FROM   departments;

--현재 시퀀스 값 조회
SELECT dept_deptid_seq.CURRVAL
FROM   dual;

--시퀀스 수정 : ALTER SEQUENCE
--시퀀스 삭제 : DROP SEQUENCE

--<동의어(Synonym)>
--원본 그대로 있고 또 다른 이름을 만들어 주는 것
--동의어 추가 : CREATE SYNONYM ~ FOR ~
CREATE SYNONYM d_sum
FOR    dept_sum_vu;

SELECT *
FROM   d_sum;

SELECT *
FROM   dept_sum_vu;


--<데이터 제어(DCL)>
--시스템 권한: DB에 액세스 가능

--시스템 권한 확인
SELECT *
FROM system_privilege_map;

--사용자 계정 생성: CREATE USER => 관리자 계정에서 생성

--객체 권한: DB 객체 내용 조작 가능
--객체 권한 부여 : CREATE SELECT ~ ON ~
--객체 권한 철회 : REVOKE ~ ON ~ FROM ~

--계층적 질의
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
