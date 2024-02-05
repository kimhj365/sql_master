use dev;

ALTER TABLE t_users
DROP COLUMN `user_id`;

ALTER TABLE t_users
ADD COLUMN `user_id` VARCHAR(100) NOT NULL UNIQUE;

DESC t_users;

SELECT * FROM t_users;

INSERT INTO t_users (`user_no`, `user_id`, `user_pwd`, `user_name`) VALUES ('2', 'user01', '1234', '회원1');
INSERT INTO t_users (`user_no`, `user_id`, `user_pwd`, `user_name`) VALUES ('1', 'admin', 'admin', '관리자');
