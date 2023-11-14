select * from trips_details;

--total trips

select count(distinct tripid) from trips_details;

--total drivers

select * from trips;

select count(distinct driverid) from trips;

-- total earnings

select sum(fare) from trips;

-- total Completed trips

select * from trips_details;

select sum(end_ride) from trips_details;

--total searches
--total searches which got estimate
--total searches for quotes
--total searches which got quotes
--total customer not cancelled
--total driver not cancelled
--total otp entered
--total end ride

select sum(searches),sum(searches_got_estimate),sum(searches_for_quotes),sum(searches_got_quotes),
sum(customer_not_cancelled),sum(driver_not_cancelled),sum(otp_entered),sum(end_ride)
from trips_details;

--average fare per trip

select sum(fare)/count(*) from trips;

--which duration had more trips

select * from 
(select *,rank() over(order by cnt desc) rnk from
(select duration,count(distinct tripid) cnt from trips
group by duration)b)c
where rnk=1;

--which driver,customer pair had more orders

select * from
(select *,rank() over(order by cnt desc)rnk from
(select driverid,custid,count(distinct tripid) cnt from trips
group by driverid,custid)c)d
where rnk=1;

--search to estimate rate

select sum(searches_got_estimate)*100.0/sum(searches) from trips_details;

--estimate to search for quote rates

select sum(searches_for_quotes)*100.0/sum(searches) from trips_details;

--quote acceptance rate

select sum(searches_got_quotes)*100.0/sum(searches) from trips_details;

--quote to booking rate

select sum(searches_got_quotes)*100.0/sum(searches) from trips_details;

--which area got highest trips in which duration

select * from
(select *,rank() over(partition by loc_from order by cnt desc) rnk from
(select duration,loc_from,count(distinct tripid) cnt from trips
group by duration,loc_from)a)c
where rnk=1;

--which area got the highest fares,cancellations,trips

select * from (select *,rank() over(order by fare desc)rnk
from
(select loc_from,sum(fare) fare from trips
group by loc_from)b)c
where rnk=1;

select * from (select *,rank() over(order by can desc)rnk
from
(select loc_from,count(*)-sum(driver_not_cancelled) can from trips_details
group by loc_from)b)c
where rnk=1;

select * from (select *,rank() over(order by can desc)rnk
from
(select loc_from,count(*)-sum(customer_not_cancelled) can from trips_details
group by loc_from)b)c
where rnk=1;

--which duration got the highest trips and fares

select * from 
(select *,rank() over(order by cnt desc) rnk from
(select duration,count(distinct tripid) cnt from trips
group by duration)b)c
where rnk=1;

--which driver,customer pair had more orders

select * from
(select *,rank() over(order by cnt desc) rnk from
(select driverid,custid,count(distinct tripid)cnt from trips
group by driverid,custid)c)d
where rnk=1;

