/*
6. What is the trend of the quarterly postings?
- Looking when in the year does the postings increase for data roles
*/

WITH quarterly_postings AS (
    SELECT 'Q1 2023' AS quarter, job_title_short, salary_year_avg
    FROM q1_2023_postings
    UNION ALL
    SELECT 'Q2 2023', job_title_short, salary_year_avg
    FROM q2_2023_postings
    UNION ALL
    SELECT 'Q3 2023', job_title_short, salary_year_avg
    FROM q3_2023_postings
    UNION ALL
    SELECT 'Q4 2023', job_title_short, salary_year_avg
    FROM q4_2023_postings
)
SELECT
    quarter,
    job_title_short AS data_role,
    COUNT(*) AS total_postings,
    COUNT(salary_year_avg) AS postings_with_salary,
    ROUND(AVG(salary_year_avg)) AS avg_salary_year,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_year_avg)) AS median_salary_year,
    ROUND(MIN(salary_year_avg)) AS min_salary_year,
    ROUND(MAX(salary_year_avg)) AS max_salary_year,
    RANK() OVER (PARTITION BY quarter ORDER BY PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_year_avg) DESC) AS pay_rank
FROM quarterly_postings
WHERE job_title_short LIKE '%Data%'
GROUP BY quarter, job_title_short
ORDER BY quarter, pay_rank, avg_salary_year DESC;