/*
Topics which we have learned so far:
	1. Create database and tables
	2. INSERT/UPDATE/DELETE for tables
	3. Join (both inner and outer)
	4. Stored Procedure (SP)
	5. Trigger
	6. Try-Catch block
	7. The combination of SP and Try-Catch
	8. The combination of SP and INSERT/UPDATE/DELETE commands
*/

-- Midterm preparion part II - Nov 09
/*
We know how to create a table with the basic approach , now we want to create a stored procedure which creates a table for us.

The stored procedure which we want to create recives two arguemnts of 
	- name of the table
	- the name of the columns
then, the SP creates the table for us.
*/
CREATE PROCEDURE CreateDynamicTable
	@TableName NVARCHAR(50), -- this is the first argument which hold the name of the table
	@Columns NVARCHAR(MAX) -- this is the second argument which saves a list of columns.
AS
BEGIN
	DECLARE @SQLQuery NVARCHAR(MAX) -- this is the local variables which we name it @SQLQuery
	-- Recall that variables in sql should start with @
	-- in fact the indentifier for a varibale is @
	SET @SQLQuery = 'CREATE TABLE ' + @TableName + ' ('+ @Columns + ')' -- here we only form the quey but we cannot run it!
	-- the above line is just for preparing the query NOT running it
	EXEC sp_executesql @SQLQuery, N'@statement NVARCHAR(MAX)', @statement = @SQLQuery -- for runing the above query we have
	-- two options: (1) clikcing on the Execute button on the taskbar. But here we cannot because the stored procedure should
	-- automatically run it. (2) calling a built-in funciton which runs the qury for us.

	-- sp_executesql is a built-in funciton so you cannot change it
	-- @SQLQuery is the name of the query and you can change it to anything.
END


-- in the above code we created the stored procedure and now wehow to drop want to see how to use it
EXEC CreateDynamicTable @TableName = 'Midterm_BD1', @Columns='ID INT, Name NVARCHAR(100), Age INT'
EXEC CreateDynamicTable @TableName = 'Thomas_tbl', @Columns = 'StudentID INT, Firstname NVARCHAR(50), GPA FLOAT'

-- For dropping an stored procedure
DROP PROCEDURE CreateDynamicTable


/*
We know how to create a table and insert into it but in this example we want to create a stored procedure which inserts
records into table.
*/