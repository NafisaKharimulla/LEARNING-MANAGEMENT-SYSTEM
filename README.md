#  PostgreSQL Practice Assignment  
## Learning Management System (LMS) Schema

---

##  Objective

This assignment is designed to strengthen PostgreSQL skills using a realistic Learning Management System (LMS) database schema.

The focus areas include:

- Strong SQL fundamentals  
- Understanding relational data modeling  
- Writing optimized and scalable queries  
- Explaining design decisions and performance trade-offs  
- Handling transactions, concurrency, and constraints  

This is a **practice-oriented assignment**. The goal is conceptual clarity and reasoning — not memorization.

---

##  Learning Outcomes

By completing this assignment, you will be able to:

- Write intermediate and advanced PostgreSQL queries  
- Analyze relational schema relationships  
- Optimize queries for large datasets  
- Implement indexing and partitioning strategies  
- Design constraints for data integrity  
- Manage transactions and concurrency  
- Make architectural decisions for scalability  

---

##  Database Schema Overview

The LMS schema contains the following entities:

- Users  
- Courses  
- Lessons  
- Enrollments  
- User Activity  
- Assessments  
- Assessment Submissions  

###  Key Relationships

- Users enroll in Courses  
- Courses contain Lessons and Assessments  
- Users perform activity on Lessons  
- Users submit Assessments and receive scores  

Understanding these relationships is essential before writing queries.

---

#  Assignment Structure

---

#  Section 1: Intermediate SQL Queries

You are required to write queries for:

1. Users enrolled in more than three courses  
2. Courses with no enrollments  
3. Total enrolled users per course  
4. Users enrolled but never accessed lessons  
5. Lessons never accessed  
6. Last activity timestamp per user  
7. Users scoring less than 50% in assessments  
8. Assessments with no submissions  
9. Highest score per assessment  
10. Users with inactive enrollment status  

Each query must include:

- Explanation of join choices  
- Assumptions made  
- Performance behavior on large datasets  

---

#  Section 2: Advanced SQL & Analytics

Tasks include:

- Course-level aggregates (users, lessons, duration)  
- Top three most active users  
- Course completion percentage per user  
- Users scoring above course average  
- Courses with lesson activity but no assessment attempts  
- Ranking users per course  
- First lesson accessed per user  
- Users active for five consecutive days  
- Users enrolled but never submitted assessments  
- Courses where all enrolled users submitted at least one assessment  

Focus areas:

- Window functions  
- Aggregations  
- CTEs  
- Subqueries  
- Performance awareness  

---

#  Section 3: Performance & Optimization

You must propose:

- Appropriate indexing strategies  
- Bottleneck analysis  
- Query optimization for large `user_activity` tables  
- Use cases for materialized views  
- Partitioning strategy for activity tables  

---

#  Section 4: Data Integrity & Constraints

Design constraints to ensure:

- No duplicate assessment submissions  
- Scores do not exceed maximum score  
- Users cannot enroll in courses without lessons  
- Only instructors can create courses  
- Safe deletion strategy preserving historical data  

---

#  Section 5: Transactions & Concurrency

You must design:

- Transaction flow for enrollments  
- Safe concurrent assessment submission handling  
- Partial failure recovery strategy  
- Recommended isolation levels  
- Phantom read prevention in analytics queries  

---

#  Section 6: Database Design & Architecture

Propose solutions for:

- Course completion certificates  
- Efficient video progress tracking  
- Normalization vs denormalization trade-offs  
- Reporting-friendly analytics schema  
- Scaling architecture for millions of users  

---

#  Technical Requirements

- Use PostgreSQL syntax only  
- Write clear, readable SQL  
- Include explanations for every query  
- Be prepared to adapt queries when constraints change  
- Understand and explain every line of your solution  

---

#  Evaluation Criteria

Your submission will be evaluated on:

- SQL correctness  
- Clarity of explanations  
- Understanding of schema relationships  
- Performance reasoning  
- Scalability awareness  
- Adaptability during review  

---

#  Suggested Repository Structure

```
LMS-PostgreSQL-Assignment/
│
├── schema.sql
├── sample_data.sql
├── intermediate_queries.sql
├── advanced_queries.sql
├── optimization_notes.md
├── architecture_design.md
└── README.md
```

---

#  Recommended PostgreSQL Concepts to Revise

- JOIN types (INNER, LEFT, RIGHT)  
- GROUP BY & HAVING  
- Window Functions (RANK, ROW_NUMBER, AVG OVER)  
- CTEs (WITH clause)  
- Indexing strategies  
- Partitioning  
- Transaction Isolation Levels  
- Constraints & Foreign Keys  
- Materialized Views  

---

#  Author

Nafisa Shaik  
MSSQL Learner | Data & Backend Enthusiast  

---

⭐ This assignment is focused on deep understanding. Be ready to explain your design decisions clearly.
