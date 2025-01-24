CREATE OR ALTER PROCEDURE InsertOrUpdateUserInterest
    @UserId INT,
    @Interest VARCHAR(200)
AS
BEGIN
    -- Prevent excessive message logging
    SET NOCOUNT ON;

	-- Safety check to prevent recursive execution
    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

    -- Check if the record already exists in the UserInterests table
    IF EXISTS (SELECT 1 FROM UserInterests WHERE UserId = @UserId AND Interest = @Interest)
    BEGIN
        -- Record exists, no insertion needed
        PRINT 'Record already exists.';
    END
    ELSE
    BEGIN
        -- Insert a new record
        INSERT INTO UserInterests (UserId, Interest)
        VALUES (@UserId, @Interest);

        PRINT 'Record inserted successfully.';
    END
END;

EXEC InsertOrUpdateUserInterest
	@UserId = '6',
	@Interest = 'Ball Batminton'
