/*
4. Question: what are the highest hiring methods (job_via)?
Discover where are the highest hiring chances for data roles
Why? help job seekers to understand which platforms are being used to hire data roles and where they should focus their job search efforts
we can clearly see some unusual platforms are being used to hire data roles, BeBee, trabajo.org and Snagajob which are not the most common platforms for hiring data rolesare actually higher than famous sites like indeed and ziprecruiter. This could indicate that these platforms are being used to 
*/

WITH cleaned_names AS (
    SELECT
        job_id,
        salary_year_avg,
        CASE
            WHEN job_via ILIKE '%linkedin%' THEN 'LinkedIn'
            WHEN job_via ILIKE '%bebee%' THEN 'BeBee'
            WHEN job_via ILIKE '%trabajo%' THEN 'Trabajo.org'
            WHEN job_via ILIKE '%indeed%' THEN 'Indeed'
            WHEN job_via ILIKE '%recruit.net%' THEN 'Recruit.net'
            WHEN job_via ILIKE '%ziprecruiter%' THEN 'ZipRecruiter'
            WHEN job_via ILIKE '%snagajob%' THEN 'Snagajob'
            WHEN job_via ILIKE '%simplyhired%' THEN 'SimplyHired'
            WHEN job_via ILIKE '%adzuna%' THEN 'Adzuna'
            ELSE TRIM(REGEXP_REPLACE(job_via, '^via\s+', '', 'i'))
        END AS raw_platform
    FROM job_postings_fact
    WHERE job_via IS NOT NULL 
),
platform_counts AS (
    SELECT
        job_id,
        salary_year_avg,
        raw_platform,
        -- Count how many times each cleaned platform appears across the dataset
        COUNT(*) OVER (PARTITION BY raw_platform) AS platform_total
    FROM cleaned_names
)
SELECT
    CASE 
        WHEN platform_total > 1000 THEN raw_platform 
        ELSE 'Other Platforms' 
    END AS platform,
    COUNT(*) AS total_postings,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS share_pct,
    COUNT(salary_year_avg) AS salary_disclosed_count,
    ROUND(100.0 * COUNT(salary_year_avg) / COUNT(*), 2) AS salary_disclosure_pct
FROM platform_counts
GROUP BY 1
ORDER BY total_postings DESC;