-- 2024-02-19 PL/SQL TEST
-- 2.
DECLARE
    v_eid employees.employee_id%TYPE := &사원번호;
    v_dname departments.department_name%TYPE;
    v_jobid employees.job_id%TYPE;
    v_sal employees.salary%TYPE;
    v_annual v_sal%TYPE;
BEGIN
    SELECT d.department_name,
           e.job_id,
           NVL(e.salary,0),
           NVL(e.salary,0)*(1+NVL(e.commission_pct, 0))*12 annual
    INTO   v_dname,
           v_jobid,
           v_sal,
           v_annual
    FROM   employees e JOIN departments d
           ON e.department_id = d.department_id
    WHERE  e.employee_id = v_eid;
    
    DBMS_OUTPUT.PUT('부서이름 : ' || v_dname);
    DBMS_OUTPUT.PUT(', job_id : ' || v_jobid);
    DBMS_OUTPUT.PUT(', 급여 : ' || v_sal);
    DBMS_OUTPUT.PUT_LINE(', 연간 총수입 : ' || v_annual);
END;
/


-- 3.
DECLARE
    v_eid employees.employee_id%TYPE := &사원번호;
    v_date employees.hire_date%TYPE;
BEGIN
    SELECT hire_date
    INTO   v_date
    FROM   employees
    WHERE  employee_id = v_eid;
    
    IF TO_NUMBER(TO_CHAR(v_date, 'YYYY')) > 2015 THEN
        DBMS_OUTPUT.PUT_LINE('New employee');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Career employee');
    END IF;
END;
/


-- 4.
BEGIN
    FOR dan IN 1..9 LOOP
        IF dan MOD 2 = 1 THEN
            FOR num IN 1..9 LOOP
                DBMS_OUTPUT.PUT_LINE(dan || ' x ' || num || ' = ' || dan*num);
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
    END LOOP;
END;
/


-- 5.
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id,
               last_name,
               salary
        FROM   employees
        WHERE  department_id = &부서번호;
    
BEGIN
    FOR emp_info IN emp_cursor LOOP
        DBMS_OUTPUT.PUT('사번 : ' || emp_info.employee_id);
        DBMS_OUTPUT.PUT(', 이름 : ' || emp_info.last_name);
        DBMS_OUTPUT.PUT_LINE(', 급여 : ' || emp_info.salary);
    END LOOP;
END;
/


-- 6.
CREATE OR REPLACE PROCEDURE emp_pro
    (p_eid NUMBER,
     p_sal_increase NUMBER)
IS
    e_no_emp EXCEPTION;
BEGIN
    UPDATE employees
    SET    salary = salary * (1 + p_sal_increase / 100)
    WHERE  employee_id = p_eid;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_no_emp;
    END IF;
    
EXCEPTION
    WHEN e_no_emp THEN
        DBMS_OUTPUT.PUT_LINE('No search employee!!');
END;
/

SELECT *
FROM   employees;

EXECUTE emp_pro(1000, 10);


-- 7.
CREATE OR REPLACE FUNCTION age_gender_func
    (p_jumin_id VARCHAR2)
    RETURN VARCHAR2
IS
    v_birthday DATE;
    v_age NUMBER(3,0);
    v_gender VARCHAR(10);
BEGIN
    -- 생년월일 
    IF SUBSTR(p_jumin_id, 7, 1) IN (1, 2) THEN
        v_birthday := TO_DATE('19' || SUBSTR(p_jumin_id, 1, 6), 'YYYYMMDD');
    ELSE
        v_birthday := TO_DATE('20' || SUBSTR(p_jumin_id, 1, 6), 'YYYYMMDD');
    END IF;
    
    -- 만 나이
    v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, v_birthday)/12);
    
    -- 성별
    IF SUBSTR(p_jumin_id, 7, 1) IN (1, 3) THEN
        v_gender := '남';
    ELSE
        v_gender := '여';
    END IF;
    
    RETURN '만 나이 : ' || v_age || ', 성별 : ' || v_gender;
END;
/

SELECT age_gender_func('0211023234567')
FROM   dual;


-- 8.
CREATE OR REPLACE FUNCTION year_func
    (p_eid NUMBER)
    RETURN NUMBER
IS
    v_result NUMBER(2,0) := 0;
BEGIN
    SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12, 0)
    INTO   v_result
    FROM   employees
    WHERE  employee_id = p_eid;
    
    RETURN v_result;
END;
/

SELECT year_func(143)
FROM   dual;


-- 9.
CREATE OR REPLACE FUNCTION mgr_func
    (p_dname VARCHAR2)
    RETURN VARCHAR2
IS
    v_result employees.last_name%TYPE;
BEGIN
    SELECT last_name
    INTO   v_result
    FROM   employees
    WHERE  employee_id = ( SELECT manager_id
                           FROM   departments
                           WHERE  department_name = p_dname);
    RETURN v_result;
END;
/

SELECT mgr_func('Executive')
FROM   dual;


-- 10.
SELECT name, text
FROM   user_source
WHERE  type IN ('PROCEDURE', 'FUNCTION', 'PACKAGE', 'PACKAGE BODY');


-- 11.
DECLARE
    v_bar VARCHAR2(100) := '';
    v_star VARCHAR2(100) := '';
    v_height NUMBER(2,0) := 9;
BEGIN 
    FOR i IN REVERSE 1..v_height LOOP
        FOR j IN 1..i LOOP
            v_bar := v_bar || '-';
        END LOOP;
        DBMS_OUTPUT.PUT(v_bar);
        v_bar := '';
        
        v_star := v_star || '*';
        DBMS_OUTPUT.PUT_LINE(v_star);
    END LOOP;   
END;
/
