SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

	/* SQL GOES HERE */

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    DECLARE
        @ERROR_SEVERITY INT,
        @ERROR_STATE    INT,
        @ERROR_NUMBER   INT,
        @ERROR_LINE     INT,
        @ERROR_MESSAGE  NVARCHAR(4000);

    SELECT
        @ERROR_SEVERITY = ERROR_SEVERITY(),
        @ERROR_STATE    = ERROR_STATE(),
        @ERROR_NUMBER   = ERROR_NUMBER(),
        @ERROR_LINE     = ERROR_LINE(),
        @ERROR_MESSAGE  = ERROR_MESSAGE();

    RAISERROR('Msg %d, Line %d, :%s',
        @ERROR_SEVERITY,
        @ERROR_STATE,
        @ERROR_NUMBER,
        @ERROR_LINE,
        @ERROR_MESSAGE);
END CATCH