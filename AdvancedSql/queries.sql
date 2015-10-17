USE TelerikAcademy

--1. Find the names and salaries of the employees that take the minimal salary in the company.
--	*	Use a nested `SELECT` statement.
SELECT FirstName + ' ' + LastName AS [Full Name], Salary
FROM Employees
	WHERE Salary =
	(SELECT MIN(Salary) FROM Employees)
	
--2. Find the names and salaries of the employees that have a salary that is up to 10% higher than the minimal salary for the company.
SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name], Salary
FROM Employees
	WHERE Salary <=
	(SELECT ((MIN(Salary) * 0.1) + MIN(Salary)) FROM Employees)
	
--3. Find the full name, salary and department of the employees that take the minimal salary in their department.
--	*	Use a nested `SELECT` statement.
SELECT e.FirstName + ' ' + e.MiddleName + ' ' + e.LastName AS [Full Name], e.Salary, d.Name
FROM Employees e
INNER JOIN Departments d
	ON e.DepartmentId = d.DepartmentId
WHERE e.Salary = 
	(SELECT MIN(Salary) FROM Employees)

--4. Find the average salary in the department #1.
SELECT AVG(Salary)
FROM Employees
WHERE DepartmentID = 1

--5. Find the average salary  in the "Sales" department.
SELECT AVG(Salary)
FROM Employees e
	JOIN Departments d
	ON e.DepartmentID = d.DepartmentID AND d.Name = 'Sales'
	
--6. Find the number of employees in the "Sales" department.
SELECT COUNT(*)
FROM Employees e
	JOIN Departments d
	ON e.DepartmentID = d.DepartmentID AND d.Name = 'Sales'
	
--7. Find the number of all employees that have manager.
SELECT COUNT(ManagerID)
FROM Employees

--8. Find the number of all employees that have no manager.
SELECT COUNT(*) - COUNT(ManagerID)
FROM Employees

	--another option
SELECT COUNT(*)
FROM Employees
WHERE ManagerID IS NULL

--9. Find all departments and the average salary for each of them.
SELECT AVG(Salary) AS [Average Salary], d.Name AS [Department Name]
FROM Employees e
	JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name

--10. Find the count of all employees in each department and for each town.
SELECT COUNT(*) AS [Employees], d.Name AS [Department], t.Name AS [Town]
FROM Employees e
	JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
	JOIN Addresses a
	ON e.AddressID = a.AddressID
	JOIN Towns t
	ON a.TownID = t.TownID
GROUP BY d.Name, t.Name
ORDER BY d.Name

--11. Find all managers that have exactly 5 employees. Display their first name and last name.
SELECT m.FirstName, m.LastName, COUNT(e.ManagerID) AS [Employees Count]
FROM Employees e
	JOIN Employees m
	ON m.EmployeeID = e.ManagerID
GROUP BY m.FirstName, m.LastName
HAVING COUNT(e.ManagerID) = 5

--12. Find all employees along with their managers. For employees that do not have manager display the value "(no manager)".
SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], 
	 COALESCE(m.FirstName + ' ' + m.LastName, 'No Manager')
FROM Employees e
LEFT OUTER JOIN Employees m
ON e.ManagerID = m.EmployeeID

--13. Find the names of all employees whose last name is exactly 5 characters long. Use the built-in `LEN(str)` function.
SELECT FirstName AS [First Name], LastName AS [Last Name]
FROM Employees
WHERE LEN(LastName) = 5

--14. Display the current date and time in the following format "`day.month.year hour:minutes:seconds:milliseconds`".
SELECT CONVERT(VARCHAR(24),GETDATE(),113)

--https://robbamforth.wordpress.com/2010/06/11/sql-date-formats-getdate-examples/

--15. Write a SQL statement to create a table `Users`. Users should have username, password, full name and last login time.
--	*	Choose appropriate data types for the table fields. Define a primary key column with a primary key constraint.
--	*	Define the primary key column as identity to facilitate inserting records.
--	*	Define unique constraint to avoid repeating usernames.
--	*	Define a check constraint to ensure the password is at least 5 characters long.
CREATE TABLE Users (
	Id int IDENTITY,
	Username nvarchar(20) NOT NULL,
	UserPass nvarchar(40) NOT NULL,
	FullName nvarchar(50) NOT NULL,
	LastLogin datetime DEFAULT GETDATE(),
	CONSTRAINT PK_Users PRIMARY KEY (Id),
	CONSTRAINT UK_Users_Username UNIQUE (Username)
)
GO
ALTER TABLE Users
ADD CHECK (DATALENGTH(UserPass)>=5)

--16. Create a view that displays the users from the `Users` table that have been in the system today.
USE TelerikAcademy
GO
CREATE VIEW [Users_Today]
AS 
SELECT Username, FullName
FROM TelerikAcademy.dbo.Users
WHERE CAST(LastLogin AS DATE) = CAST(GETDATE() AS DATE)
GO

--17. Create a table `Groups`. Groups should have unique name (use unique constraint).
--	*	Define primary key and identity column.
CREATE TABLE Groups (
	Id int IDENTITY,
	Name nvarchar(100) NOT NULL,
	CONSTRAINT PK_Groups PRIMARY KEY (Id),
	CONSTRAINT UK_Groups_Name UNIQUE (Name)
)

