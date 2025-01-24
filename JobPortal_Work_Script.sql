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

DROP TABLE DemographicInformation;
DROP TABLE UserInterest;

SELECT * FROM DemographicInformation;
SELECT * FROM UserInterest;

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