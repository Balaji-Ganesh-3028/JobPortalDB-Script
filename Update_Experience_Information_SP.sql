CREATE TYPE UpdateExperienceInfoTableType AS TABLE
(
    ExperienceId INT NOT NULL,
    UserId INT NOT NULL,
    Employer VARCHAR(250),
    DOJ DATE,
    JobRole VARCHAR(200),
    DurationInMonth INT
);

CREATE OR ALTER PROCEDURE UpdateExperienceInformation
    @UpdateExperienceInfo UpdateExperienceInfoTableType READONLY
AS
BEGIN
    UPDATE EI
    SET
        EI.Employer = UEI.Employer,
        EI.DOJ = UEI.DOJ,
        EI.JobRole = UEI.JobRole,
        EI.DurationInMonth = UEI.DurationInMonth
    FROM
        ExperienceInformation EI
    INNER JOIN
        @UpdateExperienceInfo UEI
        ON EI.Id = UEI.ExperienceId AND EI.UserId = UEI.UserId;
END;

-- Declare the TVP variable
DECLARE @ExperienceUpdates AS UpdateExperienceInfoTableType;

-- Insert sample data
INSERT INTO @ExperienceUpdates (
    ExperienceId,
    UserId,
    Employer,
    DOJ,
    JobRole,
    DurationInMonth
)
VALUES
(1, 1, 'Google India Pvt Ltd', '2020-06-01', 'Senior Software Engineer', 48);

-- Execute the update procedure
EXEC UpdateExperienceInformation @UpdateExperienceInfo = @ExperienceUpdates;
