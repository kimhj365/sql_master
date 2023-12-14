SELECT *
FROM   tab;

--student ���̺� �߰�
CREATE TABLE student (
        student_number   VARCHAR2(10) PRIMARY KEY,
        student_name     VARCHAR(100) NOT NULL,
        english_score    NUMBER DEFAULT 80,
        mathematics_score NUMBER DEFAULT 70
        );

--���, ����, ����, �ܰ���ȸ, ��� 

--student ���̺� ������ ���
INSERT INTO student
VALUES      ('23-001', 'ȫ�浿', 70, 75);

INSERT INTO student(student_number, student_name)
VALUES      ('23-007', '��μ�');

SELECT *
FROM   student;

--������ ����
UPDATE student
SET    english_score = 85,
       mathematics_score = 75
WHERE  student_number = '23-002';

--������ ����
DELETE student
WHERE  student_number = '23-002';

--������ �ܰ� ��ȸ
SELECT *
FROM   student
WHERE  student_number = '23-002';


--books ���̺� ����
CREATE TABLE books (
        book_code   VARCHAR2(10) PRIMARY KEY,
        book_name   VARCHAR(100) NOT NULL,
        author      VARCHAR(100),
        publisher   VARCHAR(100),
        book_cost   NUMBER DEFAULT 10000
        );

INSERT INTO books
VALUES      ('A001', '�̰��� ��������', '���糲', '�Ѻ��̵��', 36000);

INSERT INTO books
VALUES      ('A002', 'ȥ�� �����ϴ� �ڹ�', '�ſ��', '�Ѻ��̵��', 24000);

INSERT INTO books
VALUES      ('B001', '�ڹٽ�ũ��Ʈ �Ŀ���', '������Ʈ', '������Ʈ', 22000);

SELECT   *
FROM     books
ORDER BY 1;
