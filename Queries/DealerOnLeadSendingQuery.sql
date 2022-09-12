DECLARE @LeadID INT = 50348

SELECT *
FROM   dealeron..leadlog
WHERE  leadid IN ( @LeadID )

SELECT *
FROM   dealeron..leadsentlog
WHERE  logid IN (SELECT logid
                 FROM   dealeron..leadlog
                 WHERE  leadid IN ( @LeadID )) 