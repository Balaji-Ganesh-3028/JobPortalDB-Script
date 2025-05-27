USE JobPortalDB

INSERT INTO DemographicInformation ( FirstName, LastName, Email, Salutation, Gender) 
VALUES
	( 
		'Balaji',
		'Ganesh',
		'balaji@gmail.com',
		'Mr.',
		'Male'
	);

INSERT INTO DemographicInformation ( FirstName, LastName, Email, Salutation, Gender)
VALUES
	( 
		'Prasad',
		'Dass',
		'prasad@gmail.com',
		'Mr.',
		'Male'
	);

-- ALTER DEMOGRAPHIC INFORMATION --
ALTER TABLE DemographicInformation
ADD CreatedAt DATETIME DEFAULT GETDATE()


-- ALTER USER INTEREST TABLE --
ALTER TABLE UserInterests
ADD CreatedAt DATETIME DEFAULT GETDATE()

INSERT INTO UserInterests (	UserId,	Interest ) 
VALUES
	(
		3,
		'Cricket'
	),
	(
		3,
		'Basket Ball'
	);

DELETE FROM DemographicInformation;
DELETE FROM UserInterest;

DELETE FROM AddressInformation;
DELETE FROM ExperienceInformation;
DELETE FROM EducationInformation;
DELETE FROM GenderMaster WHERE code = 'M.'

DROP TABLE DemographicInformation;
DROP TABLE UserInterest;
DROP TABLE AddressInformation;
DROP TABLE ExperienceInformation;
DROP TABLE EducationInformation;
DROP TABLE GenderMaster;
DROP TABLE SalutationMaster;
DROP TABLE InterestsMaster;
DROP TABLE CredentialMaster;
DROP TABLE AddressTypeMaster;



SELECT * FROM DemographicInformation;
SELECT * FROM UserInterest;
SELECT * FROM EducationInformation;
SELECT * FROM ExperienceInformation;
SELECT * FROM AddressInformation;
SELECT * FROM GenderMaster;
SELECT * FROM SalutationMaster;
SELECT * FROM InterestsMaster;
SELECT * FROM CredentialMaster;
SELECT * FROM AddressTypeMaster;
SELECT * FROM CountryMaster;
SELECT * FROM StateMaster;
SELECT * FROM CityMaster;

UPDATE AddressTypeMaster
SET code = 'IN'
WHERE id = 4;


------DROP TVP AND PROCEDURE-------
--EXPERIENCE 
DROP PROCEDURE IF EXISTS InsertExperienceInformation;
DROP TYPE IF EXISTS ExperienceInfoTableType;

--EDUCATION
DROP PROCEDURE IF EXISTS InsertEducationInformation;
DROP TYPE IF EXISTS EducationInfoTableType

--ADDRESS
DROP PROCEDURE IF EXISTS InsertAddressInformation
DROP TYPE IF EXISTS AddressInfoTableType


-- Truncate the table
TRUNCATE TABLE UserInterest;
TRUNCATE TABLE DemographicInformation;


-- Reset the identity column
DBCC CHECKIDENT ('UserInterest', RESEED, 1);
DBCC CHECKIDENT ('DemographicInformation', RESEED, 1);


SELECT 
	Demo.FirstName,
	Demo.LastName,
	Demo.Email,
	Inte.Interest
FROM
	DemographicInformation Demo
LEFT JOIN
	UserInterests Inte
ON
	Demo.Id = Inte.UserId
WHERE
	Demo.FirstName = 'Prasad';

SELECT
	Demo.FirstName,
	Inte.UserId AS UserId_In_UserInterest,
	Demo.Id AS UserId_In_DemographicDetails
FROM
	UserInterests Inte
RIGHT JOIN
	DemographicInformation Demo
ON 
	Inte.UserId = Demo.Id
WHERE
	Inte.Interest = 'Cricket';





	
EXEC InsertOrUpdateDemographicInformation 
    @FirstName = 'John', 
    @LastName = 'Doeqqqq', 
    @Email = 'joh11111n.doe@example.com', 
    @Salutation = 'Mr.', 
    @Gender = 'Male';

EXEC InsertOrUpdateDemographicInformation 
    @FirstName = 'Divya', 
    @LastName = 'Bharathi', 
    @Email = 'divya.bharathi@kanini.com', 
    @Salutation = 'Ms.', 
    @Gender = 'Female';

EXEC InsertOrUpdateDemographicInformation 
    @FirstName = 'Sai', 
    @LastName = 'Priya', 
    @Email = 'sai.priya@kanini.com', 
    @Salutation = 'Ms.', 
    @Gender = 'Female';

SELECT * FROM DemographicInformation;

delete  [dbo].[UserInterest]

Select * from [dbo].[UserInterest] where [USERID] = 1

CREATE OR ALTER PROCEDURE dbo.InsertUserInterests  
    @UserInterests [dbo].[INTREST_LIST] READONLY  
AS  
BEGIN  
    SET NOCOUNT ON;

    INSERT INTO [dbo].[UserInterest] (UserId, Interest)  
    SELECT UI.[USERID], UI.[INTREST_ID] 
    FROM @UserInterests UI
    WHERE NOT EXISTS (
        SELECT 1 
        FROM [dbo].[UserInterest] U 
        WHERE U.UserId = UI.[USERID] AND U.Interest = UI.[INTREST_ID]
    );
END;



DECLARE @MyUserInterests AS [dbo].[INTREST_LIST] ;

INSERT INTO @MyUserInterests ([USERID],[INTREST_ID] )
VALUES (1, 1001), (1, 1002), (1, 1003);
SELECT * FROM @MyUserInterests

EXEC dbo.InsertUserInterests @UserInterests = @MyUserInterests;

