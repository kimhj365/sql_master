SELECT * FROM books;

CREATE SEQUENCE book_code_seq;

INSERT INTO books
VALUES (book_code_seq.NEXTVAL, 'Do It! 자바 입문', '박은종', '이지스퍼블리싱', 25000);

INSERT INTO books
VALUES (book_code_seq.NEXTVAL, '이것이 리눅스다', '우재남', '한빛미디어', 36000);

INSERT INTO books
VALUES (book_code_seq.NEXTVAL, '혼자 공부하는 자바', '신용권', '한빛미디어', 24000);

INSERT INTO books
VALUES (book_code_seq.NEXTVAL, '자바스크립트 파워북', '어포스트', '어포스트', 22000);
