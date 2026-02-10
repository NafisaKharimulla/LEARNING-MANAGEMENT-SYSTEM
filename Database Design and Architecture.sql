/* 36. Propose schema changes to support course completion certificates. */
CREATE TABLE lms.Course_Certificates (
    certificate_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    completed_on DATETIME NOT NULL,
    issued_on DATETIME DEFAULT GETDATE(),
    certificate_number VARCHAR(50) UNIQUE NOT NULL,

    CONSTRAINT fk_cert_user
        FOREIGN KEY (user_id) REFERENCES lms.Users(user_id),

    CONSTRAINT fk_cert_course
        FOREIGN KEY (course_id) REFERENCES lms.Courses(course_id),

    CONSTRAINT uq_user_course_certificate
        UNIQUE (user_id, course_id)
);

/* 37. Describe how you would track video progress efficiently at scale. */
    /*
    To track video progress efficiently, save the user’s position only at key points,
    like when they pause, leave, or every 30 seconds. Store just the latest progress for each user
    and video in a table, instead of recording every second. Add indexes on user_id and lesson_id to make updates fast.
    */

/* 38. Discuss normalization versus denormalization trade-offs for user activity data.
    /*
    Normalization means organizing user activity data into separate tables to avoid duplicate information.
    It keeps data clean, reduces storage, and makes updates easy, but queries can be slower
    because you need to join many tables. Denormalization means combining data into fewer tables for faster queries,
    which is useful for analytics dashboards or reports, but it can use more storage and may lead to duplicate data. 
    For user activity, normalized tables are good for storing detailed events, while denormalized tables or summary tables 
    are better for fast analytics.
    */

/* 39. Design a reporting-friendly schema for analytics dashboards. */
    /*
    For reporting dashboards, create separate analytics tables that store summarized data 
    like total enrollments, lessons completed, and average scores. This avoids scanning millions
    of raw activity rows and keeps queries fast. Update these tables periodically to keep dashboards 
    accurate and responsive.
    */
 
/* 40. Explain how this schema should evolve to support millions of users. */
    /*
    To support millions of users, the schema should use indexes on key columns like user_id and course_id 
    to make queries fast. Large tables like User_Activity can be partitioned by date to manage data efficiently. 
    Summarized analytics tables should be used to avoid scanning raw data. Finally, archiving old or less-used data
    can keep the database responsive at scale.
    */

