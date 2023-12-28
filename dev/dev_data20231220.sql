--------------------------------------------------------
--  ������ ������ - ������-12��-20-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence SCHEDULE_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DEV"."SCHEDULE_ID_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 141 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence S_NUMBER_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DEV"."S_NUMBER_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence TICKET_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DEV"."TICKET_ID_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table BOOKS
--------------------------------------------------------

  CREATE TABLE "DEV"."BOOKS" 
   (	"BOOK_CODE" VARCHAR2(10 BYTE), 
	"BOOK_NAME" VARCHAR2(100 BYTE), 
	"AUTHOR" VARCHAR2(100 BYTE), 
	"PUBLISHER" VARCHAR2(100 BYTE), 
	"BOOK_COST" NUMBER DEFAULT 10000
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table MOVIE
--------------------------------------------------------

  CREATE TABLE "DEV"."MOVIE" 
   (	"MOVIE_ID" VARCHAR2(10 BYTE), 
	"MOVIE_NAME" VARCHAR2(100 BYTE), 
	"DIRECTOR" VARCHAR2(50 BYTE), 
	"GENRE" VARCHAR2(50 BYTE), 
	"ACTORS" VARCHAR2(1000 BYTE), 
	"RELEASE_DATE" DATE, 
	"AGE_LIMIT" NUMBER(10,0), 
	"RUNNING_TIME" NUMBER(20,0), 
	"PLOT" VARCHAR2(1000 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SCHEDULE
--------------------------------------------------------

  CREATE TABLE "DEV"."SCHEDULE" 
   (	"SCHEDULE_ID" NUMBER, 
	"MOVIE_ID" VARCHAR2(10 BYTE), 
	"SCHEDULE_DATE" DATE, 
	"REMAIN_SEAT" NUMBER(10,0) DEFAULT 50, 
	"DISCOUNT" VARCHAR2(20 BYTE) DEFAULT ' '
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table STUDENT
--------------------------------------------------------

  CREATE TABLE "DEV"."STUDENT" 
   (	"STUDENT_NUMBER" VARCHAR2(10 BYTE), 
	"STUDENT_NAME" VARCHAR2(100 BYTE), 
	"ENGLISH_SCORE" NUMBER DEFAULT 80, 
	"MATHEMATICS_SCORE" NUMBER DEFAULT 70
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table TICKET
--------------------------------------------------------

  CREATE TABLE "DEV"."TICKET" 
   (	"TICKET_ID" NUMBER(38,0), 
	"USER_ID" VARCHAR2(50 BYTE), 
	"SCHEDULE_ID" NUMBER, 
	"AGE" VARCHAR2(10 BYTE), 
	"SEAT_ROW" VARCHAR2(10 BYTE), 
	"SEAT_COLUMN" NUMBER(10,0), 
	"DISCOUNT" VARCHAR2(50 BYTE), 
	"PRICE" NUMBER(30,0), 
	"RESERVE_DATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table T_USER
--------------------------------------------------------

  CREATE TABLE "DEV"."T_USER" 
   (	"USER_ID" VARCHAR2(50 BYTE), 
	"PASSWD" VARCHAR2(50 BYTE), 
	"USER_NAME" VARCHAR2(50 BYTE), 
	"USER_TEL" VARCHAR2(50 BYTE), 
	"JOIN_DATE" DATE DEFAULT SYSDATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into DEV.BOOKS
SET DEFINE OFF;
Insert into DEV.BOOKS (BOOK_CODE,BOOK_NAME,AUTHOR,PUBLISHER,BOOK_COST) values ('D002','Do It! �ڹ� �Թ�','������','�������ۺ�����',25000);
Insert into DEV.BOOKS (BOOK_CODE,BOOK_NAME,AUTHOR,PUBLISHER,BOOK_COST) values ('A001','�̰��� ��������','���糲','�Ѻ��̵��',36000);
Insert into DEV.BOOKS (BOOK_CODE,BOOK_NAME,AUTHOR,PUBLISHER,BOOK_COST) values ('A002','ȥ�� �����ϴ� �ڹ�','�ſ��','�Ѻ��̵��',24000);
Insert into DEV.BOOKS (BOOK_CODE,BOOK_NAME,AUTHOR,PUBLISHER,BOOK_COST) values ('B001','�ڹٽ�ũ��Ʈ �Ŀ���','������Ʈ','������Ʈ',22000);
REM INSERTING into DEV.MOVIE
SET DEFINE OFF;
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-006','3���� �ް�','����ȿ','���','���ؼ� ,  �Źξ� ,  ���⿵ ,  Ȳ���� ,  �ڸ���',to_date('2023-12-06 00:00:00','YYYY-MM-DD HH24:MI:SS'),12,105,'���� �� 3��° �Ǵ� ��,
    �����ڡ�(���ؼ�)�� �ϴÿ��� 3�ϰ��� �ް��� �޾�
    ��Ģ �ȳ��� ���� ���� �����̵塯(���⿵)�� �Բ� ���� �����´�.');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-007','�̱� �� ����','�ڹ���','�θǽ�','�̵���, �Ӽ���, �̼�, ������, ������',to_date('2023-11-29 00:00:00','YYYY-MM-DD HH24:MI:SS'),12,103,'����� ȥ���� ����� ���ݾƿ䡱
    ����, ȥ�ڰ� ������ ���ִ� �ϰ� ����
    �� ������ �̱� �������� ���۵ȴ�!');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-008','��������','���鸮 ����','����','ȣ��Ų �Ǵн�, �ٳ׻� Ŀ��, ���� ��Ͽ�, ����Ʈ ������',to_date('2023-12-06 00:00:00','YYYY-MM-DD HH24:MI:SS'),15,158,'�������� Ȳ���� �� ����!
    ������ ������ ���� �ƹ��͵� ���� ���� Ȳ��,
    ���������ˡ��� �뼭�簡 ��������!');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-009','���ϰ� ���� ���','Ÿ�ɹ��� ��Ÿ��','�θǽ�','Ÿī�Ͻ� �Ĺ̾�, ������� ���丮',to_date('2023-12-13 00:00:00','YYYY-MM-DD HH24:MI:SS'),0,110,'����� �� ���ڱ� ���� ���!? ������ �߸� ��޵Ǿ���!
    ���������� ���� Ŀ������ �ʸ� ���� ����');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-010','��� X','�ɺ� �׷���Ʈ','����','��� ��, ��� ���̽�, �ų�� ���ڵ� ����, ��Ƽ�� �귣��, ����Ŭ ��ġ',to_date('2023-12-13 00:00:00','YYYY-MM-DD HH24:MI:SS'),18,118,'�̰��� ������ �ƴϴ�.
    ������� ����� �ʴ���� ��� ����� �ڽ��� ������ ��ȸ�� ������.
    �׵��� ������ ������, ������ ������ ���۵ȴ�.');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-011','Ʈ��: ��� ���Դ�','��Ʈ ����','�ִϸ��̼�','�ֳ� �˵帯, ����ƾ ��������ũ, ī�ж� ī����, ���� �ȵ巹, Ʈ���� �ù�',to_date('2023-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),0,92,'�־� ���̵� �׷� ����� ���б�! �츮 �Բ��ϸ� �� ���ݾ�!
    �� ���� ��� Ʈ���� ������ �ߴ� �ְ��� ���̵� �׷� ���������.
    12��, ���� ¥���� �Ĺ� ������ ����!');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-001','������ ��','�輺��','���','Ȳ����, ���켺, �̼���, ������, �輺��',to_date('2023-11-22 00:00:00','YYYY-MM-DD HH24:MI:SS'),12,141,'1979�� 12�� 12��, ���� ���� ����ݶ� �߻�
        �׳�, ���ѹα��� ����� �ٲ����');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-002','����','�������� ����ī��','���','�ȵ� ������, �����߸� ����Ÿ, ����ī�� �Ҿ�, ���̶�� ����Ÿ, Ÿī��Ÿ ����Ű',to_date('2023-11-29 00:00:00','YYYY-MM-DD HH24:MI:SS'),12,127,'���츮 ���׿��� ������ ��١�
        ��ǳ�� ����ġ�� ��� ��, �ƹ��� ������ ������ �巯����.');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-003','�Ƿη� ������','������','�ִϸ��̼�','�̼�, �̹���, �Լ���, ȫ�ҿ�, ���̼�',to_date('2023-12-13 00:00:00','YYYY-MM-DD HH24:MI:SS'),0,78,'�Ƿηο� ģ������ �� ���ָ� ��Ʋ�� �ְ��� ���۽�Ÿ�� �̴� ���� ����
        ���Ķ��� ���۽�Ÿ ���ߴ�ȸ�� ������ �����ϱ� ���� ������ ������.');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-004','�����Ƹ�','���ӽ� ��','�׼�','���̽� ���� ,  ��Ʈ�� ���� ,  ������ �е� ��ƾ 2�� ,  �ڹ� ��� ,  ���� Ű���',to_date('2023-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),12,124,'��Ʋ��Ƽ�� �ձ��� �̲� ���� �ڸ��� ���� �������Ƹǡ�,
        �ٴٸ� ������ ���� ����ΰ� ������ �ǵ��� �ٲ۴�!');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-005','�뷮-������ �ٴ�','���ѹ�','�׼�','������, ������, ���翵, ����ȣ, �輺��',to_date('2023-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),12,124,'�����ֶ� �߹߷κ��� 7���� ���� 1598�� 12��,
        ��θ� �е��� ������ ������ ���۵ȴ�!');
REM INSERTING into DEV.SCHEDULE
SET DEFINE OFF;
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (103,'23-001',to_date('2023-12-20 08:00:00','YYYY-MM-DD HH24:MI:SS'),49,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (121,'23-004',to_date('2023-12-25 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (122,'23-004',to_date('2023-12-25 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (123,'23-004',to_date('2023-12-25 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (124,'23-005',to_date('2023-12-25 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (125,'23-005',to_date('2023-12-25 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (126,'23-005',to_date('2023-12-25 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (127,'23-005',to_date('2023-12-25 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (128,'23-005',to_date('2023-12-25 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'�ɾ�');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (101,'23-001',to_date('2023-12-20 10:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (2,'23-001',to_date('2023-12-20 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (3,'23-001',to_date('2023-12-20 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (4,'23-001',to_date('2023-12-20 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (5,'23-001',to_date('2023-12-20 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'�ɾ�');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (6,'23-001',to_date('2023-12-21 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (7,'23-001',to_date('2023-12-21 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (8,'23-001',to_date('2023-12-21 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (9,'23-001',to_date('2023-12-21 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (10,'23-001',to_date('2023-12-21 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'�ɾ�');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (11,'23-001',to_date('2023-12-22 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (12,'23-001',to_date('2023-12-22 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (13,'23-001',to_date('2023-12-22 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (14,'23-001',to_date('2023-12-22 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (15,'23-001',to_date('2023-12-22 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'�ɾ�');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (16,'23-001',to_date('2023-12-23 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (17,'23-001',to_date('2023-12-23 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (18,'23-001',to_date('2023-12-23 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (19,'23-001',to_date('2023-12-23 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (20,'23-001',to_date('2023-12-23 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (22,'23-001',to_date('2023-12-24 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (23,'23-001',to_date('2023-12-24 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (24,'23-001',to_date('2023-12-24 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (25,'23-001',to_date('2023-12-24 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (26,'23-001',to_date('2023-12-24 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'�ɾ�');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (27,'23-001',to_date('2023-12-25 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (28,'23-001',to_date('2023-12-25 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (29,'23-001',to_date('2023-12-25 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (30,'23-001',to_date('2023-12-25 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (31,'23-001',to_date('2023-12-25 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'�ɾ�');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (32,'23-001',to_date('2023-12-26 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (33,'23-001',to_date('2023-12-26 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (34,'23-001',to_date('2023-12-26 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (35,'23-001',to_date('2023-12-26 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (36,'23-001',to_date('2023-12-26 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'�ɾ�');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (39,'23-001',to_date('2023-12-27 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (40,'23-001',to_date('2023-12-27 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (41,'23-001',to_date('2023-12-27 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (42,'23-001',to_date('2023-12-27 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (43,'23-001',to_date('2023-12-27 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'�ɾ�');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (60,'23-002',to_date('2023-12-20 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (61,'23-002',to_date('2023-12-20 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (62,'23-002',to_date('2023-12-20 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (63,'23-002',to_date('2023-12-21 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (64,'23-002',to_date('2023-12-21 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (65,'23-002',to_date('2023-12-21 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (66,'23-002',to_date('2023-12-22 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (67,'23-002',to_date('2023-12-22 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (68,'23-002',to_date('2023-12-22 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (69,'23-002',to_date('2023-12-23 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (70,'23-002',to_date('2023-12-23 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (71,'23-002',to_date('2023-12-23 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (72,'23-002',to_date('2023-12-24 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (73,'23-002',to_date('2023-12-24 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (74,'23-002',to_date('2023-12-24 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (75,'23-002',to_date('2023-12-25 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (76,'23-002',to_date('2023-12-25 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (77,'23-002',to_date('2023-12-25 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (78,'23-002',to_date('2023-12-26 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (79,'23-002',to_date('2023-12-26 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (80,'23-002',to_date('2023-12-26 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (81,'23-002',to_date('2023-12-27 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'����');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (82,'23-002',to_date('2023-12-27 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (83,'23-002',to_date('2023-12-27 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
REM INSERTING into DEV.STUDENT
SET DEFINE OFF;
Insert into DEV.STUDENT (STUDENT_NUMBER,STUDENT_NAME,ENGLISH_SCORE,MATHEMATICS_SCORE) values ('23-002','���浿',77,88);
Insert into DEV.STUDENT (STUDENT_NUMBER,STUDENT_NAME,ENGLISH_SCORE,MATHEMATICS_SCORE) values ('23-001','ȫ�浿',88,77);
Insert into DEV.STUDENT (STUDENT_NUMBER,STUDENT_NAME,ENGLISH_SCORE,MATHEMATICS_SCORE) values ('23-003','������',99,98);
REM INSERTING into DEV.TICKET
SET DEFINE OFF;
REM INSERTING into DEV.T_USER
SET DEFINE OFF;
Insert into DEV.T_USER (USER_ID,PASSWD,USER_NAME,USER_TEL,JOIN_DATE) values ('sys','sys','������',null,null);
Insert into DEV.T_USER (USER_ID,PASSWD,USER_NAME,USER_TEL,JOIN_DATE) values ('khj365','0000','������','010-1234-5678',to_date('2023-12-15 10:20:41','YYYY-MM-DD HH24:MI:SS'));
Insert into DEV.T_USER (USER_ID,PASSWD,USER_NAME,USER_TEL,JOIN_DATE) values ('asdf9876','9876','�ڹμ�','010-9876-9876',to_date('2022-05-30 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into DEV.T_USER (USER_ID,PASSWD,USER_NAME,USER_TEL,JOIN_DATE) values ('efgh3355','3355','��ö��','010-3355-3355',to_date('2023-01-26 00:00:00','YYYY-MM-DD HH24:MI:SS'));
--------------------------------------------------------
--  DDL for Index SYS_C007036
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEV"."SYS_C007036" ON "DEV"."STUDENT" ("STUDENT_NUMBER") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C007038
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEV"."SYS_C007038" ON "DEV"."BOOKS" ("BOOK_CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C007044
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEV"."SYS_C007044" ON "DEV"."T_USER" ("USER_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C007046
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEV"."SYS_C007046" ON "DEV"."MOVIE" ("MOVIE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C007051
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEV"."SYS_C007051" ON "DEV"."SCHEDULE" ("SCHEDULE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C007052
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEV"."SYS_C007052" ON "DEV"."TICKET" ("TICKET_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C007038
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEV"."SYS_C007038" ON "DEV"."BOOKS" ("BOOK_CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C007046
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEV"."SYS_C007046" ON "DEV"."MOVIE" ("MOVIE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C007051
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEV"."SYS_C007051" ON "DEV"."SCHEDULE" ("SCHEDULE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C007036
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEV"."SYS_C007036" ON "DEV"."STUDENT" ("STUDENT_NUMBER") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C007052
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEV"."SYS_C007052" ON "DEV"."TICKET" ("TICKET_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C007044
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEV"."SYS_C007044" ON "DEV"."T_USER" ("USER_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table BOOKS
--------------------------------------------------------

  ALTER TABLE "DEV"."BOOKS" ADD PRIMARY KEY ("BOOK_CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DEV"."BOOKS" MODIFY ("BOOK_NAME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MOVIE
--------------------------------------------------------

  ALTER TABLE "DEV"."MOVIE" ADD PRIMARY KEY ("MOVIE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DEV"."MOVIE" MODIFY ("MOVIE_NAME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SCHEDULE
--------------------------------------------------------

  ALTER TABLE "DEV"."SCHEDULE" ADD PRIMARY KEY ("SCHEDULE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table STUDENT
--------------------------------------------------------

  ALTER TABLE "DEV"."STUDENT" ADD PRIMARY KEY ("STUDENT_NUMBER")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DEV"."STUDENT" MODIFY ("STUDENT_NAME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TICKET
--------------------------------------------------------

  ALTER TABLE "DEV"."TICKET" ADD PRIMARY KEY ("TICKET_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table T_USER
--------------------------------------------------------

  ALTER TABLE "DEV"."T_USER" ADD PRIMARY KEY ("USER_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DEV"."T_USER" MODIFY ("PASSWD" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table SCHEDULE
--------------------------------------------------------

  ALTER TABLE "DEV"."SCHEDULE" ADD FOREIGN KEY ("MOVIE_ID")
	  REFERENCES "DEV"."MOVIE" ("MOVIE_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table TICKET
--------------------------------------------------------

  ALTER TABLE "DEV"."TICKET" ADD CONSTRAINT "SCHEDULE_TICKET_FK" FOREIGN KEY ("SCHEDULE_ID")
	  REFERENCES "DEV"."SCHEDULE" ("SCHEDULE_ID") ENABLE;
  ALTER TABLE "DEV"."TICKET" ADD FOREIGN KEY ("USER_ID")
	  REFERENCES "DEV"."T_USER" ("USER_ID") ENABLE;