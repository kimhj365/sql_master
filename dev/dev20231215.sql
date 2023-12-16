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
VALUES ('abcd1234', '1234', 'ȫ�浿', '010-1234-1234', 
        TO_DATE('2020/02/07', 'YYYY/MM/DD'));

INSERT INTO theater_user
VALUES ('qwer7788', '7788', '��浿', '010-7788-7788',
        TO_DATE('2021/12/09', 'YYYY/MM/DD'));

INSERT INTO theater_user
VALUES ('asdf9876', '9876', '�ڹμ�', '010-9876-9876',
        TO_DATE('2022/05/30', 'YYYY/MM/DD'));

INSERT INTO theater_user
VALUES ('efgh3355', '3355', '��ö��', '010-3355-3355',
        TO_DATE('2023/01/26', 'YYYY/MM/DD'));


INSERT INTO theater_user(user_id, passwd, user_name, user_tel)
VALUES ('khj365', '0000', '������', '010-1234-5678');

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
VALUES ('23-001', '������ ��', '�輺��', '���', 
        'Ȳ����, ���켺, �̼���, ������, �輺��',
        TO_DATE('2023/11/22', 'YYYY/MM/dd'), 12, 141,
        '1979�� 12�� 12��, ���� ���� ����ݶ� �߻�
        �׳�, ���ѹα��� ����� �ٲ����');

INSERT INTO movie
VALUES ('23-002', '����', '������ ����ī��', '���', 
        '�ȵ� �����, �����߸� ����Ÿ, ���ī�� �Ҿ�, ���̶�� ����Ÿ, Ÿī��Ÿ ����Ű',
        TO_DATE('2023/11/29', 'YYYY/MM/dd'), 12, 127,
        '���츮 ���׿��� ������ ��١�
        ��ǳ�� ����ġ�� ��� ��, �ƹ��� ������ ������ �巯����.');
        
INSERT INTO movie
VALUES ('23-003', '�Ƿη� ������ ���۽�Ÿ �����', '������', '�ִϸ��̼�', 
        '�̼�, �̹���, �Լ���, ȫ�ҿ�, ���̼�',
        TO_DATE('2023/12/13', 'YYYY/MM/dd'), 0, 78,
        '�Ƿηο� ģ������ �� ���ָ� ��Ʋ�� �ְ��� ���۽�Ÿ�� �̴� ���� ����
        ���Ķ��� ���۽�Ÿ ���ߴ�ȸ�� ������ �����ϱ� ���� ������ ������.');

INSERT INTO movie
VALUES ('23-004', '����Ƹǰ� �ν�Ʈ ŷ��', '���ӽ� ��', '�׼�', 
        '���̽� ����, ��Ʈ�� ����, ������ �е� ��ƾ 2��, �ڹ� ���, ���� Ű���',
        TO_DATE('2023/12/20', 'YYYY/MM/dd'), 12, 124,
        '��Ʋ��Ƽ�� �ձ��� �̲� ���� �ڸ��� ���� ������Ƹǡ�,
        �ٴٸ� ������ ���� ����ΰ� ������ �ǵ��� �ٲ۴�!');
        
INSERT INTO movie
VALUES ('23-005', '�뷮-������ �ٴ�', '���ѹ�', '�׼�', 
        '������, ������, ���翵, ����ȣ, �輺��',
        TO_DATE('2023/12/20', 'YYYY/MM/dd'), 12, 124,
        '�����ֶ� �߹߷κ��� 7���� ���� 1598�� 12��,
        ��θ� �е��� ������ ������ ���۵ȴ�!');
        
UPDATE movie
SET    movie_name = '�Ƿη� ������'
WHERE  movie_id = '23-003';

UPDATE movie
SET    movie_name = '����Ƹ�'
WHERE  movie_id = '23-004';

SELECT *
FROM   movie
WHERE  movie_name LIKE '%����%' 
OR     actors LIKE '%����%'
OR     director LIKE '%����%';

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
