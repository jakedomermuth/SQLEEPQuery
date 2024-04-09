----Checking sheet 1
WITH SplitValues AS (
    SELECT value
    FROM dbo.['SQL-sheet$']
    CROSS APPLY STRING_SPLIT([Categories], ';')
)
SELECT DISTINCT value
FROM SplitValues
WHERE value IS NOT NULL AND value != '';



----Checking sheet 2
WITH SplitValues AS (
    SELECT value
    FROM dbo.['SQL-Sheet2$']
    CROSS APPLY STRING_SPLIT([FAQ: Venues: What types of kids' venue do you have?], ';')
)
SELECT DISTINCT value
FROM SplitValues
WHERE value IS NOT NULL AND value != '';


----Chexking sheet 3
WITH SplitValues AS (
    SELECT value
    FROM [dbo].[Sheet1$]
    CROSS APPLY STRING_SPLIT([FAQ: Venues: What type of amusement venue do you have?], ';')
)
SELECT DISTINCT value
FROM SplitValues
WHERE value IS NOT NULL AND value != '';


--getting a list of values that do not match from each column 

SELECT DISTINCT t1.[BM Venues (Category ID 8)] AS unmatched_value
FROM [dbo].['Value Comparison$'] t1
WHERE NOT EXISTS (
    SELECT 1
    FROM [dbo].['Value Comparison$'] t2
    WHERE t2.[BM Venues (In main)] = t1.[BM Venues (Category ID 8)]
)

SELECT DISTINCT t1.[BM Venues (In main)] AS unmatched_value
FROM [dbo].['Value Comparison$'] t1
WHERE NOT EXISTS (
    SELECT 1
    FROM [dbo].['Value Comparison$'] t2
    WHERE t2.[BM Venues (Category ID 8)] = t1.[BM Venues (In main)]
)
