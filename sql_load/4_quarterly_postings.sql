--Creating One Table per Quarter (2023)

-- Q1 2023 (Jan 1 – Mar 31)
CREATE TABLE q1_2023_postings AS
SELECT *
FROM job_postings_fact
WHERE job_posted_date >= '2023-01-01'
  AND job_posted_date <  '2023-04-01';

-- Q2 2023 (Apr 1 – Jun 30)
CREATE TABLE q2_2023_postings AS
SELECT *
FROM job_postings_fact
WHERE job_posted_date >= '2023-04-01'
  AND job_posted_date <  '2023-07-01';

-- Q3 2023 (Jul 1 – Sep 30)
CREATE TABLE q3_2023_postings AS
SELECT *
FROM job_postings_fact
WHERE job_posted_date >= '2023-07-01'
  AND job_posted_date <  '2023-10-01';

-- Q4 2023 (Oct 1 – Dec 31)
CREATE TABLE q4_2023_postings AS
SELECT *
FROM job_postings_fact
WHERE job_posted_date >= '2023-10-01'
  AND job_posted_date <  '2024-01-01';