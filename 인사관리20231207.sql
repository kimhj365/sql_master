select *
from tab;

select * from employees;

--DESC(Describe): 테이블의 구조
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

--산술연산자
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

--NVL(칼럼, 값) : 해당 칼럼에서 널값인 경우 대체할 값
SELECT last_name, 12*salary*NVL(commission_pct, 0)
FROM employees;

SELECT last_name, 12*salary*NVL(commission_pct, 1)
FROM employees;

--AS : 칼럼의 별칭(따옴표 없으면 전부 대문자)
SELECT last_name as name, commission_pct comm
FROM employees;

SELECT last_name "Name", salary*12 "Annual Salary"
FROM employees;

--한글도 AS 별칭 가능
SELECT last_name "이름", salary*12 "보너스"
FROM employees;

--연결연산자 || : 열 or 문자열을 다른 열에 연결
SELECT last_name||job_id as "Employees"
FROM employees;

--별칭에 소문자, 공백 있는 경우 큰따옴표로 묶음
SELECT last_name||' is a '||job_id AS "Employee Details"
FROM employees;

SELECT department_id
FROM employees;

--DISDINCT : 중복행 제거 => SELECT 바로 다음에 와야함
SELECT DISTINCT department_id
FROM employees;

SELECT DISTINCT department_id, job_id
FROM employees;

--문제1
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

--WHERE절 : 조건 만족하는 행만 질의하도록 제한
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 90;

--데이터 값은 대소문자 구분해야됨
SELECT last_name, job_id, department_id
FROM employees
WHERE last_name = 'Whalen';

--날짜 값은 시스템 날짜 형식에 맞게 적어야 함
SELECT last_name
FROM employees
WHERE hire_date = '05/10/10';

SELECT last_name, hire_date
FROM employees;

--비교연산자
SELECT last_name, salary
FROM employees
WHERE salary <= 3000;

SELECT last_name, hire_date
FROM employees
WHERE hire_date < '05/01/01';

--BETWEEN 연산자 : BETWEEN 최소값 AND 최대값
-- => 최소값 이상 최대값 이하(포함) 값 가진 행
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 2500 AND 3500;

--오류는 안뜨지만 논리적으로 맞지 않는 연산 => 논리적 오류
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 3500 AND 2500;

--IN 연산자 : IN(a, b, c)
-- =>a, b, c중의 값 가진 행
SELECT employee_id, last_name, salary, manager_id
FROM employees
WHERE manager_id IN (100, 101, 201);

--LIKE 연산자 : 문자열 포함한 행 찾기 
--'S%' : 대문자 S로 시작하는 문자열
SELECT first_name
FROM employees
WHERE first_name LIKE 'S%';

--'%s' : 소문자 s로 시작하는 문자열
SELECT last_name
FROM employees
WHERE last_name LIKE '%s';

--날짜에도 % 사용 가능(시스템 날짜 포맷 주의)
SELECT last_name, hire_date
FROM employees
WHERE hire_date LIKE '05%';

--'_'(언더바) : 한 문자 대체
--'_o%' : 두번째 문자가 o로 시작하는 자료
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

--IS NULL 연산자 : null 값 조회
SELECT *
FROM employees
WHERE commission_pct IS NULL;

--AND 연산자 : 조건이 모두 true인 것만 조회
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
AND job_id LIKE '%MAN%';

--OR 연산자 : 조건 중 하나가 true면 true
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
OR job_id LIKE '%MAN%';

--NOT 연산자 : 제외한 나머지(다른 연산자와 함께 사용 가능)
SELECT last_name, job_id
FROM employees
WHERE job_id
NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP');

--연산자 우선순위 : AND > OR
--그냥 괄호가 우선순위 제일 높음
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

--문제2
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
