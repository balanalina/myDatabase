-- create database,populate it and some queries
create database GreenHouse
go
use GreenHouse
create table Building(bid int primary key , name varchar(50) not null,location varchar(50),nrOfPlants int check(nrOfPlants >0))
create table isWorking(time time,date date,gid int foreign key references Gardener(gid) on update cascade on delete cascade,bid int foreign key references Building(bid) on update cascade on delete cascade, pid int foreign key references Plant(pid) on update cascade on delete cascade, primary key(time,date))
create table Gardener(gid int primary key, name varchar(50) not null)
create table Plant(pid int primary key, price int, type varchar(50) not null , name varchar(50))
create table Customer(cid int primary key,address varchar(50) not null,phoneNr int, name varchar(50) not null)
create table Orderr(oid int primary key,price int check(price > 0),quantity int,cid int foreign key references Customer(cid) on update cascade on delete cascade,pid int references Plant(pid) on update cascade on delete cascade)
create table Delivery(componentNr int not null primary key,deid int,did int foreign key references Driver(did) on update cascade on delete cascade,tid int foreign key references Truck(tid),oid int foreign key references Orderr(oid),date date, time time)
create table Driver(did int primary key, name varchar(50) not null)
create table Truck(tid int primary key, model varchar(50) not null,capacity int,state varchar(50))
create table Maintenance(tid int foreign key references Truck(tid) on update cascade on delete cascade,lastCheck date, nextCheck date primary key)
alter table Plant
add name varchar(50)
drop table Delivery
--h2
--insert data in table Plants
insert into Plant (pid, price, type, name) values
(423, 30, 'Autumn Flower', 'CHRYSANTHEMUM INDICUM' ),
(645, 25, 'Autumn Flower' , 'GAURA LINDHEIMERI'),
(946, 10, 'Autumn Flower', 'KALANCHOE'),
(349, 70, 'Garden Plants', 'MAGNOLIA SOULANGEANA'),
(761, 35, 'Garden Plants', 'JUNIPERUS SQUAMATA'),
(852, 20, 'Garden Plants', 'LEWISIA COTYLEDON'),
(496, 40, 'Indoor Plants', 'HIBISCUS ROSA-SINENSIS'),
(396, 20, 'Indoor Plants' , 'OXALIS'),
(159, 25, 'Indoor Plants', 'CLOROPHYTUM COMOSUM'),
(678, 40, 'Feng Shui Plants', 'SANSEVIERIA CYLINDRICA'),
(462, 160, 'Feng Shui Plants', 'CHRYSALIDOCARPUS LUTESCENS'),
(768, 120, 'Feng Shui Plants', 'CRASSULA OVATA'),
(645, 10, 'Feng Shui Plants', 'DRACAENA SANDERIANA');
--printing the tabel Plants
SELECT *
FROM Plant
--inserting data into table Building
insert into Building (bid, name, location, nrOfPlants) values
(62, 'MacMillan greenhouse', 'Rhode road', 320),
(92, 'Naturhus', 'Vänersborg road', 410),
(28, 'Rue Voltaire', 'Hermès and Cartier square', 280),
(84, 'Pennsylvania greenhouse', ' Bucks' , 310),
(46, 'Camouflage House 3', 'Iguchi rload',275);
--printing table Building
SELECT *
FROM Building
--inserting data into table Gardener
insert into Gardener (gid, name) values
(9168,'Jemma Oneill'),
(1685,'Sianna Salter'),
(6791, 'Arnav Hart'),
(4958, 'Clifford Leigh'), 
(6125,'Nathanial Mcneill'),
(7339, 'Lexi Sinclair'),
(3954,'Roma Stein'),
(2684,'Anabia Seymour'),
(9563,'Ayda Watkins'),
(6532,'Traci Sumner');
--printing the table Gardener
SELECT *
FROM Gardener
--inserting data into table isWorking
insert into isWorking (time, date, gid, bid , pid) values
('06:00:00','2019-01-08',9563,46,462),
('12:00:00','2019-01-08',1685,28,462),
('15:00:00','2019-01-07',6791,28,462),
('15:00:00','2019-01-05',1685,46,462),
('16:00:00','2019-01-07',9563,62,678),
('08:00:00','2019-01-04',6532,92,761),
('16:00:00','2019-01-04',9563,84,396),
('06:30:00','2019-01-04',6791,46,678),
('14:30:00','2019-01-04',1685,62,496),
('10:30:00','2019-01-05',6532,84,946),
('18:30:00','2019-01-05',7339,92,761),
('06:30:00','2019-01-05',6125,28,159),
('08:00:00','2019-01-06',9563,28,349),
('14:30:00','2019-01-06',3954,62,768),
('10:30:00','2019-01-06',2684,46,423),
('16:00:00','2019-01-06',4958,84,852),
('06:30:00','2019-01-07',6791,92,678);
--printing the table isWorking
SELECT * 
FROM isWorking
--inserting data into table Truck
insert into Truck(tid,model, capacity,state) values
(1,'Mercedes-Benz Atego 815 4x2', 4819, 'functional'),
(2, 'MAN TGL 8.210', 880, 'functional'),
(3, 'Mercedes-Benz Actros 2548 L nR 6x2', 4006, 'needs repairs'),
(4,'Renault T 480 6x2', 5576, 'needs repair'),
(5, 'Iveco 75E16 4x2', 2875,'functional'),
(6, 'Kristyan 96F65 4x4', 5000, 'functional'),
(7,'Kristyna 98PL96 4x4x4x4', 6900, 'functional');
--print Truck table
SELECT *
FROM Truck
--inserting data into table Maintenance 
insert into Maintenance(tid, lastCheck, nextCheck) values
(1,'2018-12-15','2019-06-15'),
(2,'2018-12-10', '2019-06-10'),
(3,'2018-12-05','2019-01-05'),
(4,'2018-12-11', '2019-01-11'),
(5,'2018-12-16', '2019-06-16'),
(6,'2018-12-20','2019-06-20'),
(7,'2018-12-14','2019-06-14');
--printing the table Maintenance
SELECT *
FROM Maintenance
--inserting data into Driver table
insert into Driver(did,name) values
(123,'Kristian Chifla'),
(234,'Kristina Denysa Bac'),
(345,'David Georgi'),
(456,'Irakli Mamuka'),
(567,'Levan Zazza'),
(678,'Zurab Lasha'),
(789,'Gocha Gela');
DELETE Driver
--printing table Driver
SELECT *
FROM Driver
--change phneNr column type from int to string
ALTER TABLE Customer
add address varchar(50) DEFAULT(NULL)

