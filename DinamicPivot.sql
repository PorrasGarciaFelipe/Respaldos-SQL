
CREATE TABLE #REVENUE
(
ID             INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
[MONTH]        VARCHAR(8) NOT NULL,
SALES          DECIMAL(8,2) NOT NULL
)

INSERT INTO #REVENUE
([MONTH],SALES)
VALUES
('JAN-2015', 200000.16),
('FEB-2015', 220000.17),
('MAR-2015', 227000.55),
('APR-2015', 247032.75),
('MAY-2015', 287652.75),
('JUN-2015', 265756.75)

select * from #REVENUE

ALTER DATABASE COCOA  
SET COMPATIBILITY_LEVEL = 100; 


SELECT * FROM
(SELECT     
    [MONTH], 
    SALES
FROM #REVENUE)X
PIVOT 
(
    AVG(SALES)
    for [MONTH] in ([JAN-2015],[FEB-2015],[MAR-2015],[APR-2015],[MAY-2015],[JUN-2015])
) Pvt



INSERT INTO #REVENUE
([MONTH],SALES)
VALUES
('JUL-2015', 316532.16)





DECLARE @cols AS NVARCHAR(MAX),
@query  AS NVARCHAR(MAX)

SELECT @cols = STUFF((SELECT  ',' + QUOTENAME([MONTH]) 
                    FROM #REVENUE
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

SELECT @query = 
'SELECT * FROM
(SELECT     
    [MONTH], 
    SALES
FROM #REVENUE)X
PIVOT 
(
    AVG(SALES)
    for [MONTH] in (' + @cols + ')
) P'

EXEC SP_EXECUTESQL @query



        