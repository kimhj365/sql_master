-- < PL/SQL 커서 속성 >
SET SERVEROUTPUT ON;

-- INSERT문
-- ※ 변수 몇개 쓸건지 정했으면 DECLARE절 먼저 or 아니면 BEGIN 먼저
--   BEGIN 먼저 작성 후 역으로 DECLARE절에 변수 선언
DECLARE
    -- %TYPE: 특정 테이블의 칼럼 데이터 타입 가져옴
    --        테이블명 명시해야 함
    v_deptno departments.department_id%TYPE;
    v_comm employees.commission_pct%TYPE := .1;
    
BEGIN
    -- SELECT: 특정 사원번호에 해당하는 사원의 부서번호 찾기
    SELECT department_id
    -- 변수명에 접두어 붙이기(v_)
    INTO v_deptno
    FROM employees
    WHERE employee_id = &사원번호;
    
    -- INSERT: 부서번호 변수받아 사원 추가
    INSERT INTO employees(
        employee_id,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
        )
    VALUES (
        1000, 
        'Hong',
        'khd@google.com',
        sysdate,
        'IT_PROG',
        v_deptno
        );
    
    --UPDATE: salary값 수정
    UPDATE employees
    SET salary = (NVL(salary, 0) + 10000) * v_comm
    WHERE employee_id = 1000;
END;
/

-- 롤백
-- PL/SQL 문 실행후에도 트랜잭션 닫히지 않음 => 롤백 가능
ROLLBACK;

SELECT *
FROM   employees
WHERE  employee_id = 1000;


-- < PL/SQL ROWCOUNT 속성 > 
BEGIN
    -- DELETE: 오류 안나면 ROWCOUNT 속성 = 1
    DELETE FROM employees
    WHERE employee_id = 1000;
    
    -- UPDATE: ROWCOUNT 속성 = 0
--     UPDATE employees
--     SET salary = salary * 1.1
--     WHERE employee_id = 0;
    
    -- PL/SQL IF문
    -- ROWCOUNT : 자동 생성됨
    --            가장 최근에 실행된 값 => UPDATE의 ROWCOUNT값(0)
    -- 암시적 커서는 쿼리문 중에 가장 최근에 실행된 값을 덮어씀
    -- why? 이름 없어서 명시적으로 쿼리 지정할 수 없음
    --  => UPDATE 말고 DELETE에 반응하기 불가능(제어 불가)
    --     특정 쿼리문에 반응하려면 매번 ROWCOUNT 써줘야 함
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('정상적으로 삭제되지 않았습니다.');
    END IF;
    
END;
/

/*
Q1. 사원번호를 입력(치환변수 &사용) 할경우
사원번호, 사원이름, 부서이름을 출력하는 PL/SQL문 작성하시오

=> SQL문을 먼저 작성보고 그 후에 PL/SQL문에 알맞게 집어넣기
*/

-- 1) JOIN
DECLARE
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_dname departments.department_name%TYPE;
BEGIN
    SELECT e.employee_id, e.last_name, d.department_name
    INTO   v_eid, v_ename, v_dname
    FROM   employees e
           JOIN departments d
           ON e.department_id = d.department_id
    WHERE  e.employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('사원번호: ' || v_eid);
    DBMS_OUTPUT.PUT_LINE('사원이름: ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('부서이름: ' || v_dname);

END;
/


/*
Q2. 사원번호를 입력(치환변수 &사용) 할경우
사원이름, 급여, 연봉 -> (급여*12 + (NVL(급여, 0)*NVL(커미션퍼센트,0)*12)
출력하는 PL/SQL문 작성하시오
*/

-- 1) SQL문
    SELECT last_name, 
           salary, 
           (salary*12 + (NVL(salary,0)*NVL(commission_pct,0)*12)) annual_sal
    FROM   employees
    WHERE  employee_id = &사원번호;

-- 2) PL/SQL문
DECLARE
    v_name employees.last_name%TYPE;
    v_sal employees.salary%TYPE;
    v_annual_sal v_sal%TYPE;
