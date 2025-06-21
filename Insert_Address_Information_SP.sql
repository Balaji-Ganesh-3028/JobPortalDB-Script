CREATE OR ALTER PROCEDURE InsertAddressInformation
	@AddressInfos AddressInfoTableType READONLY
AS
BEGIN
	-- Prevent excessive message logging
    SET NOCOUNT ON;

	BEGIN
		INSERT INTO AddressInformation (UserId, AddressType, Country, StateOrProvince, City, DoorNoStreet, Pincode)
		SELECT
			src.UserId,
			src.AddressType,
			src.Country,
			src.StateOrProvince,
			src.City,
			src.DoorNoStreet,
			src.Pincode
		FROM @AddressInfos src
		WHERE NOT EXISTS (
			SELECT 1
			FROM AddressInformation AD
			WHERE AD.UserId = src.UserId
		);
	END;
END;


CREATE TYPE AddressInfoTableType AS TABLE
	(
		UserId INT NOT NULL,
		AddressId INT NOT NULL,
		AddressType VARCHAR(100),
		Country VARCHAR(100),
		StateOrProvince VARCHAR(100),
		City VARCHAR(100),
		DoorNoStreet VARCHAR(100),
		Pincode VARCHAR(10)
	);


EXEC InsertAddressInformation
	@UserId = 2,
	@AddressType = 'Premanent',
	@Country = 'India',
	@StateOrProvince = 'TN',
	@City = 'Tuty',
	@DoorNoStreet = '10, East car street',
	@Pincode = '620051'


	------------------------------------------------------------------------------------------------------------------------------
DECLARE @AddressInfos AddressInfoTableType;

INSERT INTO @AddressInfos (UserId, AddressType, Country, StateOrProvince, City, DoorNoStreet, Pincode)
VALUES
    (2, 'Premanent Update', 'India', 'TN', 'Tuty', '10, East Car Street', '628002');

EXEC dbo.InsertAddressInformation @AddressInfos = @AddressInfos;