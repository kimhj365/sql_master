--<정렬 연산자>

--ORDER BY 절 : 행 정렬.
--ASC : 오름차순(기본값).
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date;

--DESC : 내림차순.
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date DESC;

--ORDER BY에 컬럼 ALIAS 사용 가능.
SELECT employee_id, last_name, salary*12 annsal
FROM employees
ORDER BY annsal;

--ORDER BY 숫자 : 해당 번호 컬럼 기준 정렬
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY 3; --department_id 기준 정렬

--여러 컬럼 정렬 가능(1차 정렬, 2차 정렬, ...)
SELECT last_name, department_id, salary
FROM employees
ORDER BY department_id, salary;

--SELECT절에 없는 컬럼 순으로도 정렬가능(테이블에 있는 컬럼)
SELECT employee_id, salary
FROM employees
ORDER BY hire_date;

--치환 변수 & / && : 실행한 후 대체하는 값 입력 받음
--단일 치환변수 &
SELECT employee_id,last_name,salary,department_id
FROM employees
WHERE employee_id = &employee_num;
--&employee_num 부분에 대체값 입력받음
--ex. 101 입력 => WHERE employee_id = 101;
--실행할 때마다 새로 입력 받음(잠시 쓰이고 없어지는 변수)
--대체하는 부분이 문자타입이라면 & 부분에 '' 둘러줘야함
--ex. job_id = '$job_num';

--SELECT문 전체에 사용 가능
--WHERE, ORDER BY 조건 전체를 입력 받을 수 있음
SELECT employee_id,last_name, job_id, &column_name
FROM employees
WHERE &condition
ORDER BY &order_column;

--&& 치환변수
--입력받은 값이 메모리에 저장되어 계속 보관됨 => 반복적으로 사용
SELECT employee_id,last_name, job_id, &&column_name
FROM employees
ORDER BY &column_name;
--&&column_name에서 입력받은 값 &column_name에서 사용

--다음 실행문에서도 전에 입력받은 &&값 계속 사용
SELECT employee_id, salary
FROM employees
ORDER BY &column_name;

--UNDEFINE : &&변수 없애기
UNDEFINE column_name;

--&&변수 없애서 &에서 다시 입력받음
SELECT employee_id, salary
FROM employees
ORDER BY &column_name;


--<집합 연산자(SET)>

--1.UNION
--두 테이블의 조합(합집합)

--EMPLOYEES 테이블 : 현재 사원 정보 상태
--JOB_HISTORY 테이블 : 직무 변경 이력(사원번호 중복값 있음)
SELECT *
FROM job_history
ORDER BY employee_id;

--중복되는 행 제거됨
SELECT employee_id, job_id
FROM employees --107개 행
UNION
SELECT employee_id, job_id
FROM job_history; --10개 행
--리턴값 115개 => 2개 중복값 제거

--2. UNION ALL
-- 합집합 + 중복값 제거 안됨, 정렬 안됨
SELECT employee_id, job_id
FROM employees
UNION ALL
SELECT employee_id, job_id
FROM job_history;

--ORDER BY절은 항상 맨 밑줄로 와야함
SELECT employee_id, job_id, department_id
FROM employees
UNION ALL
SELECT employee_id, job_id, department_id
FROM job_history
ORDER BY employee_id;

--UNION, UNION ALL : 두 SELECT문 위치 바꿔도 결과값 같음

--3. INTERSECT
--공통된 행 검생(교집합)
SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history;

--문장 순서 바뀌어도 결과값 동일
SELECT employee_id, job_id
FROM job_history
INTERSECT
SELECT employee_id, job_id
FROM employees;

--4. MINUS
--첫번째 문장에서 두번째 문장 뺀 결과(차집합)
--첫번째 컬럼 순으로 오름차순 정렬됨
SELECT employee_id, job_id
FROM employees --107개 행
MINUS
SELECT employee_id, job_id
FROM job_history;
--중복 2개 => 결과값 105개

--문장 순서 바뀌면 결과값 달라짐
SELECT employee_id, job_id
FROM job_history --10개 행
MINUS
SELECT employee_id, job_id
FROM employees;
--중복 2개 => 결과값 8개


--<함수>
--인수 input 받아서 처리 후 output 산출 => 리턴값 존재
--사용자 정의함수 : 직접 만든 함수
--표준화된 함수 / DB별로 표준화 안된 함수 

