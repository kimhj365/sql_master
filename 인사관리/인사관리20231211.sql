--<그룹 함수>

--그룹함수 : 행들의 집합 연산 => 하나의 결과 반환
--SUM : 합계
--AVG : 평균
--COUNT : 행의 갯수
--   COUNT(*) : NULL값 포함 (나머지 함수 NULL 무시)
--   COUNT(DISTINCT ~) : NULL값 제외
--MAX : 최대값
--MIN : 최소값
--=> NULL 값 주의(특히 AVG)

SELECT AVG(salary), MAX(salary), 
       MIN(salary), SUM(salary)
FROM   employees
WHERE  job_id LIKE '%REP%';

--MAX, MIN : (문자, 날짜 O)
--MIN : 빠른 날짜 / MAX : 느린 날짜 
SELECT MIN(hire_date), MAX(hire_date)
FROM   employees;

--MIN : 앞 문자 / MAX : 뒷 문자 
SELECT MIN(last_name), MAX(last_name)
FROM   employees;

--COUNT(*) : 행의 갯수(NULL 포함)
SELECT COUNT(*)
FROM   employees;

SELECT COUNT(*)
FROM   employees
WHERE  department_id = 50;

--COUNT(expr) : 행의 갯수(NULL 제외)
SELECT COUNT(commission_pct)
FROM   employees
WHERE  department_id = 80;

--DISTINCT : 중복값 제외
SELECT COUNT(DISTINCT department_id),
       COUNT(department_id) --106명 => 1명 NULL값 무시
FROM   employees;

SELECT DISTINCT department_id
FROM   employees;

--NVL : AVG이 NULL값 포함하도록 지정
SELECT AVG(NVL(commission_pct, 0)), --=>널값 포함(0으로 지정)
       AVG(commission_pct)          --=>널값 제외
FROM   employees;

--<데이터 그룹화(GROUP BY)>
--테이블 정보를 더 작은 그룹으로 나누기

--SELECT절에서 그룹함수 안에 없는열 => 반드시 GROUP BY절에 포함(필수)
SELECT   department_id, AVG(salary)
FROM     employees
GROUP BY department_id;
--SELECT절의 department_id열은 그룹함수(AVG) 안에 없음
-- => ★★★GROUP BY절에 반드시 넣어줘야함

--★★★GROUP BY 절에 있는 열 목록은 SELECT절에 안와도 됨(선택)
SELECT   AVG(salary)
FROM     employees
GROUP BY department_id;
--salary : GROUP BY 절에 없어도 됨

--GROUP BY절에 2개 이상 열 넣어도 됨
SELECT   department_id, job_id, SUM(salary)
FROM     employees
GROUP BY department_id, job_id
ORDER BY job_id;
--department_id(1차 그룹) => job_id(2차 그룹)

--GROUP BY + WHERE절 가능
SELECT   department_id, job_id, SUM(salary)
FROM     employees
WHERE    department_id > 40
GROUP BY department_id, job_id
ORDER BY department_id;

--그룹함수 + WHERE절 불가능(오류)
--WHERE절 : 원본 데이터를 가져옴 => 그룹 함수로 제한된 데이터 없음
--그룹 제한 위해서는 HAVING 절 사용

--<HAVING 절>
--WHERE 절과 같은 방식으로 표시할 그룹을 제한
--HAVING절은 반드시 GROUP BY절을 써야 사용가능 
SELECT   department_id, MAX(salary)
FROM     employees
GROUP BY department_id
HAVING   MAX(salary) > 10000;

--종합
SELECT   job_id, SUM(salary) PAYROLL
FROM     employees
WHERE    job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING   SUM(salary) > 13000
ORDER BY SUM(salary); -- / 2 / PAYROLL

--그룹함수 중첩
--그룹함수끼리는 2번까지 밖에 중첩 불가
--그룹함수끼리 중첩시에는 SELECT절에 일반 칼럼 올 수 없음
--ex. SELECT department_id, MAX(AVG(salary)) => 오류
SELECT   MAX(AVG(salary))
FROM     employees
GROUP BY department_id;

