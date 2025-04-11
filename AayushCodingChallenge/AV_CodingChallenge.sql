-- Coding Challenge ( PetPals, The Pet Adoption Platform )
CREATE DATABASE IF NOT EXISTS PetPals;


ALTER TABLE Pets
ADD CONSTRAINT FK_Pets_Shelters
FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID);


-- 6.Write an SQL query that retrieves the names of participants (shelters and adopters) registered 
-- for a specific adoption event. Use a parameter to specify the event ID. Ensure that the query 
-- joins the necessary tables to retrieve the participant names and types. 

Select p.ParticipantName, p.ParticipantType
From Participants p
Where p.EventID = eventid;
select * from participants ;


-- 7. Create a stored procedure in SQL that allows a shelter to update its information (name and 
-- location) in the "Shelters" table. Use parameters to pass the shelter ID and the new information. 
-- Ensure that the procedure performs the update and handles potential errors, such as an invalid 
-- shelter ID. 



-- 8. Write an SQL query that calculates and retrieves the total donation amount for each shelter (by 
-- shelter name) from the "Donations" table. The result should include the shelter name and the 
-- total donation amount. Ensure that the query handles cases where a shelter has received no donations. 
select s.Shelter_Name, coalesce(sum(d.donationamount),0) as totaldonation
from shelters s
left join donations d on s.Shelter_name = s.Shelter_name
group by s.Shelter_Name;


-- Updating a table     
select * from pets ;
Alter Table Pets
Add Column ShelterID INT;
UPDATE Pets SET ShelterID = 1 WHERE PetID = 1;
UPDATE Pets SET ShelterID = 2 WHERE PetID = 2;
UPDATE Pets SET ShelterID = 3 WHERE PetID = 3;
UPDATE Pets SET ShelterID = 4 WHERE PetID = 4;
UPDATE Pets SET ShelterID = 5 WHERE PetID = 5;
UPDATE Pets SET ShelterID = 6 WHERE PetID = 6;
UPDATE Pets SET ShelterID = 7 WHERE PetID = 7;
UPDATE Pets SET ShelterID = 8 WHERE PetID = 8;
UPDATE Pets SET ShelterID = 9 WHERE PetID = 9;
UPDATE Pets SET ShelterID = 10 WHERE PetID = 10;
UPDATE Pets SET ShelterID = 11 WHERE PetID = 11;
UPDATE Pets SET ShelterID = 12 WHERE PetID = 12;
UPDATE Pets SET ShelterID = 13 WHERE PetID = 13;
UPDATE Pets SET ShelterID = 14 WHERE PetID = 14;
UPDATE Pets SET ShelterID = 15 WHERE PetID = 15;

SET SQL_SAFE_UPDATES = 0;

-- 9. Write an SQL query that retrieves the names of pets from the "Pets" table that do not have an 
-- owner (i.e., where "OwnerID" is null). Include the pet's name, age, breed, and type in the result 
-- set. 

select Name , age , breed , type 
from pets p1
where OwnerID is Null ;

-- 10. Write an SQL query that retrieves the total donation amount for each month and year (e.g., 
-- January 2023) from the "Donations" table. The result should include the month-year and the 
-- corresponding total donation amount. Ensure that the query handles cases where no donations 
-- were made in a specific month-year. 
;
select date_format(DonationDate , '%m-%Y') as DonationMonthYear,
	coalesce(sum(DonationAmount) , 0) as TotalDonationAmount
from Donations
group by DonationMonthYear
order by DonationMonthYear ; 

-- 11. Retrieve a list of distinct breeds for all pets that are either 
-- aged between 1 and 3 years or older than 5 years.

select breed , age 
from pets 
where (age between 1 and 3) or (age>5) ;

-- 12. Retrieve a list of pets and their respective shelters 
-- where the pets are currently available for adoption.
Select p.Name as PetName, s.Shelter_Name
From Pets p
JOIN Shelters s On ShelterID = s.ShelterID -- ERROR
Where p.AvailableForAdoption = 1;

-- 13.  Find the total number of participants in events organized by shelters located in specific city. 
-- Example: City=Chennai

select count(p.ParticipantID) as TotalParticipants
from participants p join adoptionevents e on p.eventid
where e.location like '%Park%';

-- 14. Retrieve a list of unique breeds for pets with ages between 1 and 5 years. 

Select distinct Breed
from Pets
where Age between 1 and 5;

-- 15. Find the pets that have not been adopted by selecting 
-- their information from the 'Pet' table.


select * from pets where AvailableForAdoption = 1 ; 

-- 16. Retrieve the names of all adopted pets along with the 
-- adopter's name from the 'Adoption' and 'User' tables. 
select p.Name as name , u.username as AdopterName
from adoption a 
join pets p on a.pet_id = p.petid 
Join Users u on a.user_id = u.user_id ;


-- 17. Retrieve a list of all shelters along with the 
-- count of pets currently available for adoption in each shelter. 

select s.Shelter_Name as Shelter_Name , count(p.PetID) as AvailablePets
from shelters s
left join pets p on s.ShelterID = p.ShelterID and p.AvailableForAdoption
group by s.shelterid , s.Shelter_Name ;


-- 18 Find pairs of pets from the same shelter that have the same breed.
select p1.name as pet1, p2.name as pet2, p1.breed, s.Shelter_Name as sheltername
from pets p1
join pets p2 on p1.shelterid = p2.shelterid and p1.breed = p2.breed and p1.petid < p2.petid
join shelters s on p1.shelterid = s.shelterid;
-- No pet has same breed

-- 19.  List all possible combinations of shelters and adoption events.
select s.Shelter_Name, ae.EventName
from Shelters s
cross join adoptionevents ae ;

-- 20. Determine the shelter that has the highest number of adopted pets. 
select s.shelter_name as shelter_name, count(a.pet_id) as adoptedcount  
from shelters s  
join pets p on s.shelterid = p.shelterid  
join adoption a on p.petid = a.pet_id  
group by s.shelterid, s.shelter_name  
order by adoptedcount desc  
limit 1; 





