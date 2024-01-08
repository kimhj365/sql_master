--20240108 SQL 시험 피드백 + 답변 수정

--1.
SELECT	employee_id, last_name, salary, department_id
FROM	employees
WHERE	salary BETWEEN 7000 AND 12000
AND	UPPER(last_name) LIKE 'H%';

--2.
SELECT	employee_id, last_name, TO_CHAR(hire_date, 'MM/DD/YYYY DAY') HIRE_DATE,
        	TO_CHAR(salary*commission_pct, '$9,999.00') SALARY
FROM	employees
WHERE 	commission_pct IS NOT NULL
ORDER BY 4 DESC;

--3.
SELECT	employee_id, last_name, job_id, salary, department_id
FROM	employees
WHERE	department_id IN (50, 60)
AND	salary > 5000;

--4. => JOIN 안써도 됨
--기존 답변
DESC	employees;

SELECT	e.employee_id, e.last_name, e.department_id, 
       CASE d.department_id WHEN 20 THEN 'Canada'
                          	WHEN 80 THEN 'UK'
                               	ELSE 'USA'
       END LOCATION
FROM	employees e, departments d
WHERE	e.department_id = d.department_id;

--수정 답변
SELECT	employee_id, last_name, department_id, 
        CASE department_id WHEN 20 THEN 'Canada'
                           WHEN 80 THEN 'UK'
                                   ELSE 'USA'
        END LOCATION
FROM    employees
WHERE   department_id IS NOT NULL;

--5.
SELECT	e.employee_id, e.last_name, e.department_id, d.department_name
FROM	employees e, departments d
WHERE	e.department_id = d.department_id(+);

--6.
SELECT	last_name, hire_date,
       CASE WHEN hire_date >= TO_DATE('05/01/01', 'YY/MM/DD') 
                    THEN 'New employee'
                    ELSE 'Career employee' 
       END EMP_TYPE
FROM	employees
WHERE	employee_id = &employee_num;

--7.
SELECT	last_name, salary,
       CASE WHEN salary <= 5000  THEN salary*1.2
              WHEN salary <= 10000 THEN salary*1.15
              WHEN salary <= 15000 THEN salary*1.1
                                 ELSE salary
       END "Increased_Salary"
FROM	employees
WHERE	employee_id = &employee_num;

--8.
DESC	locations;

SELECT	d.department_id, d.department_name, l.city
FROM	departments d, locations l
WHERE	d.location_id = l.location_id;

--9.
SELECT	employee_id, last_name, job_id
FROM	employees
WHERE	department_id = (SELECT department_id
                        FROM   departments
                        WHERE  UPPER(department_name) = 'IT');
                        
--10.
SELECT	  department_id, COUNT(employee_id), TRUNC(AVG(salary))
FROM	  employees
GROUP BY department_id;

--11.
CREATE TABLE prof
  	(profno	  NUMBER(4),
  	 name	  VARCHAR2(15) NOT NULL,
   	 id	  VARCHAR2(15) NOT NULL,
  	 hiredate DATE,
  	 pay	  NUMBER(4));
   
--12.
--(1)
INSERT INTO prof
VALUES       (1001, 'Mark', 'm1001', TO_DATE('07/03/01', 'YY/MM/DD'), 800);

INSERT INTO prof
VALUES       (1003, 'Adam', 'm1003', TO_DATE('11/03/02', 'YY/MM/DD'), NULL);

SELECT *
FROM   prof;

COMMIT;

--(2)
UPDATE	prof
SET  	pay = 1200
WHERE	profno = 1001;

--(3)
DELETE	prof
WHERE	profno = 1003;

--13.
--(1)
ALTER TABLE	prof
ADD CONSTRAINT prof_no_pk PRIMARY KEY(profno);

--(2)
ALTER TABLE prof
ADD        (gender CHAR(3));

--(3)
ALTER TABLE prof
MODIFY     (name VARCHAR2(20));

--14.=> (2)번 문항 빼먹음
--(1)
CREATE VIEW prof_vu(pno, pname, id)
    AS SELECT profno, name, id
        FROM   prof;

SELECT	*
FROM	prof_vu;

--(2)
CREATE OR REPLACE VIEW prof_vu (pno, pname, id, phiredate)
AS SELECT  profno, name, id, hiredate
    FROM    prof;

--15.
--(1)
DROP TABLE prof PURGE;

--(2)
--뷰, 동의어 : 테이블이 삭제되어도 남아있지만 사용 불가능
--인덱스     : 테이블이 삭제되면 함께 삭제됨

--16.
--4개 테이블 조인 조건 : 최소 3개 필요