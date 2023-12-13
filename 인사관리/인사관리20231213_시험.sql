--1.
SELECT	employee_id, last_name, salary, department_id
FROM	employees
WHERE	salary BETWEEN 7000 AND 12000
AND 	UPPER(last_name) LIKE 'H%';

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
AND	    salary > 5000;

--4.
DESC	departments;

SELECT	e.employee_id, e.last_name, e.department_id, 
        CASE d.department_id WHEN 20 THEN 'Canada'
                             WHEN 80 THEN 'UK'
                             ELSE 'USA'
        END LOCATION
FROM	employees e, departments d
WHERE	e.department_id = d.department_id;

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
GROUP BY  department_id;

--11.
CREATE TABLE PROF
  	(PROFNO	  NUMBER(4),
  	 NAME	  VARCHAR2(15) NOT NULL,
   	 ID	  VARCHAR2(15) NOT NULL,
  	 HIREDATE DATE,
  	 PAY	  NUMBER(4));
   
--12.
--(1)
INSERT INTO PROF
VALUES       (1001, 'Mark', 'm1001', TO_DATE('07/03/01', 'YY/MM/DD'), 800);

INSERT INTO PROF
VALUES       (1003, 'Adam', 'm1003', TO_DATE('11/03/02', 'YY/MM/DD'), NULL);

SELECT *
FROM   PROF;

COMMIT;

--(2)
UPDATE	PROF
SET  	PAY = 1200
WHERE	PROFNO = 1001;

--(3)
DELETE	PROF
WHERE	PROFNO = 1003;

--13.
--(1)
ALTER TABLE	PROF
ADD CONSTRAINT PROF_NO_PK PRIMARY KEY(PROFNO);

--(2)
ALTER TABLE PROF
ADD        (GENDER CHAR(3));

--(3)
ALTER TABLE PROF
MODIFY     (NAME VARCHAR2(20));

--14.
CREATE VIEW PROF_VU(PNO, PNAME, ID)
    AS SELECT PROFNO, NAME, ID
        FROM   PROF;
       
SELECT	*
FROM	PROF_VU;

--15.
--(1)
DROP TABLE PROF PURGE;

--(2)
--뷰, 동의어 : 테이블이 삭제되어도 남아있지만 사용 불가능
--인덱스     : 테이블이 삭제되면 함께 삭제됨

--16.
--4개 테이블 조인 조건 : 최소 3개 필요