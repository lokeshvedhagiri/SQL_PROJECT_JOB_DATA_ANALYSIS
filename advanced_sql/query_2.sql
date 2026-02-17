WITH remote_job_skills as(
SELECT skill_id, COUNT(*) as skill_count
FROM skills_job_dim as sjd
INNER JOIN job_postings_fact  as jpf ON jpf.job_id = sjd.job_id
WHERE
     jpf.job_work_from_home = TRUE AND
     jpf.job_title_short IN  ('Data Analyst')
GROUP BY skill_id)

select sd.skill_id,skills as skill_name, skill_count
from remote_job_skills as rjs
INNER JOIN skills_dim as sd ON rjs.skill_id = sd.skill_id
order by skill_count DESC
LIMIT 5
