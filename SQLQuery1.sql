CREATE DATABASE CLASS_INFO;
USE CLASS_INFO
CREATE TABLE Sudent_Inf
(Student_ID int,
Student_Name varchar(8000),
Student_Fone bigint,
Student_Country Varchar(8000)
);
create database stf;
drop database stf;
create table Student_Inf_Constraint (
StudentID int NOT NULL,
StudentName varchar (8000) NOT NULL,
StudentPhone bigint,
StudentCountry varchar(8000)
);
create table Customer (
CustomerID bigint not null,
CustomerName varchar(8000),
CustomerFone bigint
);
insert into Student_Inf_Constraint values ('02', 'Bob', null, null);
//select + from Student_Inf_Constraint; 
//truncate table Student_Inf_Constraint;
//alter table Student_Inf_Constraint
//alter column StudentPhone bigint not null;

