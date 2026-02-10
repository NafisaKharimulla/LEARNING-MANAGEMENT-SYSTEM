
USE lms_db;
/*For each course, calculate:
    Total number of enrolled users
    Total number of lessons
    Average lesson duration*/

--  Total number of enrolled users per course --
SELECT 
    e.course_id,
    COUNT(e.user_id) AS total_users
FROM lms.Enrollments e
GROUP BY e.course_id;

-- Total number of lessons per course --
SELECT 
    course_id,
    COUNT(lesson_id) AS total_lessons
FROM lms.Lessons
GROUP BY course_id;

-- Average lesson duration per course--
SELECT 
    course_id,
    AVG(duration_minutes) AS avg_lesson_duration
FROM lms.Lessons
GROUP BY course_id;


/* 12. Top 3 most active users (based on activity count) */
SELECT TOP 3
    user_id,
    COUNT(*) AS activity_count
FROM lms.User_Activity
GROUP BY user_id
ORDER BY activity_count DESC;

/* 13. Course completion percentage per user */
SELECT
    e.user_id,
    e.course_id,
    (COUNT(a.lesson_id) * 100.0 / COUNT(l.lesson_id)) AS completion_percentage
FROM lms.Enrollments e
JOIN lms.Lessons l
    ON e.course_id = l.course_id
LEFT JOIN lms.User_Activity a
    ON a.lesson_id = l.lesson_id
    AND a.user_id = e.user_id
GROUP BY e.user_id, e.course_id;


/* 14. Users whose average assessment score is higher than course average */
SELECT
    s.user_id
FROM lms.Assessment_Submissions s
JOIN lms.Assessments a
    ON s.assessment_id = a.assessment_id
GROUP BY s.user_id, a.course_id
HAVING AVG(s.score) >
       (SELECT AVG(score)
        FROM lms.Assessment_Submissions);


/* 15. Courses where lessons are accessed but assessments are never attempted */
SELECT DISTINCT
    l.course_id
FROM lms.Lessons l
JOIN lms.User_Activity ua
    ON ua.lesson_id = l.lesson_id
WHERE l.course_id NOT IN (
    SELECT course_id
    FROM lms.Assessments a
    JOIN lms.Assessment_Submissions s
        ON a.assessment_id = s.assessment_id
);

use lms_db;
/* 16.Rank users within each course based on their total assessment score.*/
SELECT
    a.course_id,
    s.user_id,
    SUM(s.score) AS total_score,
    RANK() OVER (PARTITION BY a.course_id
        ORDER BY SUM(s.score) DESC
        
    ) AS user_rank
FROM lms.Assessment_Submissions s
JOIN lms.Assessments a
    ON s.assessment_id = a.assessment_id
GROUP BY
    a.course_id,
    s.user_id;

--select * from lms.Lessons;

 /* 17. Identify the first lesson accessed by each user for every course */
SELECT
    ua.user_id,
    l.course_id,
    MIN(ua.activity_time) AS first_access_time
FROM lms.User_Activity ua
JOIN lms.Lessons l
    ON ua.lesson_id = l.lesson_id
GROUP BY
    ua.user_id,
    l.course_id;
 
/* 18.Find users with activity recorded on at least five consecutive days. */
--SELECT *from lms.user_activity;

SELECT
    user_id
FROM (
    SELECT
        user_id,
        activity_date,
        DATEDIFF(DAY, '2000-01-01', activity_date)
        - ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY activity_date
        ) AS grp
    FROM (
        SELECT DISTINCT
            user_id,
            CAST(activity_time AS DATE) AS activity_date
        FROM lms.User_Activity
    ) d
) x
GROUP BY
    user_id,
    grp
HAVING COUNT(*) >= 5;

/* 19.Retrieve users who enrolled in a course but never submitted any assessment. */
--SELECT * from lms.Enrollments
--SELECT * from lms.Assessment_Submissions

SELECT 
    e.user_id,
    e.course_id
FROM lms.Enrollments e
LEFT JOIN lms.Assessment_Submissions s
ON e.user_id= s.user_id
WHERE s.user_id IS NULL;

/* 20. Courses where every enrolled user submitted at least one assessment */
SELECT
    e.course_id
FROM lms.Enrollments e
LEFT JOIN lms.Assessment_Submissions s
    ON e.user_id = s.user_id
GROUP BY
    e.course_id
HAVING COUNT(e.user_id) = COUNT(s.user_id);

