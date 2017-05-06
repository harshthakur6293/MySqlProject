# Harsh Thakur
# Homework 2-5
# U01232909
# DATABASE PROGRAMMING
# Monday Batch

-- Creating pacenetworks database
DROP DATABASE IF EXISTS pacenetworks;
CREATE DATABASE pacenetworks;
USE pacenetworks;

SELECT "Database pacenetworks created & in use" AS "Database Created";

-- Creating Table data_center
DROP TABLE IF EXISTS data_center;
CREATE TABLE data_center (
Name VARCHAR(20) NOT NULL UNIQUE,
Location_X INT NOT NULL,
Location_Y INT NOT NULL,
PRIMARY KEY (Name));

SELECT "The data_center table has been created" as "Msg";
INSERT INTO data_center VALUES ('PaceData',0,0);

SELECT * from data_center;
SELECT "The data_center table has been populated" as "Msg";

-- Creating Table server_farm
DROP Table IF EXISTS server_farm;
CREATE TABLE server_farm (
Name Varchar(20) NOT NULL,
Data_Center Varchar(20) NOT NULL,
Location_X INT NOT NULL,
Location_Y INT NOT NULL,
PRIMARY KEY (Name),
FOREIGN KEY (Data_Center) REFERENCES data_center(Name));

SELECT "The server_farm table has been created" as "Msg";

-- Inserting into Table server_farm

INSERT INTO server_farm VALUES ('PD-SF-01','PaceData',10,10),('PD-SF-02','PaceData',20,20),('PD-SF-03','PaceData',30,30);
-- Display
SELECT * FROM server_farm;

SELECT "The server_farm table has been populated" as "Msg";

-- Rack Type Table
DROP TABLE IF EXISTS rack_type;
CREATE TABLE rack_type (
Type Varchar(20) NOT NULL,
Height INT NOT NULL,
Width INT NOT NULL,
Depth INT NOT NULL,
ShelfCount INT NOT NULL,
Manufacturer CHAR(5) NOT NULL,
Cost DECIMAL(6,2) NOT NULL,
PRIMARY KEY (Type,Manufacturer));

SELECT "The rack_type table has been created" AS "Msg";
INSERT INTO rack_type VALUES ('R530',10,20,18,20,'CISCO',1825.00),('R330',10,40,20,25,'RAMCO',2789.00);

SELECT * from rack_type; 
SELECT "The rack_type table has been populated" AS "Msg";

-- Rack Table
DROP TABLE IF EXISTS rack;
CREATE TABLE rack (
ID Varchar(20) NOT NULL UNIQUE,
ServerFarm Varchar(20) NOT NULL,
Type Varchar(20) NOT NULL,
Status ENUM ('Online','Offline') NOT NULL,
PRIMARY KEY (ID),
FOREIGN KEY (ServerFarm) REFERENCES server_farm(Name),
FOREIGN KEY (Type) REFERENCES rack_type(Type));


SELECT "The rack table has been created" AS "Msg";
INSERT INTO rack VALUES ('R-01-001','PD-SF-01','R530','Online'),('R-01-002','PD-SF-01','R530','Online'),('R-01-003','PD-SF-01','R530','Online'),('R-02-001','PD-SF-02','R330','Online'),('R-02-002','PD-SF-02','R330','Online'),('R-02-003','PD-SF-02','R330','Online'),('R-03-001','PD-SF-03','R530','Online'),('R-03-002','PD-SF-03','R530','Online'),('R-03-003','PD-SF-03','R530','Online');

SELECT * FROM rack;
SELECT "The rack table has been populated" AS "Msg";

# Server Type Table
DROP TABLE IF EXISTS server_type;
CREATE TABLE server_type (
Type Varchar(20) NOT NULL,
Power Varchar(20) NOT NULL,
Cooling char(3) NOT NULL,
Storage varchar(4) NOT NULL,
Processor varchar(5) NOT NULL,
OS Enum ('Windows','Linux','OS-X') NOT NULL, 
Manufacturer char(5) NOT NULL,
Cost DECIMAL(6,2) NOT NULL,
PRIMARY KEY (Type));


#Server Table
DROP TABLE IF EXISTS server;
CREATE TABLE server (
ID Varchar(20) NOT NULL,
Rack Varchar(20) NOT NULL,
Type Varchar(20) NOT NULL,
Status Enum ('Online','Offline') NOT NULL,
PRIMARY KEY(ID),
FOREIGN KEY (Type) REFERENCES server_type(Type));


INSERT INTO server_type VALUES ('CISCO-12','120 Volts','Fan','1TB','I7-ST','Windows','CISCO',5987.00);

INSERT INTO server VALUES ('S-01-001','R-01-001','CISCO-12','Online'),('S-01-002','R-01-001','CISCO-12','Online'),('S-01-003','R-01-001','CISCO-12','Online'),('S-02-001','R-02-002','CISCO-12','Online'),('S-02-002','R-02-003','CISCO-12','Offline'),('S-03-001','R-03-001','CISCO-12','Offline'),('S-03-002','R-03-001','CISCO-12','Offline'),('S-03-003','R-03-001','CISCO-12','Offline'),('S-03-004','R-03-001','CISCO-12','Offline'),('S-03-005','R-03-001','CISCO-12','Offline');

