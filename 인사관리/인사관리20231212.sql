DESC   employees;

SELECT *
FROM   employees;

--<서브쿼리>
-- ※ sql_labs의 cre_empl, cre_hrdata 파일 열어서 스크립트 실행 후 실습
-- ※ sales_reps 파일 열어서 스크립트 실행 후 실습

--2. 다중행 서브쿼리
--여러행 반환하는 서브쿼리
--다중행 연산자 사용: IN, ANY, SOME

--ANY: 값을 서브퀴리 반환값 각각과 비교(OR)
--ALL: 값을 서브퀴리 반환값 모두와 비교(AND)

-- < ANY : 리턴값들 중 최대값보다 작은 데이터
--ex. 리턴값 : 9000, 6000, 4200 => 9000보다 작은 salary
SELECT employee_id, last_name, job_id, salary
FROM   employees
WHERE  salary < ANY (SELECT salary
                     FROM   employees
                     WHERE  job_id = 'IT_PROG')
AND    job_id <> 'IT_PROG';

-- < ALL : 리턴값들 중 최소값보다 작은 데이터
--ex. 리턴값 : 9000, 6000, 4200 => 4200보다 작은 salary
SELECT employee_id, last_name, job_id, salary
FROM   employees
WHERE  salary < ALL (SELECT salary
                     FROM   employees
                     WHERE  job_id = 'IT_PROG')
AND    job_id <> 'IT_PROG';


--3. 다중열 서브쿼리

--(1)Nonpairwise Comparison(비-쌍비교)
--   : 논리 연산자 사용(AND, OR, ...) => 혼합 WHERE절로 결합
SELECT manager_id, department_id
FROM   empl_demo
WHERE  first_name = 'John';
--이름이 'John'인 사람 : 3명

SELECT employee_id, manager_id, department_id
FROM   empl_demo
WHERE  manager_id IN   (SELECT manager_id
                        FROM   empl_demo
                        WHERE  first_name = 'John')
AND    department_id IN (SELECT department_id
                        FROM   empl_demo
                        WHERE  first_name = 'John')
AND    first_name <> 'John';
-- => 3명의 매니저번호, 부서번호를 조합한 순서쌍 9개의 경우 가져옴(3^2)
-- => (108, 123, 100) * (100, 50, 80)의 모든 조합

--(2)Pairwise Comparison(쌍비교)
--   : 다중열 서브쿼리 사용 => 단일 WHERE절로 결합
SELECT employee_id, manager_id, department_id
FROM   empl_demo
WHERE  (manager_id, department_id) IN
                    (SELECT manager_id, department_id
                     FROM   empl_demo
                     WHERE  first_name = 'John')
AND    first_name <> 'John';
-- 3명의 (매니저번호, 부서번호) 순서쌍 3개 경우만 가져옴
-- => (108, 100), (123, 50), (100, 80)


--<데이터 조작어 DML>
--DML문 : INSERT / DELETE / UPDATE => Transaction

--1. INSERT 구문
--테이블에 새 행 추가(★한번에 하나의 행만 추가)
--문자, 날짜 값 : ' '로 묶음

--ex. departments 테이블에 370 데이터 하나 추가

SELECT *
FROM   departments;

INSERT INTO departments
           (department_id, department_name, manager_id, location_id)
VALUES     (370, 'Public Relations', 100, 1700);

--모든 칼럼에 값 입력할 때는 칼럼명 안적어도 됨
INSERT INTO departments
VALUES     (371, 'Public Relations', 100, 1700);

--특정 칼럼에만 값 입력할때는 칼럼명 반드시 기입
--입력되지 않은 칼럼에는 NULL값(암시적 NULL)
INSERT INTO departments
           (department_id, department_name)
VALUES     (330, 'Purchasing');

--NULL값 키워드 지정 가능(명시적 NULL)
--주의: 'NULL' 아님
INSERT INTO departments
VALUES     (400, 'Finance', NULL, NULL);

--문자열의 경우 ''으로 NULL값 명시적 지정 가능
--주의: ' '(space) 아님
INSERT INTO departments
VALUES     (100, 'Finance', '', '');

--함수 사용해서 값 입력(SYSDATE)
SELECT *
FROM   employees;

INSERT INTO employees
VALUES      (113, 'Louis', 'Popp', 'LPOPP', '515.124.4567',
             SYSDATE, 'AC_ACCOUNT', 6900, NULL, 205, 110);

--날짜 형식 맞춰서 입력(TO_DATE)
INSERT INTO employees
VALUES     (114, 'Den', 'Raphaely', 'DRAPHAEL', '515.127.4561', 
            TO_DATE('FEB 3, 1999', 'MON DD, YYYY'),
            'SA_REP', 11000, 0.2, 100, 60);