--단일행 함수 :행 당 하나의 결과값 반환
--그룹함수(다중행 함수) : 여러 개의 인수가 들어와도 하나의 리턴값만 산출

--dual 테이블
--칼럼 1개, 행 1개 => 함수 리턴값 확인할 때 쓰는 테이블
desc dual;

select *
from dual;

--함수 값 행 갯수만큼 출력됨
select sysdate
from employees;

--dual 테이블 : 행 1개 => 리턴값 확인 쉬움
select sysdate
from dual;

--<단일 행 함수>

--1. 문자 함수
--LOWER : 소문자로 리턴
--UPPER : 대문자로 리턴
--INITCAP : 단어 첫글자는 대문자, 나머지 소문자(ex. Ye Dam)
SELECT 'The job id for '||UPPER(last_name)||' is '|| 
        LOWER(job_id) AS "EMPLOYEE DETAILS"
FROM employees;

--컬럼명에 씌워서 컬럼 전체 값 소문자로 출력 가능
SELECT employee_id, last_name, department_id
FROM employees
WHERE LOWER(last_name) = 'higgins';

--문자 조작함수
--CONCAT : 두 문자열 연결
--★SUBSTR : 문자열 추출
--LENGTH : 문자열 길이
--INSTR : 문자 위치
--LPAD : 문자열 길이 정하고 우측 정렬, 남는 자리 채움
--RPAD : 좌측 정렬, 남는 자리 채움
--TRIM : 맨 앞, 맨 뒤 문자 하나 제거 (LTRIM, RTRIM)

--SUBSTR(문자열, n) : n번째 문자부터 자르기
SELECT last_name, SUBSTR(last_name, 4)
FROM employees
WHERE department_id = 90;

--SUBSTR(문자열, n, m) : n ~ m번째 문자 잘라내기
SELECT last_name, SUBSTR(last_name, 2, 2)
FROM employees
WHERE department_id = 90;

--음수 n : 뒤에서 부터 자릿수 세기
SELECT last_name, SUBSTR(last_name, -3, 2)
FROM employees
WHERE department_id = 90;

SELECT employee_id, CONCAT(first_name, last_name) NAME, job_id, 
       LENGTH(last_name), INSTR(last_name, 'a') "Contains 'a'?"
FROM employees
WHERE SUBSTR(job_id, 4) = 'REP';

--TRIM(LTRIM, RTRIM)
SELECT LTRIM('yyedaymy', 'yea') -- => 왼쪽부터 y, e, a 잘라냄
FROM dual;

SELECT RTRIM('yyedaymy', 'yea') -- => 오른쪽부터 y, e, a 잘라냄
FROM dual;\

--2. 숫자 함수
--ROUND : 소수점 반올림
SELECT ROUND(345.678) AS round1, -- => 소수점 자리 없음 (= ,0)
       ROUND(345.678, 0) AS round2,
       ROUND(345.678, 1) AS round3,
       ROUND(345.678, -1) AS round4 -- =>1의 자리에서 반올림
FROM dual;

--TRUNC : 소수점 버림
SELECT TRUNC(345.678) AS trunc1, -- => 소수점 자리 없음 (= ,0)
       TRUNC(345.678, 0) AS trunc2,
       TRUNC(345.678, 1) AS trunc3,
       TRUNC(345.678, -1) AS trunc4 -- =>1의 자리에서 버림
FROM dual;

--MOD : 나누고 난 나머지
SELECT last_name, salary, MOD(salary, 5000)
FROM employees;


--sql03_1 문제------------------------------------------------------------------

--1.
SELECT SYSDATE "Date"
FROM dual;

--2. 각 사원에 대해 사원 번호, 이름, 급여 및
--   15% 인상된 급여를 정수로 표시하시오.
--   인상된 급여 열의 레이블을 New Salary로 지정하시오. 
SELECT employee_id, last_name, salary, 
       ROUND(salary*1.15) "New Salary"
FROM employees;

--3. 2번 질의를 수정하여 
--  새 급여에서 이전 급여를 빼는 새 열을 추가하고 
--  레이블을 Increase로 지정하고 수정한 질의를 실행하시오.
SELECT employee_id, last_name, salary,
       ROUND(salary*1.15) "New Salary", 
       ROUND(salary*1.15-salary) "Increase"
