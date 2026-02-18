/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
Identify skills in high demand and associated with high average salaries for Data Analyst roles
Concentrates on remote positions with specified salaries
Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
offering strategic insights for career development in data analysis
*/
WITH skills_demand as 
(
SELECT sd.skill_id,sd.skills, COUNT(sjd.job_id) as demand_count
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Analyst' AND
      jpf.job_location = 'Anywhere' AND
        salary_year_avg is not NULL
GROUP BY sd.skill_id

), average_salary as
(
SELECT sd.skill_id,sd.skills, round(AVG(salary_year_avg),2) as avg_salary
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Analyst' AND
    salary_year_avg is not NULL  AND
    jpf.job_location = 'Anywhere'
GROUP BY sd.skill_id
)

SELECT skills_demand.skills,
       skills_demand.skill_id,
         demand_count,
            avg_salary
FROM skills_demand
inner join  average_salary on skills_demand.skill_id = average_salary.skill_id
ORDER BY demand_count DESC, avg_salary DESC
LIMIT 25;


-- Rewriting the query  more concisely

SELECT sd.skills,sd.skill_id, COUNT(sjd.job_id) as demand_count, round(AVG(salary_year_avg),2) as avg_salary
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Analyst' AND
      jpf.job_location = 'Anywhere' AND
        salary_year_avg is not NULL
GROUP BY sd.skill_id
HAVING COUNT(sjd.job_id) > 10
ORDER BY demand_count DESC, avg_salary DESC
LIMIT 25;