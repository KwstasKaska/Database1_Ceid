/*queries*/

/*(a)*/
/*SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));*/

SELECT surname,user.name,etaireia.name,id,salary ,COUNT(job.id) AS 'amount of candidates'
FROM job
INNER JOIN recruiter ON recruiter.username = job.recruiter
INNER JOIN user ON user.username = recruiter.username
INNER JOIN etaireia ON etaireia.AFM = recruiter.firm
INNER JOIN applies ON applies.job_id = job.id
WHERE job.salary>1900
GROUP BY job.id;

/*(b)*/
SELECT username,certificates,count(has_degree.cand_usrname) AS 'amount of degrees of a candidate',avg(has_degree.grade)
FROM candidate
INNER JOIN has_degree ON candidate.username = has_degree.cand_usrname
GROUP BY has_degree.cand_usrname HAVING count(has_degree.cand_usrname)>1; 

/*(c)*/
SELECT candidate.username,count(applies.cand_usrname) AS 'amount of applications',avg(job.salary)
FROM candidate
INNER JOIN applies ON applies.cand_usrname = candidate.username
INNER JOIN job ON applies.job_id = job.id
GROUP BY applies.cand_usrname HAVING avg(job.salary)>1800;

/*(d)*/
SELECT etaireia.name,job.position,antikeim.title
FROM job
INNER JOIN requires ON job.id = requires.job_id
INNER JOIN antikeim ON antikeim.title = requires.antikeim_title
INNER JOIN recruiter ON recruiter.username = job.recruiter
INNER JOIN etaireia ON etaireia.AFM = recruiter.firm
WHERE etaireia.city LIKE 'Patra' AND antikeim.title LIKE '%Program%';
 o
/*(e)*/
SELECT recruiter.username,count(distinct job.id) AS 'amount of announcements', count(distinct interview.recr_username) AS 'amount of interviews',
avg(job.salary)
FROM job
INNER JOIN recruiter ON recruiter.username = job.recruiter
INNER JOIN interview ON recruiter.username = interview.recr_username
GROUP BY recruiter.username HAVING count(distinct job.id)>2
ORDER BY avg(job.salary) DESC;



