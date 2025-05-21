CREATE OR ALTER PROCEDURE InsertEducationInformation
    @EducationInfos EducationInfoTableType READONLY
AS
BEGIN
    SET NOCOUNT ON;

    -- Prevent recursive execution
    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

    -- Step 1: Update existing records
    UPDATE EI
    SET 
        EI.CredentialInfo    = src.CredentialInfo,
        EI.DegreeCertificate = src.DegreeCertificate,
        EI.Institution       = src.Institution,
        EI.City              = src.City,
        EI.StateOrProvince   = src.StateOrProvince
    FROM EducationInformation EI
    INNER JOIN @EducationInfos src
        ON EI.UserId = src.UserId
		WHERE EI.Id = src.EducationId;

    -- Step 2: Insert new records (that don't exist in the target table)
    INSERT INTO EducationInformation (UserId, CredentialInfo, DegreeCertificate, Institution, City, StateOrProvince)
    SELECT 
        src.UserId,
        src.CredentialInfo,
        src.DegreeCertificate,
        src.Institution,
        src.City,
        src.StateOrProvince
    FROM @EducationInfos src
    WHERE NOT EXISTS (
        SELECT 1
        FROM EducationInformation EI
        WHERE EI.UserId = src.UserId
    );
END;

--  Create a user-defined table type to hold your multiple rows
CREATE TYPE EducationInfoTableType AS TABLE
	(
		UserId           INT         NOT NULL,
		EducationId		 INT		 NOT NULL,
		CredentialInfo   VARCHAR(200) NULL,
		DegreeCertificate VARCHAR(250) NULL,
		Institution      VARCHAR(300) NULL,
		City             VARCHAR(150) NULL,
		StateOrProvince  VARCHAR(150) NULL
	);
----------------------------------------------------------------------------------------------------------------------------------

EXEC InsertEducationInformation
	@CredentialInfo = 'Sample Credential Info',
	@DegreeCertificate = 'Sample Degree Certificate',
	@Institution = 'Sample Institution',
	@City = 'Sample City',
	@StateOrProvince = 'Sample State or Province',
	@UserId = 2


-----------------------------------------------------------------------------------------------------------------------------------

DECLARE @EduInfos EducationInfoTableType;

INSERT INTO @EduInfos (UserId, CredentialInfo, DegreeCertificate, Institution, City, StateOrProvince)
VALUES
    (3, 'Certified Ethical Hacker New', 'CEH-Cert.pdf updated', 'EC-Council', 'Albuquerque', 'NM');

EXEC dbo.InsertEducationInformation @EducationInfos = @EduInfos;


DECLARE @EduInfos4 EducationInfoTableType;

INSERT INTO @EduInfos4 (UserId, CredentialInfo, DegreeCertificate, Institution, City, StateOrProvince)
VALUES 
( 2, 'Updated Ethical Hacker Certification update',  'Updated-CEH-Cert.pdf', 'EC-Council Institute', 'Santa Fe', 'New Mexico' );

EXEC InsertEducationInformation @EducationInfos = @EduInfos4;
