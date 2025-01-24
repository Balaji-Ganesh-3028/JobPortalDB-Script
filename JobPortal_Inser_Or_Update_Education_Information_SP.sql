CREATE OR ALTER PROCEDURE InsertOrUpdateEducationInformation
    @UserId INT,
	@CredentialInfo VARCHAR(200),
	@DegreeCertificate VARCHAR(250),
	@Institution VARCHAR(300),
	@City VARCHAR(150),
	@StateOrProvince VARCHAR(150)
AS
BEGIN
	-- Prevent excessive message logging
    SET NOCOUNT ON;

	-- Safety check to prevent recursive execution
    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

	-- Check if the record already exists in the UserInterests table
    IF EXISTS (SELECT 1 FROM EducationInformation WHERE UserId = @UserId)
	BEGIN
		UPDATE EducationInformation
		SET
			CredentialInfo = @CredentialInfo,
			DegreeCertificate = @DegreeCertificate,
			Institution = @Institution,
			City = @City,
			StateOrProvince = @StateOrProvince
		WHERE
			UserId = @UserId

		PRINT 'Record updated successfully';
	END;

	ELSE
	BEGIN
		INSERT INTO EducationInformation (CredentialInfo, DegreeCertificate, Institution, City, StateOrProvince)
		VALUES (@CredentialInfo, @DegreeCertificate, @Institution, @City, @StateOrProvince);

		PRINT 'Record inserted successfully';
	END;
END;