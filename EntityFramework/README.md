## 08. Entity Framework
### _Homework_

1.  Using the Visual Studio Entity Framework designer create a `DbContext` for the `Northwind` database.
	*	[NorthwindDb](NorthwindDb)
1.  Create a DAO class with static methods which provide functionality for inserting, modifying and deleting customers.
    *   Write a testing class.
    	*	[NorthwindDb](NorthwindDb) -> CustomersDAO, StartUp
1.  Write a method that finds all customers who have orders made in 1997 and shipped to Canada.
	*	[NorthwindDb](NorthwindDb) -> CustomersDAO, StartUp
1.  Implement previous by using native SQL query and executing it through the `DbContext`.
	*	[NorthwindDb](NorthwindDb) -> StartUp
1.  Write a method that finds all the sales by specified region and period (start / end dates).
	*	[NorthwindDb](NorthwindDb) -> StartUp
1.  Create a database called `NorthwindTwin` with the same structure as `Northwind` using the features from `DbContext`.
    *   Find for the API for schema generation in MSDN or in Google.
    	*	[NorthwindTwinDb](NorthwindTwinDb)
1.  Try to open two different data contexts and perform concurrent changes on the same records.
    *   What will happen at `SaveChanges()`?
    *   How to deal with it?
    	*	[NorthwindDb](NorthwindDb) -> StartUp
1.  By inheriting the `Employee` entity class create a class which allows employees to access their corresponding territories as property of type `EntitySet<T>`.
	*	[NorthwindDb](NorthwindDb) -> EmployeeExtended
