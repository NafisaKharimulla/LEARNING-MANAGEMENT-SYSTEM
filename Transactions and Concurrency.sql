/* 31. Design a transaction flow for enrolling a user into a course. */
BEGIN TRANSACTION;
-- 1. Check course exists
IF NOT EXISTS (SELECT 1 FROM lms.Courses WHERE course_id = @course_id)
BEGIN
    ROLLBACK;
    RETURN;
END

-- 2. Check course has lessons
IF NOT EXISTS (
    SELECT 1 FROM lms.Lessons WHERE course_id = @course_id
)
BEGIN
    ROLLBACK;
    RETURN;
END

-- 3. Check user not already enrolled
IF EXISTS (
    SELECT 1
    FROM lms.Enrollments
    WHERE user_id = @user_id
      AND course_id = @course_id
)
BEGIN
    ROLLBACK;
    RETURN;
END

-- 4. Enroll user
INSERT INTO lms.Enrollments (enrollment_id, user_id, course_id, status)
VALUES (@enrollment_id, @user_id, @course_id, 'active');

COMMIT;

/* 32. Explain how to handle concurrent assessment submissions safely. */
    /* 
    When many users submit assessments at the same time, the database must prevent duplicate or conflicting submissions.
    First, I would use UNIQUE constraint on (user_id, assessment_id).
    This makes even if two submissions happen at the same time, only one record can be stored.
    proper error handling should be added.
    If a duplicate submission is done, the system should catch the error and show a message instead of crashing.
    */

/* 33. Describe how partial failures should be handled during assessment submission. */
    /*
    A partial failure happens when only some steps of the submission process succeed, for example when the score is saved
    but the submission timestamp is not saved.
    To handle this , the entire assessment submission should be wrapped inside a database transaction.
    If any step fails, the transaction should be rolled back, so no incomplete or incorrect data is stored.
    Clear error handling should be implemented to detect what went wrong, such as validation errors or constraint violations.
    The system should then return a  message to the user instead of leaving the data in an inconsistent state.
    All failures should be logged for debugging and auditing, so developers can identify recurring issues.
    */

/* 34. Recommend suitable transaction isolation levels for enrollments and submissions. */
    /*
    Enrollments use READ COMMITTED for speed and safety, while assessment submissions use 
    SERIALIZABLE to prevent duplicate submissions.
    --You see only final, correct data,You do NOT see half-done or temporary data
    --Blocks other users until the current operation finishes, Prevents duplicates and conflicts
    */


/* 35. Explain how phantom reads could affect analytics queries and how to prevent them. */
    /* Use SERIALIZABLE isolation level, because it Blocks other users until the current operation finishes,
    Prevents duplicates and conflicts
    */
