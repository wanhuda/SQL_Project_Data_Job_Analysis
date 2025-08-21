/*Questions to Answer:
1. What are the top-paying jobs for my role?
2. What are the skills required for these top-paying roles?
3. What are the most in-demand skills for my role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills to learn?
    a. Optimal: High demand AND High paying */

/*Question 3: What are the most in-demand skills for my role?
  - join job postings to inner join table similar to query 2
  - identify the top 5 in-demand skills for a data analyst
  - focus on all job postings
  - why? retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON skills_job_dim.  job_id = job_postings_fact.job_id
LEFT JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND
    job_work_from_home IS TRUE
GROUP BY skills
ORDER BY demand_count DESC
limit 5;

