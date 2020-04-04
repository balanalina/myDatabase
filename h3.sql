--versioning mechanism that allows you to easily move from one version of the database to another
use GreenHouse

SELECT * FROM Building2

CREATE TABLE Version(currentVersion INT)
INSERT INTO Version(currentVersion) values (0)

create table Building2(bid int, name varchar(50) not null,location varchar(50) PRIMARY KEY,nrOfPlants int check(nrOfPlants >0))
create table V(vid int,name varchar(3))
create table RV(rvid int, name varchar(3))
insert into V(vid,name) values
(1,'v1'),(2,'v2'),(3,'v3'),(4,'v4'),(5,'v5'),(6,'v6'),(7,'v7')
insert into RV(rvid,name) values
(1,'rv1'),(2,'rv2'),(3,'rv3'),(4,'rv4'),(5,'rv5'),(6,'rv6'),(7,'rv7')

EXEC (SELECT NAME FROM V where vid = 1)
ALTER TABLE Gardener2
ADD location VARCHAR(50) 


--1.Modify the type of a column
--make bid small int from int
CREATE PROCEDURE V1 AS
ALTER TABLE Building2
ALTER COLUMN bid SMALLINT
GO
--reverse
--make bid int from small int
CREATE PROCEDURE RV1 AS
ALTER TABLE Building2
ALTER COLUMN bid INT
GO

--2.Add a new column
--add column construction date
CREATE PROCEDURE V2 AS 
ALTER TABLE Building2
ADD constructionDate DATE
GO
--reverse
--drop column construction date
CREATE PROCEDURE RV2 AS
ALTER TABLE Building2
DROP COLUMN constructionDate
GO

--3.Add default constraint
--add sera as defult for name
CREATE PROCEDURE V3 AS
ALTER TABLE Building2
ADD CONSTRAINT df_building DEFAULT 'sera' FOR name
GO
--reverse
CREATE PROCEDURE RV3 AS
ALTER TABLE Building2
DROP CONSTRAINT df_building
GO	

--4.Add and remove a primary key.
CREATE PROCEDURE V4 AS
CREATE TABLE Gardener2(gid int , name varchar(50) not null,CONSTRAINT pk_gid PRIMARY KEY(gid),location varchar(50))
GO
--remove the primary key
CREATE PROCEDURE RV4 AS
ALTER TABLE Gardener2
DROP CONSTRAINT pk_gid
DROP TABLE Gardener2
GO

--5.Add a candidate key
CREATE PROCEDURE V5 AS
ALTER TABLE Gardener2
ADD CONSTRAINT ck_Gardener2 UNIQUE(gid,name)
GO
--remove the candidate key(gid,name)
CREATE PROCEDURE RV5 AS
ALTER TABLE Gardener2
DROP CONSTRAINT ck_Gardener2
GO

ALTER TABLE Gardener2
ADD location VARCHAR(50) 

--6.Add new column LOCATION in Gardener2 and make it foreign key that references building2
CREATE PROCEDURE V6 AS
ALTER TABLE Gardener2
ADD CONSTRAINT fk_Gardener2 FOREIGN KEY(location) REFERENCES Building2
GO
--drop the foreign key
CREATE PROCEDURE RV6 AS
ALTER TABLE Gardener2
DROP CONSTRAINT fk_Gardener2
GO

--7.Create table Degeaba
CREATE PROCEDURE V7 AS
CREATE TABLE Degeaba(degeabaid int)
GO
--remove table
CREATE PROCEDURE RV7 AS
DROP TABLE Degeaba
GO

CREATE PROCEDURE MAIN @version INT AS
IF @version < 0 or @version > 7 BEGIN
	PRINT 'There is no such version of the database!'
END
ELSE BEGIN 
	DECLARE @currentVersion INT
	SET @currentVersion = (SELECT currentVersion FROM Version)
	IF @currentVersion = @version BEGIN
		PRINT 'The database is already in this version!'
	END
	ELSE BEGIN
		DELETE FROM Version
		INSERT INTO Version(currentVersion) values (@version)
		DECLARE @execute nvarchar(3)
		IF @version > @currentVersion BEGIN
			WHILE @currentVersion < @version BEGIN
			SET @currentVersion = @currentVersion + 1
			SET @execute = (SELECT NAME FROM V WHERE vid = @currentVersion)
			EXECUTE sp_executesql  @execute
			PRINT 'Current version: '
			PRINT @currentVersion 
			END
		END
		ELSE BEGIN
			WHILE @currentVersion > @version BEGIN
				PRINT 'Current version: '
				PRINT @currentVersion + 1
				SET @execute = (SELECT NAME FROM RV WHERE rvid = @currentVersion)
				EXECUTE sp_executesql @execute
				SET @currentVersion = @currentVersion - 1
			END
		END
	END
END
GO



exec main 20
drop procedure main
select * from Version
