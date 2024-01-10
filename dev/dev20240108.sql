INSERT INTO member
VALUES ('user4', '4444', '������', 'user');

INSERT INTO member
VALUES ('user5', '5555', '����', 'user');

INSERT INTO reply
VALUES (reply_seq.NEXTVAL, 1, 'test', 'user5', sysdate);

SELECT  replyer, COUNT(*)
FROM    reply
GROUP BY replyer;

SELECT      name, COUNT(*)
FROM        reply r 
JOIN        member m
ON          r.replyer = m.id
GROUP BY    name;
