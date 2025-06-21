CREATE OR ALTER PROCEDURE InsertUsersInterest
--	@UserId INT,
	@UserInterests INTREST_LIST READONLY
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO UserInterest (UserId, Interest)  
    SELECT UI.USERID, UI.INTREST_ID 
    FROM @UserInterests UI
    WHERE NOT EXISTS (
        SELECT 1 
        FROM UserInterest U 
        WHERE U.UserId = UI.USERID AND U.Interest = UI.INTREST_ID
    );
END;

CREATE TYPE INTREST_LIST AS TABLE(
	[USERID] [int] NULL,
	[INTREST_ID] VARCHAR(200) NULL
)

DECLARE @MyUserInterests AS INTREST_LIST;

EXEC InsertUsersInterest @UserInterests = @MyUserInterests;