--inserting data into Customer Table
insert into Customer(cid, name,phoneNr,address,city) values
(54782,'Yesenia Murphy','+40-705-5577-124','STR. MUSCĂ VASILE nr. 5','Bucuresti - DISTRICT 5'),
(11111,'GGSGSE','HREWEHRW',null,null),
(54692,'Yesenia Murphy','+40-705-5577-124','STR. MUSCĂ VASILE nr. 5','Bucuresti - DISTRICT 5'),
(61832,'Emanuel Anderson','+40-711-5552-270','STR. COANDĂ HENRI nr. 11,','Prahova'),
(97658,'Lincoln Rodgers','+40-711-5555-033','Bulevardul Dacia 81, 020052','Bucuresti 2'),
(65932,'Grayson Stein','+40-785-5592-307','STR. COSTIN MIRON nr. 68','BACĂU'),
(12684,'Giana Mcintyre','+40-711-5556-354','STR. HOREA nr. 40,400202','CLUJ'),
(69321,'Julia Andrews','+40-711-5554-615','nr 56','SAT BOBOC, COM. COCHIRLEANCA'),
(25498,'Mayra Wise','+40-711-5558-314','BD. TOMIS nr. 328, 900463','Constanta'),
(79543,'Haley Zavala','+40-755-5568-867','STR. SPITALULUI nr. 36, 320076','CARAS-SEVERIN'),
(39456,'Alexander Miles','+40-711-5555-605','Strada Simion Barnutiu 12','Bihor'),
(49030,'Jocelynn Booker','+40-705-5565-654','Strada Mihai Bravu 2','Prahova'),
(5465,'dewfwegw','gwwe44','gew',null),
(80361,'Camren Nunez','+40-711-5556-464','BD. IPĂTESCU ANA nr. 6 bl. D1','SUCEAVA'),
(50690,'Gabrielle Dennis','+40-745-5587-224','STR. LUCA ARBORE nr. 2','IAŞI'),
(61495,'Moses Kemp','+40-705-5586-699','NR. 277','COM. CHEVEREŞU MARE'),
(36251,'Sasha Moyer','+40-705-5565-655','CAL. LUI TRAIAN nr. 331','VÂLCEA'),
(84625,'Selina Blackburn','+40-712-5555-605','STR. ALECSANDRI VASILE nr. 1','COMĂNEŞTI'),
(70219,'Demarcus Simmons','+40-705-5576-699','STR. VICTORIEI bl. Z1 ap. PARTER','COSTEŞTI'),
(10302,'Alana Yates','+40-711-5558-314','Strada Darniciei 10A','Bucuresti 5');
--printing customer table
SELECT *
FROM Customer
--inserting data into Order table
insert into Orderr(oid,quantity,price,pid,cid) values 
(123654,25,3000,852,10302),
(11111,6,120,852 , 70219),
(22222,2,140,349 , 97658),
(33333,5,100,396 , 84625),
(44444,1,160,462 , 79543),
(55555,30,300,946 ,69321),
(66666,10, 250,645, 61495),
(77777,20,800,496 , 50690),
(88888,50,1250,761 , 39456),
(99999,1,30,423 , 25498),
(12121,100,1000,946 ,10302);
--print Orderr table
SELECT * 
FROM Truck
--insert data int table Delivery
insert into Delivery(componentNR,deid,did,tid,oid,date,time) values
(1,876543,2574,6,22222,'2019-01-05','07:00:00'),
(2,345678,2574,2,33333,'2019-01-03','12:00:00'),
(3,123456,2574,1,12121,'2019-01-17','15:00:00'),
(4,123456,1353,1,99999,'2019-01-17','15:00:00'),
(5,123456,6237,1,88888,'2019-01-17','15:00:00'),
(6,123456,6237,1,77777,'2019-01-17','15:00'),
(7,234567,7458,7,55555,'2019-01-20','07:00:00'),
(8,234567,1353,7,44444,'2019-01-20','07:00:00');
--print the table Delivery
SELECT *
FROM Delivery
--update the price of flowers
UPDATE Plant
--SET price = price + 15
--WHERE price > 35
SET price = price + 5
WHERE price < 36
--add column age to the tables Driver and Gardener
ALTER TABLE Gardener
ADD age int NOT NULL DEFAULT(22)
ALTER TABLE Driver
ADD age int NOT NULL DEFAULT(27)
--add column city in table Customer
ALTER TABLE Customer
ADD city varchar(30) DEFAULT(NULL)
--update the driver id such that it wil have 4 digits
UPDATE Driver
SET did = did*10+did
--update some of the gardeners ages
UPDATE Gardener
SET age = age + 12
WHERE gardener.gid/1000 = 6
--have every record from Bucuresti uppercase
UPDATE Customer
SET address = UPPER(address),city = UPPER(city)
WHERE city LIKE 'BUCURESTI%'
--update the cid for every customer from Prahova or SUCEAVA
UPDATE Customer
SET cid = cid +1
WHERE city in ('PRAHOVA','SUCEAVA')
--update the price of certain flowers
UPDATE Plant
SET price = price - 30
WHERE price BETWEEN 90 AND 200 AND type NOT IN('Indoor Plants','Autumn Flower')
--delete data from Customer where the adress is null
DELETE 
FROM Customer 
WHERE address IS NULL OR city IS NULL
--delete from isWorking
DELETE
FROM isWorking
WHERE isWorking.date = '2019-01-06' AND isWorking.time<='12:00:00';
--union plants with a price over 40 or sold in more than 20 pieces
SELECT Plant.pid
FROM Plant
WHERE Plant.price > 40
UNION 
SELECT Orderr.pid
FROM Orderr
WHERE Orderr.quantity > 20
--union all customers from Bucuresti,Cluj or Timisoara and have orders of value over or equal to 1000
SELECT DISTINCT cid
FROM Customer
WHERE Customer.city = 'BUCURESTI%' OR Customer.city = 'TIMISOARA%' OR Customer.city = 'CLUJ%'
UNION ALL
SELECT DISTINCT cid 
FROM Orderr
WHERE Orderr.price >= 1000
--union all with or find the Garden Plants and Autumn Flowers
SELECT Plant.pid, Plant.name
FROM Plant
WHERE Plant.type = 'Autumn Flower' OR Plant.type = 'Garden Plants'
--union with or - find all gardeners that are working from 6:30 or 16:00
SELECT isWorking.gid,Gardener.name
FROM Gardener, isWorking
WHERE isWorking.gid = Gardener.gid AND (isWorking.time = '06:30:00' OR isWorking.time = '16:00:00')
-- insert find all gardeners who work on both 04.01.2019 and 07.01.2019
SELECT g1.gid
FROM isWorking g1
WHERE g1.date = '2019-01-04'
INTERSECT
SELECT g2.gid
FROM isWorking g2
WHERE g2.date = '2019-01-07' 
--intersect find all trucks that are functional,have a capacity greater than 1000 and are used in a delivery
SELECT t.tid as Capacity
FROM Truck t
WHERE t.state = 'functional'  AND t.capacity >= 1000  
INTERSECT 
SELECT  D.tid 
FROM Delivery D
ORDER BY Capacity DESC
--intersect with in all customers from Bucuresti and ordered both an Autumn Flowers and Garden Plants by name ascending
SELECT Orderr.cid, Customer.name
FROM Orderr,Customer, Plant
WHERE Orderr.cid = Customer.cid AND Customer.city LIKE 'BUCURESTI%' AND Plant.pid = Orderr.pid AND Plant.type IN('Autumn Flowers','Garden Plants')
ORDER BY Customer.name ASC
--intersect with in count the numbers of deliveries that start 007:00 or 12:00 for each driver
SELECT COUNT(DISTINCT Delivery.did) AS Count
FROM Driver,Delivery
WHERE Driver.did = Delivery.did AND Delivery.time IN('07:00:00','12:00:00')
--except find top 1  gardener that has the maxim age and works on the most expensive Feng Shui Plant
SELECT TOP 1 Gardener.gid,Gardener.name
FROM Gardener,isWorking
WHERE Gardener.gid IN(
	SELECT isWorking.gid
	FROM isWorking, Plant
	WHERE isWorking.pid = Plant.pid AND( Plant.price IN(SELECT MAX(price) FROM Plant)))
