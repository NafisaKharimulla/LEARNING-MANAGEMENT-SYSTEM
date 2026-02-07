--creating the DB--
CREATE DATABASE lms_db;
SELECT DB_NAME();
--creating the Schema--
use lms_db;
CREATE SCHEMA lms;
GO
--checking the Schema--
SELECT name
FROM sys.schemas
WHERE name = 'lms';

--finding UserName--
SELECT name
FROM sys.database_principals
WHERE type_desc = 'SQL_USER';

--make lms as Default Schema--
ALTER USER guest WITH DEFAULT_SCHEMA = lms;

--creating the tables--
--USers table--
CREATE TABLE lms.Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    role VARCHAR(20) CHECK (role IN ('student', 'instructor')),
    created_at DATETIME DEFAULT GETDATE()
);
GO

--Courses Table--
CREATE TABLE lms.Courses (
    course_id INT IDENTITY(1,1) PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    instructor_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT fk_course_instructor
        FOREIGN KEY (instructor_id)
        REFERENCES lms.Users(user_id)
);
GO

--Lessons Table--
CREATE TABLE lms.Lessons (
    lesson_id INT IDENTITY(1,1) PRIMARY KEY,
    course_id INT NOT NULL,
    lesson_title VARCHAR(150) NOT NULL,
    lesson_order INT NOT NULL,
    duration_minutes INT CHECK (duration_minutes > 0),

    CONSTRAINT fk_lessons_course
        FOREIGN KEY (course_id)
        REFERENCES lms.Courses(course_id)
);
GO

--Enrollments Table--
CREATE TABLE lms.Enrollments (
    enrollment_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    status VARCHAR(20) CHECK (status IN ('active', 'inactive')),
    enrolled_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT fk_enroll_user
        FOREIGN KEY (user_id)
        REFERENCES lms.Users(user_id),

    CONSTRAINT fk_enroll_course
        FOREIGN KEY (course_id)
        REFERENCES lms.Courses(course_id),

    CONSTRAINT uq_user_course UNIQUE (user_id, course_id)
);
GO

--User Activity Table--
CREATE TABLE lms.User_Activity (
    activity_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    lesson_id INT NOT NULL,
    activity_type VARCHAR(20) CHECK (activity_type IN ('START', 'COMPLETE')),
    activity_time DATETIME NOT NULL,

    CONSTRAINT fk_activity_user
        FOREIGN KEY (user_id)
        REFERENCES lms.Users(user_id),

    CONSTRAINT fk_activity_lesson
        FOREIGN KEY (lesson_id)
        REFERENCES lms.Lessons(lesson_id)
);
GO

--Assessments Table--
CREATE TABLE lms.Assessments (
    assessment_id INT IDENTITY(1,1) PRIMARY KEY,
    course_id INT NOT NULL,
    assessment_title VARCHAR(150),
    max_score INT CHECK (max_score > 0),

    CONSTRAINT fk_assessment_course
        FOREIGN KEY (course_id)
        REFERENCES lms.Courses(course_id)
);
GO

--Assessment Submission table--
CREATE TABLE lms.Assessment_Submissions (
    submission_id INT IDENTITY(1,1) PRIMARY KEY,
    assessment_id INT NOT NULL,
    user_id INT NOT NULL,
    score INT CHECK (score >= 0),
    submitted_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT fk_submission_assessment
        FOREIGN KEY (assessment_id)
        REFERENCES lms.Assessments(assessment_id),

    CONSTRAINT fk_submission_user
        FOREIGN KEY (user_id)
        REFERENCES lms.Users(user_id),

    CONSTRAINT uq_user_assessment UNIQUE (user_id, assessment_id)
);
GO

--load data to Users--
BULK INSERT lms.Users
FROM 'C:\Users\NAFISA SHAIK\OneDrive\Attachments\Desktop\LMS\users (1).csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0X0A'
);
--load data to Courses--
BULK INSERT lms.Courses
FROM 'C:\Users\NAFISA SHAIK\OneDrive\Attachments\Desktop\LMS\courses.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0X0A'
   
);
--load data to Lessons--
BULK INSERT lms.Lessons
FROM 'C:\Users\NAFISA SHAIK\OneDrive\Attachments\Desktop\LMS\lessons.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0X0A'
   
);

--load data into Enrollments--
BULK INSERT lms.Enrollments
FROM 'C:\Users\NAFISA SHAIK\OneDrive\Attachments\Desktop\LMS\enrollments_unique.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0X0A'
   
);

--load data into Assessments--
BULK INSERT lms.Assessments
FROM 'C:\Users\NAFISA SHAIK\OneDrive\Attachments\Desktop\LMS\assessments.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0X0A'
   
);

--load data into Assessment_Submissions--
BULK INSERT lms.Assessment_Submissions
FROM 'C:\Users\NAFISA SHAIK\OneDrive\Attachments\Desktop\LMS\assessment_submissions_unique.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0X0A'
   
);

--load data into User Activty--
BULK INSERT lms.User_Activity
FROM 'C:\Users\NAFISA SHAIK\OneDrive\Attachments\Desktop\LMS\Data\user_activity.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0X0A'
   
);



select * from lms.Assessment_Submissions