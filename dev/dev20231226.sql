SELECT * FROM tab;

CREATE TABLE member(
    id              VARCHAR2(20)  PRIMARY KEY,
    pw              VARCHAR2(10)  NOT NULL,
    name            VARCHAR2(100) NOT NULL,
    responsibility   VARCHAR2(10)  DEFAULT 'User' --Admin/User
);

INSERT INTO member
VALUES ('user1', '1111', 'ȫ�浿', 'User');

INSERT INTO member
VALUES ('user2', '2222', '��ö��', 'User');

INSERT INTO member
VALUES ('user3', '3333', '������', 'Admin');

SELECT * FROM member;