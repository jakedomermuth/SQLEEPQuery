--Returns all words in update linkto column that do not appear in event singular column. 
--SplitValues: This part of the query takes each row from the table and uses STRING_SPLIT to divide ColumnB into separate rows based on commas.
--The CROSS APPLY is used to apply the split operation to each row in the table and essentially flattens the results
--FilteredValues CTE: This takes the output of SplitValues and filters out those values that are found in ColumnA using a NOT EXISTS subquery. 
--The DISTINCT keyword ensures each value is listed only once in the final output.
--Final SELECT: This retrieves the values that were not found in Event singular.

SELECT  [Unique ID], [Event Singular], [Updated LinkTo]
FROM dbo.Assignments$


WITH SplitValues AS (
    SELECT 
        value
    FROM 
        dbo.Assignments$
    CROSS APPLY 
        STRING_SPLIT([Updated LinkTo], ',') AS Split
),
FilteredValues AS (
    SELECT DISTINCT 
        sv.value
    FROM 
        SplitValues sv
    WHERE NOT EXISTS (
        SELECT 1 
        FROM dbo.Assignments$ yt
        WHERE yt.[Event Singular] = sv.value
    )
)
SELECT *
FROM FilteredValues;




-- Returns all columns that have "event singlar" in "update link to"
SELECT  [Unique ID], [Event Singular], [Updated LinkTo]
FROM dbo.Assignments$
WHERE PATINDEX('%' + [Event Singular] + '%', [Updated LinkTo]) > 0;

