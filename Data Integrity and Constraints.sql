/* 26. Propose constraints to ensure a user cannot submit the same assessment more than once. */
ALTER TABLE lms.Assessment_Submissions
ADD CONSTRAINT uq_user_assessment
UNIQUE (user_id, assessment_id);

/* 27. Ensure that assessment scores do not exceed the defined maximum score. */
CREATE TRIGGER trg_check_score_max
ON lms.Assessment_Submissions
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN lms.Assessments a
            ON i.assessment_id = a.assessment_id
        WHERE i.score > a.max_score
    )
    BEGIN
        RAISERROR ('Score cannot exceed the maximum score for the assessment.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

use lms_db;
/* 28.Prevent users from enrolling in courses that have no lessons. */
CREATE TRIGGER trg_no_enroll_without_lessons
ON lms.Enrollments
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1
            FROM lms.Lessons l
            WHERE l.course_id = i.course_id
        )
    )
    BEGIN
        RAISERROR ('Enrollment not allowed. Course has no lessons.', 16, 1);
        ROLLBACK;
    END
END;

/* 29. Ensure that only instructors can create courses.*/
CREATE TRIGGER trg_only_instructor_can_create_course
ON lms.Courses
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN lms.Users u
            ON i.instructor_id = u.user_id
        WHERE u.role <> 'instructor'
    )
    BEGIN
        RAISERROR ('Only instructors are allowed to create courses.', 16, 1);
        ROLLBACK;
    END
END;


/* 30. Describe a safe strategy for deleting courses while preserving historical data. */
    /*Instead of permanently deleting a course, I would use a soft delete approach.
This means adding a column like is_active or is_deleted in the Courses table and marking the 
course as inactive rather than removing it.
All historical data such as enrollments, lessons, user activity, and assessment submissions 
remain in the database and are still available for reports and analytics.
Application queries will simply filter active courses using a WHERE condition. */



