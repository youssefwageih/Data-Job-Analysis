/*
5. What are the most optimal skills for remote Data Analysts (high demand + high median pay)?.
*/
SELECT
    sd.skills,
    COUNT(DISTINCT jp.job_id) AS demand_count,
    ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY jp.salary_year_avg)) AS median_salary
FROM job_postings_fact jp
INNER JOIN skills_job_dim sjd ON jp.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jp.job_title_short = 'Data Analyst'
    AND jp.job_location = 'Anywhere'
    AND jp.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING COUNT(DISTINCT jp.job_id) >= 15
ORDER BY median_salary DESC, demand_count DESC
LIMIT 6;