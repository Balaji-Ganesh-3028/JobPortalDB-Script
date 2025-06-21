CREATE OR ALTER PROCEDURE getState
 @CountryId INT
AS

BEGIN
	SET NOCOUNT ON

	SELECT * from StateMaster WHERE country_id = @CountryId
END;

EXEC getState
	@CountryId = 1;