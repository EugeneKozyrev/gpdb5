
DROP FUNCTION subt_insertData(integer);
CREATE OR REPLACE FUNCTION subt_insertData (startValue INTEGER) RETURNS VOID
AS
$$
DECLARE
   i INTEGER;
BEGIN
   i = startValue;
    EXECUTE 'INSERT INTO subt_plpgsql_t2(a) VALUES (' || i || ')';
END;
$$
LANGUAGE PLPGSQL
;

drop table if exists subt_plpgsql_t2;
create table subt_plpgsql_t2( a int );
BEGIN;
select subt_insertData(1);
select subt_insertData(2);
select subt_insertData(3);
select subt_insertData(4);
select subt_insertData(5);
select subt_insertData(6);
select subt_insertData(7);
select subt_insertData(8);
select subt_insertData(9);
select subt_insertData(10);
select subt_insertData(11);
select subt_insertData(12);
select subt_insertData(13);
select subt_insertData(14);
select subt_insertData(15);
select subt_insertData(16);
select subt_insertData(17);
select subt_insertData(18);
select subt_insertData(19);
select subt_insertData(20);
select subt_insertData(1);
select subt_insertData(2);
select subt_insertData(3);
select subt_insertData(4);
select subt_insertData(5);
select subt_insertData(6);
select subt_insertData(7);
select subt_insertData(8);
select subt_insertData(9);
select subt_insertData(10);
select subt_insertData(11);
select subt_insertData(12);
select subt_insertData(13);
select subt_insertData(14);
select subt_insertData(15);
select subt_insertData(16);
select subt_insertData(17);
select subt_insertData(18);
select subt_insertData(19);
select subt_insertData(20);
select subt_insertData(1);
select subt_insertData(2);
select subt_insertData(3);
select subt_insertData(4);
select subt_insertData(5);
select subt_insertData(6);
select subt_insertData(7);
select subt_insertData(8);
select subt_insertData(9);
select subt_insertData(10);
select subt_insertData(11);
select subt_insertData(12);
select subt_insertData(13);
select subt_insertData(14);
select subt_insertData(15);
select subt_insertData(16);
select subt_insertData(17);
select subt_insertData(18);
select subt_insertData(19);
select subt_insertData(20);
select subt_insertData(1);
select subt_insertData(2);
select subt_insertData(3);
select subt_insertData(4);
select subt_insertData(5);
select subt_insertData(6);
select subt_insertData(7);
select subt_insertData(8);
select subt_insertData(9);
select subt_insertData(10);
select subt_insertData(11);
select subt_insertData(12);
select subt_insertData(13);
select subt_insertData(14);
select subt_insertData(15);
select subt_insertData(16);
select subt_insertData(17);
select subt_insertData(18);
select subt_insertData(19);
select subt_insertData(20);
select subt_insertData(1);
select subt_insertData(2);
select subt_insertData(3);
select subt_insertData(4);
select subt_insertData(5);
select subt_insertData(6);
select subt_insertData(7);
select subt_insertData(8);
select subt_insertData(9);
select subt_insertData(10);
select subt_insertData(11);
select subt_insertData(12);
select subt_insertData(13);
select subt_insertData(14);
select subt_insertData(15);
select subt_insertData(16);
select subt_insertData(17);
select subt_insertData(18);
select subt_insertData(19);
select subt_insertData(20);
select subt_insertData(1);
select subt_insertData(2);
select subt_insertData(3);
select subt_insertData(4);
select subt_insertData(5);
select subt_insertData(6);
select subt_insertData(7);
select subt_insertData(8);
select subt_insertData(9);
select subt_insertData(10);
select subt_insertData(11);
select subt_insertData(12);
select subt_insertData(13);
select subt_insertData(14);
select subt_insertData(15);
select subt_insertData(16);
select subt_insertData(17);
select subt_insertData(18);
select subt_insertData(19);
select subt_insertData(20);
COMMIT;
Select count(*) from subt_plpgsql_t2;
