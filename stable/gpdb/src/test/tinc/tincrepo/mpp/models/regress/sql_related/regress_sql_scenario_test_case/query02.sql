-- 
-- @description test sql test case
-- @created 2012-07-05 12:00:00
-- @modified 2012-07-08 12:00:02
-- @tags orca hashagg executor

CREATE TABLE TMP (
	name int) 
DISTRIBUTED BY (
		name);

INSERT INTO TMP
VALUES (1);

select pg_sleep(2);
