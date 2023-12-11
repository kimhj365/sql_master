--<���� ������>

--ORDER BY �� : �� ����.
--ASC : ��������(�⺻��).
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date;

--DESC : ��������.
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date DESC;

--ORDER BY�� �÷� ALIAS ��� ����.
SELECT employee_id, last_name, salary*12 annsal
FROM employees
ORDER BY annsal;

--ORDER BY ���� : �ش� ��ȣ �÷� ���� ����
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY 3; --department_id ���� ����

--���� �÷� ���� ����(1�� ����, 2�� ����, ...)
SELECT last_name, department_id, salary
FROM employees
ORDER BY department_id, salary;

--SELECT���� ���� �÷� �����ε� ���İ���(���̺� �ִ� �÷�)
SELECT employee_id, salary
FROM employees
ORDER BY hire_date;

--ġȯ ���� & / && : ������ �� ��ü�ϴ� �� �Է� ����
--���� ġȯ���� &
SELECT employee_id,last_name,salary,department_id
FROM employees
WHERE employee_id = &employee_num;
--&employee_num �κп� ��ü�� �Է¹���
--ex. 101 �Է� => WHERE employee_id = 101;
--������ ������ ���� �Է� ����(��� ���̰� �������� ����)
--��ü�ϴ� �κ��� ����Ÿ���̶�� & �κп� '' �ѷ������
--ex. job_id = '$job_num';

--SELECT�� ��ü�� ��� ����
--WHERE, ORDER BY ���� ��ü�� �Է� ���� �� ����
SELECT employee_id,last_name, job_id, &column_name
FROM employees
WHERE &condition
ORDER BY &order_column;

--&& ġȯ����
--�Է¹��� ���� �޸𸮿� ����Ǿ� ��� ������ => �ݺ������� ���
SELECT employee_id,last_name, job_id, &&column_name
FROM employees
ORDER BY &column_name;
--&&column_name���� �Է¹��� �� &column_name���� ���

--���� ���๮������ ���� �Է¹��� &&�� ��� ���
SELECT employee_id, salary
FROM employees
ORDER BY &column_name;

--UNDEFINE : &&���� ���ֱ�
UNDEFINE column_name;

--&&���� ���ּ� &���� �ٽ� �Է¹���
SELECT employee_id, salary
FROM employees
ORDER BY &column_name;


--<���� ������(SET)>

--1.UNION
--�� ���̺��� ����(������)

--EMPLOYEES ���̺� : ���� ��� ���� ����
--JOB_HISTORY ���̺� : ���� ���� �̷�(�����ȣ �ߺ��� ����)
SELECT *
FROM job_history
ORDER BY employee_id;

--�ߺ��Ǵ� �� ���ŵ�
SELECT employee_id, job_id
FROM employees --107�� ��
UNION
SELECT employee_id, job_id
FROM job_history; --10�� ��
--���ϰ� 115�� => 2�� �ߺ��� ����

--2. UNION ALL
-- ������ + �ߺ��� ���� �ȵ�, ���� �ȵ�
SELECT employee_id, job_id
FROM employees
UNION ALL
SELECT employee_id, job_id
FROM job_history;

--ORDER BY���� �׻� �� ���ٷ� �;���
SELECT employee_id, job_id, department_id
FROM employees
UNION ALL
SELECT employee_id, job_id, department_id
FROM job_history
ORDER BY employee_id;

--UNION, UNION ALL : �� SELECT�� ��ġ �ٲ㵵 ����� ����

--3. INTERSECT
--����� �� �˻�(������)
SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history;

--���� ���� �ٲ� ����� ����
SELECT employee_id, job_id
FROM job_history
INTERSECT
SELECT employee_id, job_id
FROM employees;

--4. MINUS
--ù��° ���忡�� �ι�° ���� �� ���(������)
--ù��° �÷� ������ �������� ���ĵ�
SELECT employee_id, job_id
FROM employees --107�� ��
MINUS
SELECT employee_id, job_id
FROM job_history;
--�ߺ� 2�� => ����� 105��

--���� ���� �ٲ�� ����� �޶���
SELECT employee_id, job_id
FROM job_history --10�� ��
MINUS
SELECT employee_id, job_id
FROM employees;
--�ߺ� 2�� => ����� 8��


--<�Լ�>
--�μ� input �޾Ƽ� ó�� �� output ���� => ���ϰ� ����
--����� �����Լ� : ���� ���� �Լ�
--ǥ��ȭ�� �Լ� / DB���� ǥ��ȭ �ȵ� �Լ� 

