-- Title: Exercise 2
-- Author: Jaymeee3



-- 1 – Consider the database mydemo.
-- Consider the table iscrizione. Extract idiscrizione and dataiscrizione only for course enrollments from January to March 2020.
select idiscrizione, dataiscrizione
from mydemo.iscrizione
where dataiscrizione between '2020-01-01' and '2020-03-31';
select * from iscrizione;
 
 
 
-- 2 – Consider the table SurveyIngresso. We want to analyze the differences between female employees, male employees, and all other users. Create a new field impiegato_cat indicating whether the user is a female employee, a male employee, or belongs to any other category. Store the result in a temporary table.
-- (Hint: the information is contained in the field occupazione, and the variable should be created using CASE WHEN).
select * from surveyingresso;

create temporary table esame.impiegato 
select *, case when genere like '%Femmina%' AND occupazione like '%impiegato%' then 'impiegato_donna'
			   when genere like '%Maschio%' AND occupazione like '%impiegato%' then 'impiegato_uomo' 
               else 'other' end as impiegato_cat
from mydemo.surveyingresso;

select * from esame.impiegato;



-- 3. - Si consideri nuovamente la tabella creata nel quesito #9.
-- Si è deciso che quando ci sono valori mancanti per il campo fkCorso si vuole inserire un id fittizio pari a 9999. 
-- Fare un UPDATE della tabella per finalizzare questa modifica.
SET SQL_SAFE_UPDATES = 0;

UPDATE esame.impiegato
SET fkCorso = ifnull(fkcorso, 9999);
SET SQL_SAFE_UPDATES = 1;



-- 4 – Briefly explain what a stored procedure is and how it can be used.
-- Answer:
-- A stored procedure is a set of SQL statements stored on the server under a specific name. When called, it executes the predefined set of instructions.
-- It is useful for automating analyses, generating reports, and updating tables. Additionally, it can be scheduled to run at a specific time and date.



-- 5 – Consider the table corso. Calculate the duration of the courses in months and extract only those courses with a duration of less than 10 months.
-- (Bonus: obtain the result with a single query).
select * from corso;
select *
from (select idcorso, timestampdiff(month, datapartenza, datafine) as n_mesi
from mydemo.corso) as x
where n_mesi < 10;



-- 6 – Consider the table SurveyIngresso. Perform a LEFT JOIN with the table iscrizione and also include the course tags to which the user is enrolled (this field is in the corso table). Describe the relationships between the tables.
-- (Hint: be careful, there are 3 tables involved).
select * from surveyingresso;
select * from iscrizione;
select * from corso;

select *, c.tags
from surveyingresso s
left join iscrizione i
		on	s.fkutente = i.fkutente
left join corso c 
	on i.fkcorso = c.idcorso;

select count(fkutente)
from mydemo.surveyingresso
group by fkutente
having count(fkutente) >1; -- 1


select count(fkutente)
from mydemo.iscrizione
group by fkutente
having count(fkutente) > 1; -- many

select count(fkcorso)
from mydemo.iscrizione
group by fkcorso
having count(fkcorso) > 1; -- many

select count(idcorso)
from mydemo.corso
group by idcorso
having count(idcorso) > 1; -- 1 

-- 1-to-Many and Many-to-1

