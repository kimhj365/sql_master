-- 20240318 Spring paging

-- 기존 쿼리
-- 서브쿼리 2번 사용
SELECT * FROM ( SELECT rownum rn, a.* FROM (
	
		SELECT rownum id, e.*
		  FROM employees e
	  ORDER BY employee_id DESC		
	  
	) a WHERE rownum <= 10 ) b WHERE rn >= 1;
    
-- HINT + 서브쿼리 1번 사용
SELECT * FROM  (
    SELECT /*+INDEX_ASC(employees EMP_EMP_ID_PK) */
           ROWNUM rn
           , employee_id
           , first_name
           , last_name
           , email
           , department_id
      FROM employees
     WHERE ROWNUM <=20
) WHERE rn >=10;

SELECT *
  FROM departments;