-- connect to database;
connect to db4ad3;
--++++++++++++++++++++++++++++++++++++++++++++++
-- CREATE TABLES 
--++++++++++++++++++++++++++++++++++++++++++++++


------------------------------------------------
--  DDL Statements for table ProductCategory 
------------------------------------------------
create table ProductCategory(
	ID integer not null,
	name varchar(50),
	primary key (ID)
);


------------------------------------------------
--  DDL Statements for table ProductSubcategory 
------------------------------------------------
create table ProductSubcategory(
	ID integer not null,
	name varchar(50),
	description varchar(50),
	primary key (ID)
);

------------------------------------------------
--  DDL Statements for table Warranty 
------------------------------------------------
create table Warranty (
	ID integer not null,
	type varchar(10) NOT NULL CHECK (type IN ('Standard','Extended')),
	warrantyDuration integer,
	primary key (ID)
);

------------------------------------------------
--  DDL Statements for table Product 
------------------------------------------------
create table Product(
	ID integer not null,
	modelNumber varchar(50),
	name varchar (2000),
	description varchar (2000),
	price real,
	primary key (ID)
);

------------------------------------------------
--  DDL Statements for table Warranty 
------------------------------------------------
create table With (
	productID integer not null,
	warrantyID integer not null,
	primary key (productID, warrantyID),
	foreign key (productID) references Product (ID) on delete cascade,
	foreign key (warrantyID) references Warranty (ID) on delete cascade 
);


------------------------------------------------
--  DDL Statements for table Vendor 
------------------------------------------------
create table Vendor(
	ID integer not null,
	name varchar (100),
	street varchar (100),
	city varchar (100),
	postalCode varchar (50),
	telephoneNumber varchar (50),
	email varchar (50),
	primary key (ID)
);


------------------------------------------------
--  DDL Statements for table Passcard 
------------------------------------------------
create table Passcard(
	serialID integer not null,
	balance real check (balance >= 0),
	reloadDate Date,
	primary key (serialID)
);


------------------------------------------------
--  DDL Statements for table Person 
------------------------------------------------
create table Person(
	ID integer not null,
	lastname varchar (50),
	firstname varchar (50),
	telephoneNumber varchar(50),
	street varchar (100),
	city varchar (50),
	postalCode varchar (50),
	gender char(1) NOT NULL CHECK (gender IN ('M','F')),
	dateOfBirth date,
	email varchar (100),
	primary key (ID)
);

------------------------------------------------
--  DDL Statements for table Attendee 
------------------------------------------------
create table Attendee(
	ID integer not null references Person (ID) on delete cascade,
	initialLoadAmount real,
	loyaltyYears integer,
	primary key (ID)
);


------------------------------------------------
--  DDL Statements for table vendorRepresentative 
------------------------------------------------
create table VendorRepresentative(
	ID integer not null references Person (ID) on delete cascade,
	vendorID integer not null,
	primary key (ID),
	foreign key (vendorID) references Vendor (ID) on delete cascade
);
------------------------------------------------
--  DDL Statements for table keynoteSpeaker 
------------------------------------------------
create table KeynoteSpeaker(
	ID integer not null references Person (ID) on delete cascade,
	jobTitle varchar (30),
	affiliation varchar (40),
	keynoteTitle varchar (40),
	areaOfExpertise varchar (30),
	primary key (ID)
);


------------------------------------------------
--  DDL Statements for table ProductBelongToSubcategory 
------------------------------------------------
create table ProductBelongToSubcategory(
	productID integer not null,
	productSubcategoryID integer not null,
	primary key (productID, productSubcategoryID),
	foreign key (productID) references Product (ID) on delete cascade,
	foreign key (productSubcategoryID) references ProductSubcategory (ID) on delete cascade
);

------------------------------------------------
--  DDL Statements for table Sell 
------------------------------------------------
create table Sell(
	vendorID integer not null,
	productID integer not null,
	primary key (vendorID, productID),
	foreign key (productID) references Product (ID) on delete cascade,
	foreign key (vendorID) references Vendor (ID) on delete cascade
);

------------------------------------------------
--  DDL Statements for table Has 
------------------------------------------------
create table Has(
	attendeeID integer not null,
	passcardID integer not null,
	primary key (attendeeID, passcardID),
	foreign key (attendeeID) references Attendee (ID) on delete cascade,
	foreign key (passcardID) references Passcard (serialID) on delete cascade
);

------------------------------------------------
--  DDL Statements for table Talk 
------------------------------------------------
create table Talk(
	 vendorRepresentativeID integer not null,
	 attendeeID integer not null,
	 primary key (vendorRepresentativeID, attendeeID),
	 foreign key (vendorRepresentativeID) references VendorRepresentative (ID) on delete cascade,
	 foreign key (attendeeID) references Attendee (ID) on delete cascade
);

------------------------------------------------
--  DDL Statements for table CategoryContainSubcategory 
------------------------------------------------
create table CategoryContainSubcategory(
	productCategoryID integer not null,
	productSubcategoryID integer not null,
	primary key (productCategoryID, productSubcategoryID),
	foreign key (productCategoryID) references ProductCategory (ID) on delete cascade,
	foreign key (productSubcategoryID) references ProductSubcategory (ID) on delete cascade
);

------------------------------------------------
--  DDL Statements for table Transaction 
------------------------------------------------
create table Transaction(
	transactionID integer not null,
	productID integer not null,
	vendorID integer not null,
	attendeeID integer not null,
	quantity integer, 
	amount real,
	time time,
	date date,
	paymentMethod varchar (20),
	primary key (productID, vendorID,attendeeID),
	foreign key (productID) references Product (ID) on delete cascade,
	foreign key (vendorID) references Vendor (ID) on delete cascade,
	foreign key (attendeeID) references Attendee (ID) on delete cascade
);

------------------------------------------------
--  DDL Statements for table ListenTo 
------------------------------------------------
create table ListenTo(
	attendeeID integer not null references Attendee (ID) on delete cascade,
	keynoteSpeakerID integer not null references KeynoteSpeaker (ID) on delete cascade,
	primary key (attendeeID, keynoteSpeakerID)
);

------------------------------------------------
--  DDL Statements for table ProductTrial 
------------------------------------------------
create table ProductTrial(
	productID integer not null,
	attendeeID integer not null,
	minutesTried integer not null,
	primary key (productID, attendeeID),
	foreign key (productID) references Product (ID) on delete cascade,
	foreign key (attendeeID) references Attendee (ID) on delete cascade
);

list tables;