--������ �Լ� :�� �� �ϳ��� ����� ��ȯ
--�׷��Լ�(������ �Լ�) : ���� ���� �μ��� ���͵� �ϳ��� ���ϰ��� ����

--dual ���̺�
--Į�� 1��, �� 1�� => �Լ� ���ϰ� Ȯ���� �� ���� ���̺�
desc dual;

select *
from dual;

--�Լ� �� �� ������ŭ ��µ�
select sysdate
from employees;

--dual ���̺� : �� 1�� => ���ϰ� Ȯ�� ����
select sysdate
from dual;

--<���� �� �Լ�>

--1. ���� �Լ�
--LOWER : �ҹ��ڷ� ����
--UPPER : �빮�ڷ� ����
--INITCAP : �ܾ� ù���ڴ� �빮��, ������ �ҹ���(ex. Ye Dam)
SELECT 'The job id for '||UPPER(last_name)||' is '|| 
        LOWER(job_id) AS "EMPLOYEE DETAILS"
FROM employees;

--�÷��� ������ �÷� ��ü �� �ҹ��ڷ� ��� ����
SELECT employee_id, last_name, department_id
FROM employees
WHERE LOWER(last_name) = 'higgins';

--���� �����Լ�
--CONCAT : �� ���ڿ� ����
--��SUBSTR : ���ڿ� ����
--LENGTH : ���ڿ� ����
--INSTR : ���� ��ġ
--LPAD : ���ڿ� ���� ���ϰ� ���� ����, ���� �ڸ� ä��
--RPAD : ���� ����, ���� �ڸ� ä��
--TRIM : �� ��, �� �� ���� �ϳ� ���� (LTRIM, RTRIM)

--SUBSTR(���ڿ�, n) : n��° ���ں��� �ڸ���
SELECT last_name, SUBSTR(last_name, 4)
FROM employees
WHERE department_id = 90;

--SUBSTR(���ڿ�, n, m) : n ~ m��° ���� �߶󳻱�
SELECT last_name, SUBSTR(last_name, 2, 2)
FROM employees
WHERE department_id = 90;

--���� n : �ڿ��� ���� �ڸ��� ����
SELECT last_name, SUBSTR(last_name, -3, 2)
FROM employees
WHERE department_id = 90;

SELECT employee_id, CONCAT(first_name, last_name) NAME, job_id, 
       LENGTH(last_name), INSTR(last_name, 'a') "Contains 'a'?"
FROM employees
WHERE SUBSTR(job_id, 4) = 'REP';

--TRIM(LTRIM, RTRIM)
SELECT LTRIM('yyedaymy', 'yea') -- => ���ʺ��� y, e, a �߶�
FROM dual;

SELECT RTRIM('yyedaymy', 'yea') -- => �����ʺ��� y, e, a �߶�
FROM dual;\

--2. ���� �Լ�
--ROUND : �Ҽ��� �ݿø�
SELECT ROUND(345.678) AS round1, -- => �Ҽ��� �ڸ� ���� (= ,0)
       ROUND(345.678, 0) AS round2,
       ROUND(345.678, 1) AS round3,
       ROUND(345.678, -1) AS round4 -- =>1�� �ڸ����� �ݿø�
FROM dual;

--TRUNC : �Ҽ��� ����
SELECT TRUNC(345.678) AS trunc1, -- => �Ҽ��� �ڸ� ���� (= ,0)
       TRUNC(345.678, 0) AS trunc2,
       TRUNC(345.678, 1) AS trunc3,
       TRUNC(345.678, -1) AS trunc4 -- =>1�� �ڸ����� ����
FROM dual;

--MOD : ������ �� ������
SELECT last_name, salary, MOD(salary, 5000)
FROM employees;


--sql03_1 ����------------------------------------------------------------------

--1.
SELECT SYSDATE "Date"
FROM dual;

--2. �� ����� ���� ��� ��ȣ, �̸�, �޿� ��
--   15% �λ�� �޿��� ������ ǥ���Ͻÿ�.
--   �λ�� �޿� ���� ���̺��� New Salary�� �����Ͻÿ�. 
SELECT employee_id, last_name, salary, 
       ROUND(salary*1.15) "New Salary"
FROM employees;

--3. 2�� ���Ǹ� �����Ͽ� 
--  �� �޿����� ���� �޿��� ���� �� ���� �߰��ϰ� 
--  ���̺��� Increase�� �����ϰ� ������ ���Ǹ� �����Ͻÿ�.
SELECT employee_id, last_name, salary,
       ROUND(salary*1.15) "New Salary", 
       ROUND(salary*1.15-salary) "Increase"
FROM employees;