BEGIN
    SELECT last_name, 
           salary, 
           (salary*12 + (NVL(salary,0)*NVL(commission_pct,0)*12)) annual_sal
    INTO   v_name, v_sal, v_annual_sal
    FROM   employees
    WHERE  employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('사원이름: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('급여: ' || v_sal);
    DBMS_OUTPUT.PUT_LINE('연봉: ' || v_annual_sal);
END;
/

-- PL/SQL에서 가능한 방법) 별도 연산
-- 칼럼명은 SELECT문 벗어나면 사용 불가능 => 별도의 변수에 넣어서 연산
DECLARE
    v_name   employees.last_name%TYPE;
    v_sal    employees.salary%TYPE;
    v_comm   employees.commission_pct%TYPE;
    v_annual v_sal%TYPE;
    
BEGIN
    SELECT last_name, 
           salary,
           commission_pct
    INTO   v_name, v_sal, v_comm
    FROM   employees
    WHERE  employee_id = &사원번호;
    
    v_annual := (v_sal*12 + (NVL(v_sal,0)*NVL(v_comm,0)*12));
    
    DBMS_OUTPUT.PUT_LINE('사원이름: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('급여: ' || v_sal);
    DBMS_OUTPUT.PUT_LINE('연봉: ' || v_annual_sal);
    
END;
/


-- < PL/SQL IF문 > 

-- test_employees 테이블 생성(employees 테이블 복사)
CREATE TABLE test_employees
AS
    SELECT * 
    FROM   employees;
    
SELECT *
FROM   test_employees;

-- 1. 기본 IF문
BEGIN
    DELETE FROM test_employees
    WHERE employee_id = &사원번호;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('정상적으로 삭제되지 않았습니다.');
        DBMS_OUTPUT.PUT_LINE('사원번호를 확인해주세요');
    END IF;
END;
/

-- 2. IF ~ ELSE문: 하나의 조건식, 결과는 참과 거짓 각각
DECLARE
    v_result NUMBER(4,0);
    
BEGIN
    -- COUNT : 그룹함수 중에 유일하게 0 처리 가능함
    SELECT COUNT(employee_id)
    INTO   v_result
    FROM   employees
    WHERE  manager_id = &사원번호;
    
    IF v_result = 0 THEN
        DBMS_OUTPUT.PUT_LINE('일반사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('팀장입니다.');
        DBMS_OUTPUT.PUT_LINE('부하직원: ' || v_result || '명');
    END IF;
    
END;
/

-- 3. IF ~ ELSIF ~ ELSE문 : 다중 조건식이 필요, 가가각 결과처리
-- 1) 연차 구하는 공식: 소수점 버림(TRUNC)
SELECT employee_id,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12, 0)
FROM   employees;

-- 2) PL/SQL문
DECLARE
    v_hyear NUMBER(2,0);

BEGIN
    SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12, 0)
    INTO   v_hyear
    FROM   employees
    WHERE  employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('입사연차: ' || v_hyear || '년');
    
    -- 비교되는 값 정렬되도록 작성(오름차순/내림차순)
    IF v_hyear < 5 THEN
        DBMS_OUTPUT.PUT_LINE('입사한 지 5년 미만입니다.');
    
    ELSIF v_hyear < 10 THEN
        DBMS_OUTPUT.PUT_LINE('입사한 지 5년 이상 10년 미만 입니다.');
        
    ELSIF v_hyear < 15 THEN
        DBMS_OUTPUT.PUT_LINE('입사한 지 10년 이상 15년 미만 입니다.');
    
    ELSIF v_hyear < 20 THEN
        DBMS_OUTPUT.PUT_LINE('입사한 지 15년 이상 20년 미만 입니다.');
    
    ELSE
        DBMS_OUTPUT.PUT_LINE('입사한 지 20년 이상입니다.');
        
    END IF;
END;
/

/*
Q3-1.
사원번호를 입력(치환변수 &사용)
입사일이 2015년 이후(2015년 포함)이면 'New Employee' 출력
         2015년 이전이면 'Career Employee' 출력
*/

-- 1) 입사일 구하기
SELECT hire_date
FROM   employees
WHERE  employee_id = &사원번호;

-- 2) PL/SQL문
DECLARE
    v_hdate employees.hire_date%TYPE;

