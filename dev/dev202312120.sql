SELECT *
FROM   ticket
WHERE  ticket_id = 47;

SELECT movie_id
FROM   schedule
WHERE  schedule_id = (SELECT schedule_id
                      FROM   ticket
                      WHERE  ticket_id = 47);
                    
SELECT *
FROM   movie
WHERE  movie_id = (SELECT movie_id
                    FROM   schedule
                    WHERE  schedule_id = (SELECT schedule_id
                                            FROM   ticket
                                            WHERE  ticket_id = 47));
                                            
SELECT *
FROM   movie
WHERE  movie_id = (SELECT movie_id
                    FROM   schedule
                    WHERE  schedule_id = (SELECT schedule_id
                                            FROM   ticket
                                            WHERE  ticket_id = 53 ));
                                            
DELETE t_user
WHERE  user_id = 'ssss8888';