-- use 스키마: 해당 DB에 접근
use dev;

-- 테이블 생성
-- ※ 테이블 단위로 제약조건 생성 가능(NOT NULL 제외)
-- 	ex) 2개 이상 복합 칼럼으로 제약조건 설정 가능
-- ※ unique, primary key 제약조건은 자동으로 index 생성됨
CREATE TABLE `dev`.`customers` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(45) NOT NULL,
	`email` VARCHAR(45) NOT NULL,
	`phone` VARCHAR(45) NOT NULL,
	`address` VARCHAR(100) NULL,
	PRIMARY KEY(`id`)
);

-- ※count 제외하고 '*' 사용하지 말기
--  => 몇개 칼럼 불러오는지 파악하기 위해
SELECT id
	   , name
       , email
       , phone
       , address
FROM customers;

-- DESC : 테이블 구조 알려줌(+ PK)
DESC customers;

-- 데이터 추가
-- ※ SQL 작성법: 위에서 밑으로 엔터(옆으로 나열 X)
-- ※ MySQL INSERT: 한 번에 여러개 데이터 추가 가능
INSERT INTO customers
			(
               id
             , name
             , email
             , phone
             , address
			)
			VALUES
            (
			   1
			 , 'John Doe'
             , 'john@mail.com'
             , '010-000-0000'
             , ''
             );

COMMIT;

-- 새 계정 생성
-- 비밀번호 암호화하지 않고 사용 -> Node.js 에서 접속가능
CREATE USER 'dev01'@'%'IDENTIFIED WITH MYSQL_NATIVE_PASSWORD BY '1234';

-- 권한 부여
GRANT ALL PRIVILEGES ON dev.* to 'dev01'@'%' WITH GRANT OPTION;

-- 재부팅 안하고 권한 부여 바로 실행
FLUSH PRIVILEGES;

-- t_users 테이블 생성
USE dev;

CREATE TABLE `t_users` (
	`user_no` INT AUTO_INCREMENT,
    `user_id` VARCHAR(100) NOT NULL,
    `user_pwd` VARCHAR(100) NOT NULL,
    `user_name` VARCHAR(100) NOT NULL,
    `user_gender` CHAR(1) CHECK(user_gender IN ('M',  'F')),
    `user_age` INT,
    `join_date` DATE,
    PRIMARY KEY(`user_no`)
);