-- 20240216 PL/SQL
SET SERVEROUTPUT ON;

-- < 명시적 커서 이어서 >

/*

< 커서 FOR LOOP >
- 범위로서 커서가 존재 : IN ~ LOOP 사이에 커서
    => ★ 커서 데이터 없으면 FOR LOOP 실행 안됨

- OPEN, FETCH, CLOSE 암시적으로 발생함
- 레코드 암시적으로 선언됨
- END LOOP ~ CLOSE 사이 존재 안함
- 커서 FOR LOOP 사용할 수 있는 경우
    => (1)커서 모든 데이터 순환해야하고 (2)커서에 빈값 없는게 보장되는 경우 
       커서 데이터 없고 특정 조건에서 LOOP 멈춰야할 경우 그냥 LOOP 사용

*/

-- 커서 FOR LOOP
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, 
               last_name
        FROM   employees;
BEGIN
/*
     커서 FOR LOOP
     - OPEN, FETCH, CLOSE 암시적 발생
        => 커서 FOR LOOP 안에서 커서 실행됨 => 커서 속성 접근 가능
     - counter 변수: 정수X, 레코드 들어감
     - 범위 : 커서 => 커서 데이터 없으면 FOR LOOP 실행 안됨
     - Q.커서가 실제 몇개인지 확인하고 싶다면(총 개수)?
        => LOOP문 끝나야지만 ROWCOUNT가 변경안되고 고정값 가짐
           but END LOOP = CLOSE => LOOP끝나면 커서 닫힘, 커서 속성 접근 불가(ISOPEN 제외)
        => 제한적으로 사용됨 => (1) 데이터 반드시 있고 (2) 순환하는 경우
                             해당 안되면 기본 LOOP 사용해야 함
*/
    FOR emp_record IN emp_cursor LOOP
        DBMS_OUTPUT.PUT('No. ' || emp_cursor%ROWCOUNT);
        DBMS_OUTPUT.PUT(', 사원번호 : ' || emp_record.employee_id);
        DBMS_OUTPUT.PUT_LINE(', 사원이름 : ' || emp_record.last_name);
    END LOOP;
    -- LOOP 끝나면 커서 속성 접근 불가
    -- DBMS_OUTPUT.PUT('Total : ' || emp_cursor%ROWCOUNT);
    
    -- FOR LOOP 범위에 커서 대신 서브쿼리 사용 가능
    --  => 이름 없어서 속성 사용불가, 다시 불러오기 불가
    --    
    FOR dept_info IN (SELECT *
                      FROM departments) LOOP
        DBMS_OUTPUT.PUT('부서번호 : ' || dept_info.department_id);
        DBMS_OUTPUT.PUT_LINE(', 부서이름 : ' || dept_info.department_name);
    END LOOP;
END;
/

-- Q1. 모든 사원의 사원번호, 이름, 부서이름 출력
DECLARE
    CURSOR emp_cursor IS
        SELECT e.employee_id, 
               e.last_name, 
               d.department_name
        FROM   employees e
               LEFT OUTER JOIN departments d
               ON e.department_id = d.department_id;
BEGIN
    FOR emp_record IN emp_cursor LOOP
        DBMS_OUTPUT.PUT('사원번호 : ' || emp_record.employee_id);
        DBMS_OUTPUT.PUT(', 사원이름 : ' || emp_record.last_name);
        DBMS_OUTPUT.PUT_LINE(', 부서이름 : ' || emp_record.department_name);
    END LOOP;
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
        
    v_annual employees.salary%TYPE;
BEGIN
    FOR emp_record IN emp_cursor LOOP
        v_annual := (emp_record.salary
                + NVL(emp_record.salary,0)*NVL(emp_record.commission_pct,0))*12;
                
        DBMS_OUTPUT.PUT('사원이름 : ' || emp_record.last_name);
        DBMS_OUTPUT.PUT(', 급여 : ' || emp_record.salary);
        DBMS_OUTPUT.PUT_LINE(', 연봉 : ' || v_annual);
    END LOOP;
END;
/

/*
매개변수 사용 커서
- OPEN 할때 매개변수 부여
- 값이 달라지지 커서 종류가 달라지지 않음

*/

-- 매개변수 사용 커서
DECLARE
    CURSOR emp_cursor 
        (p_mgr employees.manager_id%TYPE) IS 
            SELECT *
            FROM   employees
            WHERE  manager_id = p_mgr;
    
     v_emp_info emp_cursor%ROWTYPE;
