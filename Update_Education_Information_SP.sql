CREATE OR ALTER PROCEDURE UpdateEducationInformation
	@UpdateEducationInfo UpdateEducationInfoTableType READONLY
AS
BEGIN
	UPDATE EI
		SET
			CredentialInfo = UEI.CredentialInfo,
			DegreeCertificate = UEI.DegreeCertificate,
			Institution = UEI.Institution,
			City = UEI.City,
			StateOrProvince = UEI.StateOrProvince
		FROM
			EducationInformation EI
		INNER JOIN
			@UpdateEducationInfo UEI
		ON 
			EI.UserId = UEI.UserId AND EI.Id = UEI.EducationId
END;

CREATE TYPE UpdateEducationInfoTableType AS TABLE
	(
		EducationId INT NOT NULL,
		UserId INT NOT NULL,
		CredentialInfo VARCHAR(200),
		DegreeCertificate VARCHAR(250),
		Institution VARCHAR(300),
		City VARCHAR(150),
		StateOrProvince VARCHAR(150)
	);

-- STEP 1: Declare variable of the TVP type
DECLARE @EducationUpdates AS UpdateEducationInfoTableType;

-- STEP 2: Insert test data into the variable using separate statements
INSERT INTO @EducationUpdates (
    EducationId,
    UserId,
    CredentialInfo,
    DegreeCertificate,
    Institution,
    City,
    StateOrProvince
)
VALUES
-- Example 1
(1, 1, 'Bachelor of Science in Computer Science', 'Degree123.pdf', 'ABC University', 'Chennai', 'Tamil Nadu');


-- STEP 3: Execute the 
EXEC UpdateEducationInformation @UpdateEducationInfo = @EducationUpdates;