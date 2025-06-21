SELECT * FROM sys.tables

SELECT * FROM DemographicInformation;

SELECT * FROM UserInterest;


SELECT * FROM DemographicInformation AS DGI
LEFT JOIN UserInterest AS UI ON DGI.Id = UI.UserId
--LEFT JOIN InterestsMaster AS IM ON UI.Interest = IM.id  
WHERE DGI.Id = 12



SELECT 
    im.id,
    im.code,
    im.value
FROM 
    UserInterest ei
INNER JOIN 
    InterestsMaster im ON ei.Interest = im.value
WHERE 
    ei.UserId = 12
FOR JSON PATH, INCLUDE_NULL_VALUES


SELECT * FROM UserInterest WHERE UserId = 12

SELECT * FROM UserInterest
INNER JOIN
	InterestsMaster im ON UserInterest.Interest = im.value
WHERE UserId = 12

SELECT * FROM InterestsMaster

UPDATE UserInterest
	SET 
		Interest = 'Cooking'
	WHERE UserId = 12 AND id = 24


SELECT * FROM EducationInformation WHERE UserId = 12
SELECT * FROM EducationInformation;

SELECT * FROM ExperienceInformation WHERE UserId = 12;
SELECT * FROM ExperienceInformation;