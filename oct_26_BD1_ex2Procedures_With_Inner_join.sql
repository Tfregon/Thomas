/*
now we want to see how long join commands can be integrated into a shoe stored procedure.
*/

-- let's create another database to join with student table

CREATE TABLE studetn_tuition(
	student_id INT,
	tuition_amount DECIMAL(10,2),
	payment_date DATE
)

-- now we add some records into this table
INSERT INTO studetn_tuition(student_id, tuition_amount, payment_date) VALUES
(1001, 2000.00, '2023-10-25'),
(1002, 1567.18, '2023-09-11'),
(1003, 2134.45, '2023-10-17'),
(1004, 1897.23, '2023-09-19'),
(1005, 1902.90, '2023-10-14')

/*
Now we write a stored procedure which accepts student's id as an argument and retrives
their tuition payment information by joining the table student_tb and student_tuition

Here there is a func fact:
in all the programming languages we firstly define the object and then we use
in sql, we can use the object and define it later :)
*/

CREATE PROCEDURE getStudentTuitionInfo(@student_id INT)
AS
BEGIN
	-- here st is an object (a name) for the table student_tb and stt is another object for table student_tuition
	SELECT st.id AS student_id,
	st.first_name,
	st.last_name,
	st.salary,
	-- the three above items are available inside of the table student_tb but the two items below are not!
	-- therefore, we join these two tables to get all the inforamtion
	-- in fact, the above three items will come from table student_tb and the two bwelow come from table student_tuition
	-- only join can make this relationship between table student_tb and student_tuition
	stt.tuition_amount,
	stt.payment_date
	FROM student_tb AS st -- although we are decalring the st here, we have used it above :) funny
	INNER JOIN studetn_tuition AS stt ON st.id = stt.student_id
	-- the condition is on having the same student ids in two tables
	-- if there is no match betwween these two tables which means the if id from the table student_tb and the student_id
	-- from the table student_tuition do not match nothing will be returned.
	-- in other words the join between the above two tables is under the condition of having teh same student ids
	WHERE st.id = @student_id
END

EXEC getStudentTuitionInfo @student_id = 1005
-- quick note, id is in comon between these two tables (student_tb and student_tuition)
-- first_name, last_name, and salary are form the table student_tb
-- tuition_amount and payment date are from the second table

-- now we see another example
-- note that in below query we have three arguments

CREATE PROCEDURE getStudentTuitionByDateRange(@student_id INT, @start_date DATE, @end_date DATE)
AS
BEGIN
	SELECT st.id AS student_id,
	st.first_name, -- st refers to the table student_tb
	st.last_name,
	stt.tuition_amount, -- stt stands for the table student_tuition
	stt.payment_date
	FROM student_tb AS st
	INNER JOIN studetn_tuition AS stt On st.id = stt.student_id
	WHERE st.id = @student_id
	AND stt.payment_date >= @start_date
	AND stt.payment_date <= @end_date
END

-- Obviously, you can chnage the name of objects from st, and stt to whatever you want
-- but I highly recommned to name them relevently. for example the name obj does not have any sign to refer to the table student_tb
-- compiler is smart and it's ok with any name but it will be difficult for you and your colleagues to understand your code.

EXEC getStudentTuitionByDateRange @student_id = 1001, @start_date = '2023-01-01', @end_date = '2023-11-10';
/*
in above query we run the getStudentTuitionByDateRange procedure with three argumens.
firstly the id should exist and secondly the payment date of that student should be between the start and end date which 
we have provided. If the Id exist but the date does not match then nothing will be shown
*/

--ex Implement a query in which find the firstname and last name of the person who pays the highest tuition

--You should use join between table student_tb and table student_tuition
--Your stored procedure does not enquere any argument. However, if you prefer to include, it is ok.

CREATE PROCEDURE getStudentNameHighestTuition (@student_amount INT)
AS
BEGIN
	-- here st is an object (a name) for the table student_tb and stt is another object for table student_tuition
	SELECT st.id AS student_id,
	st.first_name,
	st.last_name,
	st.salary,
	-- the three above items are available inside of the table student_tb but the two items below are not!
	-- therefore, we join these two tables to get all the inforamtion
	-- in fact, the above three items will come from table student_tb and the two bwelow come from table student_tuition
	-- only join can make this relationship between table student_tb and student_tuition
	stt.tuition_amount,
	stt.payment_date
	FROM student_tb AS st -- although we are decalring the st here, we have used it above :) funny
	INNER JOIN studetn_tuition AS stt ON st.id = stt.student_id
	-- the condition is on having the same student ids in two tables
	-- if there is no match betwween these two tables which means the if id from the table student_tb and the student_id
	-- from the table student_tuition do not match nothing will be returned.
	-- in other words the join between the above two tables is under the condition of having teh same student ids
	WHERE st.id = @student_id
END

EXEC getStudentTuitionInfo @student_id = 1005