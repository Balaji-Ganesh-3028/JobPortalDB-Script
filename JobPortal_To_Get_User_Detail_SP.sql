CREATE OR ALTER PROCEDURE ToGetUserDetail
    @UserId INT
AS
BEGIN
    -- Check if @UserId is provided
    IF @UserId IS NULL
    BEGIN
        PRINT 'Error: UserId cannot be NULL.';
        RETURN;
    END

    SELECT
        di.FirstName, di.LastName, di.Email, di.Salutation, di.Gender,
        STRING_AGG(ui.Interest, ', ') AS Interests,
        ei.CredentialInfo, ei.DegreeCertificate, ei.Institution, ei.City AS EducationCity, ei.StateOrProvince AS EducationState,
        exi.Employer, exi.DOJ, exi.JobRole, exi.DurationInMonth,
        ai.AddressType, ai.Country AS AddressCountry, ai.StateOrProvince AS AddressState, ai.City AS AddressCity, ai.DoorNoStreet, ai.Pincode
    FROM 
        DemographicInformation di
    LEFT JOIN
        UserInterest ui ON ui.UserId = di.Id
    LEFT JOIN
        EducationInformation ei ON ei.UserId = @UserId
    LEFT JOIN
        ExperienceInformation exi ON exi.UserId = @UserId
    LEFT JOIN
        AddressInformation ai ON ai.UserId = @UserId
    WHERE
        di.Id = @UserId
    GROUP BY
        di.FirstName, di.LastName, di.Email, di.Salutation, di.Gender,
        ei.CredentialInfo, ei.DegreeCertificate, ei.Institution, ei.City, ei.StateOrProvince,
        exi.Employer, exi.DOJ, exi.JobRole, exi.DurationInMonth,
        ai.AddressType, ai.Country, ai.StateOrProvince, ai.City, ai.DoorNoStreet, ai.Pincode;
END;

