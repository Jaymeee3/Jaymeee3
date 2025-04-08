-- Title: Exercise 4
-- Author: Jaymeee3



-- Consider the database mydemo.
use mydemo;



-- 1 - Specifically, consider the clienti table.
-- Extract idcliente, the number of active accounts, and the age of the contact person for male clients only.
select * from clienti;

select id idcliente, n_utenze , etareferente eta
from clienti
where sessoreferente like "M";



-- 2 - We want to analyze the differences between gas clients and all other clients.
-- Create a new field flag_gas that indicates whether the client has activated at least one gas service (hint: the gas service is indicated by “G” in the field serviziattivaticliente, so a LIKE operator should be used).
-- Store the result in a temporary table.
delete temporary table if exists scienzesociali.a;
create temporary table scienzesociali.a
select *,
if(serviziattivaticliente like "G", "Si", "No") flag_gas
from clienti;

select *
from scienzesociali.a



-- 3 - Consider the table created in question #2.
-- Calculate the number of clients, the average age, and the total number of activated accounts for the two groups of clients identified by the new field flag_gas.
select * from clienti

select flag_gas,
count(id) n_clienti,
avg(etareferente) eta_media,
sum(n_utenze_attive) somma_utenze_attivate
from scienzesociali.a
group by flag_gas



-- 4 - Consider the table created in question #2. Create a ranking of the top 10 energy clients based on average bill amount
-- (hint: the average bill is provided in the field fattmedia, so there is no need to calculate an additional average).
use mydemo;

delete temporary table if exists scienzesociali.i;
create temporary table scienzesociali.i
select *, if(serviziattivaticliente like "G", "Si", "No") flag_gas
from clienti;

select * from scienzesociali.i;
-- If we need to filter clients by energy service, we use WHERE serviziattivaticliente LIKE '%E%'; otherwise, we omit that part.


