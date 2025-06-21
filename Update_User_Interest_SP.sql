CREATE OR ALTER PROCEDURE UpdateUserInterest
    @UpdateUserInterests INTREST_Update_LIST READONLY
AS
BEGIN
    UPDATE UI
    SET 
        UI.Interest = UUI.Interest_Value
    FROM 
        UserInterest UI
    INNER JOIN 
        @UpdateUserInterests UUI 
        ON UI.UserId = UUI.UserId AND UI.Id = UUI.Interest_Id;
END;

CREATE TYPE INTREST_Update_LIST AS Table(
	UserId INT NULL,
	Interest_Id INT NULL,
	Interest_Value VARCHAR(200) NULL
)

-- STEP 1: Declare variable of the TVP type
DECLARE @UserInterestUpdates AS INTREST_Update_LIST;

-- STEP 2: Insert test data into the variable using separate statements
INSERT INTO @UserInterestUpdates (UserId, Interest_Id, Interest_Value)
VALUES (2, 4, 'Music');
EXEC UpdateUserInterest @UpdateUserInterests = @UserInterestUpdates;


