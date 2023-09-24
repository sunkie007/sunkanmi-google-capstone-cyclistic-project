

select --Average ride minute for casual riders
SELECT 'casual' AS MembershipType, AVG([trip_duration_m]) AS AverageTripDurationInMinutes
FROM [dbo].[cyclist_tripdata]
WHERE [membership_type] = 'casual'
UNION
SELECT 'member' AS MembershipType, AVG([trip_duration_m]) AS AverageTripDurationInMinutes
FROM [dbo].[cyclist_tripdata]
WHERE [membership_type] = 'member';

-- Count of rides by members and casual riders
SELECT 'casual' AS MembershipType, COUNT(ride_id) AS CountOfTrips
FROM [dbo].[cyclist_tripdata]
WHERE [membership_type] = 'casual'
UNION
SELECT 'member' AS MembershipType, COUNT(ride_id) AS CountOfTrips
FROM [dbo].[cyclist_tripdata]
WHERE [membership_type] = 'member';

--checking for the preferred bike type among both riders
SELECT COUNT([ride_id]) AS 'Count of Rides', bike_type
FROM [dbo].[cyclist_tripdata]
WHERE [membership_type] = 'member'
GROUP BY bike_type
ORDER BY COUNT([ride_id]) desc;

SELECT COUNT([ride_id]) AS 'Count of Rides', bike_type
FROM [dbo].[cyclist_tripdata]
WHERE [membership_type] = 'casual'
GROUP BY bike_type
ORDER BY COUNT([ride_id]) desc;