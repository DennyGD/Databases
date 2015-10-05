## Database Systems - Overview
### _Homework_

#### Answer the following questions in Markdown format (`.md` file)

1.  What database models do you know?
	*	Hierarchical - organizes data in a tree structure;
	*	Network - expands upon the hierarchical structure, allowing many-to-many relationships;
	*	Relational - the data and relations between them are organised in tables;
	*	Object/Relational - adds new object storage capabilities to the relational systems;
	*	Object-Oriented - defines a database as a collection of objects with features and methods;
	*	etc.
1.  Which are the main functions performed by a Relational Database Management System (RDBMS)?
	*	Creating / altering / deleting tables and relationships between them (database schema);
	*	Adding, changing, deleting, searching and retrieving of data stored in the tables;
	*	Support for the SQL language;
	*	Transaction management (optional);
1.  Define what is "table" in database terms.
	*	A table is a collection of records and each record in a table contains the same fields.
	*	Main features:
		*	values are atomic;
		*	each row is unique;
		*	column values are of the same kind;
		*	the sequence of columns is insignificant;
		*	each column has a unique name.
1.  Explain the difference between a primary and a foreign key.
	*	The primary key is a unique identifier of a record. It is a column that uniquely identifies its rows. Actually, it could be composed of several columns and in this case, it is called a composite primary key.
	*	The foreign key is a reference to a column(or columns) in another table. Usually, the refernce is to that other table's primary key.
1.  Explain the different kinds of relationships between tables in relational databases.
	*	One-to-one - each primary key value relates to only one (or no) record in the related table.
	*	One-to-many - the primary key table contains only one record that relates to none, one, or many records in the related table.
	*	Many-to-many - each record in both tables can relate to any number of records (or no records) in the other table. To define such a relationship, a third table is needed.
1.  When is a certain database schema normalized?
  * What are the advantages of normalized databases?
  
	*	Normalization is a systematic approach of decomposing tables to eliminate data redundancy. It eliminates useless data and ensures that data dependencies make sense.
	*	When a database is normalized, it is easy to insert, update and delete attributes, while avoiding unwanted data loss.
1.  What are database integrity constraints and when are they used?
	*	Integrity constraints provide a way of ensuring that changes made to the database by authorized users do not result in a loss of data consistency.
	*	They are used whenever certain rules concerning the data must be enforced.
1.  Point out the pros and cons of using indices in a database.
	*	Usind indices speeds up search but insert and delete remain slow operations. It might be a good idea to use them in big tables only (50 000 rows and more).
1.  What's the main purpose of the SQL language?
	*	Its main purpose is to manage data held in a relational database management system.
1.  What are transactions used for?
  * Give an example.
  
	*	They are a sequence of database operations which are executed as a single unit - either all of them execute successfully or none of them is executed at all. Therefore, transactions guarantee the consistency and the integrity of the database.
	*	A classical example is money transfer. In this case, a transaction makes sure that there is enough money in the account and that, once withdrawn, it will reach its final destination (e.g. another bank account).
1.  What is a NoSQL database?
	*	It provides a mechanism for storage and retrieval of data that is modeled in means other than the tabular relations used in relational databases.
1.  Explain the classical non-relational data models.
	*	The data structures used by NoSQL databases (e.g. key-value, graph, or document) differ slightly from those used by default in relational databases, making some operations faster in NoSQL and others faster in relational databases. 
		*	Key-value - uses associative arrays to store, retrieve and manage data;
		*	Document-oriented - uses document-oriented information, a.k.a semi-structured data. These databases get their type information from the data itself, normally store all related information together, and allow every instance of data to be different from any other.
		*	Graph - based on graph theory. They use nodes, properties and edges.
		*	etc.
1.  Give few examples of NoSQL databases and their pros and cons.
	*	MongoDB - mMature and powerful JSON-document database. Suitable for dynamic queries, defining indices, frequently changing data.
	*	CouchDB - JSON-based document database with REST API. Suitable for accumulating, occasionally changing data, on which pre-defined queries are to be run.
	*	Cassandra - distributed wide-column database. Suitable for storing huge data.
	*	Redis - fast. Suitable for rapidly changing data with a foreseeable database size (should fit mostly in memory). 

More information: [NoSql databases comparison](http://kkovacs.eu/cassandra-vs-mongodb-vs-couchdb-vs-redis)