--4. �̸��� J, A �Ǵ� M���� �����ϴ� 
--   ��� ����� �̸�(�빮�� ǥ��) �� �̸� ���̸� ǥ���ϴ� 
--   ���Ǹ� �ۼ��ϰ� ������ ������ ���̺��� �����Ͻÿ�. 
--   ����� ����� �̸��� ���� �����Ͻÿ�.
SELECT UPPER(last_name) "Upper Name", LENGTH(last_name) "Name Length"
FROM employees
WHERE UPPER(SUBSTR(last_name, 1, 1)) IN ('J', 'A', 'M')
ORDER BY 1;

--------------------------------------------------------------------------------

--3. ��¥ �Լ�
--�⺻ ��¥ ���� : DD-MON-YY
--SYSDATE : ���� ��¥, �ð� ��ȯ �Լ�

SELECT SYSDATE
FROM dual;

--��¥-��¥ : ����(�ϼ�)
SELECT last_name, (SYSDATE-hire_date) / 7 AS WEEKS --�ֱ� ���
FROM employees
WHERE department_id = 90;

--MONTHS_BETWEEN : ��¥ ������ �� ��
--ADD_MONTHS : �� ���ϱ�
--NEXT_DAY : ������ ���ƿ��� ������ ��¥(1:�Ͽ��� ~ 7:�����)
--LAST_DAY : ���� ������ ��¥

SELECT employee_id, hire_date, 
       MONTHS_BETWEEN(SYSDATE, hire_date) TENURE,
       ADD_MONTHS(hire_date, 6) REVIEW, --�Ի� 6���� �� ��¥
       NEXT_DAY(hire_date, '��'),   --�Ի��� �� ���ƿ��� �ݿ��� ��¥
       LAST_DAY(hire_date)
FROM employees;

--ROUND : ��¥ �ݿø�
SELECT  ROUND(SYSDATE, 'YEAR'), --���� ���� (7�� 1�� 0�� ���� �ݿø�)
        ROUND(SYSDATE, 'MONTH'), --�� ���� (16�� 0��)
        ROUND(SYSDATE, 'DAY'), --�� ���� (������ �� 12��)
        ROUND(SYSDATE, 'DD') --�� ���� (�� 12��)
FROM dual;

--TRUNC : ��¥ ����
SELECT  TRUNC(SYSDATE, 'YEAR'), --�̹� �⵵ ù��
        TRUNC(SYSDATE, 'MONTH'), --�̹� �� ù��
        TRUNC(SYSDATE, 'DAY'), --�̹� ��
        TRUNC(SYSDATE, 'DD') --����
FROM dual;


--4. ��ȯ �Լ�
--������ Ÿ�� �ٲٴ� �Լ�

--�Ͻ��� ������ ��ȯ(�˾Ƽ� �ٲ���)
SELECT *
FROM employees
WHERE employee_id = '101'; -- ���� => ����

--����� ������ ��ȯ
--TO_CHAR : ��¥ => ����
--��¥ ���ĸ� ���缭 �Է�

--��¥ ���� �̱������� ��ȯ(�Ͻ���)
ALTER SESSION SET
NLS_DATE_LANGUAGE = AMERICAN;

--��¥ ���� �ٲ㼭 ���ڷ� ǥ��
SELECT employee_id, TO_CHAR(hire_date, 'MM/YY')
FROM employees;

--month ��ҹ��� ������
SELECT last_name, TO_CHAR(hire_date, 'DD Month YYYY')
FROM employees;

SELECT last_name, TO_CHAR(hire_date, 'DD month YYYY')
FROM employees;

SELECT last_name, TO_CHAR(hire_date, 'DD MONTH YYYY')
FROM employees;

--fm : ���� ����, ���� 0 ���� 
SELECT last_name, TO_CHAR(hire_date, 'fmDD MONTH YYYY')
FROM employees;

--sp : ���ڷ� ǥ��
--th : ����
SELECT last_name, 
       TO_CHAR(hire_date, 'fmDdspth MONTH YYYY fmHH:MI:SS AM')
FROM employees;

--TO_CHAR : ���� => ����
--9: ���� ǥ��
--0: 0 ����ǥ��
--$, L: ȭ���ȣ
--. ,: �Ҽ���/������ ǥ��
SELECT TO_CHAR(salary, '$99,999.00') SALARY
FROM employees;

--�ڸ��� �Ѿ ���� ǥ�� X
SELECT TO_CHAR(salary, '$9,999.00') SALARY
FROM employees;

--TO_NUMBER : ���� => ����
--���� ��: ���� �μ��� ���İ� ����(�� ���ڴ� �䷱ ������ �����Դϴ�)
SELECT TO_NUMBER('$3,400', '$99,999')
FROM dual;

