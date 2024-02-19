-- 20240216 PL/SQL 오후수업
SET SERVEROUTPUT ON;

-- < Procedure >

/*

@ 프로시저
- 내장 프로시저: 매개변수(Parameter)를 사용하여 호출할 수 있는
  명명된(named) PL/SQL 블록 => 헤더(Header)
- 각 블록 별로 이름 존재 => 필요할때마다 이름으로 호출함
- 프로시져 == 객체로 취급 => CREATE 명령어로 생성

★★★ 매개변수: 
- 프로시저는 매개변수로 INPUT + OUTPUT 둘 다 처리(양방향)
- 프로시저는 return 없음 => 매개변수로 OUTPUT 처리함

★★★ 매개변수 종류
(1) IN
    - 1)명시 여부 : 기본값(default)
    - 2)목적      : 값을 서브 프로그램에 전달 
    - 3)내부 인식 : 상수(값 변경불가 readonly)
    - 4)매개변수 타입 : 값을 전달할 수 있는 모든 형태 가능
                        리터럴, 표현식, 상수, (초기화된)변수 등
    
(2) OUT
    - 1)명시 여부 : 명시적으로 지정해야함
    - 2)목적      : 값을 호출 환경으로 반환
    - 3)내부 인식 : 변수(초기화 X)
                    내부적으로 인식 불가(밖으로 돌려주기 only)
    - 4)매개변수 타입 : 변수 => 값이 없는 변수 쓰는게 좋음
    
(3) IN OUT
    - 1)명시 여부 : 명시적으로 지정해야함
    - 2)목적      : 값을 서브 프로그램에 전달 + 호출 환경으로 반환 
    - 3)내부 인식 : 변수(초기화 O)
                    내부적으로 값 인식
    - 4)매개변수 타입 : 변수
*/

-- Procedure

-- 프로시저 생성: CREATE PROCEDURE 이름(매개변수 생략가능)
--               DECLARE절 명시 안함 / BEGIN 윗 공간이 선언부
CREATE PROCEDURE test_pro
IS
-- 선언부: 내부에서 사용하는 변수, 커서, 타입, 예외 선언
    v_msg VARCHAR2(1000) := 'Execute Procedure';
BEGIN
    -- ※ 프로시저 안에서 치환변수 사용하지 말기 (고정값이라서.. 그냥 상수 쓰기)
    DELETE FROM test_employees
    WHERE department_id = 50;
    
    DBMS_OUTPUT.PUT_LINE(v_msg);

EXCEPTION
    -- (구색맞추기용 예외처리문...)
    WHEN INVALID_CURSOR THEN
        DBMS_OUTPUT.PUT_LINE('사용할 수 없는 커서입니다.');
END;
/

SELECT *
FROM   test_employees;

-- 실행시 '컴파일 되었습니다' 만 뜨고 코드 실행 안됨
-- why? CREATE문으로 프로시저 객체 등록한 상태
-- => 프로시저 등록하고 다시 수정해서 등록 불가
--    ALTER 불가능 / DROP-CREATE로 다시 등록해야함


-- 프로시저 호출 방법
-- ※ 반드시 PL/SQL 안에서 실행되야 함

-- (1) 블록 안에서 실행
-- 주의: return 구문 없어서 왼쪽에 변수가 없어야 함
--       변수 옆에 있으면 function으로 인식함
DECLARE
    v_num NUMBER(1,0);
BEGIN
    test_pro;
END;
/

-- (2) EXECUTE 명령어
--      : 임시적으로 블록 생성됨
--        변수 선언 불가능. test 할때 사용
EXECUTE test_pro;


-- 프로시저 매개변수 형태에 따른 실행
-- (1) IN 매개변수
--  : 매개변수 이름, 데이터 타입 설정(사이즈 X)
--    읽기 전용 => 상수 취급, 변경 불가(코드 실행 전 컴파일 단계에서 거름)

-- 프로시저 생성
CREATE PROCEDURE raise_salary
(p_eid IN employees.employee_id%TYPE)
IS

BEGIN
    -- 변수값 변경 시도시 오류
    -- p_eid := 100;
    
    UPDATE employees
    SET    salary = salary * 1.1
    WHERE  employee_id = p_eid;
END;
/

SELECT last_name,
       salary
FROM   employees;

-- 프로시저 실행
-- 변수 형태: 값을 전달할 수 있는 모든 형태
DECLARE
    v_first  NUMBER(3,0) :=100;
    v_second CONSTANT NUMBER(3,0) := 149;
BEGIN
    raise_salary(103);          -- 리터럴
    raise_salary((100+10)); -- 식의 결과값
    raise_salary(v_second);     -- 상수
    raise_salary(v_first);      -- 값 가진 변수
END;
/

