USE JobPortalDB
SELECT * FROM sys.tables

-- ALTER DEMOGRAPHIC INFORMATION --
ALTER TABLE DemographicInformation
ADD CreatedAt DATETIME DEFAULT GETDATE()


-- ALTER USER INTEREST TABLE --
ALTER TABLE UserInterests
ADD CreatedAt DATETIME DEFAULT GETDATE()


DELETE FROM DemographicInformation;
DELETE FROM UserInterest;

DELETE FROM AddressInformation;
DELETE FROM ExperienceInformation;
DELETE FROM EducationInformation;
DELETE FROM GenderMaster;

DROP TABLE DemographicInformation;
DROP TABLE UserInterest;
DROP TABLE AddressInformation;
DROP TABLE ExperienceInformation;
DROP TABLE EducationInformation;

--MASTER TABLE
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


DROP PROCEDURE IF EXISTS InsertUserInterests
DROP TYPE IF EXISTS INTREST_LIST
DROP TYPE IF EXISTS INTREST_Update_LIST



-- Truncate the table
TRUNCATE TABLE UserInterest;
TRUNCATE TABLE DemographicInformation;


-- Reset the identity column
DBCC CHECKIDENT ('UserInterest', RESEED, 1);
DBCC CHECKIDENT ('DemographicInformation', RESEED, 1);
DBCC CHECKIDENT ('AddressInformation', RESEED, 1);
DBCC CHECKIDENT ('ExperienceInformation', RESEED, 1);
DBCC CHECKIDENT ('EducationInformation', RESEED, 1);