--치환변수 &으로 값 입력받아서 추가 가능
INSERT INTO departments
           (department_id, department_name, location_id)
VALUES     (&department_id, '&department_name', &location);

--sales_reps 파일: 데이터 없는 테이블 2개 생성
SELECT *
FROM   sales_reps;

SELECT *
FROM   copy_emp;

--SELECT문 쿼리 리턴 결과를 데이터로 추가
INSERT INTO sales_reps
            SELECT employee_id, last_name, salary, commission_pct
            FROM   employees
            WHERE  job_id LIKE '%REP%';

--테이블 전체를 복사
INSERT INTO copy_emp
            SELECT *
            FROM   employees;

--주요 오류 1: 기본키 조건 위배
INSERT INTO departments(department_id, department_name)
VALUES      ('YEDAM');
--기본키 NULL값 오류

INSERT INTO departments(department_id, department_name)
VALUES      (10, 'YEDAM');
--기본키 중복값 오류

INSERT INTO departments(department_id, department_name)
VALUES      (120, 'YEDAM');
--기본키 중복값, 널값X => 정상 추가

--주요 오류 2: NOT NULL 제약조건 위배
INSERT INTO departments(department_id)
VALUES      (130);
--department_id는 NOT NULL 제약조건 걸려있는 칼럼
-- => NULL값 입력시 오류

--주요 오류 3: 외래키 참조 오류
INSERT INTO departments(department_id, department_name, manager_id)
VALUES      (130, 'YD', 1);
--외래키 manager_id는 employees 테이블의 employee_id 칼럼 참조
-- => employee_id 칼럼에 없는 manager_id 입력 시 오류

--2. UPDATE 구문
-- : 테이블의 기존 데이터 변경
--   한번에 여러개 행 갱신 가능
--   WHERE절 조건으로 특정 행 지정해 변경(생략시 모든 행이 수정됨)

UPDATE employees
set    department_id = 50
WHERE  employee_id = 113;

SELECT *
FROM   employees;

--주의 : WHERE절 생략시 모든 행이 수정됨
UPDATE copy_emp
SET    department_id = 110;

SELECT *
FROM   copy_emp;

--여러 개의 데이터 수정: SET expr1, expr2, ...
UPDATE employees
SET    job_id = 'IT_PROG',
       commission_pct = NULL
WHERE  employee_id = 114;

--Transcation
--DML문으로 작업한거 취소
ROLLBACK;

--3. DELETE
--WHERE절 지정하여 특정 행 삭제
--★★주의 : WHERE절 지정 안하면 테이블의 모든 행 삭제됨

--참조하고 있는 테이블이 있으면 삭제 안됨
DELETE employees;

SELECT *
FROM   employees;

--빈 테이블에 복사해서 실습
INSERT INTO copy_emp
            SELECT *
            FROM   employees;

--현재 상황 저장
COMMIT;            

--테이블 전체 삭제
DELETE copy_emp;

SELECT *
FROM   copy_emp;

--롤백하면 COMMIT한 시점으로 돌아감
ROLLBACK;

--WHERE절로 조건 지정해 삭제
DELETE FROM departments
WHERE  department_name = 'Finance';

SELECT *
FROM   departments;

--비교연산자를 활용한 삭제
DELETE departments
WHERE  department_id IN (30, 40);

ROLLBACK;

--DDL 명령어로 데이터 삭제하면 롤백으로 복구 불가능
TRUNCATE TABLE copy_emp;

ROLLBACK;

SELECT *
FROM   copy_emp;

--sql07 문제--------------------------------------------------------------------

--1. Zlotkey와 동일한 부서에 속한 모든 사원의 
--   이름과 입사일을 표시하는 질의를 작성하시오. 
--   Zlotkey는 결과에서 제외하시오.
SELECT last_name, hire_date
FROM   employees
WHERE  department_id = (SELECT department_id
                        FROM   employees
                        WHERE  LOWER(last_name) = 'zlotkey')
AND LOWER(last_name) != 'zlotkey';

--2. 급여가 평균 급여보다 많은 모든 사원의 
--   사원 번호와 이름을 표시하는 질의를 작성하고 
--   결과를 급여에 대해 오름차순으로 정렬하시오.
SELECT   employee_id, last_name
FROM     employees
WHERE    salary > (SELECT AVG(salary)
                   FROM   employees)
ORDER BY salary;

--3. 이름에 u가 포함된 사원과 같은 부서에서 일하는 
--   모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고 
--   질의를 실행하시오.
SELECT employee_id, last_name
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   employees
                         WHERE  LOWER(last_name) LIKE '%u%');
--서브쿼리 결과 : 50, 60 => 다중행 서브쿼리

--4. 부서 위치 ID(location_id)가 1700인 
--   모든 사원의 이름, 부서 번호 및 업무 ID를 표시하시오.
SELECT *
FROM   departments;

