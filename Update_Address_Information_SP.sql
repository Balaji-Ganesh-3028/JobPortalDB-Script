CREATE OR ALTER PROCEDURE UpdateAddressInformation
	@UpdateAddressInfos UpdateAddressInfoTableType READONLY
AS
BEGIN
	UPDATE AI
		SET 
			AddressType = UIA.AddressType,
			Country = UIA.Country,
			StateOrProvince = UIA.StateOrProvince,
			City = UIA.City,
			DoorNoStreet = UIA.DoorNoStreet,
			Pincode = UIA.Pincode
		FROM 
			AddressInformation AI
		INNER JOIN
			@UpdateAddressInfos UIA 
		ON
			AI.UserId = UIA.UserId AND AI.Id = UIA.AddressId
END;

CREATE TYPE UpdateAddressInfoTableType AS TABLE
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

-- STEP 1: Declare variable of the TVP type
DECLARE @UserAddressUpdate AS UpdateAddressInfoTableType;

-- STEP 2: Insert test data into the variable using separate statements
INSERT INTO @UserAddressUpdate (UserId, AddressId, AddressType, Country, StateOrProvince, City, DoorNoStreet, Pincode)
VALUES ( 1, 1, 'Present', 'India', 'Tamil Nadu', 'Chennai', '10, Easr car street', '600001');

-- STEP 3: Execute the 
EXEC UpdateAddressInformation @UpdateAddressInfos = @UserAddressUpdate;
