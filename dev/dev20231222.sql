CREATE TABLE board(
    board_no   NUMBER PRIMARY KEY,
    title      VARCHAR2(100) NOT NULL,
    content    VARCHAR2(500) NOT NULL,
    writer     VARCHAR2(50)  NOT NULL,
    write_date DATE DEFAULT sysdate,
    click_cnt  NUMBER DEFAULT 0,
    image      VARCHAR2(100)
);

CREATE SEQUENCE board_seq;

INSERT INTO board(board_no, title, writer, content)
VALUES (board_seq.NEXTVAL, '첫번째 글', '홍길동', 'JSP 열심히 공부하자');

INSERT INTO board(board_no, title, writer, content)
VALUES (board_seq.NEXTVAL, '오늘은 금요일', '김박사', '불코딩하자');

INSERT INTO board(board_no, title, writer, content)
VALUES (board_seq.NEXTVAL, '우리반 화이팅', '김막내', '열심히 공부해요');

SELECT *
FROM   board
ORDER BY 1;

UPDATE board 
SET click_cnt = click_cnt + 1
WHERE board_no = 1;

