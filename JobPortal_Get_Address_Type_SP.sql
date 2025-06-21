CREATE OR ALTER PROCEDURE getAddressType
AS

BEGIN
	SET NOCOUNT ON

	SELECT * from AddressTypeMaster
END;

EXEC getAddressType;