DELIMITER $

CREATE PROCEDURE hire_cand(IN id_job INT(4)) 
BEGIN 
 SELECT interview.cand_username , COUNT(interview.cand_username) as 'Amount of interviews',
 interview.score_personality , interview.cand_education ,interview.cand_experience,
 (interview.score_personality + interview.cand_education + interview.cand_experience)/3 as 'AVG scores'
 FROM interview 
 INNER JOIN applies ON interview.cand_username=applies.cand_usrname
 INNER JOIN job ON applies.job_id=job.id
 WHERE applies.job_id=id_job
 GROUP BY interview.cand_username
 ORDER BY (interview.score_personality + interview.cand_education + interview.cand_experience)/3 DESC;

END $

CREATE PROCEDURE reject_cand(IN id_job INT(4))
BEGIN 
SELECT interview.cand_username , COUNT(interview.cand_username) as 'Amount of interviews',
 interview.score_personality , interview.cand_education ,interview.cand_experience,
 (interview.score_personality + interview.cand_education + interview.cand_experience)/3 as 'AVG scores'
 CASE WHEN interview.score_personality=0 then CONCAT('failed the interview')
      WHEN interview.cand_education=0 then CONCAT('inadequate education')
      WHEN interview.cand_experience=0 then CONCAT('no prior experience')
      WHEN interview.score_personality=0 and interview.cand_education=0 then CONCAT('failed the interview','inadequete education') 
      WHEN interview.score_personality=0 and interview.cand_experience=0 then CONCAT('failed the interview','no prior experience')
      WHEN interview.cand_education=0 and interview.cand_experience=0 then CONCAT('inadequete education','no prior experience')
      WHEN interview.score_personality=0 and interview.cand_education=0 and interview.cand_experience=0 then CONCAT('failed the interview','inadequete education','no prior experience')
      WHEN null then CONCAT('under evaluation')
 END 
from interview 
 INNER JOIN applies ON interview.cand_username=applies.cand_usrname
 INNER JOIN job ON applies.job_id=job.id
 WHERE applies.job_id=id_job
 GROUP BY interview.cand_username
 ORDER BY interview.cand_username DESC;

END $

CREATE PROCEDURE outcome(IN id_job INT(4))
BEGIN 
call hire_cand(id_job);
call reject_cand(id_job);
END$

DELIMITER ;