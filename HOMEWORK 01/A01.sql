-- How many taxi trips were there on January 15?

select count(1) as records 
from yellow_taxi_trips 
where CAST(yellow_taxi_trips.tpep_pickup_datetime as DATE) = '2021-01-15';

-- Find the largest tip for each day. On which day it was the largest tip in January?

select CAST(yellow_taxi_trips.tpep_pickup_datetime as DATE) as day,
max(tip_amount) as tip_max
from yellow_taxi_trips
group by day
order by tip_max desc limit 1;

-- What was the most popular destination for passengers picked up in central park on January 14?

select 
CONCAT(zpu."Borough", '/', zpu."Zone") AS "pickup_loc", 
count(1) 
from yellow_taxi_trips t LEFT JOIN zones zpu
ON t."PULocationID" = zpu."LocationID"
where CAST(t.tpep_pickup_datetime as DATE) = '2021-01-14'
group by "pickup_loc"
order by count desc LIMIT 1;

-- What's the pickup-dropoff pair with the largest average price for a ride (calculated based on total_amount)?

select 
AVG(total_amount),
CONCAT(zpu."Borough", '/', zpu."Zone") AS "pickup_loc", 
CONCAT(zpu."Borough", '/', zdo."Zone") AS "dropoff_loc"
from yellow_taxi_trips t LEFT JOIN zones zpu
ON t."PULocationID" = zpu."LocationID"
LEFT JOIN zones zdo
ON t."DOLocationID" = zdo."LocationID"
group by "pickup_loc","dropoff_loc"
order by AVG desc ;