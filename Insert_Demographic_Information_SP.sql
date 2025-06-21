CREATE OR ALTER PROCEDURE InsertDemographicInformation
    @FirstName VARCHAR(200),
    @LastName VARCHAR(100),
    @Email VARCHAR(200),
    @Salutation VARCHAR(50),
    @Gender VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM DemographicInformation WHERE Email = @Email)
    BEGIN
        -- Return existing user info with OperationType
        SELECT 
            Id,
            'Exists' AS OperationType
        FROM DemographicInformation
        WHERE Email = @Email;
    END
    ELSE
    BEGIN
        DECLARE @Inserted TABLE (Id INT);

        INSERT INTO DemographicInformation (FirstName, LastName, Email, Salutation, Gender)
        OUTPUT INSERTED.Id INTO @Inserted(Id)
        VALUES (@FirstName, @LastName, @Email, @Salutation, @Gender);

        SELECT Id, 'Inserted' AS OperationType FROM @Inserted;
    END
END

----------------------------------------------------
EXECUTE InsertDemographicInformation
	@FirstName = 'Prasad', 
    @LastName = 'Dass', 
    @Email = 'prasasdsd3823115@gmail.com', 
    @Salutation = 'Mr.', 
    @Gender = 'Male';
