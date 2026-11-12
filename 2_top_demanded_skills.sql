/*
2. Question: What are the most in-demand skills for remote data analysts?
- Identify the top in-demand skills for a data analyst by count and pct.
- Focus on all job postings.
- Why? Retrieves the top skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/


SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(100 * COUNT(skills_job_dim.job_id) / (
            SELECT COUNT(*) 
            FROM job_postings_fact 
            WHERE job_title_short = 'Data Analyst' 
              AND job_work_from_home = true),1) AS pct_of_postings
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = true 
GROUP BY
    skills
ORDER BY
    pct_of_postings DESC,
    demand_count DESC;
