/* Question: What are the top paying job data analyst jobs?
   -- Identify top 10 highest paying Data Analyst roles that are available remotely.
   -- focus on job postings with specified salaries(remove NULLs)
   --why? Highlight the top paying opportunities for data analysts,offering insights into employment trends.. 
*/

SELECT 
   job_id,
   job_title,
   job_location,
   job_schedule_type,
   salary_year_avg,
   job_posted_date,
   cd.name as company_name
FROM job_postings_fact as jpf
LEFT JOIN company_dim as cd  ON 
  jpf.company_id = cd.company_id
WHERE job_title_short = 'Data Analyst' 
   and job_location = 'Anywhere'
   and salary_year_avg is not NULL
ORDER BY salary_year_avg DESC
LIMIT 10


 

  