SELECT * from server;
SELECT "The server table has been populated" AS "Msg";
SELECT * from server_type;
SELECT "The server_type table has been populated" AS "Msg";


# Network Table
DROP TABLE IF EXISTS network;
CREATE TABLE network (
Designation varchar(20) NOT NULL,
Bandwidth varchar(10) NOT NULL,
Reliability Enum ('Excelleent','Good','Average','Poor') NOT NULL,
Status Enum ('Online','Offline') NOT NULL,
CurrentLoad varchar(10) NOT NULL,
PRIMARY KEY(Designation));

SELECT "The network table has been created" AS MSG;
# Client Table 

DROP TABLE IF EXISTS client;
CREATE TABLE client(
Client_No INT AUTO_INCREMENT COMMENT 'Client_No.',
IDNumber Varchar(10) NOT NULL,
IPAddress Varchar(16) NOT NULL,
Device Varchar(20) NOT NULL,
OnNetwork Varchar(20) NOT NULL,
Location_X INT NOT NULL,
Location_Y INT NOT NULL,
PRIMARY KEY(Client_No),
FOREIGN KEY(OnNetwork) REFERENCES network(Designation));

SELECT "The Client Table has been created" AS MSG;



# Switch_Type Table

DROP TABLE IF EXISTS switch_type;
CREATE TABLE switch_type(
Type Varchar(20) NOT NULL,
Uplink Varchar(4) NOT NULL,
Ports INT NOT NULL,
FRate Varchar(10) NOT NULL,
Manufacturer Varchar(20) NOT NULL,
Cost DECIMAL(6,2) NOT NULL,
PRIMARY KEY (Type));

SELECT "The Switch_Type Table has been created" AS MSG;


# Switch Table

DROP TABLE IF EXISTS switch;
CREATE TABLE switch (
ID Varchar(20) NOT NULL,
Network varchar(20) NOT NULL,
Type Varchar(20) NOT NULL,
Location_X INT NOT NULL,
Location_Y INT NOT NULL,
PRIMARY KEY(ID),
FOREIGN KEY(Network) REFERENCES network(Designation),
FOREIGN KEY(Type) REFERENCES switch_type(Type));

SELECT "The Switch Table has been created" AS MSG;



#Router_Type Table
DROP TABLE IF EXISTS router_type;
CREATE TABLE router_type (
Type Varchar(20) NOT NULL,
SignalRange Varchar(20) NOT NULL,
Manufacturer Varchar(10) NOT NULL,
Cost DECIMAL(6,2) NOT NULL,
PRIMARY KEY(Type));

SELECT "The Router_Type Table has been created" AS MSG;




# Router Table

DROP TABLE IF EXISTS router;
CREATE TABLE router(
ID Varchar(20) NOT NULL,
Network varchar(20) NOT NULL,
Type Varchar(20) NOT NULL,
Location_X INT NOT NULL,
Location_Y INT NOT NULL,
PRIMARY KEY(ID),
FOREIGN KEY(Network) REFERENCES network(Designation),
FOREIGN KEY(Type) REFERENCES router_type(Type));

SELECT "The Router Table has been created" AS MSG;


INSERT INTO network VALUES('Spectrum-A','1Gbps','Poor','Offline','None'),('Spectrum-B','1Gbps','Poor','Offline','None'),('Spectrum-C','1Gbps','Poor','Offline','None');
SELECT * from network;

SELECT "The network table has been populated" AS "Msg";

INSERT INTO client VALUES(NULL,'C-00-001','127.255.255.001','Dell XPS Laptop','Spectrum-A',1200,1200),(NULL,'C-00-002','127.255.255.002','IBM TP Laptop','Spectrum-B',1100,1100),(NULL,'C-00-003','127.255.255.003','Apple Laptop','Spectrum-C',1000,1000);
SELECT * from client;

SELECT "The client table has been populated" AS "Msg";

INSERT INTO switch_type VALUES('S-200','3GB',50,'200MB','CISCO',5200.00),('S-205','5GB',75,'300MB','SPANX',6300.00);
SELECT * from switch_type;

SELECT "The switch_type table has been populated" AS "Msg";

INSERT INTO switch VALUES('A-S-001','Spectrum-A','S-200',120,120),('B-S-001','Spectrum-B','S-200',220,220),('C-S-001','Spectrum-C','S-205',330,330);
SELECT * from switch;

SELECT "The switch table has been populated" AS "Msg";

INSERT INTO router_type VALUES('R-330','50 meters','CISCO',200.00),('S-530','100 meters','SAMSUNG',370.00);
SELECT * from router_type;

SELECT "The router_type table has been populated" AS "Msg";