-- (2) OUT 매개변수
--  : 프로시저 내부에서 초기화되지 않은 변수로 인식됨
--    값이 있는 매개변수 받아도 내부적으로는 null로 인식
--    OUT => 값을 담는 용도로만 사용

-- 프로시저 생성
CREATE PROCEDURE test_p_out
(p_num    IN NUMBER,
 p_result OUT NUMBER)
IS
    v_sum NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('IN : ' || p_num);
    DBMS_OUTPUT.PUT_LINE('OUT : ' || p_result); 
    -- OUT: 내부적으로 null로 인식됨 

    v_sum := p_num + p_result;
    p_result := v_sum;
    -- p_result값 null로 덮임
END;
/

-- 프로시저 실행
DECLARE
    v_result NUMBER(4,0) := 1234;
BEGIN
    DBMS_OUTPUT.PUT_LINE('(1)result : ' || v_result);
    test_p_out(1000, v_result);
    DBMS_OUTPUT.PUT_LINE('(2)result : ' || v_result);
END;
/

-- ex
-- 프로시저 생성
CREATE PROCEDURE select_emp
(p_eid   IN  employees.employee_id%TYPE,
 p_ename OUT employees.last_name%TYPE,
 p_sal   OUT employees.salary%TYPE,
 p_comm  OUT employees.commission_pct%TYPE)
IS

BEGIN
    SELECT last_name,
           salary,
           NVL(commission_pct,0)
    INTO   p_ename,
           p_sal, 
           p_comm
    FROM   employees
    WHERE  employee_id = p_eid;
END;
/

-- 프로시저 실행
-- 내부에서 일어난 결과가 해당 변수에 담겨서 반환됨
DECLARE
    v_name VARCHAR2(100 char);
    v_sal  NUMBER;
    v_comm NUMBER;
    
    v_eid  NUMBER := &사원번호;
BEGIN
    select_emp(v_eid,
               v_name,
               v_sal,
               v_comm);
    
    DBMS_OUTPUT.PUT('사원번호 : ' || v_eid);
    DBMS_OUTPUT.PUT(', 사원이름 : ' || v_name);
    DBMS_OUTPUT.PUT(', 급여 : ' || v_sal);
    DBMS_OUTPUT.PUT_LINE(', 커미션 : ' || v_comm);
           
END;
/

-- (3) IN OUT 매개변수
--  주의 : 하나의 변수에 그 값을 덮어씀 
--  => 내가 전달한게 유지 안됨. 원데이터가 사라질 수 있음

-- ex. 포맷 변환: '01012341234' => '010-1234-1234'
-- 프로시저 생성
CREATE PROCEDURE format_phone
(p_phone_no IN OUT VARCHAR2)
IS

BEGIN
    -- SUBSTR(문자열, n, m) : n번째 자리부터 m개 자름(음수 nㄴ: 뒤에서부터 자름)
    p_phone_no := SUBSTR(p_phone_no, 1, 3) 
                  || '-' || SUBSTR(p_phone_no, 4, 4)
                  || '-' || SUBSTR(p_phone_no, 8);
END;
/

-- 프로시저 실행
DECLARE
    -- 변수: 데이터가 담긴 형태로 넘어가서 전달
    v_phone_no VARCHAR2(100) := '01012341234';
BEGIN
    DBMS_OUTPUT.PUT_LINE('(1) ' || v_phone_no);
    format_phone(v_phone_no);
    DBMS_OUTPUT.PUT_LINE('(2) ' || v_phone_no);
    -- 원 데이터가 덮어씌워짐(보존 안됨)
END;
/


-- ※ PK 조합(문자열 + 날짜 + 숫자)
CREATE TABLE var_pk_tbl
(
    no   VARCHAR2(1000) PRIMARY KEY,
    name VARCHAR2(4000) DEFAULT 'anony'
);

INSERT INTO var_pk_tbl(no, name)
VALUES ('TEMP240215001', '상품01');

SELECT no, name
FROM   var_pk_tbl;

-- 'TEMP240215001' => 'TEMP' + yyMMdd + 숫자(3자리)
SELECT 'TEMP' 
       || TO_CHAR(sysdate, 'YYMMDD') 
       || LPAD(TO_NUMBER(NVL(MAX(SUBSTR(no, 3)), 0))+1, 3, '0')
       AS "PK"
FROM   var_pk_tbl
WHERE  SUBSTR(no, 5, 6) = TO_CHAR(sysdate, 'YYMMDD');


/*
Q1.
주민등록번호를 입력하면 다음과 같이 출력되도록 
yedam_ju 프로시저를 작성하시오
execute yedam_ju(9501011667777) => 950101-1******
execute yedam_ju(1511013689977) => 151101-3******
*/

-- 프로시저 생성
CREATE PROCEDURE yedam_ju
(p_jumin_no IN NUMBER)
IS
    v_jumin_no VARCHAR2(1000);
    
