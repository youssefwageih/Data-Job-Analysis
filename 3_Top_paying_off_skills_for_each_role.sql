/*
3. Which skills appear most frequently—and pay the most—within the top 10 highest-paying Data roles?
- Aggregate skill frequency and average compensation across a targeted sample of the top 10 highest-paying postings.
- Why? 
- It reveals how different skills impact salary levels for Data Roles and helps identify the most financially rewarding skills to acquire or improve
- Retrieves the top skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.
- It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries

Insights: we see the highest paying skills are cloud and programming skills, also we can see the highest paying skills are used more commonly in the data science, data engineering and cloud fields, which is consistent with the high demand for these roles in the job market.
*/

SELECT 
    sd.skills AS skill,
    sd.type,
    COUNT(DISTINCT jp.job_id) AS demand_count,
    ROUND(AVG(jp.salary_year_avg), 0) AS avg_salary,
    ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY jp.salary_year_avg)::numeric, 0) AS median_salary
FROM 
    job_postings_fact AS jp
INNER JOIN skills_job_dim AS sjd 
    ON sjd.job_id = jp.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jp.salary_year_avg IS NOT NULL
GROUP BY 
    sd.skills,
    sd.type
HAVING 
    COUNT(DISTINCT jp.job_id) >= 50
ORDER BY 
    avg_salary DESC,
    demand_count DESC,
    skill ASC;