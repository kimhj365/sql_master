
SELECT *
FROM   hr.employees;

CREATE TABLE aaa(
    aa NUMBER(2));

INSERT INTO aaa
VALUES      (1);

INSERT INTO aaa
VALUES      (2);

COMMIT;

GRANT SELECT 
ON    aaa
TO    skj; 