-- 서버 설정(임시설정) => 수시로 풀림 ㅠ
SET SERVEROUTPUT ON;

-- PL/SQL
-- BEGIN~END : 블럭
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, World!');
END;
/   
-- / : 해당 블럭 컴파일, 실행 명령어(필수) => 독립된 한줄로 표기


DECLARE
    -- DECLARE(선언부): 정의 및 선언
    -- NUMBER(9,2): 총 길이 9자리 = 실수 7자리 + 소수 2자리
    -- 치환변수 &: 컴파일하기 전 미완성 형태 => 치환변수 해결 후 컴파일
    --            블럭 위치 상관없이 사용 가능
    v_annual NUMBER(9,2) := &연봉;
    -- TYPE: 이미 존재하는 변수/테이블 참조
    v_sal v_annual%TYPE;
    
BEGIN
    -- BEGIN(실행부)
    -- 한줄 끝날때 마다 세미콜론
    v_sal := v_annual/12;
    DBMS_OUTPUT.PUT_LINE('The monthly salary is ' || TO_CHAR(v_sal));

END;
/
-- 중첩 블록
DECLARE
    v_weight NUMBER(3) := 600;
    v_message VARCHAR2(255):='Product 10012';
    v_new_locn VARCHAR2(50);
BEGIN
    DECLARE
        v_weight NUMBER(7,2) := 50000;
        v_message VARCHAR2(255) := 'Product 11001';
        v_new_locn VARCHAR2(50) := 'Europe';
    BEGIN
        v_weight := v_weight + 1;
        v_new_locn := 'Western ' || v_new_locn;
        DBMS_OUTPUT.PUT_LINE(v_weight);
        DBMS_OUTPUT.PUT_LINE(v_message);
        DBMS_OUTPUT.PUT_LINE(v_new_locn);
    END;

    v_weight := v_weight + 1;
    v_message := v_message || ' is in stock';
    v_new_locn := 'Western ' || v_new_locn;
    DBMS_OUTPUT.PUT_LINE(v_weight);
    DBMS_OUTPUT.PUT_LINE(v_message);
    DBMS_OUTPUT.PUT_LINE(v_new_locn);
END;
/

-- 중첩블록 Sample
DECLARE
    v_sal NUMBER(7,2) := 60000;
    v_comm v_sal%TYPE := v_sal * .20;
    v_message VARCHAR2(255) := ' eligible for commission';
BEGIN
    DBMS_OUTPUT.PUT_LINE('v_sal ' || v_sal);                        -- v_sal 60000
    DBMS_OUTPUT.PUT_LINE('v_comm ' || v_comm);                      -- v_comm 12000
    DBMS_OUTPUT.PUT_LINE('v_message ' || v_message);                -- v_message  eligible for commission
    DBMS_OUTPUT.PUT_LINE('================================');       -- ================================
    DECLARE 
        v_sal NUMBER(7,2) := 50000;
        v_comm v_sal%TYPE := 0;
        v_total_comp NUMBER(7,2) := v_sal + v_comm;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('v_sal ' || v_sal);                    -- v_sal 50000
        DBMS_OUTPUT.PUT_LINE('v_comm ' || v_comm);                  -- v_comm 0 
        DBMS_OUTPUT.PUT_LINE('v_message ' || v_message);            -- v_message  eligible for commission
        DBMS_OUTPUT.PUT_LINE('v_total_comp ' || v_total_comp);      -- v_total_comp 50000
        DBMS_OUTPUT.PUT_LINE('================================');   -- ================================
        v_message := 'CLERK not' || v_message;
        v_comm := v_sal * .30;
    END;
    DBMS_OUTPUT.PUT_LINE('v_sal ' || v_sal);                        -- v_sal 60000
    DBMS_OUTPUT.PUT_LINE('v_comm ' || v_comm);                      -- v_comm 12000
    DBMS_OUTPUT.PUT_LINE('v_message ' || v_message);                -- v_message CLERK not eligible for commission
    DBMS_OUTPUT.PUT_LINE('================================');       -- ================================
    v_message := 'SALESMAN ' || v_message;
    DBMS_OUTPUT.PUT_LINE('v_message ' || v_message);                -- v_message SALESMAN CLERK not eligible for commission
END;
/


-- PL/SQL의 SQL문
-- SELECT문
-- : 변수 필요 => DECLARE절 필요
DECLARE
    v_eid   employees.employee_id%type;
    v_ename VARCHAR2(100);
BEGIN
    SELECT employee_id, last_name
    INTO   v_eid, v_ename   -- 변수 개수 = SELECT절 칼럼 수
    FROM   employees
    WHERE  employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || v_eid);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_ename);
END;
/