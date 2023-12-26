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
VALUES (board_seq.NEXTVAL, 'ù��° ��', 'ȫ�浿', 'JSP ������ ��������');

INSERT INTO board(board_no, title, writer, content)
VALUES (board_seq.NEXTVAL, '������ �ݿ���', '��ڻ�', '���ڵ�����');

INSERT INTO board(board_no, title, writer, content)
VALUES (board_seq.NEXTVAL, '�츮�� ȭ����', '�踷��', '������ �����ؿ�');

SELECT *
FROM   board
ORDER BY 1;

UPDATE board 
SET click_cnt = click_cnt + 1
WHERE board_no = 1;

