CREATE TABLE users  (
    userid VARCHAR2(20) PRIMARY KEY
    , userpw VARCHAR2(50)
    , grade VARCHAR2(10)
    );
    
INSERT INTO users VALUES ('user1', '1111', 'user');
INSERT INTO users VALUES ('admin1', '1111', 'admin');
INSERT INTO users VALUES ('user2', '1111', 'user');

COMMIT;

SELECT * FROM customer;

INSERT INTO customer(id, name, phone)
VALUES (hibernate_sequence.NEXTVAL, '김하성', '010-1111-2222');