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

    -- CHECK IF A RECORD EXISTS IN THE DEMOGRAPHIC INFORMATION TABLE --
    IF EXISTS (SELECT 1 FROM DemographicInformation WHERE Email = @Email)
    BEGIN
        -- UPDATE THE EXISTING RECORD
        UPDATE DemographicInformation
        SET 
            FirstName = @FirstName,
            LastName = @LastName,
            Salutation = @Salutation,
            Gender = @Gender
        WHERE 
            Email = @Email;

        PRINT 'Record updated successfully.';
    END
    ELSE
    BEGIN
        -- INSERT A NEW RECORD
        INSERT INTO DemographicInformation (FirstName, LastName, Email, Salutation, Gender)
        VALUES (@FirstName, @LastName, @Email, @Salutation, @Gender);

        PRINT 'Record inserted successfully.';
    END
END;

EXEC InsertOrUpdateDemographicInformation 
    @FirstName = 'John', 
    @LastName = 'Doe', 
    @Email = 'john.doe@example.com', 
    @Salutation = 'Mr.', 
    @Gender = 'Male';

EXEC InsertOrUpdateDemographicInformation 
    @FirstName = 'Divya', 
    @LastName = 'Bharathi', 
    @Email = 'divya.bharathi@kanini.com', 
    @Salutation = 'Ms.', 
    @Gender = 'Female';

EXEC InsertOrUpdateDemographicInformation 
    @FirstName = 'Sai', 
    @LastName = 'Priya', 
    @Email = 'sai.priya@kanini.com', 
    @Salutation = 'Ms.', 
    @Gender = 'Female';

SELECT * FROM DemographicInformation;