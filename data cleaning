-----------------------------------------------------------------------------------------
-------------------------------DATA CLEANING & PRE-PROCESSING----------------------------
-----------------------------------------------------------------------------------------

--the table schema showing the data_types
SELECT  COLUMN_NAME, 
        DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS

--Number of Records
SELECT COUNT(*) AS 'Number of Records'
FROM cyclist_tripdata

--Checking if the primary key ride_id has duplicates
SELECT ride_id, count(ride_id) AS Count
FROM cyclist_tripdata
GROUP BY ride_id
HAVING count(ride_id)>1

--Deleting the duplicates in the ride_id column
WITH CTE AS (
 SELECT *,
   ROW_NUMBER() OVER(PARTITION BY ride_id ORDER BY ride_id) AS Duplicated_rows
FROM cyclist_tripdata)
DELETE FROM CTE WHERE Duplicated_rows > 1

--getting null count for each columns
SELECT 'ride_id' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE ride_id is null
UNION
SELECT 'rideable_type' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE rideable_type is null
UNION
SELECT 'started_at' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE started_at is null
UNION
SELECT 'ended_at' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE ended_at is null
UNION
SELECT 'start_station_name' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE start_station_name is null
UNION
SELECT 'start_station_id' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE start_station_id is null
UNION
SELECT 'end_station_name' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE end_station_name is null
UNION
SELECT 'end_station_id' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE end_station_id is null
UNION
SELECT 'start_lat' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE start_lat is null
UNION
SELECT 'start_lng' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE start_lng is null
UNION
SELECT 'end_lat' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE end_lat is null
UNION
SELECT 'end_lng' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE end_lng is null
UNION
SELECT 'member_casual' as ColumnName, COUNT(*) as NullCount
FROM [dbo].[cyclist_tripdata]
WHERE member_casual is null

--Delecting records where started_at column is greater than ended_at
DELETE FROM [dbo].[cyclist_tripdata]
      WHERE [started_at] > [ended_at]

--renaming column member_casual to membership_type
sp_rename 'cyclist_tripdata.member_casual', 'membership_type'

--renaming column rideable_type to bike_type
sp_rename 'cyclist_tripdata.rideable_type', 'bike_type'

