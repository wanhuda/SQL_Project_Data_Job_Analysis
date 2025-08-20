CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_name_file VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

SELECT * FROM job_applied;

INSERT INTO job_applied
    (job_id,
    application_sent_date,
    custom_resume,
    resume_name_file,
    cover_letter_sent,
    cover_letter_file_name,
    status)
VALUES (1,
        '2024-02-01',
        true,
        'resume_01.pdf',
        true,
        'cover_letter_01.pdf',
        'submitted'),
        (2,
        '2024-02-02',
        false,
        'resume_01.pdf',
        false,
        null,
        'submitted');

ALTER TABLE job_applied
ADD contact VARCHAR(50);

-- to update data in table
UPDATE job_applied
set contact = 'Erlich Bachman'
WHERE job_id = 1;

UPDATE job_applied
set contact = 'Dinesh Chugtai'
WHERE job_id = 2;

-- to rename column
ALTER TABLE job_applied
rename column contact to contact_name;

--to use ALTER COLUMN
ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

--to use DROP COLUMN
ALTER TABLE job_applied
DROP COLUMN contact_name; -- same as DROP TABLE

DROP table job_applied;

SELECT *
FROM job_applied;