BEGIN
    SELECT hire_date
    INTO   v_hdate
    FROM   employees
    WHERE  employee_id = &사원번호;
    
    IF TO_NUMBER(TO_CHAR(v_hdate, 'YYYY')) >= 2015 THEN
--  IF v_hdate >= TO_DATE('2015/01/01', 'YYYY/MM/DD') THEN
        DBMS_OUTPUT.PUT_LINE('New Employee');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Career Employee');
    END IF;
END;
/

/*
Q3-2.
사원번호를 입력(치환변수 &사용)
입사일이 2015년 이후(2015년 포함)이면 'New Employee' 출력
         2015년 이전이면 'Career Employee' 출력
단  DBMS_OUTPUT.PUT_LINE~ 한번만 사용
*/
DECLARE
    v_hdate employees.hire_date%TYPE;
    v_result VARCHAR(100);

BEGIN
    SELECT hire_date
    INTO   v_hdate
    FROM   employees
    WHERE  employee_id = &사원번호;
    
    IF v_hdate >= TO_DATE('2015/01/01', 'YYYY/MM/DD') THEN
        v_result := 'New Employee';
    ELSE
        v_result := 'Career Employee';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/


-- ※ yy, rr 차이
--   yy: 현재 세기(2000년대)
--   rr: 세기 걸침(0~49 -> 2000년대 / 50~99 -> 1900년대)
SELECT TO_DATE('99/01/01', 'rr/MM/dd'),     -- 2099년 1월 1일
       TO_DATE('99/01/01', 'yy/MM/dd')      -- 1999년 1월 1일
FROM   dual;

/*
Q4. 다중IF문 문제
급여가 5000이하면 20% 인상된 급여
급여가 10000이하면 15% 인상된 급여
급여가 15000이하면 10% 인상된 급여
급여가 15001이상이면 급여 인상 없음

사원번호를 입력(치환변수 &사용)
사원이름, 급여, 인상된 급여 출력하는 PL/SQL문 블록 생성

의사코드
=>
입력 : 사원번호
연산 : 1) SELECT문 employees
       2) IF문 이용해서 급여 결정
          -> 조건식: 기준, 급여
출력 : 사원이름, 급여, 인상된 급여
*/

DECLARE
    v_name     employees.last_name%TYPE;
    v_sal      employees.salary%TYPE;
    v_increase NUMBER(4, 1);
    v_result   v_sal%TYPE;
BEGIN
    SELECT last_name, salary
    INTO   v_name, v_sal
    FROM   employees
    WHERE  employee_id = &사원번호;
    
    IF v_sal <= 5000 THEN
        v_increase := 20;
    ELSIF v_sal <= 10000 THEN
        v_increase := 15;
    ELSIF v_sal <= 15000 THEN
        v_increase := 10;
    ELSE
        v_increase := 0;
    END IF;

    v_result := v_sal + (v_sal * v_increase / 100);
    DBMS_OUTPUT.PUT_LINE('사원이름    : ' || v_name);
    DBMS_OUTPUT.PUT_LINE('급여        : ' || v_sal);
    DBMS_OUTPUT.PUT_LINE('인상된 급여 : ' || v_result);
END;
/


-- < LOOP문 >
/*
1. 기본 LOOP
    - 반복 조건 없음(무한루프)
    - EXIT 문을 통한 LOOP 종료 필수(종료조건)

2. WHILE LOOP
    - WHILE ~ LOOP ~ END LOOP
    - WHILE문이 갖고 있는 조건 만족하면 반복 실행
    - 조건 먼저 체크 => 만족시 반복 / 불만족시 종료
 
3. FOR LOOP
    - 횟수 기준 반복
    - ★ COUNTER: 정수형 임시변수, 암시적으로 선언됨(readonly, 값 변경 불가능)
                 DECLARE 절에 선언 안함
                 정수 기반 범위 지정 => 그 사이 모든 정수값 counter에 들어감(1씩 증가)
                 lower bound(최소값) / upper bound(최대값)
               ★ 항상 최소값 먼저 => 그 다음 최대값 순서
                 lower bound가 upper bound보다 크면 LOOP 안돌아감
                 내림차순 : reverse 추가 (최소값/최대값 순서 바꾸기 X)
                 양의 정수 + 음의 정수 가능
     
EXIT: LOOP 종료
      독립적, 어떤 LOOP문에서도 사용 가능
      종료하는 조건 작성
*/