--��ȣ ���� ���ڸ� �� ���ڸ� ���ĸ� ��������
SELECT TO_NUMBER('3400')
FROM dual;

--�ڡڡڡ�TO_DATE : ���� => ��¥
--���� ��: ���� �μ��� ���İ� ����(�� ���ڴ� �䷱ ������ ��¥�Դϴ�)
SELECT TO_DATE('2010��, 02��', 'YYYY"��", MM"��"')
FROM dual;

--�ý��� ��¥ ���� �𸦶� ���� ������
--ex. 05�� 7�� 1�� ���� �Ի��� ã��
SELECT last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('05/07/01', 'YY/MM/DD');

SELECT last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('2005�� 07�� 01��', 'YYYY"��" MM"��" DD"��"');

--���°� ����� ���� ������� �����
SELECT last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('05/07/01', 'YY-MM-DD');

--fx : Ÿ�԰� ���ĸ� �Ȱ��� ����
SELECT last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('05/07/01', 'fxYY/MM/DD');

--YY ���� : ���� ����(20XX) 
--RR ���� : ���� ���� / ���� ���� ���� ���� �޶���
--�� ���ڸ��� ���� �Է��ϸ� ��

--5. �Ϲ� �Լ�
--�ڡڡڡڡ�NVL(expr1, expr2) : ����(expr1)�� NULL�̸� ���� ��(expr2)���� ��ȯ
--ex. commission_pct�� NULL�̸� => 0���� ��ȯ
SELECT last_name, salary, NVL(commission_pct, 0),
       (salary*12) + (salary*12*NVL(commission_pct, 0)) AN_SAL
FROM employees;

--�������� ��ȯ�� ������ Ÿ�� �����ؾ� ��
SELECT last_name, salary, 
       NVL(TO_CHAR(commission_pct), '���ʽ� ����')
FROM employees;

--NVL2 �Լ�
--NVL2(expr1, expr2, expr3)
-- => 1 = ���� �ƴϸ� 2 / 1 = ���̸� 3
--2, 3�� ������ Ÿ�� �����ؾ� ��
SELECT last_name, salary, commission_pct,
       NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM employees;

--NULLIF(expr1, expr2)
--�� ǥ���� �� => ������ NULL, �ٸ��� expr1 ��ȯ
SELECT first_name, LENGTH(first_name) "expr1",
       last_name, LENGTH(last_name) "expr2",
       NULLIF(LENGTH(first_name), LENGTH(last_name)) result
FROM employees;

--COALESCE : �� �ƴ� ù��° �� ������ ���

--6. ���� ǥ����
--CASE :  = IF-THEN-ELSE��
SELECT last_name, job_id, salary,
        CASE job_id WHEN 'IT_PROG'  THEN 1.10*salary
                    WHEN 'ST_CLERK' THEN 1.15*salary
                    WHEN 'SA_REP'   THEN 1.20*salary
                                    ELSE salary
        END "REVISED_SALARY"
FROM employees;

--��ȣ ���� ������ WHEN �ȿ� 
SELECT last_name, salary,
        CASE WHEN salary<5000  THEN 'Low'
             WHEN salary<10000 THEN 'Medium'
             WHEN salary<20000 THEN 'Good'
                               ELSE 'Excellent'
        END qualified_salary
FROM employees;

--DECODE :  = IF-THEN-ELSE��
--����Ŭ ���������� ��밡��
--<,> ���Ұ� / = �� ��밡��
SELECT last_name, job_id, salary,
       DECODE(job_id, 'IT_PROG',  1.10*salary,
                      'ST_CLERK', 1.15*salary,
                      'SA_REP',   1.20*salary,
                                  salary)
       REVISED_SALARY
FROM employees;

--��ø �Լ� : ������ �Լ� ����̰� ��� ��ø���� 
--=> �ȿ��� ���� �ٱ������� ���

--sql03_2 ����------------------------------------------------------------------

--5. �� ����� �̸��� ǥ���ϰ� 
--   �ٹ� �� ��(�Ի��Ϸκ��� ��������� �� ��)�� ����Ͽ� 
--   �� ���̺��� MONTHS_WORKED�� �����Ͻÿ�. 
--   ����� ������ �ݿø��Ͽ� ǥ���Ͻÿ�.
SELECT last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) MONTHS_WORKED
FROM employees;

