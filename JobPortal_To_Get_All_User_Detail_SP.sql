CREATE OR ALTER PROCEDURE GetAllEmployees
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        di.Id,
        di.FirstName,
        di.LastName,
        di.Email,
		di.Salutation,
		di.Gender,

		-- INTEREST DETAILS
		(
			SELECT 
				im.id,
				im.code,
				im.value
			FROM
				UserInterest ui
			INNER JOIN
				InterestsMaster im ON ui.Interest = im.value
			FOR JSON AUTO, INCLUDE_NULL_VALUES
		) AS Interests,
		-- INTEREST DETAILS

		-- EDUCATION INFORMATION
		(
			SELECT
				ei.Id,
				ei.CredentialInfo,
				ei.DegreeCertificate,
				ei.Institution,
				ei.StateOrProvince,
				ei.City
			FROM 
				EducationInformation ei
			FOR JSON AUTO, INCLUDE_NULL_VALUES
		) AS EducationDetails,
		-- EDUCATION INFORMATION

		-- EXPERIENCE INFORMATION
		(
			SELECT
				exi.Id,
				exi.Employer,
				exi.JobRole,
				exi.DOJ,
				exi.DurationInMonth,
				exi.UserId
			FROM
				ExperienceInformation exi
			FOR JSON AUTO, INCLUDE_NULL_VALUES
		) AS ExperienceInformation,
		-- EXPERIENCE INFORMATION

		-- ADDRESS INFORMATION
		(
			SELECT
				addi.Id,
				addi.AddressType,
				addi.DoorNoStreet,
				addi.Pincode,
				addi.Country,
				addi.StateOrProvince,
				addi.City,
				addi.UserId
			FROM
				AddressInformation addi
			FOR JSON AUTO, INCLUDE_NULL_VALUES
		) AS AddressInformation
		-- ADDRESS INFORMATION

    FROM 
        DemographicInformation di
END


EXEC GetAllEmployees