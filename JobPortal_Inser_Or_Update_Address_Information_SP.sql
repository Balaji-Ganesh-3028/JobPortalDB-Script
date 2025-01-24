CREATE OR ALTER PROCEDURE InsertOrUpdateAddressInformation
	@UserId INT,
	@AddressType VARCHAR(100),
	@Country VARCHAR(100),
	@StateOrProvince VARCHAR(100),
	@City VARCHAR(100),
	@DoorNoStreet VARCHAR(100),
	@Pincode VARCHAR(10)
AS
BEGIN
	-- Prevent excessive message logging
    SET NOCOUNT ON;

	-- Safety check to prevent recursive execution
    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

	-- Check if the record already exists in the UserInterests table
    IF EXISTS (SELECT 1 FROM AddressInformation WHERE UserId = @UserId)
	BEGIN
		UPDATE AddressInformation
		SET
			AddressType = @AddressType,
			Country = @Country,
			StateOrProvince = @StateOrProvince,
			City = @City,
			DoorNoStreet = @DoorNoStreet,
			Pincode = @Pincode

		WHERE
			UserId = @UserId

		PRINT 'Record updated successfully';
	END;

	ELSE
	BEGIN
		INSERT INTO AddressInformation (AddressType, Country, StateOrProvince, City, DoorNoStreet, Pincode)
		VALUES (@AddressType, @Country, @StateOrProvince, @City, @DoorNoStreet, @Pincode);

		PRINT 'Record inserted successfully';
	END;
END;