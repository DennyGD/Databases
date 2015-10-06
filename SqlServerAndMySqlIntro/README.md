## SQL Server and MySQL - Introduction
### _Homework_

1.	Download and install SQL Server Express. Install also SQL Server Management Studio Express (this could take some effort but be persistent).
	*	Obviously, it's installed since the other assignements are completed.
1.	Connect to the SQL Server with SQL Server Management Studio
	*	Use Windows authentication.
	
	[login screenshot](screenshots/login.png)
1.	Create a new database `Pubs` and create new login with permissions to connect to it. Execute the script `install_pubs.sql` to populate the DB contents (you may need slightly to edit the script before).
	*	[pubs creation](screenshots/pubs-creation.png)
	*	[new login](screenshots/new-login.png)
1.	Attach the database `Northwind` (use the files `Northwind.mdf` and `Northwind.ldf`) to SQL Server and connect to it.
	* [Northwind attach](screenshots/attach-northwind.png)
1.	Backup the database `Northwind` into a file named `northwind-backup.bak` and restore it as database named `North`.
	*	[Northwind backup](screenshots/backup-northwind.png)
	*	[Nothwind backup completed](screenshots/backup-northwind-success.png)
	*	[Northwind restore - locate .bak file](screenshots/restore-north-locate-file.png)
	*	[Northwind restored as North](screenshots/restore-north-success.png)
1.	Export the entire `Northwind` database as SQL script
	*	Use `[Tasks]` > `[Generate Scripts]`
	*	Ensure you have exported table data rows (not only the schema).
		*	[Northwind as script - object selection](screenshots/northwind-as-script-objects-selection.png)
		*	[Northwind as script - select schema and data](screenshots/northwind-as-script-schema-and-data.png)
		*	[Northwind as script completed](screenshots/northwind-as-script-finish.png)
1.	Create a database NW and execute the script in it to create the database and populate table data.
	*	[NW creation](screenshots/nw-new-db.png)
	*	[NW populated](screenshots/nw-populated.png)
1.	Detatch the database NW and attach it on another computer in the training lab
	*	In case of name collision, preliminary rename the database.
		*	[NW detach](screenshots/nw-detach.png)
		*	[NW attach](screenshots/nw-attach.png)
1.	Download and install MySQL Community Server  + MySQL Workbench + the sample databases.
	*	[MySQL installed](screenshots/mysql-installation-completed.png)
1.	Export the MySQL sample database "`world`" as SQL script.
	*	[world export](screenshots/world-as-script-export.png)
1.	Modify the script and execute it to restore the database world as "`worldNew`".
	*	[worldNew import](screenshots/worldNew-import.png)
	*	[worldNew import1](screenshots/worldNew-import1.png)
1.	Connect through the MySQL console client and list the first 20 cities from the database "`worldNew`".
	*	[Top 20 cities](screenshots/worldNew-cities-selection.png)

#### As a result of your homework provide screenshots