--18. Write a SQL statement to add a column `GroupID` to the table `Users`.
--	*	Fill some data in this new column and as well in the `Groups table.
--	*	Write a SQL statement to add a foreign key constraint between tables `Users` and `Groups` tables.
USE TelerikAcademy
GO
ALTER TABLE Users
ADD GroupId int
GO

INSERT INTO Groups
VALUES ('HTML'),
	('CSharp')
GO

ALTER TABLE Users
ADD CONSTRAINT FK_Users_Groups
	FOREIGN KEY (GroupId)
	REFERENCES Groups(Id)
GO

--19. Insert several records in the `Users` and `Groups` tables.
INSERT INTO Groups
VALUES ('Databases'),
	('HQC')
GO

INSERT INTO Users (Username, UserPass, FullName, GroupId)
VALUES ('JaneyDoe', '123456', 'Janey Doe', (SELECT Id FROM Groups WHERE Name = 'Databases'))

--20. Update some of the records in the `Users` and `Groups` tables.
UPDATE Users
SET FullName = 'Jen Doe'
WHERE FullName = 'Janey Doe'
GO

UPDATE Groups
SET Name = 'High Quality Code'
WHERE Name = 'HQC'

--21. Delete some of the records from the `Users` and `Groups` tables.
DELETE FROM Users
WHERE FullName = 'Jen Doe'
GO

DELETE TOP (1) FROM Groups

--22. Write SQL statements to insert in the `Users` table the names of all employees from the `Employees` table.
--	*	Combine the first and last names as a full name.
--	*	For username use the first letter of the first name + the last name (in lowercase).
--	*	Use the same for the password, and `NULL` for last login time.
INSERT INTO Users (Username, UserPass, FullName, LastLogin)
SELECT LOWER(SUBSTRING(FirstName, 1, 3) + LastName),
	LOWER(SUBSTRING(FirstName, 1, 3) + LastName),
	FirstName + ' ' + LastName,
	NULL
FROM Employees

--takes 3 chars from FirstName because of Unique key constraint for Username in dbo.Users

--23. Write a SQL statement that changes the password to `NULL` for all users that have not been in the system since 10.03.2010.
	
	--dbo.Users contains only employees at this moment and they have been added with LastLogin as NULL (task 22). This is why some of the users are updated
	-- first.
	UPDATE TOP (10) Users
	SET LastLogin = CURRENT_TIMESTAMP
	GO

	-- Because of task 15, there is a constraint concerning passwords and they cannot be NULL. Now, it is going to be removed.
	ALTER TABLE Users
	ALTER COLUMN UserPass nvarchar(40) NULL
	
	--
	UPDATE Users
	SET UserPass = NULL
	WHERE CAST(LastLogin AS DATE) > CAST('20100310 00:00:00.000' AS DATE)

--24. Write a SQL statement that deletes all users without passwords (`NULL` password).
DELETE FROM Users
WHERE UserPass IS NULL

--25. Display the average employee salary by department and job title.
SELECT d.Name AS [Department], e.JobTitle, AVG(Salary) AS [Average Salary For Occupation]
	FROM Employees e
	JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name, e.JobTitle
ORDER BY e.JobTitle

--26. Display the minimal employee salary by department and job title along with the name of some of the employees that take it.
SELECT d.Name, 
	e.JobTitle, 
	MIN(e.Salary) AS [Min Salary For Occupation],
	MIN(CONCAT(e.FirstName, ' ', e.LastName)) AS [Some Employee Name]
FROM Employees e
	JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name, e.JobTitle

--27. Display the town where maximal number of employees work.
SELECT TOP (1) COUNT(*) AS [Employees Count], 
	t.Name AS [Town]
FROM Employees e
	JOIN Addresses a
	ON e.AddressID = a.AddressID
	JOIN Towns t
	ON a.TownID = t.TownID
GROUP BY t.Name
ORDER BY COUNT(e.EmployeeID) DESC

--28. Display the number of managers from each town.
SELECT t.Name AS [Town], 
	COUNT(DISTINCT e.ManagerID) AS [Managers Count]
FROM Employees e
	JOIN Employees m
	ON e.ManagerID = m.EmployeeID
	JOIN Addresses a
	ON m.AddressID = a.AddressID
	JOIN Towns t
	ON a.TownID = t.TownID
GROUP BY t.Name
ORDER BY [Managers Count]

--29. Write a SQL to create table `WorkHours` to store work reports for each employee (employee id, date, task, hours, comments).
--	*	Don't forget to define  identity, primary key and appropriate foreign key. 
--	*	Issue few SQL statements to insert, update and delete of some data in the table.
--	*	Define a table `WorkHoursLogs` to track all changes in the `WorkHours` table with triggers.
--		*	For each change keep the old record data, the new record data and the command (insert / update / delete).
USE TelerikAcademy
GO
CREATE TABLE WorkHours (
	Id int IDENTITY,
	EmployeeId int NOT NULL UNIQUE,
	ReportDate datetime DEFAULT GETDATE(),
	Task nvarchar(250) NOT NULL,
	Hours int NOT NULL,
	Comments nvarchar(500),
	CONSTRAINT PK_WorkHours PRIMARY KEY (Id),
	CONSTRAINT FK_WorkHours_Employees
		FOREIGN KEY	(EmployeeId)
		REFERENCES Employees(EmployeeId)
)
GO

CREATE TABLE WorkHoursLogs (
	Id int IDENTITY,
	Command nvarchar(15) NOT NULL,
	EmployeeId int NOT NULL,
	ReportDateOld datetime,
	TaskOld nvarchar(250) NOT NULL,
	HoursOld int NOT NULL,
	CommentsOld nvarchar(500),
	ReportDateNew datetime,
	TaskNew nvarchar(250),
	HoursNew int,
	CommentsNew nvarchar(500),
	CONSTRAINT PK_WorkHoursLogs PRIMARY KEY (Id)
)
GO

CREATE TRIGGER tr_WorkHoursInsert ON WorkHours FOR INSERT
AS
	INSERT INTO WorkHoursLogs (Command, EmployeeId, ReportDateOld, TaskOld, HoursOld, CommentsOld)
	VALUES(
		'insert',
		(SELECT EmployeeId FROM inserted),
		(SELECT ReportDate FROM inserted),
		(SELECT Task FROM inserted),
		(SELECT [Hours] FROM inserted),
		(SELECT Comments FROM inserted)
	)
GO

--testing the insert trigger
INSERT INTO WorkHours
VALUES(
	(SELECT TOP (1) EmployeeId FROM Employees),
	GETDATE(),
	'Some task',
	2,
	'No comment'
)
GO

CREATE TRIGGER tr_WorkHoursUpdate ON WorkHours
AFTER UPDATE
AS 
	UPDATE WorkHoursLogs
	SET Command = 'update',
		ReportDateOld = d.ReportDate,
		TaskOld = d.Task,
		HoursOld = d.[Hours],
		CommentsOld = d.Comments,
		ReportDateNew = i.ReportDate,
		TaskNew = i.Task,
		HoursNew = i.[Hours],
		CommentsNew = i.Comments
	FROM WorkHoursLogs w
	JOIN deleted d
	ON w.EmployeeId = d.EmployeeId
	JOIN inserted i
	ON w.EmployeeId = i.EmployeeId	
GO

--testing the update trigger
UPDATE TOP(1) WorkHours
SET ReportDate = GETDATE(),
	Task = 'Another task',
	[Hours] = 6,
	Comments = 'dsfsdgsdgsdfgsdfsd'
GO

CREATE TRIGGER tr_WorkHoursDelete ON WorkHours
AFTER DELETE
AS
	UPDATE WorkHoursLogs
	SET Command = 'delete',
		ReportDateOld = d.ReportDate,
		TaskOld = d.Task,
		HoursOld = d.[Hours],
		CommentsOld = d.Comments,
		ReportDateNew = NULL,
		TaskNew = NULL,
		HoursNew = NULL,
		CommentsNew = NULL
	FROM WorkHoursLogs w
	JOIN deleted d
	ON w.EmployeeId = d.EmployeeId
GO	

--testing the insert trigger again
INSERT INTO WorkHours
VALUES(
	(SELECT TOP (1) EmployeeId FROM Employees ORDER BY LastName),
	GETDATE(),
	'Testing',
	1,
	'Is it working?'
)
GO

--testing the delete trigger
DELETE 
FROM WorkHours
WHERE EmployeeId = 
	(SELECT MIN(EmployeeId) FROM WorkHours)
--30.	Start a database transaction, delete all employees from the '`Sales`' department along with all dependent records from the other tables.
--	*	At the end rollback the transaction.
BEGIN TRANSACTION

	ALTER TABLE Employees
		DROP FK_Employees_Departments

	ALTER TABLE Departments
		DROP FK_Departments_Employees

	ALTER TABLE Employees
		DROP FK_Employees_Employees

	ALTER TABLE WorkHours
		DROP FK_WorkHours_Employees

	DELETE 
	FROM Employees
	WHERE EmployeeID = 
		(SELECT ManagerID FROM Departments WHERE Name = 'Sales')

	DELETE 
	FROM Employees	
	WHERE DepartmentID = 
		(SELECT DepartmentID FROM Departments 
		WHERE Name = 'Sales')

	DELETE 
	FROM Departments
	WHERE Name = 'Sales'

ROLLBACK TRANSACTION

--31.	Start a database transaction and drop the table `EmployeesProjects`.
--	*	Now how you could restore back the lost table data?
BEGIN TRANSACTION
	DROP TABLE EmployeesProjects
ROLLBACK TRANSACTION

--32.	Find how to use temporary tables in SQL Server.
--	*	Using temporary tables backup all records from `EmployeesProjects` and restore them back after dropping and re-creating the table.
SELECT *
INTO #TempEmployeesProjects
FROM EmployeesProjects

DROP TABLE EmployeesProjects

SELECT *
INTO EmployeesProjects
FROM #TempEmployeesProjects

DROP TABLE #TempEmployeesProjects