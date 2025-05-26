USE JobPortalDB

-- CREATE GENDER MASTER TABLE --
CREATE TABLE GenderMaster (
	id INT IDENTITY(1,1),
	code VARCHAR(30),
	value VARCHAR(50)
);

-- CREATE SALUTATION MASTER TABLE --
CREATE TABLE SalutationMaster (
	id INT IDENTITY(1,1),
	code VARCHAR(30),
	value VARCHAR(50)
);


-- CREATE INTEREST MASTER TABLE --
CREATE TABLE InterestsMaster (
	id INT IDENTITY(1,1),
	code VARCHAR(100),
	value VARCHAR(100)
);

-- CREATE CREDENTIAL MASTER TABLE --
CREATE TABLE CredentialMaster (
	id INT IDENTITY(1,1),
	value VARCHAR(100)
);

-- CREATE ADDRESS TYPE MASTER TABLE --
CREATE TABLE AddressTypeMaster (
	id INT IDENTITY(1,1),
	value VARCHAR(100)
);


-- CREATE COUNTRY MASTER TABLE --
CREATE TABLE CountryMaster (
    id INT PRIMARY KEY IDENTITY(1,1),
    code VARCHAR(20) NOT NULL UNIQUE,
    value VARCHAR(100) NOT NULL
);

-- DROP TABLE CountryMaster;

-- CREATE STATE MASTER TABLE --
CREATE TABLE StateMaster (
    id INT PRIMARY KEY IDENTITY(1,1),
    code VARCHAR(20) NOT NULL UNIQUE, 
    value VARCHAR(100) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES CountryMaster(id) 
        ON DELETE CASCADE  
);

-- DROP TABLE StateMaster;

-- CREATE CITY MASTER TABLE --
CREATE TABLE CityMaster (
    id INT PRIMARY KEY Identity(1,1),
    code VARCHAR(20) NOT NULL UNIQUE, 
    value VARCHAR(100) NOT NULL,
    state_id INT NOT NULL,
    country_id INT NOT NULL, 
    FOREIGN KEY (state_id) REFERENCES StateMaster(id) 
        ON DELETE CASCADE,
    FOREIGN KEY (country_id) REFERENCES CountryMaster(id) 
        ON DELETE NO ACTION
);

-- DROP TABLE CityMaster;


-- INSERT GENDER MASTER TABLE --
INSERT INTO GenderMaster (code, value)
VALUES 
    ('M', 'Male'),
    ('F', 'Female'),
    ('Other', 'Other');

-- INSERT VALUES INTO SALUTATION MASTER TABLE --
INSERT INTO SalutationMaster (code, value)
VALUES 
    ('Mr.', 'Mister'),
    ('Mrs.', 'Mistress'),
    ('Dr.', 'Doctor'),
    ('Er.', 'Engineer'),
    ('Jr.', 'Junior'),
    ('Sr.', 'Senior');


-- INSERT VALUES INTO INTEREST MASTER TABLE --
INSERT INTO InterestsMaster (code, value)
VALUES
	('music', 'Music'),
    ('sports', 'Sports'),
    ('reading', 'Reading'),
    ('travel', 'Travel'),
    ('technology', 'Technology'),
    ('art', 'Art'),
    ('photography', 'Photography'),
    ('cooking', 'Cooking'),
    ('gaming', 'Gaming'),
    ('fitness', 'Fitness'),
    ('gardening', 'Gardening'),
    ('movies', 'Movies'),
    ('writing', 'Writing'),
    ('fashion', 'Fashion'),
    ('volunteering', 'Volunteering'),
    ('hiking', 'Hiking'),
    ('blogging', 'Blogging'),
    ('yoga', 'Yoga'),
    ('DIY', 'DIY (Do It Yourself)'),
    ('investing', 'Investing')