BEGIN
    -- OPEN시 매개변수 넣어줌
    -- 해당 커서 불러내면서 비어있는 변수에 매개변수로 값 전달
    OPEN emp_cursor(100);
    
    LOOP
        FETCH emp_cursor INTO v_emp_info;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT('사원번호 : ' || v_emp_info.employee_id);
        DBMS_OUTPUT.PUT(', 사원이름 : ' || v_emp_info.last_name);
    END LOOP ;
    
--    FOR emp_info IN emp_cursor(149) LOOP
--        DBMS_OUTPUT.PUT('사원번호 : ' || v_emp_info.employee_id);
--        DBMS_OUTPUT.PUT(', 사원이름 : ' || v_emp_info.last_name);
--    END LOOP;
--    
    CLOSE emp_cursor;

END;
/

/*

Q1.
사원 테이블에서 사원의 사원번호, 사원이름, 입사연도를
다음 기준에 맞게 각각 test01, test02에 입력하세요.
입사년도가 2015년(포함) 이전 입사한 사원은 test01 테이블에 입력
입사년도가 2015년 이후 입사한 사원은 test02 테이블에 입력

*/
-- 테이블 생성
CREATE TABLE test01
AS
    SELECT employee_id,
           first_name, 
           hire_date
    FROM   employees
    WHERE  employee_id = 0;

CREATE TABLE test02
AS
    SELECT employee_id,
           first_name, 
           hire_date
    FROM   employees
    WHERE  employee_id = 0;

-- (1) 명시적 커서 + 기본 LOOP 사용
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id,
               first_name,
               hire_date
        FROM   employees;
        
    emp_record emp_cursor%ROWTYPE;
BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        IF TO_NUMBER(TO_CHAR(emp_record.hire_date, 'YYYY')) <= 2015 THEN
            INSERT INTO test01(
                               employee_id,
                               first_name, 
                               hire_date
                               )
            VALUES (
                    emp_record.employee_id,
                    emp_record.first_name,
                    emp_record.hire_date
                    );
        ELSE
            -- 테이블의 컬럼 순서, 데이터 타입과 같은 구조 같는 변수일 경우
            --      => 컬럼, 데이터 지정 안하고 통째로 대응시킬 수 있음
            INSERT INTO test02
            VALUES emp_record;
        END IF;
        
    END LOOP;
    
    CLOSE emp_cursor;

END;
/

-- (2) 커서 FOR LOOP 사용
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id,
               first_name,
               hire_date
        FROM   employees;
BEGIN
    FOR emp_record IN emp_cursor LOOP
        IF TO_NUMBER(TO_CHAR(emp_record.hire_date, 'YYYY')) <= 2015 THEN
            INSERT INTO test01(
                               employee_id,
                               first_name, 
                               hire_date
                               )
            VALUES (
                    emp_record.employee_id,
                    emp_record.first_name,
                    emp_record.hire_date
                    );
        ELSE
            INSERT INTO test02(
                               employee_id,
                               first_name, 
                               hire_date
                               )
            VALUES (
                    emp_record.employee_id,
                    emp_record.first_name,
                    emp_record.hire_date
                    );
        END IF;
    END LOOP;
END;
/

SELECT *
FROM   test01;

SELECT *
FROM   test02;

DELETE test01;
DELETE test02;


/*

Q2.
부서번호를 입력할 경우(&치환변수 사용)
해당하는 부서의 사원이름, 입사일자, 부서명을 출력하시오
(단, cursor 사용)

*/

DECLARE
    CURSOR emp_dept_cursor IS
        SELECT e.last_name,
               e.hire_date,
               d.department_name
        FROM   employees e
               JOIN departments d
               ON e.department_id = d.department_id
        WHERE  e.department_id = &부서번호;
    
    v_emp_info emp_dept_cursor%ROWTYPE;
BEGIN
    OPEN emp_dept_cursor;

    LOOP
        FETCH emp_dept_cursor INTO v_emp_info;
        EXIT WHEN emp_dept_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT('사원이름 : ' || v_emp_info.last_name);
        DBMS_OUTPUT.PUT(', 입사일자 : ' || v_emp_info.hire_date);
        DBMS_OUTPUT.PUT_LINE(', 부서명 : ' || v_emp_info.department_name);
    END LOOP;
    
    IF emp_dept_cursor%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서에 소속된 사원이 없습니다.');
    END IF;
    
    CLOSE emp_dept_cursor;
END;
/