SELECT *
FROM   employees;

SELECT last_name, department_id, job_id
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   departments
                         WHERE  location_id = 1700);

--5. King에게 보고하는(manager가 King) 
--   모든 사원의 이름과 급여를 표시하시오.
SELECT last_name, salary
FROM   employees
WHERE  manager_id = (SELECT employee_id
                     FROM   employees
                     WHERE  LOWER(last_name) = 'king');

--6. Executive 부서의 모든 사원에 대한 
--   부서 번호, 이름 및 업무 ID를 표시하시오.
SELECT department_id, last_name, job_id
FROM   employees
WHERE  department_id = (SELECT department_id
                        FROM   departments
                        WHERE  LOWER(department_name) = 'executive');

--7. 평균 급여보다 많은 급여를 받고 이름에 u가 포함된 사원과 
--   같은 부서에서 근무하는 모든 사원의 사원 번호, 이름 및 급여를 표시하시오.
SELECT employee_id, last_name, salary
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   employees
                         WHERE  salary > (SELECT avg(salary)
                                         FROM   employees)
                         AND    LOWER(last_name) LIKE '%u%');

--------------------------------------------------------------------------------

--sql08 문제--------------------------------------------------------------------

--1. 다음과 같이 실습에 사용할 MY_EMPLOYEE 테이블을 생성하시오.
CREATE TABLE my_employee
  (id         NUMBER(4) NOT NULL,
   last_name  VARCHAR2(25),
   first_name VARCHAR2(25),
   userid     VARCHAR2(8),
   salary     NUMBER(9,2));

--2. MY_EMPLOYEE 테이블의 구조를 표시하여 열 이름을 식별하시오.
DESC my_employee;

--3. 다음 예제 데이터를 MY_EMPLOYEE 테이블에 추가하시오.
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

--4. 테이블에 추가한 항목을 확인하시오.
SELECT *
FROM   my_employee;

--6. 사원 3의 성을 Drexler로 변경하시오.
UPDATE my_employee
SET    last_name = 'Drexler'
WHERE  id = 3;

--7. 급여가 900 미만인 모든 사원의 급여를 1000으로 변경하고 
--   테이블의 변경 내용을 확인하시오.
UPDATE my_employee
SET    salary = 1000
WHERE  salary < 900;

SELECT *
FROM   my_employee;

--8. MY_EMPLOYEE 테이블에서 사원 3을 삭제하고 테이블의 변경 내용을 확인하시오.
DELETE my_employee
WHERE  id = 3;

SELECT *
FROM   my_employee;

--11. 테이블의 내용을 모두 삭제하고 테이블 내용이 비어 있는지 확인하시오.
DELETE my_employee;             --DML
--TRUNCATE TABLE my_employee;   --DDL

SELECT *
FROM   my_employee;

--------------------------------------------------------------------------------

--<트랜잭션 제어(Transaction Control Language, TCL)>
--트랜젝션 : 데이터 변경 시 융통성 및 제어 기능, 에러시 데이터 일관성 보장
--세션(Session) : 로그인 후 부터 로그아웃 전까지
--                여러 개의 트랜젝션으로 구성됨

--트랜잭션 시작 : 실행 가능한 첫번째 SQL문 실행 시
--트랜젝션 종료 : 
--   커밋 / 롤백 시
--   DDL, DCL 문장 실행 시(자동 커밋)
--   사용자 종료
--   시스템 crash(자동 롤백)

--TCL : 각각의 트랜잭션 관리하는 명령어
--(1)COMMIT : 데이터 변경사항 커밋, 현재 트랜잭션 종료
--(2)SAVEPOINT : 트랜잭션 내에서 롤백 지점 지정(중간 저장 지점)
--(3)ROLLBACK : 데이터 변경사항 모두 되돌림, 현재 트랜잭션 종료

--1. 커밋/롤백 전 : 
--데이터 복구 가능
--현재 사용자 SELECT문으로 DML 작업 가능
--행 잠김 => 다른 사용자가 변경사항 보거나 조작 불가
COMMIT;

UPDATE employees
SET    salary = 99999
WHERE  employee_id = 176;

SELECT *
FROM   employees
WHERE  employee_id = 176;

--2. 커밋 이후 : 
--변경내용 DB에 영구 저장 = > 이전 상태 상실, SAVEPOINT 제거
--행 잠금 풀림 => 다른 사용자가 보고 변경 가능
COMMIT;

--DDL은 문장 하나하나가 트랜잭션 => 자동 커밋
TRUNCATE TABLE aa;

--3. 롤백 이후 : 
--데이터 변경 취소, 이전 상태 복구
--행 잠금 풀림


--<데이터 정의어(Data Definition Language, DDL)>
--<DDL - 객체 수정>

