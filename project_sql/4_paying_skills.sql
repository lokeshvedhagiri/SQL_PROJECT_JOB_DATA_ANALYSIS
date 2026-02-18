/*
Query 4
Scenario:
Answer: What are the top skills based on salary?
Look at the average salary associated with each skill for Data Analyst positions
Focuses on roles with specified salaries, regardless of location
Why? It reveals how different skills impact salary levels for Data Analysts 
and helps identify the most financially rewarding skills to acquire or improve 
*/

SELECT skills, round(AVG(salary_year_avg),2) as avg_salary
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Analyst' AND
        salary_year_avg is not NULL
    ANDjpf.job_location = 'Anywhere'
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25