EXCEPT
SELECT Gardener.gid,Gardener.name
FROM Gardener
WHERE Gardener.age IN (SELECT MAX(age) FROM Gardener) 
--except and 2*except wihth not in find all gardeners that worked on Feng Shui Plants except for the top 1  gardener that has the maxim age and works on the most expensive Feng Shui Plant
SELECT DISTINCT Gardener.gid,Gardener.name
FROM Gardener,isWorking
WHERE Gardener.gid = isWorking.gid AND (isWorking.pid NOT IN(SELECT pid FROM Plant WHERE type NOT IN('Feng Shui Plants') ))
EXCEPT
SELECT TOP 1 Gardener.gid,Gardener.name
FROM Gardener,isWorking
WHERE Gardener.gid IN(
	SELECT isWorking.gid
	FROM isWorking, Plant
	WHERE isWorking.pid = Plant.pid AND( Plant.price IN(SELECT MAX(price) FROM Plant)))
--inner join find gardeners and their working dates and times
SELECT Gardener.gid, Gardener.name, isWorking.date, isWorking.time
FROM Gardener INNER JOIN isWorking on Gardener.gid = isWorking.gid
--left join relationship Orderr:Customer (many:many) show all customers and their orders
SELECT Customer.cid, Customer.name, Customer.city,Orderr.oid, Orderr.price
FROM Customer LEFT OUTER JOIN Orderr ON  Customer.cid = Orderr.cid
--right join show all orders and their customers
--to note the difference between the left and right joins used in the same form
SELECT Customer.cid, Customer.name, Customer.city,Orderr.oid, Orderr.price
FROM Customer RIGHT OUTER JOIN Orderr ON Customer.cid = Orderr.cid
--full join the tables gardener,isWorking, Plant and Building
SELECT  *
FROM Gardener FULL OUTER JOIN isWorking ON isWorking.gid = Gardener.gid
FULL OUTER JOIN Plant ON Plant.pid = isWorking.pid
FULL OUTER JOIN Building ON Building.bid = isWorking.bid
--1 subquerie in the where clause introducing another subquerie in its own where clause introduced by in show the drivers and their trucks for deliveries
SELECT DISTINCT  Driver.did, Driver.name, Truck.tid, Delivery.deid
FROM Driver,Truck,Delivery
WHERE Driver.did IN(SELECT DISTINCT Delivery.did FROM Delivery WHERE Delivery.tid IN (SELECT DISTINCT Truck.tid FROM Truck) AND Delivery.tid = Truck.tid) AND Driver.did = Delivery.did AND Delivery.tid = Truck.tid
--1 subquerie introduced by in show how many years the employes that started work have until retirement
SELECT DISTINCT (60-Gardener.age) AS time_until_retirement, Gardener.gid,Gardener.name,Gardener.age
FROM Gardener, isWorking
WHERE Gardener.gid IN (SELECT DISTINCT isWorking.gid FROM isWorking WHERE isWorking.date IS NOT NULL) AND Gardener.gid = isWorking.gid
--1 subquerie introduced by exists in the where clause top 2 Autumn Flowers by their sales
SELECT DISTINCT TOP 2 Plant.name,(Orderr.quantity * Plant.price) as order_price
FROM Plant,Orderr
WHERE Plant.type = 'Autumn Flower' AND EXISTS(SELECT Orderr.pid FROM Orderr WHERE Orderr.pid = Plant.pid )
ORDER BY order_price DESC
--1 subquerie introduced by exists in the where clause show bulding having more than 300 plants and contain Indoor Plants or Garden Plants
SELECT *
FROM Building,isWorking
WHERE Building.nrOfPlants > 300 AND EXISTS(SELECT type FROM Plant WHERE Plant.type IN('Indoor Plants','Garden Plants') AND isWorking.pid = Plant.pid) AND Building.bid = isWorking.bid
--1 subquerie introduced in the from clause show how much space is left free after one orderr is loaded
SELECT (A.Capacity - A.quantity* 2)as space_left,A.tid
FROM (SELECT Truck.tid,Truck.capacity,Orderr.quantity FROM Truck,Orderr,Delivery WHERE Truck.tid = Delivery.tid AND Delivery.oid = Orderr.oid) A
--1 subquerie introduced in the form clause show all customers outside Bucuresti that bought Plants
SELECT DISTINCT A.cid,A.name
FROM (SELECT Customer.cid,Customer.name FROM Customer LEFT JOIN Orderr ON Customer.cid = Orderr.cid) A,Plant
--group by count customers and the group them by city
SELECT COUNT(Customer.cid) AS Count,Customer.city
FROM Customer
GROUP BY city
--group by having cities that have the average price of orders greater than 100
SELECT Customer.city,AVG(Orderr.price) as Average_per_city
FROM Customer,Orderr
GROUP BY city HAVING AVG(Orderr.price) >100