--6. ��� ����� �� �� �޿��� ǥ���ϱ� ���� query�� �ۼ��մϴ�. 
--   �޿��� 15�� ���̷� ǥ�õǰ� ���ʿ� # ��ȣ�� ä�������� ������ �����Ͻÿ�. 
--   �� ���̺��� SALARY �� �����մϴ�.
SELECT last_name, LPAD(salary, 15, '$') SALARY
FROM employees;

--7. �μ� 90�� ��� ����� ���� ��(last_name) �� 
--   ���� �Ⱓ(�� ����)�� ǥ���ϵ��� query �� �ۼ��Ͻÿ�. 
--   �ָ� ��Ÿ���� ���� ���� ���̺�� TENURE�� �����ϰ�
--   �ָ� ��Ÿ���� ���� ���� ������ ��Ÿ���ÿ�.
SELECT last_name, ROUND((SYSDATE-hire_date) / 7) TENURE
FROM employees
WHERE department_id = 90;

--------------------------------------------------------------------------------

--sql04 ����--------------------------------------------------------------------

--1. �� ����� ���� ���� �׸��� �����ϴ� ���Ǹ� �ۼ��ϰ� 
--   �� ���̺��� Dream Salaries�� �����Ͻÿ�.
--   <employee last_name> earns <salary> monthly but wants <3 times salary>. 
--   <����> Matos earns $2,600.00 monthly but wants $7,800.00.
SELECT last_name
       ||' earns '
       ||TO_CHAR(salary, 'fm$99,999.00')
       ||' monthly but wants '
       ||TO_CHAR(salary*3, 'fm$99,999.00')
FROM employees;

--2. ����� �̸�, �Ի��� �� �޿� �������� ǥ���Ͻÿ�.
--   �޿� �������� ���� ���� ����� �� ù��° �������Դϴ�. 
--   �� ���̺��� REVIEW�� �����ϰ� 
--   ��¥�� "2010.03.31 ������"�� ���� �������� ǥ�õǵ��� �����Ͻÿ�.
SELECT last_name, hire_date,
       TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6),2), 'YYYY.MM.DD DAY') REVIEW
FROM employees;
--ADD_MONTH(_,6) : �Ի��� + 6����
--NEXT_DAT(_,2) : ù��° ������
--TO_CHAR(_, 'YYYY.MM.DD DAY') : ���ڿ� ��ȯ

--3. �̸�, �Ի��� �� ���� ���� ������ ǥ���ϰ� 
--   �� ���̺��� DAY�� �����Ͻÿ�. 
--   �������� �������� �ؼ� ������ �������� ����� �����Ͻÿ�.
SELECT last_name, hire_date, TO_CHAR(hire_date, 'day') DAY
FROM employees
ORDER BY MOD(TO_NUMBER(TO_CHAR(hire_date, 'd'))+5, 7);
--TO_CHAR(hire_date, 'd') => 1: ��, 2: ��
--TO_NUMBER(_) + 5 => 6: ��, 7: ��
--MOD(_,7) => 6: ��, 0: ��

--�������� Ǯ��
SELECT last_name, hire_date, TO_CHAR(hire_date, 'day') DAY
FROM employees
ORDER BY TO_CHAR((hire_date-1), 'd');
--hire_date-1 => 7:��, 1:�� (overflow??)

--4. ����� �̸��� Ŀ�̼��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
--   Ŀ�̼��� ���� �ʴ� ����� ��� ��No Commission���� ǥ���Ͻÿ�. 
--   �� ���̺��� COMM���� �����Ͻÿ�.
SELECT last_name, NVL(TO_CHAR(commission_pct), 'No Commission') COMM
FROM employees;

--5. DECODE �Լ��� CASE ������ ����Ͽ� ���� �����Ϳ� ���� 
--   JOB_ID ���� ���� �������� ��� ����� ����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
--   ����         ���
--   AD_PRES     A
--   ST_MAN      B
--   IT_PROG     C
--   SA_REP      D
--   ST_CLERK    E
--   �׿�        0

--DECODE��
SELECT last_name, job_id,
       DECODE(job_id, 'AD_PRES',  'A',
                      'ST_MAN',   'B',
                      'IT_PROG',  'C',
                      'SA_REP',   'D',
                      'ST_CLERK', 'E',
                                   0)
       GRADE
FROM employees;

--CASE��
SELECT last_name, job_id,
       CASE job_id WHEN 'AD_PRES'  THEN 'A'
                   WHEN 'ST_MAN'   THEN 'B'
                   WHEN 'IT_PROG'  THEN 'C'
                   WHEN 'SA_REP'   THEN 'D'
                   WHEN 'ST_CLERK' THEN 'E'
                   ELSE                 '0'
        END
        GRADE
FROM employees;

--------------------------------------------------------------------------------
