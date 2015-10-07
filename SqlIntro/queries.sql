USE TelerikAcademy

--4. Find all information about all departments.
SELECT * FROM Departments

--5. Find all department names.
SELECT DepartmentID, Name
FROM Departments

--6. Find the salary of each employee.
SELECT EmployeeID, FirstName, LastName, Salary
FROM Employees

--7. Find the full name of each employee.
SELECT EmployeeID, FirstName + ' ' + LastName AS [Full Name]
FROM Employees

--8. Find the email addresses of each employee (by his first and last name). Consider that the mail domain is telerik.com. 
--Emails should look like “John.Doe@telerik.com". The produced column should be named "Full Email Addresses".
SELECT EmployeeID, FirstName + '.' + LastName + '@telerik.com' AS [Full Email Address]
FROM Employees

--9. Find all different employee salaries.
SELECT DISTINCT Salary
FROM Employees

--10. Find all information about the employees whose job title is “Sales Representative“.
SELECT *
FROM Employees
WHERE JobTitle = 'Sales Representative'

--11. Find the names of all employees whose first name starts with "SA".
SELECT FirstName
FROM Employees
WHERE FirstName LIKE 'SA%'

--12. Find the names of all employees whose last name contains "ei".
SELECT LastName
FROM Employees
WHERE LastName LIKE '%ei%'

--13. Find the salary of all employees whose salary is in the range [20000…30000].
SELECT FirstName + ' ' + LastName AS [Full Name], Salary
FROM Employees
WHERE Salary BETWEEN 20000 AND 30000

--14. Find the names of all employees whose salary is 25000, 14000, 12500 or 23600.
SELECT FirstName + ' ' + LastName AS [Full Name], Salary
FROM Employees
WHERE Salary = 25000 OR Salary = 14000 OR Salary = 12500 OR Salary = 23600

--15. Find all employees that do not have manager.
SELECT FirstName + ' ' + LastName AS [Full Name]
FROM Employees
WHERE ManagerID IS NULL

--16. Find all employees that have salary more than 50000. Order them in decreasing order by salary.
SELECT FirstName + ' ' + LastName AS [Full Name], Salary
FROM Employees
WHERE Salary > 50000
ORDER BY Salary DESC

--17. Find the top 5 best paid employees.
SELECT TOP 5 FirstName + ' ' + LastName AS [Full Name], Salary
FROM Employees
ORDER BY Salary DESC

--18. Find all employees along with their address. Use inner join with ON clause.
SELECT e.FirstName, e.LastName, a.AddressText
FROM Employees e
	INNER JOIN Addresses a
	ON e.AddressID = a.AddressID

--19. Find all employees and their address. Use equijoins (conditions in the WHERE clause).
SELECT e.FirstName, e.LastName, a.AddressText
FROM Employees e, Addresses a
WHERE e.AddressID = a.AddressID

--20. Find all employees along with their manager.
SELECT e.FirstName, e.LastName, m.FirstName + ' ' + m.LastName AS [Manager Name]
FROM Employees e
	INNER JOIN Employees m
	ON e.ManagerID = m.EmployeeID

--21. Find all employees, along with their manager and their address. Join the 3 tables: Employees e, Employees m and Addresses a.
SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], 
	m.FirstName + ' ' + m.LastName AS [Manager Name],
	a.AddressText AS [Address]
FROM Employees e
	JOIN Employees m
	ON e.ManagerID = m.EmployeeID
	JOIN Addresses a
	ON e.AddressID = a.AddressID
	ORDER BY m.FirstName

--22. Find all departments and all town names as a single list. Use UNION.
SELECT Name
FROM Departments
UNION
SELECT Name
FROM Towns

--23. Find all the employees and the manager for each of them along with the employees that do not have manager. Use right outer join. 
SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], 
	m.FirstName + ' ' + m.LastName AS [Manager Name]
FROM Employees m
	RIGHT OUTER JOIN Employees e
	ON e.ManagerID =  m.EmployeeID

	--Rewrite the query to use left outer join.
SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], 
	m.FirstName + ' ' + m.LastName AS [Manager Name]
FROM Employees e
	LEFT OUTER JOIN Employees m
	ON e.ManagerID =  m.EmployeeID
	
--24. Find the names of all employees from the departments "Sales" and "Finance" whose hire year is between 1995 and 2005.
SELECT e.FirstName,  e.LastName, e.HireDate, d.Name AS [Department]
FROM Employees e
	JOIN Departments d
	ON (e.DepartmentID = d.DepartmentID
		AND (d.Name = 'Sales' OR d.Name = 'Finance')
		AND (e.HireDate BETWEEN '1995/01/01' AND '2005/12/31'))
		
	--another option	
SELECT e.FirstName,  e.LastName, e.HireDate, d.Name AS [Department]
FROM Employees e
	JOIN Departments d
	ON (e.DepartmentID = d.DepartmentID
		AND (d.Name = 'Sales' OR d.Name = 'Finance')
		AND (YEAR(e.HireDate) BETWEEN 1995 AND 2005)) 
		
	--another option
SELECT e.FirstName,  e.LastName, e.HireDate, d.Name AS [Department]
FROM Employees e
	JOIN Departments d
	ON (e.DepartmentID = d.DepartmentID
		AND (d.Name = 'Sales' OR d.Name = 'Finance')
		AND (DATEPART(YEAR, e.HireDate) BETWEEN 1995 AND 2005))
  ORDER BY e.FirstName ASC, e.LastName ASC