CREATE OR ALTER PROCEDURE InsertOrUpdateDemographicInformation
    @FirstName VARCHAR(200),
    @LastName VARCHAR(100),
    @Email VARCHAR(200),
    @Salutation VARCHAR(50),
    @Gender VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

	-- Safety check to prevent recursive execution
    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

    -- Declare a variable to track operation type
    DECLARE @OperationType VARCHAR(20);
    --DECLARE @InseteredId INT;
	declare @InseteredId table (ID int)

	

    -- CHECK IF A RECORD EXISTS IN THE DEMOGRAPHIC INFORMATION TABLE --
    IF EXISTS (SELECT 1 FROM DemographicInformation WHERE Email = @Email)
    BEGIN
        SET @OperationType = 'Updated';

        -- UPDATE THE EXISTING RECORD
        UPDATE DemographicInformation
        SET 
            FirstName = @FirstName,
            LastName = @LastName,
            Salutation = @Salutation,
            Gender = @Gender
			OUTPUT INSERTED.Id into @InseteredId
        WHERE 
            Email = @Email;


		PRINT 'Record Updated Successfully';
    END
    ELSE
    BEGIN
        SET @OperationType = 'Inserted';

        -- INSERT A NEW RECORD
        INSERT INTO DemographicInformation (FirstName, LastName, Email, Salutation, Gender)
		OUTPUT INSERTED.Id, @OperationType AS OperationType
        VALUES (@FirstName, @LastName, @Email, @Salutation, @Gender);

		PRINT 'Record Inserted Successfully';

    END
END;


-----------------------
EXEC InsertOrUpdateDemographicInformation 
    @FirstName = 'Prasad', 
    @LastName = 'Dass', 
    @Email = 'prasad38311@gmail.com', 
    @Salutation = 'Mr.', 
    @Gender = 'Male';

