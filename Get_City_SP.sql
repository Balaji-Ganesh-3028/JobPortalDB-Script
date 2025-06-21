CREATE OR ALTER PROCEDURE getCity
 @CountryId INT,
 @StateId INT

AS

BEGIN
	SET NOCOUNT ON

	SELECT * from CityMaster WHERE country_id = @CountryId AND state_id = @StateId
END;

EXEC getCity
	@CountryId = 1,
	@StateId = 1;