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
VALUES  ('23-006', '3���� �ް�', '����ȿ', '���', 
    '���ؼ� ,  �Źξ� ,  ���⿵ ,  Ȳ���� ,  �ڸ���', 
    TO_DATE('2023/12/06', 'YYYY/MM/DD'), 12, 105, '���� �� 3��° �Ǵ� ��,
    �����ڡ�(���ؼ�)�� �ϴÿ��� 3�ϰ��� �ް��� �޾�
    ��Ģ �ȳ��� ���� ���� �����̵塯(���⿵)�� �Բ� ���� �����´�.');
    
INSERT INTO movie
VALUES  ('23-007', '�̱� �� ����', '�ڹ���', '�θǽ�', 
    '�̵���, �Ӽ���, �̼�, ������, ������', 
    TO_DATE('2023/11/29', 'YYYY/MM/DD'), 12, 103, '����� ȥ���� ����� ���ݾƿ䡱
    ����, ȥ�ڰ� ������ ���ִ� �ϰ� ����
    �� ������ �̱� �������� ���۵ȴ�!');
    
INSERT INTO movie
VALUES  ('23-008', '��������', '���鸮 ����', '����', 
    'ȣ��Ų �Ǵн�, �ٳ׻� Ŀ��, ���� ��Ͽ�, ����Ʈ ������', 
    TO_DATE('2023/12/06', 'YYYY/MM/DD'), 15, 158, '�������� Ȳ���� �� ����!
    ������ ������ ���� �ƹ��͵� ���� ���� Ȳ��,
    ���������ˡ��� �뼭�簡 ��������!');
        
INSERT INTO movie
VALUES  ('23-009', '���ϰ� ���� ���', 'Ÿ�ɹ��� ��Ÿ��', '�θǽ�', 
    'Ÿī�Ͻ� �Ĺ̾�, ������ ���丮', 
    TO_DATE('2023/12/13', 'YYYY/MM/DD'), 0, 110, '
    ����� �� ���ڱ� ��� ���!? ������ �߸� ��޵Ǿ���!
    ���������� ���� Ŀ������ �ʸ� ���� ����,
    ������ �ʿ��� ���� �� ������?');
    
INSERT INTO movie
VALUES  ('23-010', '��� X', '�ɺ� �׷���Ʈ', '����', 
    '��� ��, ��� ���̽�, �ų�� ���ڵ� ����, ��Ƽ�� �귣��, ����Ŭ ��ġ', 
    TO_DATE('2023/12/13', 'YYYY/MM/DD'), 18, 118, '�̰��� ������ �ƴϴ�.
    ������� ����� �ʴ���� ��� ����� �ڽ��� ������ ��ȸ�� ������.
    �׵��� ������ ������, ������ ������ ���۵ȴ�.');

INSERT INTO movie
VALUES  ('23-011', 'Ʈ��: ��� ���Դ�', '��Ʈ ����', '�ִϸ��̼�', 
    '�ֳ� �˵帯, ����ƾ ��������ũ, ī�ж� ī����, ���� �ȵ巹, Ʈ���� �ù�', 
    TO_DATE('2023/12/20', 'YYYY/MM/DD'), 0, 92, 
    '�־� ���̵� �׷� ����� ���б�! �츮 �Բ��ϸ� �� ���ݾ�!
    �� ���� ��� Ʈ���� ������ �ߴ� �ְ��� ���̵� �׷� ���������.
    12��, ���� ¥���� �Ĺ� ������ ����!');

SELECT * FROM schedule;

INSERT INTO schedule
VALUES  (8, 
    '23-001',TO_DATE('2023/12/16_23:00','YYYY/MM/DD_HH24:MI'), '�ɾ�', 50);

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

