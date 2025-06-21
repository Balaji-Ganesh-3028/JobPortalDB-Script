CREATE OR ALTER PROCEDURE InsertExperienceInformation
	@ExperienceInfos ExperienceInfoTableType READONLY
AS
BEGIN
	-- Prevent excessive message logging
    SET NOCOUNT ON;
	BEGIN
		INSERT INTO ExperienceInformation (UserId, Employer, DOJ, JobRole, DurationInMonth)
		SELECT 
			src.UserId,
			src.Employer,
			src.DOJ,
			src.JobRole,
			src.DurationInMonth
		FROM @ExperienceInfos src
		WHERE NOT EXISTS (
			SELECT 1
			FROM ExperienceInformation EX
			WHERE EX.UserId = src.UserId
		);
	END;
END;

CREATE TYPE ExperienceInfoTableType AS TABLE
	(
		UserId INT NOT NULL,
		ExperienceId INT NOT NULL,
		Employer VARCHAR(250),
		DOJ Date,
		JobRole VARCHAR(200),
		DurationInMonth INT
	);

EXEC InsertExperienceInformation
	@UserId = 2,
	@Employer = 'Premanent',
	@DOJ = '2021-04-01',
	@JobRole = 'Senior Developer',
	@DurationInMonth = 38

------------------------------------------------------------------------------------------------------------------------------
DECLARE @ExeInfos ExperienceInfoTableType;

INSERT INTO @ExeInfos (UserId, Employer, DOJ, JobRole, DurationInMonth)
VALUES
    (5, 'Premanent', '2021-04-01', 'Senior Developer', 38);

EXEC dbo.InsertExperienceInformation @ExperienceInfos = @ExeInfos;