-- 모든 부서의 사원 정보 출려
DECLARE
    -- 부서 커서
    CURSOR dept_cursor IS
        SELECT *
        FROM   departments;
    -- 사원, 부서명 커서 + 매개변수
    CURSOR emp_dept_cursor
        (p_deptid departments.department_id%TYPE) IS
        SELECT e.last_name,
               e.hire_date,
               d.department_name
        FROM   employees e
               JOIN departments d
               ON e.department_id = d.department_id
        WHERE  e.department_id = p_deptid;
    
    v_emp_info emp_dept_cursor%ROWTYPE;
BEGIN
    FOR dept_info IN dept_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('======= 현재 부서 정보 : ' || dept_info.department_name || ' =======');
        OPEN emp_dept_cursor(dept_info.department_id);
        
        LOOP
            FETCH emp_dept_cursor INTO v_emp_info;
            EXIT WHEN emp_dept_cursor%NOTFOUND;
            
            DBMS_OUTPUT.PUT('사원이름 : ' || v_emp_info.last_name);
            DBMS_OUTPUT.PUT(', 입사일자 : ' || v_emp_info.hire_date);
            DBMS_OUTPUT.PUT_LINE(', 부서명 : ' || v_emp_info.department_name);
        END LOOP;
        
        IF emp_dept_cursor%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('해당 부서에 소속된 사원이 없습니다.');
        END IF;
        
        CLOSE emp_dept_cursor;
    END LOOP;
END;
/


-- < 예외처리 >

/*
1. 오라클이 관리하고 있고 이름이 존재하는 경우
- (1) DECLARE   : X
- (2) BEGIN     : X
- (3) EXCEPTION : O
*/

DECLARE
    v_ename employees.last_name%TYPE;
BEGIN
    -- 변수에 단일값 아닌 다중값 입력 => TOO_MANY_ROWS 에러
    SELECT last_name
    INTO   v_ename
    FROM   employees
    WHERE  department_id = &부서번호;
    
    -- 예외처리되면 아래 코드 실행 안됨
    -- why: 에러 처리하고 END까지 가는게 목적 / 뒤로 돌아가서 다시 실행 X
    DBMS_OUTPUT.PUT_LINE(v_ename);
EXCEPTION
    -- ※ 예외처리는 하나만 동작함
    -- WHEN ~ THEN : 미리 정의된 이름 입력
    -- THEN ~ : 예외처리 동작 작성 
    
    -- TOO_MANY_ROWS 에러 처리
    -- => 해당 에러 단건에 대해서만 처리(다른 종류의 에러는 못 잡음)
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서에는 여러 명의 사원이 존재합니다.');
        
    -- NO_DATA_FOUND 에러 처리
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서에는 근무하는 사원이 존재하지 않습니다.');

    -- 기타 에러 처리(OTHERS)
    -- OTHERS에 모든 에러 맡기면 안됨 => 어떤 에러 나는지 구분하고 개선할 필요
    -- 알고있는 선까지는 예외 개별처리 / 진짜 에러나면 안되는 상황에서 OTHERS
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('기타 예외가 발생했습니다.');
    
        -- WHEN-THEN 범위 : 다음 WHEN 전까지
        -- 마지막 WHEN-THEN 범위 : END 전까지
        DBMS_OUTPUT.PUT_LINE('EXCEPTION절이 실행되었습니다.');
        --   => OTHERS에서 실행됨
END;
/


/*
2. 오라클이 관리하고 있고 이름이 존재하지 않는 경우
- (1) DECLARE   : O(PRAGMA EXCEPTION_INIT ())
- (2) BEGIN     : X
- (3) EXCEPTION : O
*/
DECLARE
    -- 예외 이름 선언(접두어  'e_' 로 시작)
    e_emps_remaining EXCEPTION;
    -- PRAGMA : 블럭 실행전에 동작, 일시적으로 설정 변경
    --          => 예외와 이름을 묶어주는 역할
    -- PRAGMA EXCEPTION_INIT(예외 이름, 에러 코드)
    PRAGMA EXCEPTION_INIT(e_emps_remaining, -02292);
    
BEGIN
    -- (1) 제약조건 에러(Foreign Key 참조 무결성 위배)
    --      => 오라클 관리O(ORA-02292) / 이름 X
    -- (2) 데이터 타입 에러
    DELETE FROM departments
    WHERE department_id = &부서번호;
    
EXCEPTION
    -- DECLARE에서 선언된 예외 이름으로 작성
    WHEN e_emps_remaining THEN
        DBMS_OUTPUT.PUT_LINE('다른 테이블에서 사용하고 있습니다.');
    
END;
/