--group by customer and their most expensive order
SELECT A.cid,A.name,A.oid,A.price
--FROM(SELECT Customer.cid, Customer.name, Customer.city,Orderr.oid, Orderr.price
FROM Customer LEFT OUTER JOIN as A ON  Customer.cid = Orderr.cid
GROUP BY A.cid HAVING (SELECT MAX(o.price) FROM Orderr o)
--group by with subquerie in having clause scount all plants grouped by type that are ordered in more than the average quantity
SELECT Plant.type , COUNT(Plant.pid) as Number_of_this_type
FROM Plant,Orderr
GROUP BY Plant.type HAVING (SELECT AVG(O.quantity) FROM ORderr O) < (SELECT MIN(Ord.quantity) FROM Orderr Ord)
--group gardeners by age and how much of them work in a certai
--group by with subqueries in having clause
--all introducing subquerie, display  all plants  that are not null
SELECT Plant.name
FROM Plant 
WHERE Plant.name <>ALL(SELECT Plant.name FROM Plant WHERE Plant.name = NULL)
--all display all drivers that don't have any delivery
SELECT Driver.did,Driver.name
FROM Driver
WHERE Driver.did<>ALL(SELECT Delivery.did FROM Delivery)
--any display all customers with a phone number ending in 314
SELECT Customer.name
FROM Customer
WHERE Customer.phoneNr=ANY(SELECT Customer.phoneNr FrOM Customer WHERE phoneNr LIKE '%-314' )
--any display all gardeners that are working on 05.01.2019
SELECT Gardener.gid,Gardener.name
FROM Gardener
WHERE Gardener.gid =ANY(SELECT isWorking.gid FROM isWorking WHERE isWorking.date = '2019-01-07' )
-- all replaced by count, count the plants that have name not null
SELECT COUNT(Plant.name) as nrOfPlants111111
FROM Plant
WHERE Plant.name is not NULL
--any replaced by sum display the plant that was sold in maxim number of pieces
SELECT Plant.pid,Plant.name
FROM Plant
WHERE Plant.pid > (SELECT AVG(b1.price) FROM Orderr b1)
--any replaced with in display all Gardeners that have maxim age or minim age
SELECT *
FROM Gardener
WHERE Gardener.age IN ((SELECT MAX(g1.age) FROM Gardener g1),(SELECT MIN(g2.age) FROM Gardener g2))
ORDER BY Gardener.age DESC
--all replaced by not in display all Plant that have the name not NULL
SELECT Plant.name 
FROM Plant
WHERE Plant.name NOT IN ('')

use greenhouse
SELECT * 
FROM Orderr
ORDER BY price DESC