-- INSERT VALUES INTO ADDRESS TYPE MASTER TABLE --
INSERT INTO AddressTypeMaster (value)
VALUES 
    ('Present'),
    ('Permanent'),
    ('Business'),
    ('Industry'),
    ('Other');

-- INSERT VALUES INTO CREDENTIAL MASTER TABLE --
INSERT INTO CredentialMaster (value)
VALUES 
    ('SSLC'),
    ('HSC'),
    ('UG'),
    ('PG'),
    ('Diploma'),
    ('Others');

-- INSERT VALUES INTO COUNTRY MASTER TABLE --
INSERT INTO CountryMaster (code, value)
VALUES 
    ('IN', 'India'),
    ('US', 'United States of America'),
    ('UK', 'United Kingdom'),
    ('AU', 'Australia'),
    ('NZ', 'New Zealand');

-- INSERT VALUES INTO STATE MASTER TABLE --
INSERT INTO StateMaster (code, value, country_id)
VALUES 
    ('TN', 'Tamil Nadu', 1),
    ('KA', 'Karnataka', 1),
    ('MH', 'Maharashtra', 1),
    ('KL', 'Kerala', 1),
    ('AP', 'Andhra Pradesh', 1),
    ('OT', 'Others', 1);


-- INSERT VALUES INTO STATE MASTER TABLE FOR UNITED STATES --
INSERT INTO StateMaster (code, value, country_id)
VALUES 
    ('CA', 'California', 2),
    ('TX', 'Texas', 2),
    ('FL', 'Florida', 2),
    ('NY', 'New York', 2),
    ('IL', 'Illinois', 2),
    ('PA', 'Pennsylvania', 2),
    ('OH', 'Ohio', 2),
    ('MI', 'Michigan', 2),
    ('GA', 'Georgia', 2),
    ('NC', 'North Carolina', 2),
    ('NJ', 'New Jersey', 2),
    ('VA', 'Virginia', 2),
    ('WA', 'Washington', 2),
    ('MA', 'Massachusetts', 2),
    ('AZ', 'Arizona', 2),
    ('Others', 'Other States', 2);

-- INSERT VALUES INTO STATE MASTER TABLE FOR UNITED KINGDOM --
INSERT INTO StateMaster (code, value, country_id)
VALUES 
    ('ENG', 'England', 3),
    ('SCT', 'Scotland', 3),
    ('WLS', 'Wales', 3),
    ('NIR', 'Northern Ireland', 3),
    ('OT', 'Other Regions', 3);

-- INSERT VALUES INTO STATE MASTER TABLE FOR AUSTRALIA --
INSERT INTO StateMaster (code, value, country_id)
VALUES 
    ('NSW', 'New South Wales', 4),
    ('VIC', 'Victoria', 4),
    ('QLD', 'Queensland', 4),
    ('SA', 'South Australia', 4),
    ('WA', 'Western Australia', 4),
    ('TAS', 'Tasmania', 4),
    ('NT', 'Northern Territory', 4),
    ('ACT', 'Australian Capital Territory', 4),
    ('OT', 'Other Regions', 4);

-- INSERT VALUES INTO STATE MASTER TABLE FOR NEW ZEALAND --
INSERT INTO StateMaster (code, value, country_id)
VALUES 
    ('AKL', 'Auckland', 5),
    ('WGN', 'Wellington', 5),
    ('CHC', 'Christchurch', 5),
    ('HAM', 'Hamilton', 5),
    ('DUN', 'Dunedin', 5),
    ('OT', 'Other Regions', 5);

-- INSERT VALUES INTO CITY MASTER TABLE FOR INDIA (TAMIL NADU) --
INSERT INTO CityMaster (code, value, state_id, country_id)
VALUES 
    ('CHN', 'Chennai', 1, 1),
    ('CBE', 'Coimbatore', 1, 1),
    ('MDU', 'Madurai', 1, 1),
    ('TRC', 'Trichy', 1, 1),
    ('TAN', 'Tanjore', 1, 1),
    ('OT', 'Other Cities', 1, 1);

