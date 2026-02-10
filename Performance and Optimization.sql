use lms_db

/* 21.Suggest appropriate indexes for improving performance of:
	Course dashboards
	User activity analytics
*/
/* Indexes for Course Dashboards */

CREATE INDEX idx_enrollments_course
ON lms.Enrollments(course_id);

CREATE INDEX idx_lessons_course
ON lms.Lessons(course_id);

CREATE INDEX idx_assessments_course
ON lms.Assessments(course_id);

CREATE INDEX idx_submissions_assessment
ON lms.Assessment_Submissions(assessment_id);

/*  Indexes for User Activity Analytics */

CREATE INDEX idx_user_activity_user
ON lms.User_Activity(user_id);

CREATE INDEX idx_user_activity_time
ON lms.User_Activity(activity_time);

CREATE INDEX idx_user_activity_user_time
ON lms.User_Activity(user_id, activity_time);

/* 22. Identify potential performance bottlenecks in queries involving user activity. */

  /* User activity queries can be slow due to full table scans,
	missing indexes on user_id and activity_time, and using functions
	on date columns in the WHERE clause. Heavy GROUP BY or window functions without proper indexes also 
	cause performance issues. Using proper indexing and filtering data early improves performance. */

/*23. Explain how you would optimize queries when the user_activity table grows to millions of rows. */

	/* When the user_activity table grows to millions of rows, I would focus on improving query performance
	by creating indexes on commonly used columns such as user_id, activity_time, and course_id. I make sure
	that queries filter data as early as possible using WHERE conditions and avoid applying functions on indexed
	columns, as this can prevent index usage.I would consider partitioning the table based on date to reduce the 
	amount of data scanned.*/

/* 24. Describe scenarios where materialized views would be useful for this schema. */

	/* In this LMS system, materialized views are useful for queries that are used again and again 
	and take a long time to run. For example, queries that show total students per course, total lessons, 
	average scores, or course completion need to read many tables and many rows. When the data becomes large, 
	running these queries every time is slow. A materialized view stores the already calculated result,
	so the system can show dashboards and reports faster without recalculating the data each time. 
	This is very helpful for user activity reports where a lot of activity data is used. */

/* 25. Explain how partitioning could be applied to user_activity. */
	/*The user_activity table can grow very large because it stores one row for every user action. 
	To handle this, partitioning can be applied based on the activity_date. 
	For example, the table can be divided into monthly or yearly partitions using the activity_time. 
	like this, queries that look for recent activity only scan the required partitions instead of the entire table.
	Partitioning also makes maintenance easier, such as  deleting old activity data without affecting recent records. 
	Overall, partitioning improves query performance and scalability when the table grows larger. */
