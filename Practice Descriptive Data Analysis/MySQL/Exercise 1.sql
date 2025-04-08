-- Title: Exercise 1
-- Author: Jaymeee3



-- 1 – Consider the table ente. Count the number of records that contain the word "università".
select count(*) as conteggio_universita
from mydemo.ente
where TitoloEnte like '%universita%';



-- 2 – Consider the table Corso. Create a field flag_no_data that identifies the courses for which either the start date or the end date is missing.
select *, 
    case 
        when datapartenza is null or datafine is null then  'Sì'
        else 'No'
    end as flag_no_data
from mydemo.corso;
-- It can also be done using if
select *, 
    if (datapartenza is null or datafine is null , 'si','no') as flag_no_data1
from mydemo.corso;



-- 11 – Consider the table utente. Associate to it the IDs of the courses to which the users are enrolled. Describe the relationships between the tables and indicate what the unit of analysis is.
CREATE TEMPORARY TABLE ScienzeSociali.idstudente_idcorso
SELECT u.idutente
,c.idcorso
FROM mydemo.utente as u
LEFT JOIN mydemo.iscrizione AS i ON u.idutente=i.fkutente
LEFT JOIN mydemo.corso AS c ON c.idcorso=i.fkcorso;
select *
from scienzesociali.idstudente_idcorso;



-- 12 – Consider the table created in question #11. Perform an INNER JOIN with the table SurveyIngresso. Describe what happens to the table and indicate what the unit of analysis is.
SELECT id.*
, s.*
FROM mydemo.surveyingresso AS s
INNER JOIN scienzesociali.idstudente_idcorso AS id ON s.fkutente=id.idutente;

-- 
