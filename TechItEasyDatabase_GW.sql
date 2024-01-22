DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS TelevisionCIModules;
DROP TABLE IF EXISTS TelevisionWallBrackets;
DROP TABLE IF EXISTS Televisions;
DROP TABLE IF EXISTS RemoteControllers;
DROP TABLE IF EXISTS CIModules;
DROP TABLE IF EXISTS WallBrackets;


CREATE TABLE Users
(
	username VARCHAR(50) NOT NULL UNIQUE,
	password VARCHAR(50) NOT NULL
);

CREATE TABLE RemoteControllers
(
-- Attributen vanuit de abstracte Product klasse
	productid INT PRIMARY KEY,
	productname VARCHAR(50) NOT NULL,
	brand VARCHAR(50),
	price DOUBLE PRECISION,
	currentStock INT NOT NULL,
	sold INT NOT NULL,
-- /Attributen vanuit de abstracte Product klasse
	compatibleWith VARCHAR(50),
	batteryType VARCHAR(50)
);

CREATE TABLE Televisions
(
-- Attributen vanuit de abstracte Product klasse
	productid INT PRIMARY KEY,
	productname VARCHAR(50) NOT NULL,
	brand VARCHAR(50),
	price DOUBLE PRECISION,
	currentStock INT NOT NULL,
	sold INT NOT NULL,
-- /Attributen vanuit de abstracte Product klasse
	televisionType VARCHAR(50) NOT NULL,
	available DOUBLE PRECISION,
	refreshRate DOUBLE PRECISION,
	screenType VARCHAR(50),
	remoteControlID INT,
	CONSTRAINT FK_Televisions_Remotecontrollers
	FOREIGN KEY (remoteControlID) REFERENCES remoteControllers(productid)
);

CREATE TABLE CIModules
(
-- Attributen vanuit de abstracte Product klasse
	productid INT PRIMARY KEY,
	productname VARCHAR(50) NOT NULL,
	brand VARCHAR(50),
	price DOUBLE PRECISION,
	currentStock INT NOT NULL,
	sold INT NOT NULL
-- /Attributen vanuit de abstracte Product klasse
);

-- Koppeltabel: Televisions & CI Modules
CREATE TABLE TelevisionCIModules
(
	id SERIAL PRIMARY KEY,
	televisionID INT NOT NULL,
	cimoduleID INT NOT NULL,
	CONSTRAINT FK_TelevisionCIModules_Televisions
	FOREIGN KEY (televisionID) REFERENCES Televisions(productID),
	CONSTRAINT FK_TelevisionCIModules_CIModules
	FOREIGN KEY (cimoduleID) REFERENCES CIModules(productID)
);

CREATE TABLE WallBrackets
(
-- Attributen vanuit de abstracte Product klasse
	productid INT PRIMARY KEY,
	productname VARCHAR(50) NOT NULL,
	brand VARCHAR(50),
	price DOUBLE PRECISION,
	currentStock INT NOT NULL,
	sold INT NOT NULL,
-- /Attributen vanuit de abstracte Product klasse
	adjustable BOOLEAN
);

-- Koppeltabel: Televisions & WallBrackets
CREATE TABLE TelevisionWallBrackets
(
	id SERIAL PRIMARY KEY,
	televisionID INT NOT NULL,
	wallbracketID INT NOT NULL,
	CONSTRAINT FK_TelevisionWallBrackets_Televisions
	FOREIGN KEY (televisionID) REFERENCES Televisions(productID),
	CONSTRAINT FK_TelevisionWallBrackets_WallBrackets
	FOREIGN KEY (wallbracketID) REFERENCES WallBrackets(productID)
);

INSERT INTO Users (Username, Password) VALUES ('Name of user', 'PassKey1'), ('Name of 2nd user', 'PassKey2');
INSERT INTO RemoteControllers (productid, productname,currentstock, sold) VALUES 
(1, 'ControlItEasy', 11, 34),(2, 'Advanced remote control', 7, 18);
INSERT INTO televisions (productid, productname,brand,currentstock, sold, televisiontype, remotecontrolid) VALUES 
(2, 'Grote platte TV','SIMSONG',3 ,1, 'LCD', 1),(3, 'Grote ronde TV','ZONIE',5 ,3, 'LCD',2);
INSERT INTO CIModules (productid,productname,brand,price,currentstock,sold) VALUES 
(7,'Ziggo smartcard reader','Honkytonky',13.5,13,8),(9,'KPN smartcard module','Smarties',18.75,3,7);
INSERT INTO TelevisionCIModules(televisionID,CIModuleID) VALUES (3,7),(3,9),(2,9),(2,7);
INSERT INTO WallBrackets (productID, productName, brand, currentstock, sold, adjustable) VALUES
(1,'TV Lifting System', 'Mount&Co', 15, 23, FALSE), (2, 'Magic TV Mount', 'Screen Solutions', 7, 9, TRUE);
INSERT INTO TelevisionWallBrackets (televisionID,WallBracketID) VALUES (3,1),(3,2),(2,1);

SELECT televisions.productname TV_name, televisions.brand TV_brand, cimodules.productname cimodule_name, cimodules.brand cimodule_brand, 
	remotecontrollers.productname remote_name, wallbrackets.productname WallBracket_name, wallbrackets.brand WallBracket_brand FROM televisions
	JOIN TelevisionCIModules ON Televisions.ProductID = TelevisionCIModules.televisionID
	JOIN CIModules ON TelevisionCIModules.CIModuleID = CIModules.productID
	JOIN RemoteControllers ON Televisions.remoteControlID = RemoteControllers.productID
	JOIN TelevisionWallBrackets ON Televisions.productID = TelevisionWallBrackets.televisionID
	JOIN WallBrackets ON TelevisionWallBrackets.WallBracketID = WallBrackets.productID
	;

-- SELECT * FROM Users;
-- SELECT * FROM RemoteControllers;
-- SELECT * FROM Televisions;
-- SELECT * FROM CIModules;
-- SELECT * FROM TelevisionCIModules;
-- SELECT * FROM WallBrackets;
-- SELECT * FROM TelevisionWallBrackets;