--20240219 PL/SQL Function
SET SERVEROUTPUT ON;

-- 함수 선언
CREATE OR REPLACE FUNCTION test_func
(p_msg IN VARCHAR2)
RETURN VARCHAR2

IS
    -- 선언부
BEGIN
    
    RETURN p_msg;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '데이터가 존재하지 않습니다.';
END;
/

-- 함수 실행
-- 함수 return 값 담을 변수 선언해서 대입(변수 없으면 프로시저로 인식 => 오류)
DECLARE
    v_result VARCHAR2(1000);
BEGIN
    v_result := test_func('테스트');
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

-- 함수: PL/SQL 밖 SQL문에서도 사용 가능
-- 함수는 dual 테이블에서 호출 가능(프로시저는 불가능)
SELECT test_func('SELECT문에서 호출')
FROM   dual;

-- 일반 테이블에서 함수 실행시 모든 데이터마다 전부 실행됨
SELECT test_func('SELECT문에서 호출')
FROM   employees;

-- 계정 객체 정보 접근
SELECT *
FROM   user_source
WHERE  type IN ('PROCEDURE'); -- 프로시저 객체 정보 확인

-- 덧셈 함수
CREATE OR REPLACE FUNCTION y_sum
(p_x IN NUMBER, 
 p_y IN NUMBER)
RETURN NUMBER
IS
    v_result NUMBER;
BEGIN
    v_result := p_x + p_y;
    return v_result;
END;
/

SELECT y_sum(100, 200)
FROM   dual;

-- 사원번호를 기준으로 직속상사 이름을 출력
CREATE OR REPLACE FUNCTION get_mgr
(p_eid employees.employee_id%TYPE)
RETURN VARCHAR2
IS
    v_result employees.last_name%TYPE;
BEGIN
    -- SELF JOIN 사용(e: 사원 테이블 / m: 상사 테이블)
    SELECT m.last_name
    INTO   v_result
    FROM   employees e JOIN employees m
           ON e.manager_id = m.employee_id
    WHERE  e.employee_id = p_eid;
    
    RETURN v_result;
    
EXCEPTION
    -- 오라클에 정의된 예외 처리
    WHEN NO_DATA_FOUND THEN
        -- 리턴 타입에 맞게 리턴값 작성
        RETURN '직속 상사가 존재하지 않습니다.';
END;
/

-- SELECT문 전체 사원 상사이름 출력
SELECT employee_id, last_name, get_mgr(employee_id) as manager
FROM   employees
ORDER BY 1;

/*
Function 문제

Q1.
사원번호를 입력하면 
last_name + first_name 이 출력되는 
y_yedam 함수를 생성하시오.

실행) EXECUTE DBMS_OUTPUT.PUT_LINE(y_yedam(174))
출력 예)  Abel Ellen

SELECT employee_id, y_yedam(employee_id)
FROM   employees;

*/

CREATE OR REPLACE FUNCTION y_yedam
(p_eid employees.employee_id%TYPE)
RETURN VARCHAR2
IS
    v_last_name employees.last_name%TYPE;
    v_first_name employees.first_name%TYPE;
    v_result employees.last_name%TYPE;
BEGIN
    SELECT last_name, first_name
    INTO   v_last_name, v_first_name
    FROM   employees
    WHERE  employee_id = p_eid;
    
    RETURN v_last_name || ' ' || v_first_name;
END;
/

EXECUTE DBMS_OUTPUT.PUT_LINE(y_yedam(174));

SELECT employee_id, y_yedam(employee_id)
FROM   employees;

/*
Q2.
사원번호를 입력할 경우 다음 조건을 만족하는 결과가 출력되는 ydinc 함수를 생성하시오.
- 급여가 5000 이하이면 20% 인상된 급여 출력
- 급여가 10000 이하이면 15% 인상된 급여 출력
- 급여가 20000 이하이면 10% 인상된 급여 출력
- 급여가 20000 이상이면 급여 그대로 출력
실행) SELECT last_name, salary, YDINC(employee_id)
     FROM   employees;
*/

CREATE OR REPLACE FUNCTION ydinc
(p_eid employees.employee_id%TYPE)
RETURN NUMBER
IS
    v_sal employees.salary%TYPE;
    v_result employees.salary%TYPE;

BEGIN
    SELECT salary
    INTO   v_sal
    FROM   employees
    WHERE  employee_id = p_eid;
    
    IF v_sal <= 5000 THEN
        v_result := v_sal* 1.2;
    ELSIF v_sal <= 10000 THEN
        v_result := v_sal* 1.15;
    ELSIF v_sal <= 20000 THEN
        v_result := v_sal* 1.1;
    ELSE
        v_result := v_sal;
    END IF;
    
    RETURN v_result;
END;
/

SELECT last_name, 
       salary, 
       YDINC(employee_id)
FROM   employees;

/*

Q3.
사원번호를 입력하면 해당 사원의 연봉이 출력되는 yd_func 함수를 생성하시오.
->연봉계산 : (급여+(급여*인센티브퍼센트))*12
실행) SELECT last_name, salary, YD_FUNC(employee_id)
     FROM   employees;
     
*/

CREATE OR REPLACE FUNCTION yd_func
(p_eid employees.employee_id%TYPE)
RETURN NUMBER
IS
    v_sal employees.salary%TYPE;
    v_comm employees.commission_pct%TYPE;
    v_result v_sal%TYPE;

BEGIN
    SELECT salary, commission_pct
    INTO   v_sal, v_comm
    FROM   employees
    WHERE  employee_id = p_eid;

    v_result := (v_sal + (v_sal * NVL(v_comm, 0))) * 12; 
    RETURN v_result;
END;
/

SELECT last_name, 
       salary,
       commission_pct,
       YD_FUNC(employee_id)
FROM   employees;

/*
Q4. 
SELECT last_name, subname(last_name)
FROM   employees;

LAST_NAME     SUBNAME(LA
------------ ------------
King         K***
Smith        S****
...
예제와 같이 출력되는 subname 함수를 작성하시오.
*/

CREATE OR REPLACE FUNCTION subname
(p_ename employees.last_name%TYPE)
RETURN VARCHAR2
IS
    v_ename employees.last_name%TYPE;
    v_result v_ename%TYPE;
BEGIN
    SELECT last_name
    INTO   v_ename
    FROM   employees
    WHERE  last_name = p_ename;

    v_result := RPAD(SUBSTR(v_ename, 1, 1), LENGTH(v_ename), '*');
    RETURN v_result;
END;
/

SELECT last_name, 
       subname(last_name)
FROM   employees;
