-- < PL/SQL >
SET SERVEROUTPUT ON;

-- < LOOP 이어서 >
/*

Q2.
치환변수(&) 사용하여 숫자 입력하면 
해당 구구단 출력

=> 치환변수: 변수, 단을 입력
=> 곱하는 수: 1~9, 정수값 => LOOP문

*/

-- 1. 기본 LOOP => 조건과 관련된 변수 필수
DECLARE
    v_dan CONSTANT NUMBER(2,0) := &단수;
    v_num NUMBER(2,0) := 1;
BEGIN  
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || v_dan*v_num);
        v_num := v_num + 1;
        EXIT WHEN v_num > 9;
    END LOOP;
END;
/

-- 2. WHILE LOOP => 조건과 관련된 변수 필수
DECLARE
    v_dan NUMBER(2,0) := &단수;
    v_num NUMBER(2,0) := 1;
BEGIN
    WHILE v_num <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || v_dan*v_num);
        v_num := v_num + 1;
    END LOOP;
END;
/

-- 3. FOR LOOP => 조건 변수 요구 X
DECLARE
    v_dan NUMBER(2,0) := &단수;
BEGIN
    FOR num IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || num || ' = ' || v_dan*num);
    END LOOP;
END;
/

/*

Q3.
구구단 2~9단 출력

*/

-- 1. 기본 LOOP
DECLARE
    v_dan NUMBER(2,0) := 2;
    v_num NUMBER(2,0) := 1;
BEGIN
    LOOP
        LOOP
            DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || v_dan*v_num);
            v_num := v_num + 1;
            EXIT WHEN v_num > 9;
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('');
        v_num := 1;
        v_dan := v_dan + 1;
        EXIT WHEN v_dan > 9;
    END LOOP;
END;
/

-- 2. WHILE LOOP
DECLARE
    v_dan NUMBER(2,0) := 2;
    v_num NUMBER(2,0) := 1;
BEGIN
    WHILE v_dan <= 9 LOOP
        WHILE v_num <= 9 LOOP
            DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || v_dan*v_num);
            v_num := v_num + 1;
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('');
        v_num := 1;
        v_dan := v_dan + 1;
    END LOOP;
END;
/

-- 3. FOR LOOP
BEGIN
    FOR dan IN 2..9 LOOP
        FOR num IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(dan || ' * ' || num || ' = ' || dan*num);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/


/*

Q3-1.
구구단 2~9단 출력 (옆으로 나열)

*/

-- 1. 기본 LOOP
DECLARE
    v_dan NUMBER(2,0) := 2;
    v_num NUMBER(2,0) := 1;
BEGIN
    LOOP
        LOOP
            DBMS_OUTPUT.PUT(v_dan || ' * ' || v_num || ' = ' || v_dan*v_num || CHR(9)); 
            -- CHR(9): 탭 문자
            v_dan := v_dan + 1;
            EXIT WHEN v_dan > 9;
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('');
        v_dan := 2;
        v_num := v_num + 1;
        EXIT WHEN v_num > 9;
    END LOOP;
END;
/

-- 2. WHILE LOOP
DECLARE
    v_dan NUMBER(2,0) := 2;
    v_num NUMBER(2,0) := 1;
BEGIN
    WHILE v_num <= 9 LOOP
        WHILE v_dan <= 9 LOOP
            DBMS_OUTPUT.PUT(v_dan || ' * ' || v_num || ' = ' || v_dan*v_num || CHR(9)); 
            v_dan := v_dan + 1;
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('');
        v_dan := 2;
        v_num := v_num + 1;
    END LOOP;
END;
/

-- 3. FOR LOOP
BEGIN
    FOR num IN 1..9 LOOP
        FOR dan IN 2..9 LOOP
            DBMS_OUTPUT.PUT(dan || ' * ' || num || ' = ' || dan*num || CHR(9));
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/

/*

Q4.
구구단 1~9단 출력 (홀수단만 출력)

: MOD(실제값, 나누는 값): 나머지
*/

-- 1. 기본 LOOP
DECLARE
    v_dan NUMBER(2,0) := 1;
    v_num NUMBER(2,0) := 1;
BEGIN
    LOOP
        IF(MOD(v_dan, 2)) <> 0 THEN
            v_num := 1;
            LOOP    
                DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || v_dan*v_num);
                v_num := v_num + 1;
                EXIT WHEN v_num > 9;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
        
        v_dan := v_dan + 1;
        EXIT WHEN v_dan > 9;
    END LOOP;