FROM employees;

--4. 이름이 J, A 또는 M으로 시작하는 
--   모든 사원의 이름(대문자 표시) 및 이름 길이를 표시하는 
--   질의를 작성하고 각열에 적합한 레이블을 지정하시오. 
--   결과를 사원의 이름에 따라 정렬하시오.
SELECT UPPER(last_name) "Upper Name", LENGTH(last_name) "Name Length"
FROM employees
WHERE UPPER(SUBSTR(last_name, 1, 1)) IN ('J', 'A', 'M')
ORDER BY 1;

--------------------------------------------------------------------------------

--3. 날짜 함수
--기본 날짜 형식 : DD-MON-YY
--SYSDATE : 현재 날짜, 시간 반환 함수

SELECT SYSDATE
FROM dual;

--날짜-날짜 : 숫자(일수)
SELECT last_name, (SYSDATE-hire_date) / 7 AS WEEKS --주급 계산
FROM employees
WHERE department_id = 90;

--MONTHS_BETWEEN : 날짜 사이의 월 수
--ADD_MONTHS : 월 더하기
--NEXT_DAY : 다음에 돌아오는 요일의 날짜(1:일요일 ~ 7:토요일)
--LAST_DAY : 월의 마지막 날짜

SELECT employee_id, hire_date, 
       MONTHS_BETWEEN(SYSDATE, hire_date) TENURE,
       ADD_MONTHS(hire_date, 6) REVIEW, --입사 6개월 후 날짜
       NEXT_DAY(hire_date, '금'),   --입사일 후 돌아오는 금요일 날짜
       LAST_DAY(hire_date)
FROM employees;

--ROUND : 날짜 반올림
SELECT  ROUND(SYSDATE, 'YEAR'), --연도 기준 (7월 1일 0시 이후 반올림)
        ROUND(SYSDATE, 'MONTH'), --월 기준 (16일 0시)
        ROUND(SYSDATE, 'DAY'), --주 기준 (수요일 낮 12시)
        ROUND(SYSDATE, 'DD') --일 기준 (낮 12시)
FROM dual;

--TRUNC : 날짜 버림
SELECT  TRUNC(SYSDATE, 'YEAR'), --이번 년도 첫날
        TRUNC(SYSDATE, 'MONTH'), --이번 달 첫날
        TRUNC(SYSDATE, 'DAY'), --이번 주
        TRUNC(SYSDATE, 'DD') --오늘
FROM dual;


--4. 변환 함수
--데이터 타입 바꾸는 함수

--암시적 데이터 변환(알아서 바꿔줌)
SELECT *
FROM employees
WHERE employee_id = '101'; -- 문자 => 숫자

--명시적 데이터 변환
--TO_CHAR : 날짜 => 문자
--날짜 형식모델 맞춰서 입력

--날짜 형식 미국식으로 변환(일시적)
ALTER SESSION SET
NLS_DATE_LANGUAGE = AMERICAN;

--날짜 형식 바꿔서 문자로 표기
SELECT employee_id, TO_CHAR(hire_date, 'MM/YY')
FROM employees;

--month 대소문자 구분함
SELECT last_name, TO_CHAR(hire_date, 'DD Month YYYY')
FROM employees;

SELECT last_name, TO_CHAR(hire_date, 'DD month YYYY')
FROM employees;

SELECT last_name, TO_CHAR(hire_date, 'DD MONTH YYYY')
FROM employees;

--fm : 공백 제거, 선행 0 제거 
SELECT last_name, TO_CHAR(hire_date, 'fmDD MONTH YYYY')
FROM employees;

--sp : 문자로 표시
--th : 서수
SELECT last_name, 
       TO_CHAR(hire_date, 'fmDdspth MONTH YYYY fmHH:MI:SS AM')
FROM employees;

--TO_CHAR : 숫자 => 문자
--9: 숫자 표시
--0: 0 강제표시
--$, L: 화폐기호
--. ,: 소수점/구분자 표시
SELECT TO_CHAR(salary, '$99,999.00') SALARY
FROM employees;

--자리수 넘어간 숫자 표기 X
SELECT TO_CHAR(salary, '$9,999.00') SALARY
FROM employees;

--TO_NUMBER : 문자 => 숫자
--형식 모델: 문자 인수의 형식과 같음(이 문자는 요런 형식의 숫자입니다)
SELECT TO_NUMBER('$3,400', '$99,999')
FROM dual;

