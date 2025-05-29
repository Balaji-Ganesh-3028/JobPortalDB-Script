
CREATE OR ALTER PROCEDURE InsertorUpdateUsersInterest
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

Select * from UserInterest order by 1 asc


CREATE TYPE INTREST_LIST AS TABLE(
	[USERID] [int] NULL,
	[INTREST_ID] VARCHAR(200) NULL
)


DECLARE @MyUserInterests AS INTREST_LIST ;

INSERT INTO @MyUserInterests (USERID, INTREST_ID )
VALUES (1, 1001), (1, 1002), (1, 1003), (2, 1003), (2, 1004), (3, 1003);
SELECT * FROM @MyUserInterests

EXEC InsertorUpdateUsersInterest @UserInterests = @MyUserInterests;





-----------------------------------------------------OLD IMPLEMENTATION-------------------------------------------------
--CREATE OR ALTER PROCEDURE InsertOrUpdateUserInterest
--    @UserId INT,
--    @Interest VARCHAR(200)
--AS
--BEGIN
--    -- Prevent excessive message logging
--    SET NOCOUNT ON;

--	-- Safety check to prevent recursive execution
--    IF TRIGGER_NESTLEVEL() > 1
--        RETURN;

--    -- Check if the record already exists in the UserInterests table
--    IF EXISTS (SELECT 1 FROM UserInterest WHERE UserId = @UserId AND Interest = @Interest)
--    BEGIN
--        -- Record exists, no insertion needed
--        PRINT 'Record already exists.';
--    END
--    ELSE
--    BEGIN
--        -- Insert a new record
--        INSERT INTO UserInterest (UserId, Interest)
--        VALUES (@UserId, @Interest);

--        PRINT 'Record inserted successfully.';
--    END
--END;

--EXEC InsertOrUpdateUserInterest
--	@UserId = '1',
--	@Interest = 'Cricket'