END;
/

-- 2. WHILE LOOP
DECLARE
    v_dan NUMBER(2,0) := 1;
    v_num NUMBER(2,0) := 1;
BEGIN
    WHILE v_dan <= 9 LOOP
        IF(MOD(v_dan, 2)) <> 0 THEN
            v_num := 1;
            WHILE v_num <= 9 LOOP    
                DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || v_dan*v_num);
                v_num := v_num + 1;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
        
        v_dan := v_dan + 1;
    END LOOP;
END;
/

-- 3. FOR LOOP + IF문
BEGIN
    FOR dan IN 1..9 LOOP
        IF MOD(dan, 2) <> 0 THEN
            FOR num IN 1..9 LOOP
                DBMS_OUTPUT.PUT_LINE(dan || ' * ' || num || ' = ' || dan*num);
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
    END LOOP;
END;
/

--3-1. FOR LOOP + IF문 + CONTINUE
BEGIN
    FOR dan IN 1..9 LOOP
        IF MOD(dan, 2) = 0 THEN
            CONTINUE;
        END IF;
        
        FOR num IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(dan || ' * ' || num || ' = ' || dan*num);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/


-- < 조합 데이터 유형 >

-- 1. RECORD
DECLARE
    -- (1) 정의
    TYPE emp_record_type IS RECORD
        (empno NUMBER(6,0), 
         ename employees.last_name%TYPE,
         sal   employees.salary%TYPE := 0);
        
    -- (2) 변수선언
    v_emp_info   emp_record_type;
    v_emp_record emp_record_type;
BEGIN
    -- 3개의 칼럼 데이터를 1개 변수의 3개 필드에 저장
    -- 필드 순서 중요! -> 순서 바뀌면 데이터 타입 불일치
    SELECT employee_id, last_name, salary
    INTO   v_emp_info
    FROM   employees
    WHERE  employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT('사원번호 : ' || v_emp_info.empno);
    DBMS_OUTPUT.PUT(', 사원이름 : ' || v_emp_info.ename);
    DBMS_OUTPUT.PUT_LINE(', 급여 : ' || v_emp_info.sal);
END;
/

-- 1-1. RECORD : %ROWTYPE
DECLARE
    -- %ROWTYPE: 테이블의 칼럼명, 데이터 타입 복사 => 필드명, 필드의 데이터 타입
    v_emp_info employees%ROWTYPE;

BEGIN
    SELECT *
    INTO   v_emp_info
    FROM   employees
    WHERE  employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT('사원번호 : ' || v_emp_info.employee_id);
    DBMS_OUTPUT.PUT(', 사원이름 : ' || v_emp_info.last_name);
    DBMS_OUTPUT.PUT_LINE(', 업무 : ' || v_emp_info.job_id);
END;
/

-- 2. TABLE
-- 스칼라 or 레코드 데이터 유형
-- 테이블 안에 테이블 들어갈 수 없음
DECLARE
    -- (1) 정의
    TYPE num_table_type IS TABLE OF NUMBER
        INDEX BY PLS_INTEGER;
    
    -- (2) 변수선언
    v_num_info num_table_type;
BEGIN
    -- 인덱스()
    -- 테이블은 초기화 돼있지 않음 => 값 담고 사용해야함
    v_num_info(-1000) := 10000;
    
    DBMS_OUTPUT.PUT_LINE('현재 인덱스 -1000 : ' || v_num_info(-1000));
END;
/

-- 2의 배수 10개를 담는 예제 
--  : 2, 4, 6, 8, 10, 12, 14, ...
DECLARE
    TYPE num_table_type IS TABLE OF NUMBER
        INDEX BY PLS_INTEGER;
    
    v_num_ary num_table_type;
    v_result NUMBER(4,0) := 0;
BEGIN
    FOR idx IN 1..10 LOOP
        v_num_ary(idx) := idx * 2;
    END LOOP;
    
    -- FIRST, LAST => 최소 인덱스, 최대 인덱스
    FOR i IN v_num_ary.FIRST..v_num_ary.LAST LOOP
        IF v_num_ary.EXISTS(i) THEN
            DBMS_OUTPUT.PUT(i || ' : ');
            DBMS_OUTPUT.PUT_LINE(v_num_ary(i));
            v_result := v_result + v_num_ary(i);
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('총 개수 : ' || v_num_ary.COUNT);
    DBMS_OUTPUT.PUT_LINE('누적 합 : ' || v_result);