-- 1. 기본 LOOP문
DECLARE
    v_num NUMBER(38,0) := 0;
BEGIN
    LOOP 
        v_num := v_num + 1;
        DBMS_OUTPUT.PUT_LINE(v_num);
        EXIT WHEN v_num >= 5;
    END LOOP;
END;
/

-- 2. WHILE LOOP
DECLARE
    -- 초기값이 while 조건 만족 못하면 아예 실행 안됨
    v_num NUMBER(38,0) := 0;
BEGIN
    WHILE v_num < 5 LOOP
        v_num := v_num + 1;
        DBMS_OUTPUT.PUT_LINE(v_num);
    END LOOP;
END;
/

-- 3. FOR LOOP
-- DECLARE절 없어도 변수 사용+출력 가능
BEGIN
    -- counter 변수 idx
    FOR idx IN -10..5 LOOP
        -- MOD: 나머지 함수
        -- '<>' == '!='
        IF MOD(idx, 2) <> 0 THEN
            DBMS_OUTPUT.PUT_LINE(idx);
        END IF;
    END LOOP;
END;
/

-- 주의사항(1) : 최소값, 최대값 자리 바뀌면 LOOP 안돌아감
--              내림차순 정렬 => REVERSE
BEGIN
    FOR idx IN REVERSE -10..5 LOOP 
        IF MOD(idx, 2) <> 0 THEN
            DBMS_OUTPUT.PUT_LINE(idx);
        END IF;
    END LOOP;
END;
/

-- 주의사항(2) : COUNTER 변수명과 중복되는 변수명 선언 금지
--               COUNTER 변수 값 변경 불가능
DECLARE
    v_num NUMBER(2,0) := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_num);
    v_num := v_num * 2;
    DBMS_OUTPUT.PUT_LINE(v_num);
    DBMS_OUTPUT.PUT_LINE('========================================');
    FOR v_num IN 1..10 LOOP
        -- v_num := v_num * 2;
        DBMS_OUTPUT.PUT_LINE(v_num * 2);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_num);
END;
/

/*
Q5. 1 ~ 10까지 정수값의 합

num = 1 / sum = 0
->
sum += num
num += 1
num > 10 반복
*/

-- 1) 기본 LOOP
DECLARE
    v_num NUMBER(2, 0) := 1;
    v_sum NUMBER(2, 0) := 0;
BEGIN
    LOOP
        v_sum := v_sum + v_num;
        v_num := v_num + 1;
        EXIT WHEN v_num > 10;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum);
END;
/

-- 2) WHILE LOOP
DECLARE
    v_num NUMBER(2, 0) := 1;
    v_sum NUMBER(2, 0) := 0;
BEGIN
    WHILE v_num <= 10 LOOP
        v_sum := v_sum + v_num;
        v_num := v_num + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum);
END;
/

-- 3) FOR LOOP
DECLARE
    v_sum NUMBER(2, 0) := 0;
BEGIN
    FOR num IN 1..10 LOOP
        v_sum := v_sum + num;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum);
END;
/

/*
과제

1.
*
**
***
****
***** 출력
*/

-- 1. 기본 LOOP
DECLARE
    v_star VARCHAR2(10) := '';
    v_num NUMBER(2,0) := 1;
BEGIN
    LOOP
        v_star := v_star || '*';
        v_num := v_num + 1;
        DBMS_OUTPUT.PUT_LINE(v_star);
        EXIT WHEN v_num > 5;
    END LOOP;
END;
/

-- 2. WHILE LOOP
DECLARE
    v_star VARCHAR2(10) := '';
    v_num NUMBER(2,0) := 1;
BEGIN
    WHILE v_num <= 5 LOOP
        v_star := v_star || '*';
        v_num := v_num + 1;
        DBMS_OUTPUT.PUT_LINE(v_star);
    END LOOP;
END;
/

-- 3. FOR LOOP
DECLARE
    v_star VARCHAR2(10) := '';
BEGIN
    FOR num IN 1..5 LOOP
        v_star := v_star || '*';
        DBMS_OUTPUT.PUT_LINE(v_star);
    END LOOP;
END;
/

COMMIT;
