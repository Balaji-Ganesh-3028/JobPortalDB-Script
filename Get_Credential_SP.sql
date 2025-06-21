CREATE OR ALTER PROCEDURE getCredential
AS

BEGIN
	SET NOCOUNT ON

	SELECT * from CredentialMaster
END;

EXEC getCredential;