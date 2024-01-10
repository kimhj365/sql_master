CREATE TABLE reply (
    reply_no NUMBER PRIMARY KEY,
    board_no NUMBER NOT NULL,
    reply VARCHAR2(100) NOT NULL,
    replyer VARCHAR2(30) NOT NULL,
    reply_date DATE DEFAULT SYSDATE
    );
    
CREATE SEQUENCE reply_seq;

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 1, '���ƿ�', 'user1');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 1, '����', 'user1');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 1, '����2', 'user2');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 2, '�ݿ��� ������', 'user1');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 2, '2222', 'user2');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 2, '����', 'user2');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 3, 'ȭ����!', 'user1');

INSERT INTO reply(reply_no, board_no, reply, replyer)
VALUES (reply_seq.NEXTVAL, 3, 'ȭ�̶�', 'user2');

SELECT *
FROM reply;

SELECT *
FROM member;

--��� ����¡
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