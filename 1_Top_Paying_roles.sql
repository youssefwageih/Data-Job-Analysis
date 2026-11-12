/*
Note: Although the table has over 700,000 the actual job count per role is just hundreds due to lack in salaries reported
- I am using Five-number summary: minimum, 1st quartile, median, 3rd quartile, maximum to avoid skewness in the salaries
1. What are the top paying Data Roles?
- Evaluate compensation across remote data roles to help practitioners target high-yield, stable career paths.
- Why? Highlight the highest-paying data roles to help newbies entering the market or career shifters lock in a career

Insight: Analysts Roles in general are the lease regardless of the level
*/


SELECT
    job_title_short,
    COUNT(*) AS total_postings,
    ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY salary_year_avg)) AS median_salary,
    ROUND(AVG(salary_year_avg), 0) AS mean_salary,
    ROUND(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY salary_year_avg)) AS p25_salary,
    ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY salary_year_avg)) AS p75_salary
FROM job_postings_fact
WHERE
    job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY median_salary DESC;
