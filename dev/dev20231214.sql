SELECT *
FROM   tab;

--student 테이블 추가
CREATE TABLE student (
        student_number   VARCHAR2(10) PRIMARY KEY,
        student_name     VARCHAR(100) NOT NULL,
        english_score    NUMBER DEFAULT 80,
        mathematics_score NUMBER DEFAULT 70
        );

--등록, 수정, 삭제, 단건조회, 목록 

--student 테이블에 데이터 등록
INSERT INTO student
VALUES      ('23-001', '홍길동', 70, 75);

INSERT INTO student(student_number, student_name)
VALUES      ('23-007', '김민수');

SELECT *
FROM   student;

--데이터 수정
UPDATE student
SET    english_score = 85,
       mathematics_score = 75
WHERE  student_number = '23-002';

--데이터 삭제
DELETE student
WHERE  student_number = '23-002';

--데이터 단건 조회
SELECT *
FROM   student
WHERE  student_number = '23-002';


--books 테이블 생성
CREATE TABLE books (
        book_code   VARCHAR2(10) PRIMARY KEY,
        book_name   VARCHAR(100) NOT NULL,
        author      VARCHAR(100),
        publisher   VARCHAR(100),
        book_cost   NUMBER DEFAULT 10000
        );

INSERT INTO books
VALUES      ('A001', '이것이 리눅스다', '우재남', '한빛미디어', 36000);

INSERT INTO books
VALUES      ('A002', '혼자 공부하는 자바', '신용권', '한빛미디어', 24000);

INSERT INTO books
VALUES      ('B001', '자바스크립트 파워북', '어포스트', '어포스트', 22000);

SELECT   *
FROM     books
ORDER BY 1;
