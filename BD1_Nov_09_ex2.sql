/*
Here we want to practice trigger together.
We'll use the table which we just created for Thomas and implement a trigger for after insert event.
It means that whenever a record get inserted into Thomas table, then a copy should go into the ThomasHistory table.
*/

-- in order to practice more le't create both Thomas table and ThomasHistory table agains here
CREATE TABLE Thomas(
	ID INT,
	Fullname NVARCHAR(50),
	Gender BIT -- you can chnage the type anything you want
)

CREATE TABLE ThomasHistory(
	ID INT,
	Fullname NVARCHAR(50),
	Gender BIT
)

-- here we create the trigger
CREATE TRIGGER Tr_afterInsertThomas
ON Thomas
AFTER INSERT
AS
BEGIN
	INSERT INTO ThomasHistory(ID, Fullname, Gender)
	SELECT ID, Fullname, Gender FROM inserted
	-- in above line we say that, insert the information which just has been inserted into Thomas table into ThomasHistory table.
END

SELECT * FROM Thomas
SELECT * FROM ThomasHistory

INSERT INTO Thomas (ID, Fullname, Gender) VALUES (1001, 'The nice guy', 1)

/*
Your task:
 Implement a trigger for the above table of Thomas and it should get invoked after update and delete.
 *** Recall that we have implemented these examples in class ***
*/

-- Trigger for after update
CREATE TRIGGER Tr_AfterUpdateTableThomas
On Thomas
AFTER UPDATE
AS
BEGIN
	INSERT INTO ThomasHistory(ID, Fullname, Gender)
	-- SELECT ID, Fullname, Gender FROM deleted
	-- note that the the above line can be written as below also.. they are the same thing but with different approch
	-- "SELECT d.ID, d.Fullname, d.Gender FROM deleted d" and "SELECT ID, Fullname, Gender FROM deleted" are the same
	SELECT d.ID, d.Fullname, d.Gender FROM deleted d
END

-- For after insert we call inserted
-- for after update and delte we cal deleted

-- Trigger for delete
CREATE TRIGGER Tr_afterDeleteTableThomas
ON Thomas
AFTER DELETE
AS
BEGIN
	INSERT INTO ThomasHistory(ID, Fullname, Gender) 
	SELECT upppppp.ID, upppppp.Fullname, upppppp.Gender FROM deleted upppppp
	-- here we changed the name to upppppp. So we can rename it to anything 
	-- the only thing that we have be careful is consistency which means if we chnage the name somwhere, 
	-- everywhere else we have to use the same name
END
