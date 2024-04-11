SELECT * FROM orders ORDER BY 3;
SELECT * FROM prod_req;
SELECT * FROM prod_req_detail;


UPDATE orders
   SET orders_status = 'OP2'
 WHERE due_date >= '2024-04-23'
   AND due_date <= '2024-04-25';
   

CREATE PROCEDURE test_procedure
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



SELECT * FROM prod_req ORDER BY 1;
SELECT * FROM prod_req_detail ORDER BY 1;

SELECT p.prod_req_code
       , p.total_req_cnt
       , p.req_date
       , p.prod_req_status
       , u.users_name
       FROM prod_req p JOIN users u
                         ON p.users_code = u.users_code;