INSERT INTO router VALUES('A-R-001','Spectrum-A','R-330',170,120),('B-R-001','Spectrum-B','S-530',270,220),('C-R-001','Spectrum-C','S-530',380,330);
SELECT * from router;

SELECT "The router table has been populated" AS "Msg";


# Device_Type Table
DROP TABLE IF EXISTS device_type;
CREATE TABLE device_type(
Type Varchar(20) NOT NULL,
Processor Varchar(20) NOT NULL,
RAM Varchar(10) NOT NULL,
Storage Varchar(10) NOT NULL,
OS Enum ('Windows','Linux','OS-X') NOT NULL,
Manufacturer Varchar(10) NOT NULL,
Cost DECIMAL(6,2) NOT NULL,
PRIMARY KEY(Type));

INSERT INTO device_type VALUES('Dell XPS Laptop','Intel-I7','16GB','1TB','Windows','Dell',990.00),('IBM TP Laptop','AMD-6000','8GB','500GB','Linux','IBM',1200.00),('Apple Laptop','Intel-I5','8GB','500GB','OS-X','Apple',3200.00);



# Device Table
DROP TABLE IF EXISTS device;
CREATE TABLE device(
Client_No INT AUTO_INCREMENT COMMENT 'Client Number',
MCode Varchar(10) NOT NULL,
Type Varchar(20) NOT NULL,
PRIMARY KEY(Client_No),
FOREIGN KEY(Client_No) REFERENCES client(Client_No),
FOREIGN KEY(Type) REFERENCES device_type(Type));


INSERT INTO device VALUES(NULL,'D-001','Dell XPS Laptop'),(Null,'P-001','IBM TP Laptop'),(NULL,'A-001','Apple Laptop');

SELECT * from device;
SELECT * from device_type;

SELECT "The device table has been populated" AS "Msg";

SELECT "The device_type table has been populated" AS "Msg";

# Functions
DROP FUNCTION IF EXISTS Dist;

DELIMITER //
CREATE FUNCTION Dist (A INT, B INT, C INT, D INT)
RETURNS DECIMAL(6,2)

BEGIN
	DECLARE X DECIMAL(9,2);
	DECLARE	Y DECIMAL(9,2);
	DECLARE Z DECIMAL(9,2);
	SET X = A - C;
	SET Y = B - D;
	SET X = POW(X,2);
	SET Y = POW(Y,2);
	SET Z = X + Y;
	SET Z = SQRT(Z);
	RETURN Z;

END //
DELIMITER ;

#SELECT router.Location_X,router.Location_Y FROM router;
#SELECT switch.Location_X,switch.Location_Y FROM switch;

/***CREATE TABLE Eud AS (
Select router.Location_X AS X1, router.Location_Y AS Y1, switch.Location_X AS X2, switch.Location_Y AS Y2 from router inner join switch ON router.Network = switch.Network
);

Select * from Eud;

select Dist(X1,Y1,X2,Y2) AS Distances from Eud;
***/

SELECT Dist(router.Location_X, router.Location_Y, switch.Location_X, switch.Location_Y) AS "Euclidean Distance" from router JOIN switch ON router.Network = switch.Network;





DROP FUNCTION IF EXISTS TotalCost;
DELIMITER //
CREATE FUNCTION TotalCost(A INT, B INT)
RETURNS DECIMAL(6,2)

BEGIN
	DECLARE C DECIMAL(6,2);
	SET C = A * B;
	RETURN C;

END //
DELIMITER ;

SELECT TotalCost((Select Cost from switch_type WHERE Manufacturer = 'CISCO'),(SELECT COUNT(*) from switch_type WHERE Manufacturer = 'CISCO')) AS "The total cost of CISCO switches on the network is";



DROP FUNCTION IF EXISTS PercentOnline;
DELIMITER //
CREATE FUNCTION PercentOnline(A INT, B INT)
RETURNS DECIMAL(6,2)

BEGIN
	DECLARE X DECIMAL(6,2);
	DECLARE Y DECIMAL(6,2);
	DECLARE Z DECIMAL(6,2);
	SET X = A;
	SET Y = B;
	SET Z = (X / Y) * 100;
	Return Z;

END //
DELIMITER ;

SELECT PercentOnline((SELECT COUNT(*) from server WHERE Status = 'Online'), (SELECT COUNT(*) from server)) AS "Percentage of Server's Online";



DROP FUNCTION IF EXISTS ConvertMB;
DELIMITER //
CREATE FUNCTION ConvertMB(A INT)
RETURNS INT

BEGIN
	DECLARE X INT;
	SET X = A * 1000;
	RETURN X;

END //
DELIMITER ;

SELECT ConvertMB(1) AS "Convert GB TO MB";


DROP FUNCTION IF EXISTS ConvertGB;
DELIMITER //
CREATE FUNCTION ConvertGB(A INT)
RETURNS INT

BEGIN
	DECLARE X INT;
	SET X = A / 1000;
	RETURN X;

END //
DELIMITER ;

SELECT ConvertGB(1000) AS "Convert MB TO GB";