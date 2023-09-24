-----------------------------------------------------------------------------------------
-------------------------------------DATA ANALYSIS & INSIGHTS----------------------------
-----------------------------------------------------------------------------------------

--checking the distinct count of bikes
SELECT DISTINCT bike_type
FROM [dbo].[cyclist_tripdata]

--checking the distinct count of membership_type
SELECT DISTINCT membership_type
FROM [dbo].[cyclist_tripdata]

--create a new column as trip duration
ALTER TABLE [dbo].[cyclist_tripdata]
  ADD trip_duration_m int 

--Updated trip duration in minutes column
UPDATEcyclist_tripdata
SET[trip_duration_m] = DATEDIFF(minute, [started_at], [ended_at])
   WHERE DATEDIFF(minute, [started_at], [ended_at]) > 1
   AND DATEDIFF(HOUR, [started_at], [ended_at]) < 24;

--Adding new columns to the dataset
ALTER TABLE [dbo].[cyclist_tripdata]
ADD day_of_week nvarchar(50),
    rides_in_month nvarchar(50),
    time_of_the_day nvarchar(50),
    ride_route nvarchar(max),
    hour_of_the_day nvarchar(50);


--Updating the extracted day_of_week
UPDATE [dbo].[cyclist_tripdata]
SET day_of_week = 
                CASE WHEN DATEPART(WEEKDAY, [started_at]) = 1 THEN 'SUNDAY' 
                     WHEN DATEPART(WEEKDAY, [started_at]) = 2 THEN 'MONDAY'
                     WHEN DATEPART(WEEKDAY, [started_at]) = 3 THEN 'TUESDAY'
                     WHEN DATEPART(WEEKDAY, [started_at]) = 4 THEN 'WEDNESDAY'
                     WHEN DATEPART(WEEKDAY, [started_at]) = 5 THEN 'THURSDAY'
                     WHEN DATEPART(WEEKDAY, [started_at]) = 6 THEN 'FRIDAY'
                     ELSE 'SATURDAY' 
                END;

--Updating the extracted month
UPDATE [dbo].[cyclist_tripdata]
SET [rides_in_month] = CASE WHEN MONTH([started_at]) = 1 THEN 'JANUARY'
                       WHEN MONTH([started_at]) = 2 THEN 'FEBRUARY'
                       WHEN MONTH([started_at]) = 3 THEN 'MARCH'
                       WHEN MONTH([started_at]) = 4 THEN 'APRIL'
                       WHEN MONTH([started_at]) = 5 THEN 'MAY'
                       WHEN MONTH([started_at]) = 6 THEN 'JUNE'
                       WHEN MONTH([started_at]) = 7 THEN 'JULY'
                       WHEN MONTH([started_at]) = 8 THEN 'AUGUST'
                       WHEN MONTH([started_at]) = 9 THEN 'SEPTEMBER'
                       WHEN MONTH([started_at]) = 10 THEN 'OCTOBER'
                       WHEN MONTH([started_at]) = 11 THEN 'NOVEMBER'
                       ELSE 'DECEMBER'
                       END;
--Updating the extracted time of day
UPDATE [dbo].[cyclist_tripdata]
SET [time_of_the_day] = CASE
       WHEN DATEPART(HOUR, [started_at]) >= 6 AND DATEPART(HOUR, [started_at]) < 12 THEN 'Morning'
       WHEN DATEPART(HOUR, [started_at]) >= 12 AND DATEPART(HOUR, [started_at]) < 18 THEN 'Afternoon'
       ELSE 'Night'
      END

--Updating ride route
UPDATE [dbo].[cyclist_tripdata]
SET [ride_route] = CONCAT([start_station_name], ' <==> ', [end_station_name])
                   WHERE [start_station_name] IS NOT NULL AND [end_station_name] IS NOT NULL

