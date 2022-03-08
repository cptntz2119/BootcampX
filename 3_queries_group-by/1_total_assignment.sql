--Get the total number of assignments for each day of bootcamp
SELECT day, count(*) as total_assignments 
FROM assignments
GROUP BY day
ORDER BY day;

--The same query as before, but only return rows where total assignments is greater than or equal to 10.
SELECT day, count(*) as total_assignments 
FROM assignments
GROUP BY day
HAVING count(*)>=10
ORDER BY day;

--Get all cohorts with 18 or more students.
SELECT cohorts.name as cohort_name, count(students.*) as student_count
FROM students 
JOIN cohorts on cohorts.id = cohort_id
GROUP BY cohorts.name
HAVING count(students.*)>=18
ORDER BY student_count; 

--Get the total number of assignment submissions for each cohort.
SELECT cohorts.name as cohort, count(assignment_submissions.*) as total_submissions
FROM students 
JOIN cohorts ON cohorts.id = cohort_id
JOIN assignment_submissions ON students.id = assignment_submissions.student_id
GROUP BY cohorts.name
ORDER BY total_submissions DESC;

--Get currently enrolled students' average assignment completion time.
SELECT students.name as student, AVG(assignment_submissions.duration) as average_assignment_duration 
FROM students
JOIN assignment_submissions ON students.id = assignment_submissions.student_id
WHERE students.end_date IS NULL
GROUP BY student
ORDER BY average_assignment_duration DESC;

--Get the students who's average time it takes to complete an assignment is less than the average estimated time it takes to complete an assignment.
SELECT students.name as student, AVG(assignment_submissions.duration) as average_assignment_duration, AVG(assignments.duration) as average_estimated_duration
FROM students
JOIN assignment_submissions ON students.id = assignment_submissions.student_id
JOIN assignments ON assignments.id = assignment_submissions.assignment_id
WHERE students.end_date IS NULL
GROUP BY student
HAVING AVG(assignment_submissions.duration) < AVG(assignments.duration)
ORDER BY average_assignment_duration DESC;
-- for HAVING should be a calculation, use alias do not work;