BEGIN
--    v_jumin_no := SUBSTR(TO_CHAR(p_jumin_no), 1, 6)
--                  || '-' || SUBSTR(TO_CHAR(p_jumin_no), 7, 1) || '******';                
    v_jumin_no := SUBSTR(TO_CHAR(p_jumin_no), 1, 6)
                  || '-' || RPAD(SUBSTR(TO_CHAR(p_jumin_no), 7, 1), 7, '*');
    DBMS_OUTPUT.PUT_LINE(v_jumin_no);
    
END;
/

-- 프로시저 실행
EXECUTE yedam_ju(9501011667777);
EXECUTE yedam_ju(1511013689977);


/*
Q2.
사원번호를 입력할 경우
삭제하는 TEST_PRO 프로시저를 생성하시오.
단, 해당사원이 없는 경우 "해당사원이 없습니다." 출력
예) EXECUTE TEST_PRO(176)
*/

CREATE TABLE test_employees
AS
    SELECT *
    FROM employees;

-- 프로시저 생성
CREATE PROCEDURE test_pro
(p_eid IN NUMBER)
IS

BEGIN
    DELETE FROM test_employees
    WHERE employee_id = p_eid;
    
    IF SQL%ROWCOUNT <> 0 THEN
        DBMS_OUTPUT.PUT_LINE(p_eid || '사원 정보가 삭제되었습니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('해당사원이 없습니다.');
    END IF;
END;
/

SELECT *
FROM   test_employees;

EXECUTE TEST_PRO(176);

/*
Q3.
다음과 같이 PL/SQL 블록을 실행할 경우 
사원번호를 입력할 경우 사원의 이름(last_name)의 첫번째 글자를 제외하고는
'*'가 출력되도록 yedam_emp 프로시저를 생성하시오.

실행) EXECUTE yedam_emp(176)
실행결과) TAYLOR -> T*****  <- 이름 크기만큼 별표(*) 출력
*/

CREATE PROCEDURE yedam_emp
(p_eid IN VARCHAR2)
IS
    v_ename employees.last_name%TYPE;
    v_result v_ename%TYPE;
BEGIN
    SELECT last_name
    INTO   v_ename
    FROM   employees
    WHERE  employee_id = p_eid;

    v_result := RPAD(SUBSTR(v_ename, 1, 1), LENGTH(v_ename), '*');
    DBMS_OUTPUT.PUT_LINE(v_ename || ' -> ' || v_result);
END;
/

EXECUTE yedam_emp(100);

SELECT *
FROM   employees;
/*
Q4.
부서번호를 입력할 경우 
해당부서에 근무하는 사원의 사원번호, 사원이름(last_name)을 출력하는 get_emp 프로시저를 생성하시오. 
(cursor 사용해야 함)
단, 사원이 없을 경우 "해당 부서에는 사원이 없습니다."라고 출력(exception 사용)
실행) EXECUTE get_emp(30)
*/

CREATE PROCEDURE get_emp
(p_deptid IN NUMBER)
IS
    CURSOR emp_cursor IS
        SELECT employee_id, 
               last_name
        FROM   employees
        WHERE  department_id = p_deptid;
        
    v_emp_info emp_cursor%ROWTYPE;   
    e_no_emp EXCEPTION;
   
BEGIN
    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO v_emp_info;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT('사원번호 : ' || v_emp_info.employee_id);
        DBMS_OUTPUT.PUT_LINE(', 사원이름 : ' || v_emp_info.last_name);
    END LOOP;
    
    IF emp_cursor%ROWCOUNT = 0 THEN
        RAISE e_no_emp;
    END IF;
    
    CLOSE emp_cursor;
    
EXCEPTION
    WHEN e_no_emp THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서에는 사원이 없습니다.');
    
END;
/

EXECUTE get_emp(30);

/*
Q5.
직원들의 사번, 급여 증가ㄴ치만 입력하면 Employees테이블에 쉽게 사원의 급여를 갱신할 수 있는 y_update 프로시저를 작성하세요. 
만약 입력한 사원이 없는 경우에는 ‘No search employee!!’라는 메시지를 출력하세요.(예외처리)
실행) EXECUTE y_update(200, 10)
*/

CREATE PROCEDURE y_update
(p_eid          IN NUMBER,
 p_sal_increase IN NUMBER)
IS
    e_no_eid EXCEPTION;
    
BEGIN
    UPDATE employees
    SET    salary = salary + salary * (p_sal_increase / 100)
    WHERE  employee_id = p_eid;
    
    IF SQL%ROWCOUNT <> 0 THEN
        DBMS_OUTPUT.PUT_LINE('사원 급여정보가 갱신되었습니다.');
    ELSE
        RAISE e_no_eid;
    END IF;
    
EXCEPTION
    WHEN e_no_eid THEN
        DBMS_OUTPUT.PUT_LINE('No search employee!!');
    
END;
/

EXECUTE y_update(200, 10);

