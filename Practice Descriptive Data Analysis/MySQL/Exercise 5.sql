-- Title: Exercise 5
-- Author: Jaymee3



-- 1 - Perform an inner join between the utente and ente tables. To which organization does the last user registered on the platform belong?
-- Obtain the result with a single query (hint: the column dtivr indicates the registration date on the platform, so it should be used to sort the records). 
use mydemo;
select u.idutente
       , e.Titoloente
       , u.dtivr as dataiscrizione
from utente u
inner join ente e on u.fkente = e.idente
order by u.dtivr desc
LIMIT 1 ; -- facoltativo

-- 1.1 - What type of relationship exists between the tables involved?
-- The relationship is many-to-one, since the idente key is duplicated in the utente table but unique in the ente table.



-- 2 - To identify any errors, check that there are no students whose course enrollment date is earlier than their platform registration date.
-- (Hint: to perform this check, use the dtivr field from the utente table and the dataiscrizione field from the iscrizione table. Also, when performing joins on date fields, it's recommended to ensure that both fields are in the same date format, for example using CAST(field AS DATE)).
select *
from utente u
inner join iscrizione i on u.idutente = i.fkutente
where i.dataiscrizione < cast(u.dtivr as date);

-- 2.2 - What type of relationship exists between the tables involved?
-- The relationship is one-to-many, since the idutente key is unique in the utente table but duplicated in the iscrizione table.
-- As a result, one record is obtained for each enrollment.



-- 3 - How many users of type "student" (tipoutente = 2 in the utente table) have responded to the entry survey?
-- (Hint: here too, two tables are involved).
select count(*)
from utente u
inner join SurveyIngresso si on si.fkutente = u.idutente
where u.tipoutente = 2;



-- 4 - Create a table with course enrollments for users who have responded to the entry survey.
-- Also include the start and end dates of each course
-- (hint: use the tables iscrizione, SurveyIngresso, and corso).
select i.idiscrizione, i.fkutente, c.datapartenza, c.datafine
from iscrizione i
inner join SurveyIngresso si on i.fkutente = si.fkutente
inner join corso c on i.fkcorso = c.idcorso;



-- 5 - In the first question of QUIZ 1, the task was to extract the organization of the last user registered on the platform.
-- Replicate the same query using a LEFT JOIN. Explain what changes and why.
select u.idutente
       , e.Titoloente
       , u.dtivr as dataiscrizione
from utente u
left join ente e on u.fkente = e.idente
order by u.dtivr desc
LIMIT 1 ; -- facoltativo

-- Explanation:
-- Unlike the inner join, the left join returns all records from the left table, even if there is no corresponding match in the right table.
-- As a result, unlike what happened with the inner join, the last user may also have a NULL value for the organization — and that is exactly what happens in this case.



-- 6 - Create a temporary table that contains all users and the descriptive label of the organization when available.
-- Also, assign the following labels to the tipoutente field:
1 = teacher; 2 = student; 3 = admin.
create temporary table _EnteUtente
select u.idutente
	  ,e.titoloente
      ,case when u.tipoutente = 1 then 'docente'
            when u.tipoutente = 2 then 'studente'
            when u.tipoutente = 3 then 'admin'
            else NULL end as tipoutente
from utente u
left join ente e on u.fkente = e.idente;
select * from _EnteUtente; -- controllo il contenuto della tabella creata



-- 7 - From the table just created, identify the modal class (i.e., the most frequent value) for the column titoloente.
select titoloente, count(*) as n
from _EnteUtente
where titoloente is not null -- istruzione facoltativa
group by titoloente; -- 'Università Federico II di Napoli (Italy)' è la classe modale

-- Replace the NULL values in the titoloente field with the identified modal class
-- (hint: use IFNULL(). Additionally, to modify the table, you can simply copy and paste the previous query and insert DROP TABLE IF EXISTS table_name before the query to drop and recreate the table. Alternatively, you can create a new temporary table).

-- Instead I'll do:
-- I could have created a new table, but it is more convenient to copy and paste the previous query and make the necessary changes, dropping the temporary table and recreating it with the modifications applied.
drop table if exists _EnteUtente;
create temporary table _EnteUtente
select u.idutente
	  ,IFNULL(e.titoloente, 'Università Federico II di Napoli (Italy)') as titoloente_no_null
      ,case when u.tipoutente = 1 then 'docente'
            when u.tipoutente = 2 then 'studente'
            when u.tipoutente = 3 then 'admin'
            else NULL end as tipoutente
from utente u
left join ente e on u.fkente = e.idente;
select * from _EnteUtente; -- controllo il contenuto della tabella creata



-- 8 - Bonus question: an analysis is to be conducted on students only, who have completed the entry survey.
-- Create a table that, in addition to the information obtained from the entry survey, includes at least one piece of information from each table in the cluster of tables related to the e-learning platform.
-- (Hint: since the users who answered the survey are the subject of the analysis, and none of them should be excluded, start from the SurveyIngresso table and perform a series of LEFT JOINs in the most appropriate order).
select si.* -- tutte le colonne di survey ingresso, che è la tabella oggetto di analisi
       ,cast(u.dtivr as date) as dt_iscrizione_piattaforma -- il cast è facoltativo, le info prese da ogni tabella sono a piacere
       ,e.TitoloEnte as ente_utente
       ,c.datapartenza as dt_partenza_corso
       ,i.dataiscrizione as dt_iscrizione_corso
from SurveyIngresso as si
left join utente u on si.fkutente = u.idutente -- relazione uno a uno (idutente chiave univoca per entrambe le tabelle), nessun aumento di righe
left join ente e on u.fkente = e.idente -- relazione molti a uno (idente chiave univoca per la tabella ente), nessun aumento di righe
left join corso c on si.fkcorso = c.idcorso -- relazione molti a uno (idcorso chiave univoca per la tabella corso), nessun aumento di righe
left join iscrizione i on si.fkutente = i.fkutente; -- relazione uno a molti (fkutente si ripete tante volte quante sono le iscrizioni dell'utente a un corso), aumento delle righe



-- 9 - Consider the iscrizione table. Calculate how many courses each user is enrolled in.
select fkutente, count(*) as n
      from iscrizione
      group by fkutente;
      
      
      
-- 10 - How many courses have users enrolled in on average? Obtain the result using a single query.
-- (Hint: first calculate the number of courses per user, as in the previous query. Then, use that query as a subquery in the FROM clause, so that you can compute the average of the course count in the subquery).
select avg(n) as media_iscrizioni
from (select fkutente, count(*) as n
      from iscrizione
      group by fkutente) x;



-- 11 - Extract the last user enrolled in each course
-- (hint: use ROW_NUMBER(), the result can be obtained through a subquery without creating a temporary table).
select *
from (select fkutente
		, dataiscrizione
		, row_number() over (partition by fkcorso order by dataiscrizione desc) as rn
	 from iscrizione) x
where rn = 1;



-- 12 - Extract from the iscrizione table only the users who have responded to the entry survey.
-- This time, obtain the result using a subquery within a WHERE condition.
select *
from iscrizione
where fkutente in (select fkutente from SurveyIngresso);



-- 13 - How many course enrollments have been made since the entry survey was first administered?
-- (Hint: you can use a subquery within a WHERE condition that calculates the earliest survey administration date — dtrecord — from the SurveyIngresso table).
select count(*) as n_iscrizioni
from iscrizione
where dataiscrizione >= (select min(dtrecord) from SurveyIngresso);



-- 14 - Assume that the mydemo database is updated daily. A report is to be created for users who are enrolled in courses.
-- To build this report, it is necessary to extract idutente, the platform registration date (dtivr in the utente table), idcorso, course enrollment date, tags associated with the course, and the start and end dates of the course (if available).
drop table if exists ScienzeSociali.rpt_iscrizioni;
create table ScienzeSociali.rpt_iscrizioni
select i.fkutente
       ,u.dtivr as data_iscrizione_piatt
       ,i.fkcorso
       ,i.dataiscrizione
       ,c.tags
       ,c.datapartenza
       ,c.datafine
from iscrizione i
left join utente u on i.fkutente = u.idutente
left join corso c on i.fkcorso = c.idcorso;



-- 15 - Insert everything into a stored procedure and name it sp_rpt_iscritti().
DELIMITER //
CREATE PROCEDURE sp_rpt_iscritti()
BEGIN

drop table if exists ScienzeSociali.rpt_iscrizioni;
create table ScienzeSociali.rpt_iscrizioni
select i.fkutente
       ,u.dtivr as data_iscrizione_piatt
       ,i.fkcorso
       ,i.dataiscrizione
       ,c.tags
       ,c.datapartenza
       ,c.datafine
from iscrizione i
left join utente u on i.fkutente = u.idutente
left join corso c on i.fkcorso = c.idcorso;

END //
DELIMITER ; -- Reset the standard delimiter to ";".



-- 16 - Schedule an event on ScienzeSociali that executes the stored procedure every day at 8 AM. Name it crea_rpt_iscritti.
SET GLOBAL event_scheduler = ON; -- I activate the event scheduler if it is disabled.
SELECT TIMESTAMP(CURRENT_DATE) + INTERVAL 1 DAY + INTERVAL 8 HOUR; -- I check that the time of the first departure is correct.

CREATE EVENT ScienzeSociali.crea_rpt_iscritti
 ON SCHEDULE
         EVERY 1 DAY -- Every 24 hours starting from the moment of the start, which I define in the next line.
         STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL 1 DAY + INTERVAL 8 HOUR)
  DO 
  CALL ScienzeSociali.sp_rpt_iscritti(); -- What is defined after the DO command will be executed.



-- 17 - Check that the event has been created correctly.
select * from information_schema.events;



-- 18 - Delete the event.
DROP EVENT ScienzeSociali.crea_rpt_iscritti;
