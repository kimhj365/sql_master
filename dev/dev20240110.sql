SELECT * FROM books;

CREATE SEQUENCE book_code_seq;

INSERT INTO books
VALUES (book_code_seq.NEXTVAL, 'Do It! �ڹ� �Թ�', '������', '�������ۺ���', 25000);

INSERT INTO books
VALUES (book_code_seq.NEXTVAL, '�̰��� ��������', '���糲', '�Ѻ��̵��', 36000);

INSERT INTO books
VALUES (book_code_seq.NEXTVAL, 'ȥ�� �����ϴ� �ڹ�', '�ſ��', '�Ѻ��̵��', 24000);

INSERT INTO books
VALUES (book_code_seq.NEXTVAL, '�ڹٽ�ũ��Ʈ �Ŀ���', '������Ʈ', '������Ʈ', 22000);