--기호 없이 숫자만 된 문자면 형식모델 생략가능
SELECT TO_NUMBER('3400')
FROM dual;

--★★★★TO_DATE : 문자 => 날짜
--형식 모델: 문자 인수의 형식과 같음(이 문자는 요런 형식의 날짜입니다)
SELECT TO_DATE('2010년, 02월', 'YYYY"년", MM"월"')
FROM dual;

--시스템 날짜 형식 모를때 쓰면 유용함
--ex. 05년 7월 1일 이후 입사자 찾기
SELECT last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('05/07/01', 'YY/MM/DD');

SELECT last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('2005년 07월 01일', 'YYYY"년" MM"월" DD"일"');

--형태가 비슷한 유형 어느정도 적용됨
SELECT last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('05/07/01', 'YY-MM-DD');

--fx : 타입과 형식모델 똑같이 통일
SELECT last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('05/07/01', 'fxYY/MM/DD');

--YY 형식 : 현재 세기(20XX) 
--RR 형식 : 현재 연도 / 지정 연도 따라 세기 달라짐
--걍 네자리로 연도 입력하면 됨

--5. 일반 함수
--★★★★★NVL(expr1, expr2) : 원본(expr1)이 NULL이면 실제 값(expr2)으로 변환
--ex. commission_pct가 NULL이면 => 0으로 변환
SELECT last_name, salary, NVL(commission_pct, 0),
       (salary*12) + (salary*12*NVL(commission_pct, 0)) AN_SAL
FROM employees;

--원본값과 변환값 데이터 타입 통일해야 함
SELECT last_name, salary, 
       NVL(TO_CHAR(commission_pct), '보너스 없음')
FROM employees;

--NVL2 함수
--NVL2(expr1, expr2, expr3)
-- => 1 = 널이 아니면 2 / 1 = 널이면 3
--2, 3의 데이터 타입 통일해야 함
SELECT last_name, salary, commission_pct,
       NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM employees;

--NULLIF(expr1, expr2)
--두 표현식 비교 => 같으면 NULL, 다르면 expr1 반환
SELECT first_name, LENGTH(first_name) "expr1",
       last_name, LENGTH(last_name) "expr2",
       NULLIF(LENGTH(first_name), LENGTH(last_name)) result
FROM employees;

--COALESCE : 널 아닌 첫번째 값 나오면 출력

--6. 조건 표현식
--CASE :  = IF-THEN-ELSE문
SELECT last_name, job_id, salary,
        CASE job_id WHEN 'IT_PROG'  THEN 1.10*salary
                    WHEN 'ST_CLERK' THEN 1.15*salary
                    WHEN 'SA_REP'   THEN 1.20*salary
                                    ELSE salary
        END "REVISED_SALARY"
FROM employees;

--등호 들어가면 수식을 WHEN 안에 
SELECT last_name, salary,
        CASE WHEN salary<5000  THEN 'Low'
             WHEN salary<10000 THEN 'Medium'
             WHEN salary<20000 THEN 'Good'
                               ELSE 'Excellent'
        END qualified_salary
FROM employees;

--DECODE :  = IF-THEN-ELSE문
--오라클 구문에서만 사용가능
--<,> 사용불가 / = 만 사용가능
SELECT last_name, job_id, salary,
       DECODE(job_id, 'IT_PROG',  1.10*salary,
                      'ST_CLERK', 1.15*salary,
                      'SA_REP',   1.20*salary,
                                  salary)
       REVISED_SALARY
FROM employees;

--중첩 함수 : 단일행 함수 몇번이고 계속 중첩가능 
--=> 안에서 부터 바깥쪽으로 계산

--sql03_2 문제------------------------------------------------------------------

--5. 각 사원의 이름을 표시하고 
--   근무 달 수(입사일로부터 현재까지의 달 수)를 계산하여 
--   열 레이블을 MONTHS_WORKED로 지정하시오. 
--   결과는 정수로 반올림하여 표시하시오.
SELECT last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) MONTHS_WORKED
FROM employees;

--6. 모든 사원의 성 및 급여를 표시하기 위한 query를 작성합니다. 
--   급여가 15자 길이로 표시되고 왼쪽에 # 기호가 채워지도록 형식을 지정하시오. 
--   열 레이블을 SALARY 로 지정합니다.
SELECT last_name, LPAD(salary, 15, '$') SALARY
FROM employees;

