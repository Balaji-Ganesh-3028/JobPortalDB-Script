CREATE OR ALTER PROCEDURE deleteUser
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Delete related user data first (child tables)
        DELETE FROM UserInterest
        WHERE UserId = @UserId;

        DELETE FROM EducationInformation
        WHERE UserId = @UserId;

        DELETE FROM ExperienceInformation
        WHERE UserId = @UserId;

        DELETE FROM AddressInformation
        WHERE UserId = @UserId;

		DELETE FROM DemographicInformation
		WHERE Id = @UserId

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
    END CATCH
END;


EXEC deleteUser @userId = 7