END;
/

-- 100~104번 사원 정보를 테이블에 담기
DECLARE
    TYPE emp_table_type IS TABLE OF employees%ROWTYPE
        INDEX BY PLS_INTEGER;
    
    v_emps emp_table_type;
    v_emp_info employees%ROWTYPE;
BEGIN
    FOR eid IN 100..104 LOOP
        SELECT *
        INTO   v_emp_info
        FROM   employees
        WHERE  employee_id = eid;
        
        v_emps(eid) := v_emp_info;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('총 개수 : ' || v_emps.COUNT);
    DBMS_OUTPUT.PUT_LINE(v_emps(100).last_name);
END;
/

-- 모든 사원 정보를 테이블에 담기
DECLARE
    v_min employees.employee_id%TYPE; -- 최소 사원번호
    v_max employees.employee_id%TYPE; -- 최대 사원번호
    v_result NUMBER(1,0);             -- 사원의 존재유무를 확인
    v_emp_record employees%ROWTYPE;   -- Employees 테이블의 한 행에 대응
    
    TYPE emp_table_type IS TABLE OF v_emp_record%TYPE
        INDEX BY PLS_INTEGER;
    
    v_emp_table emp_table_type;
BEGIN
    -- 최소 사원번호, 최대 사원번호
    SELECT MIN(employee_id), MAX(employee_id)
    INTO v_min, v_max
    FROM employees;
    
    FOR eid IN v_min .. v_max LOOP
        SELECT COUNT(*)
        INTO v_result
        FROM employees
        WHERE employee_id = eid;
        
        IF v_result = 0 THEN
            CONTINUE;
        END IF;
        
        SELECT *
        INTO v_emp_record
        FROM employees
        WHERE employee_id = eid;
        
        v_emp_table(eid) := v_emp_record;     
    END LOOP;
    
    FOR eid IN v_emp_table.FIRST .. v_emp_table.LAST LOOP
        IF v_emp_table.EXISTS(eid) THEN
            DBMS_OUTPUT.PUT(v_emp_table(eid).employee_id || ', ');
            DBMS_OUTPUT.PUT(v_emp_table(eid).last_name || ', ');
            DBMS_OUTPUT.PUT_LINE(v_emp_table(eid).hire_date);
        END IF;
    END LOOP;    
END;
/


-- < Cursor >

/*
< 명시적 커서 >
활성 집합(Active Set) : 커서 내부에 실제 데이터가 있는 공간
현재 처리되고 있는 행 추적
필요에 따라 수동으로 제어 가능

*/
DECLARE
    -- (1) 커서를 선언 (= SELECT문에 이름 붙임)
    CURSOR emp_cursor IS
        -- SELECT문
        -- no data found 안뜸 -> 데이터 없어도 에러 X(결과 없어도 실행 가능)
        SELECT employee_id, last_name
        FROM   employees
        WHERE  employee_id = 0;
        
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
BEGIN
    -- (2) 커서 열기
    OPEN emp_cursor;
    
    -- (3) 커서에서 데이터 인출
    -- 가리키는 행 통째로 받음
    FETCH emp_cursor INTO v_eid, v_ename;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || v_eid);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_ename);
    
    -- (4) 커서 닫기
    CLOSE emp_cursor;
END;
/

-- %NOTFOUND 속성
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, job_id
        FROM   employees;
        
    v_emp_record emp_cursor%ROWTYPE;
BEGIN
    OPEN emp_cursor;
    
    LOOP
        -- LOOP안에서 FETCH, EXIT WHEN은 같이 움직임
        FETCH emp_cursor INTO v_emp_record;
        EXIT WHEN emp_cursor%NOTFOUND;  -- 더이상 새로운 데이터 못찾으면 종료
        
        -- EXIT WHEN 통과한 후 실제 연산 진행
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || '. ');
        DBMS_OUTPUT.PUT_LINE(v_emp_record.last_name);
    END LOOP;
    
    CLOSE emp_cursor;
    -- CLOSE된 이후 커서에 접근 X
END;
/

-- 커서 + 테이블 타입
-- 코드 길이 단축, SELECT 횟수 감소 => 성능 향상
DECLARE
    -- 커서 선언
    CURSOR emp_cursor IS
        SELECT *
        FROM   employees;
    
    v_emp_record employees%ROWTYPE;

    -- 테이블 타입 선언
    TYPE emp_table_type IS TABLE OF employees%ROWTYPE
        INDEX BY PLS_INTEGER;
    
    v_emp_table emp_table_type;
BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO v_emp_record;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        v_emp_table(v_emp_record.employee_id) := v_emp_record;
    END LOOP;
    
    FOR eid IN v_emp_table.FIRST .. v_emp_table.LAST LOOP
        IF v_emp_table.EXISTS(eid) THEN
            DBMS_OUTPUT.PUT(v_emp_table(eid).employee_id || ', ');
            DBMS_OUTPUT.PUT(v_emp_table(eid).last_name || ', ');
            DBMS_OUTPUT.PUT_LINE(v_emp_table(eid).hire_date);
        END IF;
    END LOOP; 
    
    CLOSE emp_cursor;

END;
/


-- %ROWCOUNT 속성
DECLARE
    CURSOR emp_dept_cursor IS
        SELECT employee_id, last_name, job_id
        FROM   employees
        WHERE  department_id = &부서번호;
    
    v_emp_info emp_dept_cursor%ROWTYPE;

BEGIN
    -- 1) 해당 부서에 속한 사원의 정보를 출력
    -- 2) 해당 부서에 속한 사원이 없는 경우 '해당 부서에 소속된 사원이 없습니다.'메세지 출력
    OPEN emp_dept_cursor;

    LOOP
        FETCH emp_dept_cursor INTO v_emp_info;
        EXIT WHEN emp_dept_cursor%NOTFOUND;
        
        -- %ROWCOUNT 들어가야 할 장소는?
        -- (1) 첫번째 위치 => 몇번째 행
        -- LOOP문 안에서 동작하는 %ROWCOUNT : 변동값
        -- 최대 크기 확인할 수 없음
        DBMS_OUTPUT.PUT_LINE('첫번째 : ' || emp_dept_cursor%ROWCOUNT);
        
        DBMS_OUTPUT.PUT('사원번호 : ' || v_emp_info.employee_id);
        DBMS_OUTPUT.PUT(', 사원이름 : ' || v_emp_info.last_name);
        DBMS_OUTPUT.PUT_LINE(', 업무 : ' || v_emp_info.job_id);
        
        
    END LOOP;
        -- (2) 두번째 위치 => 현재 캐서의 데이터 총 개수
        DBMS_OUTPUT.PUT_LINE('두번째 : ' || emp_dept_cursor%ROWCOUNT);
        
        IF emp_dept_cursor%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('해당 부서에 소속된 사원이 없습니다.');
        END IF;
    CLOSE emp_dept_cursor;
    
END;
/

-- Q1. 모든 사원의 사원번호, 이름, 부서이름 출력
DECLARE
    CURSOR emp_cursor IS 
        SELECT e.employee_id eid, e.last_name ename, d.department_name dname
        FROM   employees e
               LEFT OUTER JOIN departments d
               ON   e.department_id = d.department_id;
    v_emp_info emp_cursor%ROWTYPE;
BEGIN
    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO v_emp_info;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT('사원번호 : ' || v_emp_info.eid);
        DBMS_OUTPUT.PUT(', 사원이름 : ' || v_emp_info.ename);
        DBMS_OUTPUT.PUT_LINE(', 부서이름 : ' || v_emp_info.dname);
        
    END LOOP;

    CLOSE emp_cursor;
END;
/

-- Q2. 부서번호가 50이거나 80인 사원들의 사원이름, 급여, 연봉 출력
DECLARE
    CURSOR emp_cursor IS 
        SELECT last_name, 
               salary, 
               commission_pct
        FROM   employees
        WHERE  department_id IN (50, 80);
        
    v_emp_info emp_cursor%ROWTYPE;
    v_annual employees.salary%TYPE;
BEGIN
    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO v_emp_info;
        EXIT WHEN emp_cursor%NOTFOUND;
        v_annual := ((v_emp_info.salary) 
                + NVL(v_emp_info.salary,0)*NVL(v_emp_info.commission_pct,0))*12;
                
        DBMS_OUTPUT.PUT('사원이름 : ' || v_emp_info.last_name);
        DBMS_OUTPUT.PUT(', 급여 : ' || v_emp_info.salary);
        DBMS_OUTPUT.PUT_LINE(', 연봉 : ' || v_annual);
        
    END LOOP;

    CLOSE emp_cursor;
END;
/