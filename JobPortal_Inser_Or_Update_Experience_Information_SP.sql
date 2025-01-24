CREATE OR ALTER PROCEDURE InsertOrUpdateExperienceInformation
	@UserId INT,
	@Employer VARCHAR(250),
	@DOJ Date,
	@JobRole VARCHAR(200),
	@DurationInMonth INT
AS
BEGIN
	-- Prevent excessive message logging
    SET NOCOUNT ON;

	-- Safety check to prevent recursive execution
    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

	-- Check if the record already exists in the UserInterests table
    IF EXISTS (SELECT 1 FROM ExperienceInformation WHERE UserId = @UserId)
	BEGIN
		UPDATE ExperienceInformation
		SET
			Employer = @Employer,
			DOJ = @DOJ,
			JobRole = @JobRole,
			DurationInMonth = @DurationInMonth
		WHERE
			UserId = @UserId

		PRINT 'Record updated successfully';
	END;

	ELSE
	BEGIN
		INSERT INTO ExperienceInformation (Employer, DOJ, JobRole, DurationInMonth)
		VALUES (@Employer, @DOJ, @JobRole, @DurationInMonth);

		PRINT 'Record inserted successfully';
	END;
END;