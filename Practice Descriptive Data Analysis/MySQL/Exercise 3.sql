-- Title: Exercise 3
-- Authoer: Jaymee3



-- 1 - If not already done, create the database ScienzeSociali.
CREATE DATABASE SienzeSociali;



-- 2 - Consider the table topgear. Select the first 200 rows
-- (Note: there are fewer than 200 rows, so this is equivalent to selecting all rows).
select *
from mydemo.topgear
limit 200;



-- 3 - Select the columns name, time, and max_speed.
select name, max_speed
from mydemo.topgear;



-- 4 - Select the column name, renaming the field as nome_auto.
select name as nome_auto
from mydemo.topgear;



-- 5 - Retrieve the distinct values of the variable cilinders.
select distinct cilinders
from mydemo.topgear;



-- 6 - Ensure that all duplicate rows from the table are returned
-- (hint: apply DISTINCT to all columns in the table).
select distinct *
from mydemo.topgear;



-- 7 - Calculate the number of records in the table.
select count(*)
from mydemo.topgear;

-- 8 - Calculate the minimum value, arithmetic mean, and maximum value of the time column.
select min(time) as t_min
       ,avg(time) as t_medio
	   ,max(time) as t_max
from mydemo.topgear;



-- 9 - Round the values in the time column so that there are no decimal values.
select round(time, 0) as time
from mydemo.topgear;



-- 10 - Select the cars that reach a maximum speed (max_speed) greater than or equal to 300 km/h.
select *
from mydemo.topgear
where max_speed >= 300;



-- 11 - Select the cars that reach a maximum speed (max_speed) strictly greater than 300 km/h and were driven on a wet track (wet = 1).
select *
from mydemo.topgear
where max_speed > 300 and wet = 1;



-- 12 - Select both the cars that reach a maximum speed (max_speed) strictly greater than 300 km/h and those that were driven on a wet track (wet = 1).
select *
from mydemo.topgear
where max_speed > 300 or wet = 1;



-- 13 - Select all cars except those with 6 cylinders.
select *
from mydemo.topgear
where cilinders <> 6;



-- 14 - Select the cars that reach a maximum speed between 280 and 320 km/h (inclusive).
select *
from mydemo.topgear
where max_speed between 280 and 320;



-- 15 - Select all cars except those with 2, 4, or 10 cylinders (hint: use the NOT IN() operator).
select *
from mydemo.topgear
where cilinders not in (2,4,10);



-- 16 - Select the Ferraris (hint: use LIKE to identify cars whose name contains the string 'ferrari').
select *
from mydemo.topgear
where name like '%ferrari%';



-- 17 - Select the Ferraris and the Nissans.
select *
from mydemo.topgear
where name like '%ferrari%' or name like '%nissan%';