--Updating hour of the day
UPDATE [dbo].[cyclist_tripdata]
SET hour_of_the_day = CASE
                        WHEN DATEPART(HOUR, [started_at]) = 0 THEN '12 AM'
                        WHEN DATEPART(HOUR, [started_at]) = 1 THEN '1 AM'
                        WHEN DATEPART(HOUR, [started_at]) = 2 THEN '2 AM'
                        WHEN DATEPART(HOUR, [started_at]) = 3 THEN '3 AM'
                        WHEN DATEPART(HOUR, [started_at]) = 4 THEN '4 AM'
                        WHEN DATEPART(HOUR, [started_at]) = 5 THEN '5 AM'
                        WHEN DATEPART(HOUR, [started_at]) = 6 THEN '6 AM'
                        WHEN DATEPART(HOUR, [started_at]) = 7 THEN '7 AM'
                        WHEN DATEPART(HOUR, [started_at]) = 8 THEN '8 AM'
                        WHEN DATEPART(HOUR, [started_at]) = 9 THEN '9 AM'
                        WHEN DATEPART(HOUR, [started_at]) = 10 THEN '10 AM'
                        WHEN DATEPART(HOUR, [started_at]) = 11 THEN '11 AM'
                        WHEN DATEPART(HOUR, [started_at]) = 12 THEN '12 PM'
                        WHEN DATEPART(HOUR, [started_at]) = 13 THEN '1 PM'
                        WHEN DATEPART(HOUR, [started_at]) = 14 THEN '2 PM'
                        WHEN DATEPART(HOUR, [started_at]) = 15 THEN '3 PM'
                        WHEN DATEPART(HOUR, [started_at]) = 16 THEN '4 PM'
                        WHEN DATEPART(HOUR, [started_at]) = 17 THEN '5 PM'
                        WHEN DATEPART(HOUR, [started_at]) = 18 THEN '6 PM'
                        WHEN DATEPART(HOUR, [started_at]) = 19 THEN '7 PM'
                        WHEN DATEPART(HOUR, [started_at]) = 20 THEN '8 PM'
                        WHEN DATEPART(HOUR, [started_at]) = 21 THEN '9 PM'
                        WHEN DATEPART(HOUR, [started_at]) = 22 THEN '10 PM'
                        WHEN DATEPART(HOUR, [started_at]) = 23 THEN '11 PM'
                       END

-- Count of rides by annual members and casual riders
SELECT 'casual' AS MembershipType, COUNT(ride_id) AS CountOfTrips
FROM [dbo].[cyclist_tripdata]
WHERE [membership_type] = 'casual'
UNION
SELECT 'member' AS MembershipType, COUNT(ride_id) AS CountOfTrips
FROM [dbo].[cyclist_tripdata]
WHERE [membership_type] = 'member';

--Average ride minutes for casual riders and annual members
SELECT 'casual' AS MembershipType, AVG([trip_duration_m]) AS AverageTripDurationInMinutes
FROM [dbo].[cyclist_tripdata]
WHERE [membership_type] = 'casual'
UNION
SELECT 'member' AS MembershipType, AVG([trip_duration_m]) AS AverageTripDurationInMinutes
FROM [dbo].[cyclist_tripdata]
WHERE [membership_type] = 'member'

--looking at the preferred choice of bike among both riders
SELECT 'Annual Member' AS Membership_Type, COUNT(ride_id) AS Count_of_Rides, bike_type
FROM cyclist_tripdata
WHERE membership_type = 'member'
GROUP BY bike_type
UNION ALL
SELECT 'Casual Member' AS Membership_Type, COUNT(ride_id) AS Count_of_Rides, bike_type
FROM cyclist_tripdata
WHERE membership_type = 'casual'
GROUP BY bike_type

ORDER BY Count_of_Rides DESC, bike_type;

--Showing the count of rides by day of the week and its percentage
SELECT 
    COUNT(ride_id) AS ride_count,
    day_of_week,
    CAST(COUNT(ride_id) * 100.0 / SUM(COUNT(ride_id)) OVER () AS DECIMAL(18, 2)) AS '% of total rides'
FROM [dbo].[cyclist_tripdata]
GROUP BY day_of_week
ORDER BY ride_count DESC;

--Showing the count of rides by day of the week and its percentage 
SELECT 
    COUNT(ride_id) AS ride_count,
    day_of_week,
    CAST(COUNT(ride_id) * 100.0 / SUM(COUNT(ride_id)) OVER () AS DECIMAL(18, 2)) AS '% of total rides'
FROM [dbo].[cyclist_tripdata]
GROUP BY day_of_week
ORDER BY ride_count DESC;

--showing rides per month
SELECT count(ride_id) AS ride_count, rides_in_month
FROM [dbo].[cyclist_tripdata]
GROUP BY rides_in_month
ORDER BY ride_count desc; 

--Top 20 frequent ride route
SELECT TOP 20 ride_route, COUNT(*) AS frequency 
FROM [dbo].[cyclist_tripdata]
WHERE ride_route IS NOT NULL
GROUP BY ride_route
ORDER BY frequency DESC;