--sql05 문제----------------------------------

--다음 세 문장의 유효성을 판별하여 True 또는 False로 답하시오.
--1. 그룹 함수는 여러 행에 적용되어 그룹 당 하나의 결과를 출력한다.  => TRUE
--2. 그룹 함수는 계산에 널을 포함한다.                               => FALSE
--3. WHERE 절은 그룹 계산에 행(row)을 포함시키기 전에 행을 제한한다. => TRUE

--4. 모든 사원의 급여 최고액, 최저액, 총액 및 평균액을 표시하시오. 
--   열 레이블을 각각 Maximum, Minimum, Sum 및 Average로 지정하고 
--   결과를 정수로 반올림하도록 작성하시오.
SELECT ROUND(MAX(salary)) "Maximum", 
       ROUND(MIN(salary)) "Minimum",
       ROUND(SUM(salary)) "Sum",
       ROUND(AVG(salary)) "Average"
FROM   employees;

--5. 위의 질의를 수정하여 각 업무 유형(job_id)별로 
--   급여 최고액, 최저액, 총액 및 평균액을 표시하시오. 
SELECT   job_id,
         ROUND(MAX(salary)) "Maximum",
         ROUND(MIN(salary)) "Minimum",
         ROUND(SUM(salary)) "Sum",
         ROUND(AVG(salary)) "Average"
FROM     employees
GROUP BY job_id;

--6. 업무별 사원 수를 표시하는 질의를 작성하시오.
SELECT   job_id, COUNT(*) --COUNT 안에 기본키 넣어도 됨
FROM     employees
GROUP BY job_id;

--7. 관리자 수를 확인하시오. 열 레이블은 Number of Managers로 지정하시오. 
--   (힌트: MANAGER_ID 열을 사용)
SELECT COUNT (DISTINCT manager_id) "Number of Managers"
FROM   employees;

--8. 최고 급여와 최저 급여의 차액을 표시하는 질의를 작성하고 
--   열 레이블을 DIFFERENCE로 지정하시오.
SELECT MAX(salary) - MIN(salary) DIFFERENCE
FROM   employees;

--9. 관리자 번호 및 해당 관리자에 속한 사원의 최저 급여를 표시하시오. 
--   관리자를 알 수 없는 사원 및 최저 급여가 6,000 미만인 그룹은 제외시키고 
--   결과를 급여에 대한 내림차순으로 정렬하시오.
SELECT   manager_id, MIN(salary)
FROM     employees
WHERE    manager_id IS NOT NULL
GROUP BY manager_id
HAVING   MIN(salary) >= 6000
ORDER BY MIN(salary) DESC;


--------------------------------------------------------------------------------

--<★★★★★JOIN 구문(오라클)>
--JOIN : 2개 이상의 테이블에서 데이터 가져오기
SELECT employee_id, last_name, department_id
FROM   employees;
--department_id : Foreign Key

--Cartesian Product(오류)
--모든 경우의 수를 다 가져오는 것(n * m) => 크로스 조인
--조인 조건 안적거나 조건 잘못된 경우 발생
-- => (ORACLE의 경우에만) 항상 WHERE 절에 올바른 조인 조건 사용
SELECT count(*)
FROM   employees, departments;

--조인 유형
--Oracle 조인 구문
--★★★★★ n개 테이블 조인 => 최소 n-1개 조인 조건문 필요

--1. Equi Join
--  : '=' 으로 조인(일치하는 것 끼리 연결)
SELECT e.employee_id, e.last_name, e.department_id, 
       d.department_id, d.location_id, d.department_name
FROM   employees e, departments d --테이블 alias
WHERE  e.department_id = d.department_id;

--테이블 접두어(alias) 붙여서 성능 개선
SELECT employee_id, last_name, e.department_id, 
       d.department_id, location_id, department_name
FROM   employees e, departments d --테이블 alias
WHERE  e.department_id = d.department_id;

SELECT d.department_id, d.department_name,
       d.location_id, l.city
FROM   departments d, locations l
WHERE  d.location_id = l.location_id;

