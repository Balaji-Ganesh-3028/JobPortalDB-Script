CREATE OR ALTER PROCEDURE getSalutation
AS

BEGIN
	SET NOCOUNT ON

	SELECT * from SalutationMaster
END;

EXEC getSalutation;