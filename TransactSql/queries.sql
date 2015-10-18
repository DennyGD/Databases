--1.	Create a database with two tables: `People(Id(PK), FirstName, LastName, SSN)` and `Accounts(Id(PK), PersonId(FK), Balance)`.
--	*	Insert few records for testing.
--	*	Write a stored procedure that selects the full names of all people.
USE master

CREATE DATABASE Bank
GO

CREATE TABLE People (
	Id int IDENTITY,
	FirstName nvarchar(25) NOT NULL,
	LastName nvarchar(25) NOT NULL,
	SSN nvarchar(15),
	CONSTRAINT PK_People PRIMARY KEY (Id)
)

CREATE TABLE Accounts (
	Id int IDENTITY,
	PersonId int,
	Balance money NOT NULL,
	CONSTRAINT PK_Accounts PRIMARY KEY (Id),
	CONSTRAINT FK_Accounts_People
		FOREIGN KEY (PersonId)
		REFERENCES People(Id)
)
GO

INSERT INTO People
VALUES('Jane', 'Doe', '574989656'),
	('John', 'Doe', '527094440'),
	('William', 'Doe', '261153634')
	
INSERT INTO Accounts (PersonId, Balance)
	SELECT Id, 1000
	FROM People
GO

CREATE PROC dbo.usp_SelectFullNameOfPeople
AS
	SELECT FirstName + ' ' + LastName AS [Full Name]
	FROM People

--2. Create a stored procedure that accepts a number as a parameter and returns all people who have more money in their accounts than the supplied number.
CREATE PROC dbo.usp_PeopleHavingMoreMoney(@boundary money = 0)
AS
	SELECT p.FirstName + ' ' + p.LastName AS [Full Name]
	FROM Accounts a
	JOIN People p
	ON a.PersonId = p.Id
	WHERE Balance > @boundary

--tests
EXEC usp_PeopleHavingMoreMoney
--
EXEC usp_PeopleHavingMoreMoney 900
--3. Create a function that accepts as parameters – sum, yearly interest rate and number of months.
--	*	It should calculate and return the new sum.
--	*	Write a `SELECT` to test whether the function works as expected.
CREATE FUNCTION ufn_CalculateInterest(@sum money, @yearlyInterestRate decimal, @monthsCount int)
	RETURNS money
AS
	BEGIN
		RETURN @sum + (((@yearlyInterestRate / 12) * @monthsCount * @sum) / 100)
	END
GO

SELECT dbo.ufn_CalculateInterest(Balance, 5.3, 3)
FROM Accounts
	
--4. Create a stored procedure that uses the function from the previous example to give an interest to a person's account for one month.
--	*	It should take the `AccountId` and the interest rate as parameters.
CREATE PROC dbo.usp_AccountInterestForAMonth @accountId int, @interestRate decimal
AS
	SELECT dbo.ufn_CalculateInterest(Balance, @interestRate, 1)
	FROM Accounts
	WHERE Id = @accountId
GO

DECLARE @existantAccountId int
SET @existantAccountId = (SELECT TOP(1) Id FROM Accounts)
EXEC dbo.usp_AccountInterestForAMonth @accountId = @existantAccountId, @interestRate = 5.3

--5. Add two more stored procedures `WithdrawMoney(AccountId, money)` and `DepositMoney(AccountId, money)` that operate in transactions.
CREATE PROC dbo.usp_WithdrawMoney @accountId int, @money money
AS
	BEGIN TRAN
		UPDATE Accounts
		SET Balance = Balance - @money
		WHERE Id = @accountId

		 IF ((SELECT Balance FROM Accounts WHERE Id = @accountId) > 0)
			BEGIN
				COMMIT
			END
		ELSE
			BEGIN
				ROLLBACK
			END
GO

CREATE PROC dbo.usp_DepositMoney @accountId int, @money money
AS
	BEGIN TRAN
		UPDATE Accounts
		SET Balance = Balance + @money
		WHERE Id = @accountId
	COMMIT
--6. Create another table – `Logs(LogID, AccountID, OldSum, NewSum)`.
--	*	Add a trigger to the `Accounts` table that enters a new entry into the `Logs` table every time the sum on an account changes.
CREATE TABLE Logs(
	Id int IDENTITY,
	AccountId int,
	OldSum money,
	NewSum money,
	CONSTRAINT PK_Logs PRIMARY KEY (Id),
	CONSTRAINT FK_Logs_Accounts
		FOREIGN KEY (AccountId)
		REFERENCES Accounts(Id)
)
GO

CREATE TRIGGER tr_AccountsAfterUpdate ON Accounts
AFTER UPDATE
AS
	INSERT INTO Logs(AccountId, OldSum, NewSum)
		SELECT i.Id, d.Balance, i.Balance
		FROM inserted i, deleted d
GO

--testing the update trigger
UPDATE Accounts
SET Balance = 1500
WHERE Id = 
	(SELECT MIN(Id) FROM Accounts)

--7. Define a function in the database `TelerikAcademy` that returns all Employee's names (first or middle or last name) and all town's names that are comprised of given set of letters.
--	*	_Example_: '`oistmiahf`' will return '`Sofia`', '`Smith`', … but not '`Rob`' and '`Guy`'.
CREATE FUNCTION ufn_StringIsBuiltOnlyBySet(@charSet nvarchar(30), @stringToCheck nvarchar(50))
	RETURNS bit
AS
	BEGIN
		DECLARE @stringLen tinyint
		SET @stringLen = LEN(@stringToCheck)

		DECLARE @index int
		SET @index = 1

		DECLARE @currentChar nchar(1)

		WHILE @index <= @stringLen
		BEGIN
			SET @currentChar = (SUBSTRING(@stringToCheck, @index, 1))
			IF(CHARINDEX(@currentChar, @charSet) < 1)
			BEGIN
				RETURN 0
			END
			SET @index += 1
		END
		
		RETURN 1
	END
GO

CREATE FUNCTION ufn_GetEmployeesNamesAndTownsByCharSet(@set nvarchar(30))
RETURNS @results TABLE
	(
		Name nvarchar(50)
	)
AS
	BEGIN
		INSERT @results
			SELECT *
			FROM (SELECT FirstName FROM Employees
				UNION
				SELECT LastName FROM Employees
				UNION
				SELECT MiddleName FROM Employees
					WHERE MiddleName IS NOT NULL
				UNION
				SELECT Name FROM Towns) AS #temporaryTable(Name)
			WHERE dbo.ufn_StringIsBuiltOnlyBySet(@set, Name) = 1
		RETURN
	END
GO

--testing
SELECT *
FROM dbo.ufn_GetEmployeesNamesAndTownsByCharSet('algcyr')