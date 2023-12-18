INSERT INTO ticket
VALUES (1, 'khj365', 1, 'º∫¿Œ','C', 5, 15000);

SELECT *
FROM    ticket
ORDER BY 1;


ALTER TABLE ticket
MODIFY (seat_column NUMBER(10));

DELETE ticket
WHERE  ticket_id = 13;

SELECT  *
FROM    ticket
WHERE   seat_column = 5
AND     seat_row = 'C';

DROP SEQUENCE ticket_id_seq;

CREATE SEQUENCE ticket_id_seq
    INCREMENT BY 1
    START WITH 1;
    
ALTER TABLE ticket
MODIFY (ticket_id NUMBER(38));

SELECT upper('d')
FROM   dual;

ALTER TABLE ticket
DROP COLUMN price;

ALTER TABLE ticket
ADD (discount VARCHAR(50));

ALTER TABLE ticket
ADD (price NUMBER(30));

ALTER TABLE ticket
ADD (reserve_date DATE);


SELECT  *
FROM    ticket;

SELECT  t.ticket_id, TO_CHAR(s.schedule_date, 'YYYY-MM-DD HH24:MI:SS') str_date, m.movie_name, t.age, 
        t.seat_row, t.seat_column, TO_CHAR(t.reserve_date, 'YYYY-MM-DD HH24:MI:SS') rsv_date
FROM    ticket t, schedule s, movie m
WHERE   t.schedule_id = s.schedule_id
AND     s.movie_id = m.movie_id
AND     t.user_id = 'khj365'
ORDER BY 1;

SELECT  *
FROM    ticket
WHERE   user_id = 'khj365'
AND     ticket_id = 7;

SELECT   *
FROM    ticket
WHERE   user_id = 'khj365'
AND     ticket_id = 7;

SELECT  t.ticket_id, s.schedule_id
FROM    ticket t, schedule s
WHERE   t.schedule_id = s.schedule_id
AND     t.ticket_id = 7;