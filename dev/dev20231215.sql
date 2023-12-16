CREATE TABLE theater_user(
    user_id     VARCHAR2(50) PRIMARY KEY,
    passwd      VARCHAR2(50) NOT NULL,
    user_name   VARCHAR2(50),
    user_tel    VARCHAR2(50),
    join_date   DATE DEFAULT SYSDATE);
    
SELECT *
FROM   theater_user
ORDER BY join_date;

INSERT INTO theater_user
VALUES ('abcd1234', '1234', '홍길동', '010-1234-1234', 
        TO_DATE('2020/02/07', 'YYYY/MM/DD'));

INSERT INTO theater_user
VALUES ('qwer7788', '7788', '고길동', '010-7788-7788',
        TO_DATE('2021/12/09', 'YYYY/MM/DD'));

INSERT INTO theater_user
VALUES ('asdf9876', '9876', '박민수', '010-9876-9876',
        TO_DATE('2022/05/30', 'YYYY/MM/DD'));

INSERT INTO theater_user
VALUES ('efgh3355', '3355', '김철수', '010-3355-3355',
        TO_DATE('2023/01/26', 'YYYY/MM/DD'));


INSERT INTO theater_user(user_id, passwd, user_name, user_tel)
VALUES ('khj365', '0000', '김현준', '010-1234-5678');

SELECT *
FROM   theater_user
WHERE  user_id = 'khj365'
AND    passwd = '0000';

CREATE TABLE movie(
    movie_id        VARCHAR2(10) PRIMARY KEY,
    movie_name      VARCHAR2(100) NOT NULL,
    director        VARCHAR2(50),
    genre           VARCHAR2(50),
    actors          VARCHAR2(100),
    release_date    DATE,
    age_limit       NUMBER(10),
    running_time    NUMBER(20),
    plot            VARCHAR2(100));
    
ALTER TABLE movie
MODIFY plot VARCHAR2(1000);

ALTER TABLE movie
MODIFY actors VARCHAR2(1000);

SELECT *
FROM   movie;

INSERT INTO movie
VALUES ('23-001', '서울의 봄', '김성수', '드라마', 
        '황정민, 정우성, 이성민, 박해준, 김성균',
        TO_DATE('2023/11/22', 'YYYY/MM/dd'), 12, 141,
        '1979년 12월 12일, 수도 서울 군사반란 발생
        그날, 대한민국의 운명이 바뀌었다');

INSERT INTO movie
VALUES ('23-002', '괴물', '고레에다 히로카즈', '드라마', 
        '안도 사쿠라, 나가야마 에이타, 쿠로카와 소야, 히이라기 히나타, 타카하타 미츠키',
        TO_DATE('2023/11/29', 'YYYY/MM/dd'), 12, 127,
        '“우리 동네에는 괴물이 산다”
        태풍이 몰아치던 어느 날, 아무도 몰랐던 진실이 드러난다.');
        
INSERT INTO movie
VALUES ('23-003', '뽀로로 극장판 슈퍼스타 대모험', '윤제완', '애니메이션', 
        '이선, 이미자, 함수정, 홍소영, 정미숙',
        TO_DATE('2023/12/13', 'YYYY/MM/dd'), 0, 78,
        '뽀로로와 친구들은 전 우주를 통틀어 최고의 슈퍼스타를 뽑는 음악 축제
        ‘파랑돌 슈퍼스타 선발대회’ 축제에 참가하기 위해 모험을 떠난다.');

INSERT INTO movie
VALUES ('23-004', '아쿠아맨과 로스트 킹덤', '제임스 완', '액션', 
        '제이슨 모모아, 패트릭 윌슨, 야히아 압둘 마틴 2세, 앰버 허드, 니콜 키드먼',
        TO_DATE('2023/12/20', 'YYYY/MM/dd'), 12, 124,
        '아틀란티스 왕국을 이끌 왕의 자리에 오른 ‘아쿠아맨’,
        바다를 지배할 슈퍼 히어로가 세상의 판도를 바꾼다!');
        
INSERT INTO movie
VALUES ('23-005', '노량-죽음의 바다', '김한민', '액션', 
        '김윤석, 백윤식, 정재영, 허준호, 김성규',
        TO_DATE('2023/12/20', 'YYYY/MM/dd'), 12, 124,
        '임진왜란 발발로부터 7년이 지난 1598년 12월,
        모두를 압도할 최후의 전투가 시작된다!');
        
UPDATE movie
SET    movie_name = '뽀로로 극장판'
WHERE  movie_id = '23-003';

UPDATE movie
SET    movie_name = '아쿠아맨'
WHERE  movie_id = '23-004';

SELECT *
FROM   movie
WHERE  movie_name LIKE '%모모아%' 
OR     actors LIKE '%모모아%'
OR     director LIKE '%모모아%';

ALTER TABLE theater_user
RENAME TO   t_user;

SELECT *
FROM   t_user;

CREATE TABLE screening(
        s_number VARCHAR2(10) PRIMARY KEY,
        s_date   DATE,
        s_time   VARCHAR2(20),
        occupied_seats VARCHAR2(100),
        movie_id VARCHAR2(10),
        CONSTRAINT screening_movie_id_fk FOREIGN KEY (movie_id)
        REFERENCES movie(movie_id));
        
SELECT *
FROM   screening;
 
CREATE SEQUENCE s_number_seq
        INCREMENT BY 1
        START WITH 1
        NOCYCLE
        NOCACHE;
        
ALTER TABLE screening
DROP COLUMN s_time;

INSERT INTO screening
VALUES (s_number_seq, TO_DATE('2023/12/15 08:00','YYYY/MM/DD HH24:MI'),
        'C5', '23-001');
        
SELECT TO_DATE('2023/12/15 08:00','YYYY/MM/DD HH24:MI')
FROM   dual;

DROP TABLE screening;

CREATE TABLE ticketing(
        ticket_number VARCHAR(10) PRIMARY KEY,
        user_id VARCHAR2(50),
        movie_id VARCHAR2(50),
        seat_row NUMBER(10),
        seat_column NUMBER(10),
        
        
        );
