CREATE DATABASE sports_complex;

USE sports_complex;

CREATE TABLE Employee (
    EmployeeID INT AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(15) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Position ENUM ('Junior', 'Senior', 'Manager') NOT NULL DEFAULT 'Junior',
    Discount INT,
    PRIMARY KEY(EmployeeID)
);

DESC Employee;

CREATE TABLE Relative (
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Relation VARCHAR(50) NOT NULL,
    PRIMARY KEY (FirstName,LastName,EmployeeID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE
);

DESC Relative;

CREATE TABLE Branch (
    BranchID INT AUTO_INCREMENT,
    BranchName VARCHAR(100),
    Location VARCHAR(100),
    PRIMARY KEY (BranchID)
);

DESC Branch;

CREATE TABLE Sport (
    SportID INT AUTO_INCREMENT,
    SportName VARCHAR(50),
    Price DECIMAL(10, 2),
    PRIMARY KEY(SportID)
);

DESC Sport;

CREATE TABLE BranchSport (
    BranchID INT,
    SportID INT,
    PRIMARY KEY (BranchID, SportID),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID) ON DELETE CASCADE,
    FOREIGN KEY (SportID) REFERENCES Sport(SportID) ON DELETE CASCADE
);

DESC BranchSport;


CREATE TABLE Ticket (
    TicketID INT AUTO_INCREMENT,
    UserID INT NOT NULL,
    IsEmployee BOOLEAN,
    BranchID INT NOT NULL,
    SportID INT NOT NULL,
    DateOfUse DATE,
    Discount DECIMAL(5, 2),
    PricePaid DECIMAL(10, 2),
    PRIMARY KEY(TicketID),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID) ON DELETE CASCADE,
    FOREIGN KEY (SportID) REFERENCES Sport(SportID) ON DELETE CASCADE
);

DESC Ticket;

CREATE TABLE History (
    HistoryID INT AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    SportID INT NOT NULL,
    StartDate DATE,
    Count INT NOT NULL DEFAULT 0,
    PRIMARY KEY (HistoryID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE,
    FOREIGN KEY (SportID) REFERENCES Sport(SportID) ON DELETE CASCADE
);

DESC History;

-- For insert --
DELIMITER //
CREATE TRIGGER set_discount_eligibility
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
    IF NEW.Position = 'Junior' THEN
        SET NEW.Discount = 1;
    ELSEIF NEW.Position = 'Senior' THEN
        SET NEW.Discount = 2;
    ELSEIF NEW.Position = 'Manager' THEN
        SET NEW.Discount = 3;
    ELSE
        SET NEW.Discount = 0;
    END IF;
END;
//
DELIMITER ;


-- For update --
DELIMITER //
CREATE TRIGGER update_discount_eligibility
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF NEW.Position = 'Junior' THEN
        SET NEW.Discount = 1;
    ELSEIF NEW.Position = 'Senior' THEN
        SET NEW.Discount = 2;
    ELSEIF NEW.Position = 'Manager' THEN
        SET NEW.Discount = 3;
    ELSE
        SET NEW.Discount = 0;
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER set_price_paid
BEFORE INSERT ON Ticket
FOR EACH ROW
BEGIN
    DECLARE sport_price DECIMAL(10,2);
    DECLARE free_tickets INT;
    DECLARE used_tickets INT;
    DECLARE week_start DATE;
    
    SELECT Price INTO sport_price FROM Sport WHERE SportID = NEW.SportID;
    
    SET week_start = DATE_SUB(NEW.DateOfUse, INTERVAL WEEKDAY(NEW.DateOfUse) DAY);
    
    SELECT Discount INTO free_tickets FROM Employee WHERE EmployeeID = NEW.UserID;
    
    SELECT Count INTO used_tickets 
    FROM UsageQuota 
    WHERE EmployeeID = NEW.UserID 
      AND SportID = NEW.SportID 
      AND WeekStartDate = week_start;
    
    IF (used_tickets IS NULL OR used_tickets < free_tickets) THEN
        SET NEW.PricePaid = 0;
    ELSE
        SET NEW.PricePaid = sport_price;
    END IF;
END
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_price_paid
BEFORE UPDATE ON Ticket
FOR EACH ROW
BEGIN
    DECLARE sport_price DECIMAL(10,2);
    DECLARE free_tickets INT;
    DECLARE used_tickets INT;
    DECLARE week_start DATE;
    
    SELECT Price INTO sport_price FROM Sport WHERE SportID = NEW.SportID;
    
    SET week_start = DATE_SUB(NEW.DateOfUse, INTERVAL WEEKDAY(NEW.DateOfUse) DAY);
    
    SELECT Discount INTO free_tickets FROM Employee WHERE EmployeeID = NEW.UserID;
    
    SELECT Count INTO used_tickets 
    FROM UsageQuota 
    WHERE EmployeeID = NEW.UserID 
      AND SportID = NEW.SportID 
      AND WeekStartDate = week_start;
    
    IF (used_tickets IS NULL OR used_tickets < free_tickets) THEN
        SET NEW.PricePaid = 0;
    ELSE
        SET NEW.PricePaid = sport_price;
    END IF;
END
//
DELIMITER ;
