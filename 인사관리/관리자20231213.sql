--<데이터 제어(DCL)>
--1. 시스템 권한: DB에 액세스 가능

--시스템 권한 확인
SELECT *
FROM system_privilege_map;

--사용자 계정 생성: CREATE USER => 관리자 계정에서 생성
CREATE USER   skj
IDENTIFIED BY test;

--권한 부여
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW
TO    skj;

--권한 취소
REVOKE CREATE TABLE, CREATE VIEW
FROM   skj;

--비밀번호 변경
ALTER USER skj
IDENTIFIED BY lion;

--yedam 계정 생성 + 테이블스페이스 부여
CREATE USER yedam
IDENTIFIED BY yedam
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE temp;

--dba롤 부여
GRANT CONNECT, dba
TO    yedam;


--객체 권한  : DB 객체 내용 조작 가능 => 객체마다 다름

REVOKE SELECT
ON     hr.employees
FROM   yedam; 
