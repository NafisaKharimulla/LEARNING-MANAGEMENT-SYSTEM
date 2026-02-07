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

select * from lms.Enrollments
select * from lms.User_Activity

--4.Identify users who enrolled in a course but never accessed any lesson.--
SELECT DISTINCT
    e.user_id
FROM lms.Enrollments e
LEFT JOIN lms.User_Activity ua
    ON e.user_id = ua.user_id
WHERE ua.user_id IS NULL;

--5.Fetch lessons that have never been accessed by any user.--


    

    
