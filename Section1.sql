--Section 1: Intermediate SQL Queries--

---1. List all users who are enrolled in more than three courses.--
SELECT 
    u.user_id,          
    u.user_name,        
    COUNT(e.course_id) AS total_courses  
FROM lms.Users u        
JOIN lms.Enrollments e  
    ON u.user_id = e.user_id
GROUP BY 
    u.user_id, 
    u.user_name        
HAVING COUNT(e.course_id) > 3  
 
--2.Find courses that currently have no enrollments.--
SELECT
    c.course_id,
    c.course_name
FROM lms.Courses c
LEFT JOIN lms.Enrollments e
    ON c.course_id = e.course_id
WHERE e.course_id IS NULL;

--3.Display each course along with the total number of enrolled users.--
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.user_id) AS total_enrolled_users 
FROM lms.courses c
LEFT JOIN lms.Enrollments e
        ON c.course_id=e.course_id
GROUP BY 
    c.course_id,
    c.course_name

--select * from lms.Enrollments
--select * from lms.User_Activity

--4.Identify users who enrolled in a course but never accessed any lesson.--
SELECT DISTINCT
    e.user_id
FROM lms.Enrollments e
LEFT JOIN lms.User_Activity ua
    ON e.user_id = ua.user_id
WHERE ua.user_id IS NULL;

--5.Fetch lessons that have never been accessed by any user.--
SELECT 
    l.lesson_id,
    l.lesson_title
FROM lms.Lessons l
LEFT JOIN lms.User_Activity ua
    ON l.lesson_id = ua.lesson_id
WHERE ua.lesson_id IS NULL;

--6.Show the last activity timestamp for each user.--
SELECT 
    user_id,
    MAX(activity_time) AS last_activity_time
FROM lms.User_Activity
GROUP BY user_id;

--7.List users who submitted an assessment but scored less than 50 percent of the maximum score--
SELECT 
    s.user_id,
    s.assessment_id,
    s.score,
    a.max_score
FROM lms.Assessment_Submissions s
JOIN lms.Assessments a
    ON s.assessment_id = a.assessment_id
WHERE s.score < a.max_score / 2;

--8.Find assessments that have not received any submissions.--
SELECT 
    a.assessment_id
FROM lms.Assessments a
LEFT JOIN lms.Assessment_Submissions s
    ON a.assessment_id = s.assessment_id
WHERE s.assessment_id IS NULL;

--9.Display the highest score achieved for each assessment.--
SELECT
    s.assessment_id,
    max(s.score) AS max_score
FROM lms.Assessment_Submissions s
GROUP BY s.assessment_id;

--10.Identify users who are enrolled in a course but have an inactive enr--ollment status.
SELECT 
    e.enrollment_id,
    e.user_id,
    e.status
FROM lms.Enrollments e
WHERE e.status='inactive' ;
    
    