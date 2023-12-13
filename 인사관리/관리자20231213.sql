--<������ ����(DCL)>
--1. �ý��� ����: DB�� �׼��� ����

--�ý��� ���� Ȯ��
SELECT *
FROM system_privilege_map;

--����� ���� ����: CREATE USER => ������ �������� ����
CREATE USER   skj
IDENTIFIED BY test;

--���� �ο�
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW
TO    skj;

--���� ���
REVOKE CREATE TABLE, CREATE VIEW
FROM   skj;

--��й�ȣ ����
ALTER USER skj
IDENTIFIED BY lion;

--yedam ���� ���� + ���̺����̽� �ο�
CREATE USER yedam
IDENTIFIED BY yedam
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE temp;

--dba�� �ο�
GRANT CONNECT, dba
TO    yedam;


--��ü ����  : DB ��ü ���� ���� ���� => ��ü���� �ٸ�

REVOKE SELECT
ON     hr.employees
FROM   yedam; 