--테이블
--사용자 테이블: 사용자가 생성, 관리
--데이터 딕셔너리: 오라클 서버가 생성, 관리
SELECT table_name
FROM   user_tables;

SELECT DISTINCT object_type
FROM   user_objects;

SELECT *
FROM   user_catalog;
-- => 데이터 딕셔너리 질의

--CREATE TABLE문 : 테이블 생성
--스키마: 사용자 계정명
CREATE TABLE hire_dates
       (id        NUMBER(8),
        hire_date DATE DEFAULT SYSDATE);

--DEFAULT값 지정(명시적 NULL값 지정 가능)
INSERT INTO hire_dates
           (id)
VALUES     (35);

SELECT *
FROM   hire_dates;

INSERT INTO hire_dates
VALUES     (45, NULL);

--테이블 생성
CREATE TABLE dept
            (deptno      NUMBER(2),
             dname       VARCHAR2(14),
             loc         VARCHAR2(13),
             create_date DATE DEFAULT SYSDATE);
             
SELECT *
FROM   dept;

--데이터 딕셔너리: 사용자가 생성한 테이블 보여줌
SELECT table_name
FROM   user_tables;

--서브쿼리 이용한 테이블 생성
--ex. 부서번호가 80인 사원들 테이블 생성
--주의: 칼럼 이름에 수식 있으면 생성 안됨 => 칼럼 Alias 설정 필수
CREATE TABLE dept80
     AS
        SELECT employee_id, last_name,
               salary*12 ANNSAL, hire_date
        FROM   employees
        WHERE  department_id = 80;

SELECT *
FROM   dept80;

--<DDL - 객체 수정>
--ALTER TABLE : 객체 수정 DDL
--1. ADD : 열(칼럼) 추가

--추가된 칼럼의 행 => 널값
ALTER TABLE dept80
ADD        (job_id VARCHAR2(9));

--추가된 열의 행값 DEFAULT값 지정 가능
ALTER TABLE dept80
ADD        (hdate DATE DEFAULT SYSDATE);

--2. MODIFY : 칼럼 수정
ALTER TABLE dept80
MODIFY     (last_name VARCHAR2(30));

--데이터 크기 조정 가능
--증가는 제약 없음, 감소는 기존 데이터 길이 까지만
ALTER TABLE dept80
MODIFY     (last_name VARCHAR2(10));

ALTER TABLE dept80
MODIFY     (last_name VARCHAR2(5)); -- => 오류

--데이터 타입 변경 가능(널값만 있을때만)
ALTER TABLE dept80
MODIFY      (job_id NUMBER(15));

--이미 데이터가 있으면 타입 변경 불가능
ALTER TABLE dept80
MODIFY      (last_name NUMBER(15));

--3. DROP: 열 삭제
--데이터 포함해도 삭제가능
--칼럼 삭제한 후 최소 한개의 칼럼 남아있어야 함(하나도 없으면 테이블 삭제되니까)
--주의: 삭제 여부 한번 더 안물어봄 / 삭제된 열 복구 불가능
ALTER TABLE dept80
DROP       (job_id);

--4. SET UNUSED: 열 사용안함(실제로 제거는 X)
--칼럼에 블라인드 치는 것 => 근데 다시 복구 못함(= DROP)
--쓰는 이유: 사용자 많을때 미리 막아두고 사용자 적을때 바로 삭제할 수 있게
ALTER TABLE   dept80
SET   UNUSED (last_name);

--DROP UNUSED COLUMNS: UNUSED된 칼럼 한번에 다 제거
ALTER TABLE dept80
DROP UNUSED COLUMNS;

--<기타 데이터 정의어>
--1. DROP TABLE: 테이블 삭제
--뷰, 시노님 : 있지만 사용 불가 / 인덱스 : 같이 삭제됨
--트랜잭션 모두 커밋됨
--주의: 재차 확인 없이 바로 삭제 / 복구(ROLLBACK) 불가능
DROP TABLE dept80;

--오라클 휴지통 기능: 테이블 삭제시 휴지통 기능 제공
SELECT object_name, original_name, type
FROM   user_recyclebin;

--FLASHBACK TABLE: DROP 전 상태로 테이블 복구
FLASHBACK TABLE dept80 TO BEFORE DROP;

SELECT *
FROM   dept80;

--DROP TABLE ~ PURGE: 완전삭제(휴지통으로 복구 불가능) => 쓰지마
DROP TABLE dept80 PURGE;

--PURGE RECYCLEBIN: 휴지통 비우기 => 쓰지마

--2. RENAME: 객체 이름 변경
RENAME dept TO dept80;

SELECT *
FROM   dept80;

--3. TRUNCATE: 테이블 절삭
--테이블의 모든 행 제거 / 롤백 불가능
TRUNCATE TABLE dept80;

--4. COMMENT: 주석달기
--테이블/열에 주석 추가