/*
3. 사용자가 정의하는 예외사항(오라클이 관리 X / 이름 X)
- (1) DECLARE   : O
- (2) BEGIN     : O(RAISE)
- (3) EXCEPTION : O
*/
DECLARE
    e_emp_del_fail EXCEPTION;
    
BEGIN
    -- 오라클 입장: 에러 안나는 코드
    -- 사용자 입장: 기능 수행하는 부분에서는 체크해야 함 => 직접 예외 정의
    -- ex) 사원번호 받아서 사원 데이터 삭제
    --      : 사원번호 없어서 아무 데이터도 삭제 안됨 => 오라클이 에러로 인지 안함
    --        but 기능이 정상적으로 수행되지 않음 => 인지하고 알려줘야 함
    DELETE FROM test_employees
    WHERE employee_id = &사원번호;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_emp_del_fail;
    END IF;
    
EXCEPTION
    WHEN e_emp_del_fail THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원이 존재하지 않습니다.');
END;
/


/*
@ ★예외 트랩 함수:
- 지금 발생한 예외에 대해서 정보 반환하는 함수
- 반복적으로 일어나는 에러 파악 => 문제 확인

- 에러 메세지 담는 테이블 생성 => 에러 로그 확인
- SQLCODE : 오류 코드의 숫자 값 반환
- SQLERRM : 오류 번호와 연관된 메시지 반환
- INSERT 함수와 예외트랩함수 함께 사용 불가능 => 변수에 담아서 사용
*/

DECLARE
    e_too_many EXCEPTION;
    
    v_ex_code NUMBER;
    v_ex_msg VARCHAR2(1000);
    emp_info employees%ROWTYPE;
BEGIN
    SELECT *
    INTO emp_info
    FROM employees
    WHERE department_id = &부서번호;
    
    IF emp_info.salary < (emp_info.salary * emp_info.commission_pct + 10000) THEN
        RAISE e_too_many;
    END IF;
EXCEPTION
    WHEN e_too_many THEN
        DBMS_OUTPUT.PUT_LINE('사용자 정의 예외 발생!');
    WHEN OTHERS THEN
        -- 예외 트랩 함수(SQLCODE, SQLERRM): 변수에 담아 사용
        v_ex_code := SQLCODE;
        v_ex_msg := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('ORA ' || v_ex_code);
        DBMS_OUTPUT.PUT_LINE(' - ' || v_ex_msg);
END;
/


/*
@ 예외 전달
- 안쪽 블럭에서 정상적으로 트랩되지 않은 예외는 바깥 블록으로 전달 될 수 있음
-  => 바깥에서도 안쪽 에러를 처리하는 핸들러 둘 수 있음
- 가장 마지막에 에러처리하는 블럭: OTHERS 필요(없으면 사용자한테 에러 전달됨)
*/


/*
@ RAISE_APPLICATION_ERROR 프로시저
- 사용자 정의 에러를 오라클이 발생시킨것처럼 에러창에 띄워줌

- RAISE_APPLICATION_ERROR (error_number, message[, {TRUE | FALSE}]);
- 사용자 정의 에러는 error_number 없음 
-   => 범위 내에서 임의로 지정(-20000 ~ `20999)
- 에러 메세지 임의로 작성
(크게 쓸 일 없음)
*/

/*
Q1.
test_employees 테이블을 사용하여 선택된 사원을 삭제하는 PL/SQL 작성
- 조건 1: 치환변수 사용
- 조건 2: 사원이 존재하지 않을 경우 '해당 사원이 존재하지 않습니다.'라는 메세지 출력
-   => 사용자 정의 예외 사용
*/

DECLARE
    e_emp_del_fail EXCEPTION;
    
BEGIN
    DELETE test_employees
    WHERE  employee_id = &사원번호;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_emp_del_fail;
    END IF;
    
EXCEPTION
    WHEN e_emp_del_fail THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원이 존재하지 않습니다.');

END;
/

/*
@ 질문1: 데이터 타입 오류는 왜 OTHERS로 안걸러짐?
=>
- 데이터 타입 오류는 코드 실행 전 컴파일 단계에서 잡힘
-   => 예외 처리로 못 잡아냄

@ 질문2: 사용자 정의 예외처리 대신 걍 BEGIN의 IF절에 넣어서 처리하면 안됨?
=> 
- IF문으로 처리하면 뒤 코드 실행됨
- 예외는 STOP됨. 남아있는 코드가 진행되지 않음
-   => 강하게 제약할 필요 / 문제 발생 시 stop 해야 할때 예외처리 사용
*/
