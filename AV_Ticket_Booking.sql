-- Till Q5 in Screenshots continued with Q6

-- TASK 2
-- 6. Write a SQL query to retrieve events with dates falling within a specific range. 
Select event_name , event_date 
from event 
where event_date BETWEEN '2025-05-02' AND '2025-05-25';
select * from event

-- 7. Write a SQL query to retrieve events with available tickets that also have "Concert" in their name;
;
update event 
set event_name = 'Arijit Singh Concert '
where event_id = 208 ;

select event_name,available_seats,ticket_price
from event 
where event_name like '%Concert%' ;

-- 8. Write a SQL query to retrieve users in batches of 5, starting from the 6th user

Select *
from Customer
LIMIT 5 OFFSET 5 ;

-- 9. Write a SQL query to retrieve bookings details contains booked no of ticket more than 4.

select *
from booking
where num_tickets > 4;

-- 10. Write a SQL query to retrieve customer information whose phone number end with ‘000’

select * from customer where phone_number Like '%000' ;
-- Zero

-- 11.Write a SQL query to retrieve the events in order whose seat capacity more than 15000.

select event_name , total_seats 
from event
where total_seats > 15000
order by total_seats desc ;

-- 12. Write a SQL query to select events name not start with ‘x’, ‘y’,‘z’

select event_name 
from event 
where event_name 
	not like 'x%'
	and event_name not like 'y%' 
	and event_name  not like 'z%' ; 
    
-- Task 3 
-- 1. List Events and Their Average Ticket Prices

SELECT event_name, AVG(ticket_price) AS average_ticket_price
FROM Event
GROUP BY event_name;

-- 2.Write a SQL query to Calculate the Total Revenue Generated by Events.
SELECT SUM(total_cost) AS total_revenue
FROM Booking;

-- 3. Write a SQL query to find the event with the highest ticket sales. 
SELECT e.event_name, SUM(b.num_tickets) AS total_tickets
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name
ORDER BY total_tickets DESC
LIMIT 1;

-- 4. Write a SQL query to Calculate the Total Number of Tickets Sold for Each Event. 
SELECT e.event_name, SUM(b.num_tickets) AS total_tickets
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name;

-- 5. Write a SQL query to Find Events with No Ticket Sales. 
SELECT e.event_name
FROM Event e
LEFT JOIN Booking b ON e.event_id = b.event_id
WHERE b.booking_id IS NULL;
-- 6. Write a SQL query to Find the User Who Has Booked the Most Tickets.
SELECT c.customer_name, SUM(b.num_tickets) AS total_tickets
FROM Booking b
JOIN Customer c ON b.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_tickets DESC
LIMIT 1;

-- 7. Write a SQL query to List Events and the total number of tickets sold for each month.
select e.event_name, month(b.booking_date) as month, year(b.booking_date) as year, 
sum(b.num_tickets) as total_tickets
from booking b
join event e on b.event_id = e.event_id
group by e.event_name, year(b.booking_date), month(b.booking_date)
order by year, month;

-- 8. Write a SQL query to calculate the average Ticket Price for Events in Each Venue. 
select v.venue_name, avg(e.ticket_price) as avg_ticket_price
from event e
join venue v on e.venue_id = v.venue_id
group by v.venue_name;

-- 9. Write a SQL query to calculate the total Number of Tickets Sold for Each Event Type. 
select event_type, sum(b.num_tickets) as total_tickets
from booking b
join event e on b.event_id = e.event_id
group by event_type;

-- 10. Write a SQL query to calculate the total Revenue Generated by Events in Each Year.
select year(b.booking_date) as year, sum(b.total_cost) as total_revenue
from booking b
group by year(b.booking_date)
order by year;

-- 11. Write a SQL query to list users who have booked tickets for multiple events. 
select c.customer_name, count(distinct b.event_id) as unique_events
from booking b
join customer c on b.customer_id = c.customer_id
group by c.customer_name
having count(distinct b.event_id) > 1;

-- 12. Write a SQL query to calculate the Total Revenue Generated by Events for Each User. 
select c.customer_name, sum(b.total_cost) as total_spent
from booking b
join customer c on b.customer_id = c.customer_id
group by c.customer_name;

-- 13. Write a SQL query to calculate the Average Ticket Price for Events in Each Category and Venue. 
select e.event_type, v.venue_name, avg(e.ticket_price) as avg_price
from event e
join venue v on e.venue_id = v.venue_id
group by e.event_type, v.venue_name;

-- 14. Write a SQL query to list Users and the Total Number of 
-- Tickets They've Purchased in the Last 30 Days;
select c.customer_name, sum(b.num_tickets) as tickets_last_30_days
from booking b
join customer c on b.customer_id = c.customer_id
where b.booking_date >= curdate() - interval 30 day
group by c.customer_name;

-- Task 3 

-- 1. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery.
select venue_name, (select avg(ticket_price)
from event e where e.venue_id = v.venue_id ) as avg_price
from venue v;
 
 -- 2. Find Events with More Than 50% of Tickets Sold using subquery.
 select event_name
 from event
 where (total_seats - available_seats) > (0.5 * total_seats);
 
-- 3. Calculate the Total Number of Tickets Sold for Each Event. 
select event_id, (select sum(num_tickets)
from booking b where b.event_id = e.event_id ) as total_tickets
from event e;
 
-- 4. Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery. 
select customer_name
from customer c
where not exists (select 1 from booking b
where b.customer_id = c.customer_id);
 
 -- 5. List Events with No Ticket Sales Using a NOT IN Subquery. 
 select event_name
 from event
 where event_id not in (select distinct event_id from booking );
   
-- 6. Calculate the Total Number of Tickets Sold 
-- for Each Event Type Using a Subquery in the FROM Clause. 
select event_type, sum(total_tickets) as total_tickets
from (select e.event_type, b.num_tickets as total_tickets
from booking b
join event e on b.event_id = e.event_id) as sub
group by event_type;
 
 -- 7. Find Events with Ticket Prices Higher Than 
 -- the Average Ticket Price Using a Subquery in the WHERE Clause. 
 select event_name, ticket_price
 from event
 where ticket_price > (select avg(ticket_price) from event);
 
-- 8. Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery.
select customer_name, ( select sum(total_cost)
from booking b
where b.customer_id = c.customer_id) as total_revenue
from customer c;

-- 9. List Users Who Have Booked Tickets for Events 
-- in a Given Venue Using a Subquery in the WHERE Clause. 
select customer_name
from customer c
where customer_id in ( select b.customer_id from booking b
join event e on b.event_id = e.event_id
where e.venue_id = 1 );
 
-- 10. Calculate the Total Number of Tickets Sold for 
-- Each Event Category Using a Subquery with GROUP BY.
select event_type, sum(tickets_sold) as total_tickets
from (select e.event_type, b.num_tickets as tickets_sold
from booking b join event e on b.event_id = e.event_id) as sub
group by event_type;
 
-- 11. Find Users Who Have Booked Tickets for 
-- Events in each Month Using a Subquery with DATE_FORMAT.
select distinct customer_name
from customer c
where customer_id in (select b.customer_id from booking b
where date_format(b.booking_date, '%Y-%m') is not null
 );
 
-- 12. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
select venue_name, (select avg(ticket_price)
from event e
where e.venue_id = v.venue_id) as avg_ticket_price
from venue v;








