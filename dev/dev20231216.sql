CREATE TABLE ticket(
        ticket_id       VARCHAR2(10) PRIMARY KEY,
        user_id         VARCHAR2(50),
        schedule_id     VARCHAR2(10),
        age             VARCHAR2(10),
        seat_row        VARCHAR(10),
        seat_column     VARCHAR(10),
        price           NUMBER(10),
        FOREIGN KEY(user_id) REFERENCES t_user(user_id),
        FOREIGN KEY(schedule_id) REFERENCES schedule(schedule_id)
        );

CREATE TABLE schedule(
        schecule_id     VARCHAR2(10) PRIMARY KEY,
        movie_id        VARCHAR2(10),
        schedule_date   DATE,
        discount        VARCHAR2(10),
        remain_seat     NUMBER(10) DEFAULT 50,
        FOREIGN KEY(movie_id) REFERENCES movie(movie_id)
        );


SELECT *
FROM   movie;

INSERT INTO movie
VALUES  ('23-006', '3일의 휴가', '육상효', '드라마', 
    '김해숙 ,  신민아 ,  강기영 ,  황보라 ,  박명훈', 
    TO_DATE('2023/12/06', 'YYYY/MM/DD'), 12, 105, '죽은 지 3년째 되는 날,
    ‘복자’(김해숙)는 하늘에서 3일간의 휴가를 받아
    규칙 안내를 맡은 신입 ‘가이드’(강기영)와 함께 지상에 내려온다.');
    
INSERT INTO movie
VALUES  ('23-007', '싱글 인 서울', '박범수', '로맨스', 
    '이동욱, 임수정, 이솜, 장현성, 김지영', 
    TO_DATE('2023/11/29', 'YYYY/MM/DD'), 12, 103, '“사실 혼자인 사람은 없잖아요”
    서울, 혼자가 좋지만 연애는 하고 싶은
    두 남녀의 싱글 라이프가 시작된다!');
    
INSERT INTO movie
VALUES  ('23-008', '나폴레옹', '리들리 스콧', '전쟁', 
    '호아킨 피닉스, 바네사 커비, 루디빈 사니에, 루퍼트 에버렛', 
    TO_DATE('2023/12/06', 'YYYY/MM/DD'), 15, 158, '“스스로 황제가 된 영웅!
    세상을 정복한 영웅 아무것도 갖지 못한 황제,
    ‘나폴레옹’의 대서사가 펼쳐진다!');
        
INSERT INTO movie
VALUES  ('23-009', '말하고 싶은 비밀', '타케무라 켄타로', '로맨스', 
    '타카하시 후미야, 사쿠라다 히요리', 
    TO_DATE('2023/12/13', 'YYYY/MM/DD'), 0, 110, '
    “어느 날 갑자기 고백 사고!? 마음이 잘못 배달되었다!
    엇갈릴수록 점점 커져가는 너를 향한 마음,
    내일은 너에게 말할 수 있을까?');
    
INSERT INTO movie
VALUES  ('23-010', '쏘우 X', '케빈 그루터트', '공포', 
    '토빈 벨, 쇼니 스미스, 신노브 맥코디 런드, 스티브 브랜드, 마이클 비치', 
    TO_DATE('2023/12/13', 'YYYY/MM/DD'), 18, 118, '이것은 복수가 아니다.
    ‘직쏘’의 세계로 초대받은 모든 사람은 자신을 구원할 기회를 가진다.
    그들의 게임이 끝나고, 직쏘의 게임이 시작된다.');

INSERT INTO movie
VALUES  ('23-011', '트롤: 밴드 투게더', '월트 도른', '애니메이션', 
    '애나 켄드릭, 저스틴 팀버레이크, 카밀라 카베요, 에릭 안드레, 트로이 시반', 
    TO_DATE('2023/12/20', 'YYYY/MM/DD'), 0, 92, 
    '최애 아이돌 그룹 재결합 초읽기! 우리 함께하면 더 좋잖아!
    전 세계 모든 트롤을 열광케 했던 최고의 아이돌 그룹 ‘브로존’.
    12월, 가장 짜릿한 컴백 무대의 시작!');

SELECT * FROM schedule;

INSERT INTO schedule
VALUES  (8, 
    '23-001',TO_DATE('2023/12/16_23:00','YYYY/MM/DD_HH24:MI'), '심야', 50);

SELECT movie_id, TO_CHAR(schedule_date, 'HH24:MI')
FROM   schedule;

DROP SEQUENCE s_number_seq;

DELETE schedule;

SELECT  s.schedule_id, m.movie_name, 
        TO_CHAR(s.schedule_date, 'YYYY/MM/DD HH24:MI') date_time,
        s.discount, s.remain_seat
FROM    schedule s, movie m
where   s.movie_id = m.movie_id
AND     s.movie_id = '23-006';

ALTER TABLE schedule
DROP COLUMN discount;

SELECT *
FROM   schedule;

