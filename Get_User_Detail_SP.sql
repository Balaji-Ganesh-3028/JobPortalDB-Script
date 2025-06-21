CREATE OR ALTER PROCEDURE GetEmployeeDetails
	@UserId INT
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
				im.id AS id,
				im.code AS code,
				im.value AS value,
				ui.Id AS InterestId
			FROM
				UserInterest ui
			INNER JOIN
				InterestsMaster im ON ui.Interest = im.value
			WHERE
				ui.UserId = @UserId
			FOR JSON PATH, INCLUDE_NULL_VALUES
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
			WHERE
				ei.UserId = @UserId
			FOR JSON AUTO, INCLUDE_NULL_VALUES
		) AS EducationInformation,
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
			WHERE
				exi.UserId = @UserId
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
			WHERE
				addi.UserId = @UserId
			FOR JSON AUTO, INCLUDE_NULL_VALUES
		) AS AddressInformation
		-- ADDRESS INFORMATION

    FROM 
        DemographicInformation di
	WHERE 
		di.Id = @UserId
END


EXEC GetEmployeeDetails @UserId = 6