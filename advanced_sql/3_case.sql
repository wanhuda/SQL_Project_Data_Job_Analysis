-- CASE STATEMENT - To label new column
SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM    
    job_postings_fact;

-- to count for each location
SELECT
    COUNT (job_id) as Number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM    
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

/*
PRACTISE PROBLEM 1
I want to categorize the salaries from each job posting. To see if it fits in my desired salary range.
- Put salary into different buckets
- Define what's a high, standard and low salary with our own conditions
- Why? It is easy to determine which job postings are worth looking at based on salary.
  Bucketing is a common practise in data analysis when viewing categories
- I only want to look at data analyst roles
- order from highest to lowest */

SELECT 
    job_id as job,
    salary_year_avg as Salary,
    CASE
        WHEN salary_year_avg < 80000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 80000 AND 180000 THEN 'Standard'
        ELSE 'High'
    END AS Salary_range
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg is NOT NULL
ORDER BY
    Salary DESC;