--추가 조건: AND로 연결
SELECT d.department_id, d.department_name, l.city
FROM   departments d, locations l
WHERE  d.location_id = l.location_id
       AND d.department_id IN(20, 50);
       
--2. Non-Equi JOIN
-- '=' 아닌 나머지 연산자 조인
SELECT *
FROM   job_grades;

SELECT e.last_name, e.salary, j.grade_level
FROM   employees e, job_grades j
WHERE  e.salary 
       BETWEEN j.lowest_sal AND j.highest_sal;

--3. Outer JOIN
--조인에 포함되지 않는 행도 볼 때 사용
--ex. 190 부서 소속 사원 없지만 부서 번호 보고싶을때
--'(+)' 연산자 WHERE절 조건 왼쪽 / 오른쪽에 사용(둘 다 X)
--Left / Right Outer Join
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id(+) = d.department_id;
--Left Outer Join
-- => 부서들 중에 소속 사원이 없는 부서명도 보고 싶을때

SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+);
--Right Outer Join
-- => 사원들 중에 부서 없는 사원명도 보고 싶을때

--4. Self JOIN
--같은 테이블 안에서 조인
--한 테이블 안에 연관성이 있는 칼럼이 있는 경우
SELECT employee_id, last_name, manager_id
FROM   employees;

--한 테이블에 서로 다른 테이블 alias 부여 => 별개의 테이블로 인식
SELECT worker.last_name 
       || ' works for ' 
       || manager.last_name
FROM   employees worker, employees manager
WHERE  worker.manager_id = manager.employee_id;
--employee_id : Primary Key
--manager_id  : employee_id 참조하는 Foreign Key

--<★★★★★JOIN 구문(SQL-1999 ANSI)>
--1. CROSS JOIN
-- (= 카테시안 프로덕트)
SELECT last_name, department_name
FROM   employees CROSS JOIN departments;

--2. NATURAL JOIN
--두 테이블에서 동일한 이름가진 열 기준 조인(데이터 타입 같아야 함)
--같은 이름 칼럼 많으면 문제생길 수 있음
DESC departments;
DESC locations; -- =>location_id 기준 조인

SELECT department_id, department_name, location_id, city
FROM   departments NATURAL JOIN locations;

--3. USING절 JOIN
--데이터 유형 일치하지 않는 같은 이름 가진 열이 있을때
--조인 할 칼럼 지정할 수 있음
--NATURAL JOIN이랑 같이 사용 불가능
--USING절에 칼럼/테이블 alias 사용 불가능
SELECT employee_id, last_name,
       location_id, department_id
FROM   employees JOIN departments
                      USING (department_id);

--USING절 사용한 WHERE절에도 칼럼/테이블 alias 사용 불가능                     
SELECT l.city, d.department_name
FROM   locations l JOIN departments d
                        USING (location_id)
WHERE  d.location_id = 1400;

--4. ★★★ON절 JOIN
--ON절에 조인 조건 지정(= ORACLE SQL WHERE절)
SELECT e.employee_id, e.last_name, e. department_id,
       d.department_id, d.location_id
FROM   employees e JOIN departments d
                        ON (e.department_id = d.department_id);

-- => ORACLE JOIN 으로 변환
SELECT e.employee_id, e.last_name, e. department_id,
       d.department_id, d.location_id
FROM   employees e, departments d
WHERE  e.department_id = d.department_id;

--ON절로 3-way JOIN : 세 테이블 조인
--두 테이블 조인한 것을 다시 다른 테이블과 조인
SELECT employee_id, city, department_name
FROM   employees e JOIN departments d
                        ON d.department_id = e.department_id
                   JOIN locations l
                        ON d.location_id = l.location_id;

-- => ORACLE JOIN 으로 변환
SELECT employee_id, city, department_name
FROM   employees e, departments d, locations l
WHERE  d.department_id = e.department_id
AND    d.location_id = l.location_id;

--5. OUTER JOIN
--(1)LEFT OUTER JOIN
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e LEFT OUTER JOIN departments d
                      ON (e.department_id = d.department_id);
