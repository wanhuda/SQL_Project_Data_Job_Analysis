/*TO USE UNION - COMBINE RESULTS OF TWO OR MORE SELECT STATEMENT INTO A SINGLE RESULT SET
*/

-- UNION - DOES NOT RETURN DUPLICATE ROWS
-- UNION ALL - RETURN ALL DUPLICATE ROWS
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;

--example for UNION ALL
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;

/*PRACTICE PROBLEM 8
Find job postings from the first quarter that have a salary greater than $70k
- combine job postings tables from the first quarter of 2023 (Jan - Mar)
- gets job postings with an average yearly salary > $70,000 */

SELECT 
    quarter1_jobpostings.job_title_short,
    quarter1_jobpostings.job_location,
    quarter1_jobpostings.job_via,
    quarter1_jobpostings.job_posted_date::DATE,
    quarter1_jobpostings.salary_year_avg
FROM (
    SELECT * 
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_jobpostings
WHERE 
    quarter1_jobpostings.salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    quarter1_jobpostings.salary_year_avg DESC