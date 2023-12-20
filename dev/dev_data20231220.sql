--------------------------------------------------------
--  파일이 생성됨 - 수요일-12월-20-2023   
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
Insert into DEV.BOOKS (BOOK_CODE,BOOK_NAME,AUTHOR,PUBLISHER,BOOK_COST) values ('D002','Do It! 자바 입문','박은종','이지스퍼블리싱',25000);
Insert into DEV.BOOKS (BOOK_CODE,BOOK_NAME,AUTHOR,PUBLISHER,BOOK_COST) values ('A001','이것이 리눅스다','우재남','한빛미디어',36000);
Insert into DEV.BOOKS (BOOK_CODE,BOOK_NAME,AUTHOR,PUBLISHER,BOOK_COST) values ('A002','혼자 공부하는 자바','신용권','한빛미디어',24000);
Insert into DEV.BOOKS (BOOK_CODE,BOOK_NAME,AUTHOR,PUBLISHER,BOOK_COST) values ('B001','자바스크립트 파워북','어포스트','어포스트',22000);
REM INSERTING into DEV.MOVIE
SET DEFINE OFF;
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-006','3일의 휴가','육상효','드라마','김해숙 ,  신민아 ,  강기영 ,  황보라 ,  박명훈',to_date('2023-12-06 00:00:00','YYYY-MM-DD HH24:MI:SS'),12,105,'죽은 지 3년째 되는 날,
    ‘복자’(김해숙)는 하늘에서 3일간의 휴가를 받아
    규칙 안내를 맡은 신입 ‘가이드’(강기영)와 함께 지상에 내려온다.');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-007','싱글 인 서울','박범수','로맨스','이동욱, 임수정, 이솜, 장현성, 김지영',to_date('2023-11-29 00:00:00','YYYY-MM-DD HH24:MI:SS'),12,103,'“사실 혼자인 사람은 없잖아요”
    서울, 혼자가 좋지만 연애는 하고 싶은
    두 남녀의 싱글 라이프가 시작된다!');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-008','나폴레옹','리들리 스콧','전쟁','호아킨 피닉스, 바네사 커비, 루디빈 사니에, 루퍼트 에버렛',to_date('2023-12-06 00:00:00','YYYY-MM-DD HH24:MI:SS'),15,158,'“스스로 황제가 된 영웅!
    세상을 정복한 영웅 아무것도 갖지 못한 황제,
    ‘나폴레옹’의 대서사가 펼쳐진다!');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-009','말하고 싶은 비밀','타케무라 켄타로','로맨스','타카하시 후미야, 사쿠라다 히요리',to_date('2023-12-13 00:00:00','YYYY-MM-DD HH24:MI:SS'),0,110,'“어느 날 갑자기 고백 사고!? 마음이 잘못 배달되었다!
    엇갈릴수록 점점 커져가는 너를 향한 마음');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-010','쏘우 X','케빈 그루터트','공포','토빈 벨, 쇼니 스미스, 신노브 맥코디 런드, 스티브 브랜드, 마이클 비치',to_date('2023-12-13 00:00:00','YYYY-MM-DD HH24:MI:SS'),18,118,'이것은 복수가 아니다.
    ‘직쏘’의 세계로 초대받은 모든 사람은 자신을 구원할 기회를 가진다.
    그들의 게임이 끝나고, 직쏘의 게임이 시작된다.');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-011','트롤: 밴드 투게더','월트 도른','애니메이션','애나 켄드릭, 저스틴 팀버레이크, 카밀라 카베요, 에릭 안드레, 트로이 시반',to_date('2023-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),0,92,'최애 아이돌 그룹 재결합 초읽기! 우리 함께하면 더 좋잖아!
    전 세계 모든 트롤을 열광케 했던 최고의 아이돌 그룹 ‘브로존’.
    12월, 가장 짜릿한 컴백 무대의 시작!');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-001','서울의 봄','김성수','드라마','황정민, 정우성, 이성민, 박해준, 김성균',to_date('2023-11-22 00:00:00','YYYY-MM-DD HH24:MI:SS'),12,141,'1979년 12월 12일, 수도 서울 군사반란 발생
        그날, 대한민국의 운명이 바뀌었다');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-002','괴물','고레에다 히로카즈','드라마','안도 사쿠라, 나가야마 에이타, 쿠로카와 소야, 히이라기 히나타, 타카하타 미츠키',to_date('2023-11-29 00:00:00','YYYY-MM-DD HH24:MI:SS'),12,127,'“우리 동네에는 괴물이 산다”
        태풍이 몰아치던 어느 날, 아무도 몰랐던 진실이 드러난다.');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-003','뽀로로 극장판','윤제완','애니메이션','이선, 이미자, 함수정, 홍소영, 정미숙',to_date('2023-12-13 00:00:00','YYYY-MM-DD HH24:MI:SS'),0,78,'뽀로로와 친구들은 전 우주를 통틀어 최고의 슈퍼스타를 뽑는 음악 축제
        ‘파랑돌 슈퍼스타 선발대회’ 축제에 참가하기 위해 모험을 떠난다.');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-004','아쿠아맨','제임스 완','액션','제이슨 모모아 ,  패트릭 윌슨 ,  야히아 압둘 마틴 2세 ,  앰버 허드 ,  니콜 키드먼',to_date('2023-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),12,124,'아틀란티스 왕국을 이끌 왕의 자리에 오른 ‘아쿠아맨’,
        바다를 지배할 슈퍼 히어로가 세상의 판도를 바꾼다!');
Insert into DEV.MOVIE (MOVIE_ID,MOVIE_NAME,DIRECTOR,GENRE,ACTORS,RELEASE_DATE,AGE_LIMIT,RUNNING_TIME,PLOT) values ('23-005','노량-죽음의 바다','김한민','액션','김윤석, 백윤식, 정재영, 허준호, 김성규',to_date('2023-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),12,124,'임진왜란 발발로부터 7년이 지난 1598년 12월,
        모두를 압도할 최후의 전투가 시작된다!');
REM INSERTING into DEV.SCHEDULE
SET DEFINE OFF;
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (103,'23-001',to_date('2023-12-20 08:00:00','YYYY-MM-DD HH24:MI:SS'),49,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (121,'23-004',to_date('2023-12-25 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (122,'23-004',to_date('2023-12-25 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (123,'23-004',to_date('2023-12-25 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (124,'23-005',to_date('2023-12-25 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (125,'23-005',to_date('2023-12-25 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (126,'23-005',to_date('2023-12-25 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (127,'23-005',to_date('2023-12-25 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (128,'23-005',to_date('2023-12-25 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'심야');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (101,'23-001',to_date('2023-12-20 10:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (2,'23-001',to_date('2023-12-20 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (3,'23-001',to_date('2023-12-20 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (4,'23-001',to_date('2023-12-20 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (5,'23-001',to_date('2023-12-20 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'심야');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (6,'23-001',to_date('2023-12-21 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (7,'23-001',to_date('2023-12-21 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (8,'23-001',to_date('2023-12-21 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (9,'23-001',to_date('2023-12-21 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (10,'23-001',to_date('2023-12-21 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'심야');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (11,'23-001',to_date('2023-12-22 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (12,'23-001',to_date('2023-12-22 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (13,'23-001',to_date('2023-12-22 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (14,'23-001',to_date('2023-12-22 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (15,'23-001',to_date('2023-12-22 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'심야');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (16,'23-001',to_date('2023-12-23 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (17,'23-001',to_date('2023-12-23 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (18,'23-001',to_date('2023-12-23 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (19,'23-001',to_date('2023-12-23 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (20,'23-001',to_date('2023-12-23 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (22,'23-001',to_date('2023-12-24 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (23,'23-001',to_date('2023-12-24 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (24,'23-001',to_date('2023-12-24 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (25,'23-001',to_date('2023-12-24 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (26,'23-001',to_date('2023-12-24 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'심야');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (27,'23-001',to_date('2023-12-25 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (28,'23-001',to_date('2023-12-25 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (29,'23-001',to_date('2023-12-25 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (30,'23-001',to_date('2023-12-25 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (31,'23-001',to_date('2023-12-25 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'심야');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (32,'23-001',to_date('2023-12-26 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (33,'23-001',to_date('2023-12-26 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (34,'23-001',to_date('2023-12-26 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (35,'23-001',to_date('2023-12-26 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (36,'23-001',to_date('2023-12-26 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'심야');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (39,'23-001',to_date('2023-12-27 08:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (40,'23-001',to_date('2023-12-27 12:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (41,'23-001',to_date('2023-12-27 16:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (42,'23-001',to_date('2023-12-27 20:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (43,'23-001',to_date('2023-12-27 23:30:00','YYYY-MM-DD HH24:MI:SS'),50,'심야');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (60,'23-002',to_date('2023-12-20 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (61,'23-002',to_date('2023-12-20 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (62,'23-002',to_date('2023-12-20 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (63,'23-002',to_date('2023-12-21 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (64,'23-002',to_date('2023-12-21 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (65,'23-002',to_date('2023-12-21 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (66,'23-002',to_date('2023-12-22 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (67,'23-002',to_date('2023-12-22 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (68,'23-002',to_date('2023-12-22 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (69,'23-002',to_date('2023-12-23 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (70,'23-002',to_date('2023-12-23 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (71,'23-002',to_date('2023-12-23 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (72,'23-002',to_date('2023-12-24 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (73,'23-002',to_date('2023-12-24 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (74,'23-002',to_date('2023-12-24 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (75,'23-002',to_date('2023-12-25 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (76,'23-002',to_date('2023-12-25 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (77,'23-002',to_date('2023-12-25 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (78,'23-002',to_date('2023-12-26 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (79,'23-002',to_date('2023-12-26 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (80,'23-002',to_date('2023-12-26 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (81,'23-002',to_date('2023-12-27 09:00:00','YYYY-MM-DD HH24:MI:SS'),50,'조조');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (82,'23-002',to_date('2023-12-27 14:00:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
Insert into DEV.SCHEDULE (SCHEDULE_ID,MOVIE_ID,SCHEDULE_DATE,REMAIN_SEAT,DISCOUNT) values (83,'23-002',to_date('2023-12-27 19:30:00','YYYY-MM-DD HH24:MI:SS'),50,' ');
REM INSERTING into DEV.STUDENT
SET DEFINE OFF;
Insert into DEV.STUDENT (STUDENT_NUMBER,STUDENT_NAME,ENGLISH_SCORE,MATHEMATICS_SCORE) values ('23-002','고길동',77,88);
Insert into DEV.STUDENT (STUDENT_NUMBER,STUDENT_NAME,ENGLISH_SCORE,MATHEMATICS_SCORE) values ('23-001','홍길동',88,77);
Insert into DEV.STUDENT (STUDENT_NUMBER,STUDENT_NAME,ENGLISH_SCORE,MATHEMATICS_SCORE) values ('23-003','김현준',99,98);
REM INSERTING into DEV.TICKET
SET DEFINE OFF;
REM INSERTING into DEV.T_USER
SET DEFINE OFF;
Insert into DEV.T_USER (USER_ID,PASSWD,USER_NAME,USER_TEL,JOIN_DATE) values ('sys','sys','관리자',null,null);
Insert into DEV.T_USER (USER_ID,PASSWD,USER_NAME,USER_TEL,JOIN_DATE) values ('khj365','0000','김현준','010-1234-5678',to_date('2023-12-15 10:20:41','YYYY-MM-DD HH24:MI:SS'));
Insert into DEV.T_USER (USER_ID,PASSWD,USER_NAME,USER_TEL,JOIN_DATE) values ('asdf9876','9876','박민수','010-9876-9876',to_date('2022-05-30 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into DEV.T_USER (USER_ID,PASSWD,USER_NAME,USER_TEL,JOIN_DATE) values ('efgh3355','3355','김철수','010-3355-3355',to_date('2023-01-26 00:00:00','YYYY-MM-DD HH24:MI:SS'));
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