-- Cities in California (USA)
INSERT INTO CityMaster (code, value, state_id, country_id)
VALUES 
    ('LA', 'Los Angeles', 1, 2),  
    ('SF', 'San Francisco', 1, 2),
    ('SD', 'San Diego', 1, 2),
    ('OT', 'Other Cities', 1, 2); 

-- Cities in England (UK)
INSERT INTO CityMaster (code, value, state_id, country_id)
VALUES 
    ('LON', 'London', 1, 3),
    ('MAN', 'Manchester', 1, 3),
    ('BIR', 'Birmingham', 1, 3),
    ('OT', 'Other Cities', 1, 3); 

-- Cities in New South Wales (Australia)
INSERT INTO CityMaster (code, value, state_id, country_id)
VALUES 
    ('SYD', 'Sydney', 1, 4),  
    ('NEW', 'Newcastle', 1, 4),
    ('WOL', 'Wollongong', 1, 4),
    ('OT', 'Other Cities', 1, 4);

-- Cities in Auckland (New Zealand)
INSERT INTO CityMaster (code, value, state_id, country_id)
VALUES 
    ('AKL', 'Auckland', 1, 5),  
    ('WGN', 'Wellington', 1, 5),
    ('CHC', 'Christchurch', 1, 5),
    ('OT', 'Other Cities', 1, 5); 

-- Cities in Karnataka (India)
INSERT INTO CityMaster (code, value, state_id, country_id)
VALUES 
    ('BLR', 'Bangalore', 2, 1),  
    ('MYS', 'Mysore', 2, 1),
    ('MNG', 'Mangalore', 2, 1),
    ('OT', 'Other Cities', 2, 1); 

-- Cities in Maharashtra (India)
INSERT INTO CityMaster (code, value, state_id, country_id)
VALUES 
    ('MUM', 'Mumbai', 3, 1),  
    ('PNE', 'Pune', 3, 1),
    ('NAS', 'Nashik', 3, 1),
    ('OT', 'Other Cities', 3, 1); 

------------------------------------------------------------------------------------
---------------------------------MAIN TABLES----------------------------------------
------------------------------------------------------------------------------------
-- CREATE DEMOGRAPHIC INFORMATION --
CREATE TABLE DemographicInformation (
	Id INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
	FirstName VARCHAR(200),
    LastName VARCHAR(100),
    Email VARCHAR(200),
    Salutation VARCHAR(50),
    Gender VARCHAR(50),
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- CREATE USER INTERESTS TABLE --
CREATE TABLE UserInterest (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    UserId INT NOT NULL,
    Interest VARCHAR(200) NOT NULL,
	CreatedAt DATETIME DEFAULT GETDATE()
    FOREIGN KEY (UserId) REFERENCES DemographicInformation(Id)
);

-- CREATE EDUCATION INFORMATION --
CREATE TABLE EducationInformation (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	UserId INT NOT NULL,
	CredentialInfo VARCHAR(200),
	DegreeCertificate VARCHAR(250),
	Institution VARCHAR(300),
	City VARCHAR(150),
	StateOrProvince VARCHAR(150),
	CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES DemographicInformation(Id)
);

-- CREATE EXPERIENCE INFORMATION --
CREATE TABLE ExperienceInformation (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	UserId INT NOT NULL,
	Employer VARCHAR(250),
	DOJ Date,
	JobRole VARCHAR(200),
	DurationInMonth INT,
	CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES DemographicInformation(Id)
);

-- CREATE ADDRESS --
CREATE TABLE AddressInformation (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	UserId INT NOT NULL,
	AddressType VARCHAR(100),
	Country VARCHAR(100),
	StateOrProvince VARCHAR(100),
	City VARCHAR(100),
	DoorNoStreet VARCHAR(100),
	Pincode VARCHAR(10),
	CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES DemographicInformation(Id)
);