--사원 중에서 부서가 없는 사원도 보고싶을때

-- => ORACLE JOIN 으로 변환
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+);

--(2)RIGHT OUTER JOIN
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e RIGHT OUTER JOIN departments d
                      ON (e.department_id = d.department_id);
--부서 중에서 사원이 없는 부서도 보고싶을때

-- => ORACLE JOIN 으로 변환
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id(+) = d.department_id;

--(3)FULL OUTER JOIN
--양쪽 Outer 조인 다 보여줌
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e FULL OUTER JOIN departments d
                      ON (e.department_id = d.department_id);
--오라클은 지원X
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id(+) = d.department_id(+); -- => 오류남

--조건 추가시 AND
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e JOIN departments d
                        ON  (e.department_id = d.department_id)
                        AND e.manager_id = 149;

--WHERE로도 조건 추가 가능
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e JOIN departments d
                        ON (e.department_id = d.department_id)
WHERE  e.manager_id = 149;

--sql06 문제--------------------------------------------------------------------

--1. LOCATIONS 및 COUNTRIES 테이블을 사용하여 
--   모든 부서의 주소를 생성하는 query를 작성하시오. 
--   출력에 위치ID(location_id), 주소(street_address), 
--   구/군(city), 시/도(state_province) 및 국가(country_name)를 표시하시오.

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

--2. 모든 사원의 이름, 소속 부서번호 및 부서 이름을 표시하는 query를 작성하시오.

--Oracle
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id;

--ANSI
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e JOIN departments d
                        ON  e.department_id = d.department_id;

--3. Toronto에 근무하는 사원에 대한 보고서를 필요로 합니다. 
--   toronto에서 근무하는 모든 사원의 
--   이름, 직무, 부서번호 및 부서 이름을 표시하시오.

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

--4. 사원의 이름 및 사원 번호를 
--   해당 관리자의 이름 및 관리자 번호와 함께 표시하는 보고서를 작성하는데,
--   열 레이블을 각각 Employee, Emp#, Manager 및 Mgr#으로 지정하시오.

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

--5. King과 같이 해당 관리자가 지정되지 않은 사원도 표시하도록 
--   4번 문장을 수정합니다. 
--   사원 번호순으로 결과를 정렬하시오. 

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
                        
--6. 직무 등급 및 급여에 대한 보고서를 필요로 합니다. 
--   먼저 JOB_GRADES 테이블의 구조를 표시한 다음 
--   모든 사원의 이름, 직무, 부서 이름, 급여 및 등급을 표시하는 
--   query를 작성하시오.
--   ※ job_grades 파일 열어서 스크립트 실행 후 실습

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

--<★★★★서브 쿼리>
--SELECT문(메인쿼리) 안의 SELECT문(서브쿼리)
--서브쿼리 결과를 메인쿼리에서 사용

--1. 단일 행 서브쿼리
--하나의 행만 반환, 단일행 비교연산자 사용
--ex. 'IT' 부서 직원의 이름, 입사일
SELECT last_name, hire_date
FROM   employees
WHERE  department_id = (SELECT department_id
                        FROM   departments
                        WHERE  department_name = 'IT');
                        
--ex. 'Abel' 보다 급여 더 높은 사람
SELECT last_name, salary
FROM   employees
WHERE  salary > (SELECT salary
                 FROM   employees
                 WHERE  last_name = 'Abel');

--ex. 141번 사원과 같은 직무인 사원 조회(141번 사원 빼고)
SELECT employee_id, last_name, job_id
FROM   employees
WHERE  job_id = (SELECT job_id
                 FROM   employees
                 WHERE  employee_id = 141)
       AND employee_id != 141;

--ex. 'Abel'와 직무 같고 'Abel'보다 급여 많은 사람
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

--HAVING절에도 서브쿼리 사용 가능
SELECT   department_id, MIN(salary)
FROM     employees
GROUP BY department_id
HAVING   MIN(salary) > (SELECT MIN(salary)
                        FROM employees
                        WHERE department_id = 50);
                        