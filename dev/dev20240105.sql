CREATE TABLE reply (
    reply_no NUMBER PRIMARY KEY,
    board_no NUMBER NOT NULL,
    reply VARCHAR2(100) NOT NULL,
    replyer VARCHAR2(30) NOT NULL,
    reply_date DATE DEFAULT SYSDATE
    );
    
CREATE SEQUENCE reply_seq;

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 1, '좋아용', 'user1');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 1, '개추', 'user1');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 1, '개추2', 'user2');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 2, '금요일 개좋아', 'user1');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 2, '2222', 'user2');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 2, '개추', 'user2');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 3, '화이팅!', 'user1');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 3, '화이또', 'user2');

SELECT *
FROM reply;

SELECT *
FROM member;

--댓글 페이징
SELECT b.* FROM 
(SELECT ROWNUM rn, a.*
FROM 
(
SELECT r.*, m.name name
FROM reply r
JOIN member m
ON r.replyer = m.id
WHERE board_no = 1
ORDER BY 1
) a ) b
WHERE b.rn > (1-1)*5 AND b.rn <= 1*5;