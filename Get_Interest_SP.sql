CREATE OR ALTER PROCEDURE getInterest
AS

BEGIN
	SET NOCOUNT ON

	SELECT * from InterestsMaster
END;

EXEC getInterest;