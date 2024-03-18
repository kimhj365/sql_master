-- 페이징 쿼리 : 안쪽 쿼리문만 바뀌고 위 아래 그대로

SELECT * FROM ( SELECT rownum rn, a.* FROM (

                SELECT * 
                FROM employees
                ORDER BY first_name
                
) a WHERE rownum <= 15 ) b WHERE rn > 10;

SELECT * FROM employees;

SELECT e.department_id, d.department_name, count(*) cnt
FROM   employees e JOIN departments d
ON     e.department_id = d.department_id
WHERE  e.department_id IS NOT NULL
GROUP BY e.department_id, d.department_name;