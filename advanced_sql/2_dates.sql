-- 1. to change datatype from timestamp to date only
SELECT 
    job_title_short as title,
    job_location as location,
    job_posted_date::DATE as date -- 1. '::' this symbol means change the datatype
FROM
    job_postings_fact;

/*2. to change the timezone.
-> since we dont know the actual timezone, assumes the 
machine's time zone for conversion; specify it, or the default is UTC*/
SELECT 
    job_title_short as title,
    job_location as location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date_time
FROM
    job_postings_fact
LIMIT 10;

SELECT 
    job_title_short as title,
    job_location as location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date_time
FROM
    job_postings_fact
LIMIT 10;

--3. to extract month from datetime
SELECT 
    job_title_short as title,
    job_location as location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date_time,
    EXTRACT (MONTH FROM job_posted_date) as month,
    EXTRACT (YEAR FROM job_posted_date) as year
FROM
    job_postings_fact
LIMIT 10;

-- PRACTISE PROBLEM 1
/*Write a query to find average salary both yearly and hourly 
for job postings that were posted after 2023-06-01. Group the results by
job schedule type*/
SELECT * FROM job_postings_fact
LIMIT 10

SELECT
    job_schedule_type as JobType,
    avg(salary_year_avg) as YearlySalary,
    avg(salary_hour_avg) as HourlySalary
FROM 
    job_postings_fact
WHERE
    (job_posted_date ::DATE) > '2023-06-01'
GROUP BY JobType;

--PRACTISE PROBLEM 2
/*write a query to count the number of job postings for each month in 2023, adjusting the
job_posted_date to be in 'America/NewYork' time zone before extracting (hint) the month.
Assume the job_posted_date is stored in UTC. Group by and order by the month*/
SELECT  
    COUNT(job_id) as JobPostings,
    EXTRACT (MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') as Month
FROM    
    job_postings_fact
WHERE   
    EXTRACT (YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = '2023'
GROUP BY 
    Month
ORDER BY Month;

--PRACTISE PROBLEM 3
/*Write a query to find the companies (include company name) that have posted jobs offering health
insurance, where these postings were made in the second quarter of 2023. Use date extraction
to filter by quarter.*/
SELECT  
    company_id as Company,
    job_location as location,
    EXTRACT(MONTH FROM job_posted_date) as Month
FROM job_postings_fact
WHERE
    (EXTRACT (YEAR FROM job_posted_date) = 2023) AND
    (EXTRACT(MONTH FROM job_posted_date) BETWEEN 4 AND 6) AND
    (job_health_insurance is true);

-- ADVANCED PRACTICED PROBLEM 6
/* Question:
- Create three tables:
  - Jan 2023 jobs
  - Feb 2023 jobs
  - Mar 2023 jobs
- Foreshadowing: this will be used in another practice problem below.
- Hints:
  - Use CREATE TABLE table_name AS syntax to create your table
  - Look at a way to filter out only specific months (EXTRACT)*/
-- january
CREATE TABLE january_jobs as
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1;
--february
CREATE TABLE february_jobs as
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 2;
--march
CREATE TABLE march_jobs as
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 3;

