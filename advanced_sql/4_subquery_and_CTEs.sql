-- example on how to use subquery (query nested inside a larger query)
SELECT *
FROM ( --SubQuery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

-- example on Common Table Expressions (CTEs) - define a temporary 
-- result set that you can reference
WITH january AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT * 
FROM january;

--exercise along
SELECT
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT  
        company_id
    FROM    
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY company_id
);

--exercise along 2
/*
Find the companies that have the most job openings.
- Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/
WITH company_job_count AS (
   SELECT
        company_id,
        COUNT(*) AS Total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT 
    company_dim.name AS company_name,
    company_job_count.Total_jobs
FROM company_dim
LEFT JOIN 
    company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY   
        Total_jobs DESC;

--PRACTISE PROBLEM 1
/*
Identify the top 5 skills that are most frequently mentioned in job postings. Use a subquery to
find the skill IDs with the highest counts in the skills_job_dim table and then join the result 
with the skills_dim table to get the skill names.
*/
SELECT * FROM skills_dim LIMIT 10;
SELECT* FROM skills_job_dim LIMIT 10;

WITH top5 AS (
    SELECT 
        skill_id,
        COUNT(skill_id) AS numberappear
    FROM
        skills_job_dim
    GROUP BY skill_id
)
SELECT
    top5.numberappear,
    skills,
    type
FROM skills_dim
LEFT JOIN top5 ON
    top5.skill_id = skills_dim.skill_id
ORDER BY top5.numberappear DESC
LIMIT 5;

/*PRACTICE PROBLEM 2
Determine the size category ('Small','Medium' or 'Large') for each company by first identifying
the number of job postings they have.Use a subquery to calculate the total job postin gs per
company. A company is considered 'small' if it has less than 10 job postings, 'medium' if the 
number of job postings is between 10 and 50, and 'large' if it has more than 50 job postings.
Implement a subquery to aggregate job counts per company before classifying them based on size. */
SELECT* FROM job_postings_fact LIMIT 100
SELECT* from company_dim LIMIT 100

WITH company AS (
    SELECT 
        company_id,
        COUNT(company_id) AS number_of_job_postings,
        CASE    
            WHEN COUNT(company_id) < 10 THEN 'Small'
            WHEN COUNT(company_id) BETWEEN 10 AND 50 THEN 'Medium'
            ELSE 'Large'
        END AS company_size
    FROM job_postings_fact
    GROUP BY company_id
) 
SELECT 
    name,
    company.number_of_job_postings,
    company.company_size
FROM
    company_dim
LEFT JOIN company
    on company.company_id = company_dim.company_id;

/*PRATICE PROBLEM 7
Find the count of the number of remote job postings per skill
    - display the top 5 skills by their demand in remote jobs
    - include skill id, name, and count of postings requiring the skills*/
WITH remote_job_skills AS(
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings 
        on job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = true
    GROUP BY skill_id
)
SELECT 
    skill.skill_id,
    skills as skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skill
    ON skill.skill_id = remote_job_skills.skill_id
ORDER BY 
    skill_count DESC
limit 5