--7. 부서 90의 모든 사원에 대해 성(last_name) 및 
--   재직 기간(주 단위)을 표시하도록 query 를 작성하시오. 
--   주를 나타내는 숫자 열의 레이블로 TENURE를 지정하고
--   주를 나타내는 숫자 값을 정수로 나타내시오.
SELECT last_name, ROUND((SYSDATE-hire_date) / 7) TENURE
FROM employees
WHERE department_id = 90;

--------------------------------------------------------------------------------

--sql04 문제--------------------------------------------------------------------

--1. 각 사원에 대해 다음 항목을 생성하는 질의를 작성하고 
--   열 레이블을 Dream Salaries로 지정하시오.
--   <employee last_name> earns <salary> monthly but wants <3 times salary>. 
--   <예시> Matos earns $2,600.00 monthly but wants $7,800.00.
SELECT last_name
       ||' earns '
       ||TO_CHAR(salary, 'fm$99,999.00')
       ||' monthly but wants '
       ||TO_CHAR(salary*3, 'fm$99,999.00')
FROM employees;

--2. 사원의 이름, 입사일 및 급여 검토일을 표시하시오.
--   급여 검토일은 여섯 달이 경과한 후 첫번째 월요일입니다. 
--   열 레이블을 REVIEW로 지정하고 
--   날짜는 "2010.03.31 월요일"과 같은 형식으로 표시되도록 지정하시오.
SELECT last_name, hire_date,
       TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6),2), 'YYYY.MM.DD DAY') REVIEW
FROM employees;
--ADD_MONTH(_,6) : 입사일 + 6개월
--NEXT_DAT(_,2) : 첫번째 월요일
--TO_CHAR(_, 'YYYY.MM.DD DAY') : 문자열 변환

--3. 이름, 입사일 및 업무 시작 요일을 표시하고 
--   열 레이블을 DAY로 지정하시오. 
--   월요일을 시작으로 해서 요일을 기준으로 결과를 정렬하시오.
SELECT last_name, hire_date, TO_CHAR(hire_date, 'day') DAY
FROM employees
ORDER BY MOD(TO_NUMBER(TO_CHAR(hire_date, 'd'))+5, 7);
--TO_CHAR(hire_date, 'd') => 1: 일, 2: 월
--TO_NUMBER(_) + 5 => 6: 일, 7: 월
--MOD(_,7) => 6: 일, 0: 월

--상진이형 풀이
SELECT last_name, hire_date, TO_CHAR(hire_date, 'day') DAY
FROM employees
ORDER BY TO_CHAR((hire_date-1), 'd');
--hire_date-1 => 7:일, 1:월 (overflow??)

--4. 사원의 이름과 커미션을 표시하는 질의를 작성하시오. 
--   커미션을 받지 않는 사원일 경우 “No Commission”을 표시하시오. 
--   열 레이블은 COMM으로 지정하시오.
SELECT last_name, NVL(TO_CHAR(commission_pct), 'No Commission') COMM
FROM employees;

--5. DECODE 함수와 CASE 구문을 사용하여 다음 데이터에 따라 
--   JOB_ID 열의 값을 기준으로 모든 사원의 등급을 표시하는 질의를 작성하시오.
--   업무         등급
--   AD_PRES     A
--   ST_MAN      B
--   IT_PROG     C
--   SA_REP      D
--   ST_CLERK    E
--   그외        0

--DECODE식
SELECT last_name, job_id,
       DECODE(job_id, 'AD_PRES',  'A',
                      'ST_MAN',   'B',
                      'IT_PROG',  'C',
                      'SA_REP',   'D',
                      'ST_CLERK', 'E',
                                   0)
       GRADE
FROM employees;

--CASE식
SELECT last_name, job_id,
       CASE job_id WHEN 'AD_PRES'  THEN 'A'
                   WHEN 'ST_MAN'   THEN 'B'
                   WHEN 'IT_PROG'  THEN 'C'
                   WHEN 'SA_REP'   THEN 'D'
                   WHEN 'ST_CLERK' THEN 'E'
                   ELSE                 '0'
        END
        GRADE
FROM employees;

--------------------------------------------------------------------------------
