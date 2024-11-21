CREATE DATABASE IF NOT EXISTS SBIE;
USE SBIE;

CREATE TABLE BUSINESS (
    B_ID VARCHAR(50) PRIMARY KEY,
    B_Name VARCHAR(100),
    L_Name VARCHAR(100),
    F_Name VARCHAR(100),
    B_Type VARCHAR(50),
    OO_Mail VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE COMPETITORS (
    C_ID VARCHAR(50) PRIMARY KEY,
    C_Name VARCHAR(100),
    Industry_type VARCHAR(50),
    Prod_Sold INT,
    B_ID VARCHAR(50),
    FOREIGN KEY (B_ID) REFERENCES BUSINESS(B_ID)
);

CREATE TABLE ANALYSTS (
    A_ID VARCHAR(50) PRIMARY KEY,
    A_Name VARCHAR(100),
    Success_rate DECIMAL(5, 2),
    Experience INT,
    Salary DECIMAL(10, 2),
    B_ID VARCHAR(50),
    FOREIGN KEY (B_ID) REFERENCES BUSINESS(B_ID)
);

CREATE TABLE TRENDS (
    T_Type VARCHAR(50),
    Duration INT,
    Impact_level VARCHAR(50),
    A_ID VARCHAR(50),
    FOREIGN KEY (A_ID) REFERENCES ANALYSTS(A_ID)
);

CREATE TABLE INVESTORS (
    I_ID VARCHAR(50) PRIMARY KEY,
    I_Name VARCHAR(100),
    Industry_pref VARCHAR(50),
    Budget DECIMAL(15, 2),
    B_ID VARCHAR(50),
    FOREIGN KEY (B_ID) REFERENCES BUSINESS(B_ID)
);

CREATE TABLE CONTRACTS (
    Con_ID VARCHAR(50) PRIMARY KEY,
    Con_Type VARCHAR(50),
    Validity_period INT,
    B_ID VARCHAR(50),
    I_ID VARCHAR(50),
    FOREIGN KEY (B_ID) REFERENCES BUSINESS(B_ID),
    FOREIGN KEY (I_ID) REFERENCES INVESTORS(I_ID)
);

CREATE TABLE LEGAL_ADVISORY (
    L_ID VARCHAR(50) PRIMARY KEY,
    Adv_Name VARCHAR(100),
    L_Experience INT,
    Jurisdiction VARCHAR(100),
    Con_ID VARCHAR(50),
    B_ID VARCHAR(50),  -- Adding B_ID column for referencing BUSINESS table
    FOREIGN KEY (Con_ID) REFERENCES CONTRACTS(Con_ID),
    FOREIGN KEY (B_ID) REFERENCES BUSINESS(B_ID)  -- Foreign key constraint referencing BUSINESS table
);

CREATE TABLE PARTNERSHIP (
    P_ID VARCHAR(50) PRIMARY KEY,
    P_Name VARCHAR(100),
    P_Type VARCHAR(50),
    P_Industry VARCHAR(50),
    B_ID VARCHAR(50),
    FOREIGN KEY (B_ID) REFERENCES BUSINESS(B_ID)
);

CREATE TABLE VENDOR_SUPPLIER (
    V_ID VARCHAR(50) PRIMARY KEY,
    V_Name VARCHAR(100),
    V_Type VARCHAR(50),
    Budget DECIMAL(15, 2),
    Quality VARCHAR(50),
    V_loc VARCHAR(100),
    B_ID VARCHAR(50),
    FOREIGN KEY (B_ID) REFERENCES BUSINESS(B_ID)
);

CREATE TABLE LOCATION (
    LOC_ID VARCHAR(50) PRIMARY KEY,
    L_Name VARCHAR(100),
    Market_potential VARCHAR(50),
    Region VARCHAR(100),
    V_ID VARCHAR(50),
    FOREIGN KEY (V_ID) REFERENCES VENDOR_SUPPLIER(V_ID)
);

CREATE TABLE BENEFICIARY (
    Ben_ID VARCHAR(50) PRIMARY KEY,
    Ben_Name VARCHAR(100),
    Age INT,
    DOB DATE,
    Lease_Term INT,
    Mail VARCHAR(100),
    Phone VARCHAR(15),
    Owner VARCHAR(100),
    B_ID VARCHAR(50),
    FOREIGN KEY (B_ID) REFERENCES BUSINESS(B_ID)
);

CREATE TABLE archivedtrends (
    T_Type VARCHAR(50),
    Duration INT,
    Impact_level VARCHAR(50),
    A_ID VARCHAR(50),
    archived_date DATETIME,
    FOREIGN KEY (A_ID) REFERENCES ANALYSTS(A_ID)
);

-- Procedure to get business details and related data based on B_ID
DELIMITER //
CREATE PROCEDURE GetBusinessDetails(IN input_B_ID VARCHAR(50))
BEGIN
    -- Display Business Details
    SELECT * FROM BUSINESS WHERE B_ID = input_B_ID;
    
    -- Display Competitors
    SELECT * FROM COMPETITORS WHERE B_ID = input_B_ID;
    
    -- Display Analysts
    SELECT * FROM ANALYSTS WHERE B_ID = input_B_ID;
    
    -- Display Investors
    SELECT * FROM INVESTORS WHERE B_ID = input_B_ID;
    
    -- Display Contracts
    SELECT * FROM CONTRACTS WHERE B_ID = input_B_ID;
    
    -- Display Partnerships
    SELECT * FROM PARTNERSHIP WHERE B_ID = input_B_ID;
    
    -- Display Vendor Suppliers
    SELECT * FROM VENDOR_SUPPLIER WHERE B_ID = input_B_ID;
    
    -- Display Beneficiaries
    SELECT * FROM BENEFICIARY WHERE B_ID = input_B_ID;
END //
DELIMITER ;


-- Sample Data Insertion
INSERT INTO BUSINESS (B_ID, B_Name, L_Name, F_Name, B_Type, OO_Mail, Phone) VALUES
    ('FC_1', 'Clothes Co.', 'Smith', 'John', 'Fashion', 'clothesco@mail.com', '1234567890'),
    ('FS_1', 'Shoes Inc.', 'Doe', 'Jane', 'Fashion', 'shoesinc@mail.com', '0987654321'),
    ('FA_1', 'Accessories Hub', 'Brown', 'Alice', 'Fashion', 'accessories@mail.com', '1122334455'),
    ('TR_1', 'Travel Co 1', 'Taylor', 'Bob', 'Travel', 'travel1@mail.com', '1223334444'),
    ('TR_2', 'Travel Co 2', 'Clark', 'Emma', 'Travel', 'travel2@mail.com', '1333444555'),
    ('TR_3', 'Travel Co 3', 'Jones', 'Harry', 'Travel', 'travel3@mail.com', '1444555666'),
    ('SP_1', 'Sports Goods 1', 'White', 'James', 'Sports', 'sports1@mail.com', '1555666777'),
    ('SP_2', 'Sports Goods 2', 'Green', 'Eve', 'Sports', 'sports2@mail.com', '1666777888'),
    ('SP_3', 'Sports Goods 3', 'Black', 'Oscar', 'Sports', 'sports3@mail.com', '1777888999'),
    ('FB_1', 'Beverage Co.', 'Hall', 'Kate', 'Food', 'beverages@mail.com', '1888999000'),
    ('FE_1', 'Baked Goods', 'Scott', 'Lily', 'Food', 'bakedgoods@mail.com', '1999000111'),
    ('FE_2', 'Chocolate World', 'Young', 'Zoe', 'Food', 'chocolates@mail.com', '2111222333'),
    ('FA_2', 'Jewelry House', 'Moore', 'Ella', 'Fashion', 'jewelry@mail.com', '2223334444'),
    ('FS_2', 'Sneaker City', 'Harris', 'Noah', 'Fashion', 'sneakercity@mail.com', '2333444555'),
    ('SP_4', 'Outdoor Gear', 'Martin', 'Leo', 'Sports', 'outdoorgear@mail.com', '2444555666'),
    ('TR_4', 'Adventure Tours', 'Lee', 'Lucas', 'Travel', 'adventure@mail.com', '2555666777'),
    ('FC_2', 'High Fashion', 'Walker', 'Sophie', 'Fashion', 'highfashion@mail.com', '2666777888'),
    ('FB_2', 'Tea Time', 'Allen', 'Ryan', 'Food', 'teatime@mail.com', '2777888999'),
    ('FE_3', 'Cake Boutique', 'Wright', 'Mia', 'Food', 'cake@mail.com', '2888999000'),
    ('SP_5', 'Fitness Plus', 'Hill', 'Jack', 'Sports', 'fitness@mail.com', '2999000101');

INSERT INTO COMPETITORS (C_ID, C_Name, Industry_type, Prod_Sold, B_ID) VALUES
    ('1', 'ZARA', 'Fashion', 500, 'FC_1'),
    ('2', 'MOCHI', 'Fashion', 300, 'FS_1'),
    ('3', 'CLAIRES', 'Fashion', 450, 'FA_1'),
    ('4', 'TRIVAGO', 'Travel', 200, 'TR_1'),
    ('5', 'MAKE MY TRIP', 'Travel', 350, 'TR_2'),
    ('6', 'RED BUS', 'Travel', 400, 'TR_3'),
    ('7', 'DECATHLON', 'Sports', 250, 'SP_1'),
    ('8', 'ASICS', 'Sports', 600, 'SP_2'),
    ('9', 'SPEEDO', 'Sports', 1000, 'SP_3'),
    ('10', 'FROZEN BOTTLE', 'Food', 700, 'FB_1'),
    ('11', 'DOSA MANE', 'Food', 550, 'FE_1'),
    ('12', 'BURGER KING', 'Food', 800, 'FE_2'),
    ('13', 'LENSKART', 'Fashion', 350, 'FA_2'),
    ('14', 'BATA', 'Fashion', 500, 'FS_2'),
    ('15', 'WILSON', 'Sports', 300, 'SP_4'),
    ('16', 'EASE MY TRIP', 'Travel', 150, 'TR_4'),
    ('17', 'ZUDIO', 'Fashion', 450, 'FC_2'),
    ('18', 'PRIDE OF COWS', 'Food', 600, 'FB_2'),
    ('19', 'TACO BELL', 'Food', 650, 'FE_3'),
    ('20', 'WROGN', 'Sports', 500, 'SP_5');

INSERT INTO ANALYSTS (A_ID, A_Name, Success_rate, Experience, Salary, B_ID) VALUES
    ('A1', 'Alice', 90.00, 5, 60000, 'FC_1'),
    ('A2', 'Bob', 85.00, 7, 70000, 'FS_1'),
    ('A3', 'Charlie', 75.00, 4, 55000, 'FA_1'),
    ('A4', 'David', 92.00, 6, 72000, 'TR_1'),
    ('A5', 'Emma', 88.00, 3, 48000, 'TR_2'),
    ('A6', 'Frank', 80.00, 5, 59000, 'TR_3'),
    ('A7', 'Grace', 78.00, 4, 47000, 'SP_1'),
    ('A8', 'Hannah', 84.00, 3, 53000, 'SP_2'),
    ('A9', 'Ian', 76.00, 2, 42000, 'FE_1'),
    ('A10', 'Jack', 90.00, 5, 61000, 'FB_1');
    

INSERT INTO TRENDS (T_Type, Duration, Impact_level, A_ID) VALUES
    ('Sustainable Fashion', 12, 'High', 'A1'),
    ('AI in Fashion', 24, 'Medium', 'A2'),
    ('Eco-Friendly Materials', 36, 'High', 'A3'),
    ('Travel Personalization', 12, 'Medium', 'A4'),
    ('Budget Travel', 18, 'Medium', 'A5'),
    ('Luxury Travel', 24, 'High', 'A6'),
    ('Sports Health', 12, 'Medium', 'A7'),
    ('Wearable Technology', 18, 'High', 'A8'),
    ('Eco-Friendly Sports', 12, 'Medium', 'A9'),
    ('Healthy Food Trends', 6, 'High', 'A10');

INSERT INTO INVESTORS (I_ID, I_Name, Industry_pref, Budget, B_ID) VALUES
    ('I1', 'ARUSHI KATTA', 'Fashion', 1000000, 'FC_1'),
    ('I2', 'AMISHA JAIN', 'Fashion', 1500000, 'FS_1'),
    ('I3', 'ARCHISHA JANAWADE', 'Fashion', 2000000, 'FA_1'),
    ('I4', 'ARITRO MAITI', 'Travel', 2500000, 'TR_1'),
    ('I5', 'ADITYA TIWARI', 'Travel', 3000000, 'TR_2'),
    ('I6', 'BHASWATI CHOWDHARY', 'Travel', 3500000, 'TR_3'),
    ('I7', 'AMRITAA KALANEE', 'Sports', 500000, 'SP_1'),
    ('I8', 'ANNAPOORNESHWARI', 'Food', 600000, 'FE_1'),
    ('I9', 'ANJANA GANESH', 'Sports', 700000, 'SP_2'),
    ('I10', 'MS NAGASUNDARI', 'Food', 800000, 'FB_1');

INSERT INTO CONTRACTS (Con_ID, Con_Type, Validity_period, B_ID, I_ID) VALUES
    ('C1', 'Supply', 12, 'FC_1', 'I1'),
    ('C2', 'Partnership', 24, 'FS_1', 'I2'),
    ('C3', 'Collaboration', 36, 'FA_1', 'I3'),
    ('C4', 'Investment', 12, 'TR_1', 'I4'),
    ('C5', 'Joint Venture', 18, 'TR_2', 'I5'),
    ('C6', 'Merger', 24, 'TR_3', 'I6'),
    ('C7', 'Endorsement', 12, 'FE_1', 'I7'),
    ('C8', 'Sponsorship', 18, 'SP_1', 'I8'),
    ('C9', 'Licensing', 12, 'SP_2', 'I9'),
    ('C10', 'Franchise', 6, 'FB_1', 'I10'),
    ('C11', 'Endorsement', 12, 'SP_3', 'I7');

INSERT INTO LEGAL_ADVISORY (L_ID, Adv_Name, L_Experience, Jurisdiction, Con_ID, B_ID) VALUES
    ('L001', 'Brown & Associates', 15, 'International', 'C3', 'FA_1'),
    ('L002', 'Elite Legal Services', 10, 'Domestic', 'C5', 'FA_2'),
    ('L003', 'Global Law Partners', 20, 'International', 'C10', 'FB_1'),
    ('L004', 'Tea Leaf Legal', 8, 'Domestic', 'C7', 'FB_2'),
    ('L005', 'Fashion Law Hub', 12, 'International', 'C1', 'FC_1'),
    ('L006', 'The High Legal Group', 18, 'Domestic', 'C9', 'FC_2'),
    ('L007', 'Bakehouse Legal', 9, 'Domestic', 'C7', 'FE_1'),
    ('L008', 'ChocoLegal Services', 14, 'Domestic', 'C8', 'FE_2'),
    ('L009', 'Cake Counsel', 7, 'Domestic', 'C8', 'FE_3'),
    ('L010', 'Footwear Legal Advisors', 10, 'International', 'C2', 'FS_1'),
    ('L011', 'Sneaker Legal Network', 13, 'Domestic', 'C9', 'FS_2'),
    ('L012', 'Sports Legal Partners', 16, 'International', 'C8', 'SP_1'),
    ('L013', 'Green Legal Consultancy', 11, 'Domestic', 'C9', 'SP_2'),
    ('L014', 'Black & Co. Sports Law', 20, 'International', 'C11', 'SP_3'),
    ('L015', 'Outdoor Legal Support', 9, 'Domestic', 'C8', 'SP_4'),
    ('L016', 'Fitness Legal Advisors', 12, 'Domestic', 'C8', 'SP_5'),
    ('L017', 'Travel Counsel Partners', 15, 'International', 'C4', 'TR_1'),
    ('L018', 'Clark Legal Services', 10, 'Domestic', 'C5', 'TR_2'),
    ('L019', 'Jones & Partners', 17, 'International', 'C6', 'TR_3'),
    ('L020', 'Adventure Law Group', 18, 'Domestic', 'C4', 'TR_4');
   
INSERT INTO PARTNERSHIP (P_ID, P_Name, P_Type, P_Industry, B_ID)
VALUES
    ('P1', 'Partner1', 'Collaboration', 'Fashion', 'FC_1'),
    ('P2', 'Partner2', 'Sponsorship', 'Fashion', 'FS_1'),
    ('P3', 'Partner3', 'Joint Venture', 'Fashion', 'FA_1'),
    ('P4', 'Partner4', 'Collaboration', 'Travel', 'TR_1'),
    ('P5', 'Partner5', 'Sponsorship', 'Travel', 'TR_2'),
    ('P6', 'Partner6', 'Joint Venture', 'Travel', 'TR_3'),
    ('P7', 'Partner7', 'Collaboration', 'Sports', 'SP_1'),
    ('P8', 'Partner8', 'Sponsorship', 'Sports', 'SP_2'),
    ('P9', 'Partner9', 'Joint Venture', 'Sports', 'SP_3'),
    ('P10', 'Partner10', 'Collaboration', 'Food', 'FB_1'),
    ('P11', 'Partner11', 'Sponsorship', 'Food', 'FE_1'),
    ('P12', 'Partner12', 'Joint Venture', 'Food', 'FE_2'),
    ('P13', 'Partner13', 'Collaboration', 'Fashion', 'FA_2'),
    ('P14', 'Partner14', 'Sponsorship', 'Fashion', 'FS_2'),
    ('P15', 'Partner15', 'Joint Venture', 'Sports', 'SP_4'),
    ('P16', 'Partner16', 'Collaboration', 'Travel', 'TR_4'),
    ('P17', 'Partner17', 'Sponsorship', 'Fashion', 'FC_2'),
    ('P18', 'Partner18', 'Joint Venture', 'Food', 'FB_2'),
    ('P19', 'Partner19', 'Collaboration', 'Food', 'FE_3'),
    ('P20', 'Partner20', 'Sponsorship', 'Sports', 'SP_5');

INSERT INTO VENDOR_SUPPLIER (V_ID, V_Name, V_Type, Budget, Quality, V_loc, B_ID)
VALUES
    ('VS1_', 'Vendor1', 'Supplier', 50000.00, 'High', 'Mumbai', 'FC_1'),
    ('VS2_', 'Vendor2', 'Distributor', 60000.00, 'Medium', 'Delhi', 'FS_1'),
    ('VS3_', 'Vendor3', 'Retailer', 75000.00, 'High', 'Bangalore', 'FA_1'),
    ('VS4_', 'Vendor4', 'Supplier', 40000.00, 'Low', 'Mumbai', 'TR_1'),
    ('VS5_', 'Vendor5', 'Distributor', 55000.00, 'Medium', 'Delhi', 'TR_2'),
    ('VS6_', 'Vendor6', 'Retailer', 63000.00, 'High', 'Bangalore', 'TR_3'),
    ('VS7_', 'Vendor7', 'Supplier', 80000.00, 'High', 'Mumbai', 'FE_1'),
    ('VS8_', 'Vendor8', 'Distributor', 45000.00, 'Low', 'Delhi', 'SP_1'),
    ('VS9_', 'Vendor9', 'Retailer', 67000.00, 'Medium', 'Bangalore', 'SP_1'),
    ('VS10_', 'Vendor10', 'Supplier', 49000.00, 'Low', 'Mumbai', 'FB_1');

INSERT INTO LOCATION (LOC_ID, L_Name, Market_potential, Region, V_ID)
VALUES
    ('LOC1', 'Mumbai Central', 'High', 'West', 'VS1_'),
    ('LOC2', 'Delhi North', 'Medium', 'North', 'VS2_'),
    ('LOC3', 'Bangalore East', 'High', 'South', 'VS3_'),
    ('LOC4', 'Hyderabad South', 'Low', 'South', 'VS4_'),
    ('LOC5', 'Chennai West', 'Medium', 'South', 'VS5_'),
    ('LOC6', 'Kolkata East', 'High', 'East', 'VS6_'),
    ('LOC7', 'Pune West', 'High', 'West', 'VS7_'),
    ('LOC8', 'Ahmedabad Central', 'Low', 'West', 'VS8_'),
    ('LOC9', 'Jaipur North', 'Medium', 'North', 'VS9_'),
    ('LOC10', 'Lucknow Central', 'Low', 'North', 'VS10_');

INSERT INTO BENEFICIARY (Ben_ID, Ben_Name, Age, DOB, Lease_Term, Mail, Phone, Owner, B_ID)
VALUES
    ('BEN1', 'Rajesh Kumar', 35, '1989-05-12', 24, 'rajesh.kumar@example.com', '9123456780', 'Sunita Kumar', 'FC_1'),
    ('BEN2', 'Priya Sharma', 29, '1995-08-23', 36, 'priya.sharma@example.com', '9123456781', 'Amit Sharma', 'FS_1'),
    ('BEN3', 'Vikram Singh', 42, '1982-02-10', 18, 'vikram.singh@example.com', '9123456782', 'Meena Singh', 'FA_1'),
    ('BEN4', 'Neha Verma', 31, '1993-11-15', 48, 'neha.verma@example.com', '9123456783', 'Rohit Verma', 'TR_1'),
    ('BEN5', 'Arjun Patel', 27, '1997-04-20', 12, 'arjun.patel@example.com', '9123456784', 'Lakshmi Patel', 'SP_1'),
    ('BEN6', 'Aditi Nair', 30, '1994-07-13', 36, 'aditi.nair@example.com', '9123456785', 'Suresh Nair', 'FB_1'),
    ('BEN7', 'Ananya Gupta', 28, '1996-03-17', 24, 'ananya.gupta@example.com', '9123456786', 'Vivek Gupta', 'FE_1'),
    ('BEN8', 'Karan Desai', 33, '1991-09-22', 48, 'karan.desai@example.com', '9123456787', 'Rekha Desai', 'SP_2'),
    ('BEN9', 'Sneha Joshi', 26, '1998-11-30', 12, 'sneha.joshi@example.com', '9123456788', 'Anil Joshi', 'FB_2'),
    ('BEN10', 'Rohan Mehta', 40, '1984-01-05', 24, 'rohan.mehta@example.com', '9123456789', 'Pooja Mehta', 'TR_2');




-- Insert stored procedure with trigger integration
DELIMITER //

CREATE PROCEDURE InsertBusiness (
    IN p_B_ID VARCHAR(10),
    IN p_B_Name VARCHAR(50),
    IN p_B_Type VARCHAR(50),
    IN p_OO_Mail VARCHAR(100),
    IN p_Phone VARCHAR(50)
)
BEGIN
    -- Insert into BUSINESS table
    INSERT INTO BUSINESS (B_ID, B_Name, B_Type, OO_Mail, Phone)
    VALUES (p_B_ID, p_B_Name, p_B_Type, p_OO_Mail, p_Phone);
    
    -- No direct insertion into COMPETITORS needed; trigger will handle it
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER after_business_insert
AFTER INSERT ON BUSINESS
FOR EACH ROW
BEGIN
    -- Insert into COMPETITORS with default values, linking B_ID from BUSINESS
    INSERT INTO COMPETITORS (C_ID, C_Name, Industry_type, Prod_Sold, B_ID)
    VALUES (CONCAT('C_', NEW.B_ID), NEW.B_Name, NEW.B_Type, 0, NEW.B_ID);
END //

DELIMITER ;



--new tavle
CREATE TABLE ARCHIVEDTRENDS (
    T_Type VARCHAR(50),
    Duration INT,
    Impact_level VARCHAR(50),
    A_ID VARCHAR(50),
    FOREIGN KEY (A_ID) REFERENCES ANALYSTS(A_ID)
);


--procedure
DELIMITER $$

CREATE PROCEDURE ArchiveShortDurationTrends(IN input_duration INT)
BEGIN
    -- Archive trends with a duration less than the input value
    INSERT INTO archivedtrends (T_Type, Duration, Impact_level, A_ID, archived_date)
    SELECT T_Type, Duration, Impact_level, A_ID, NOW()
    FROM trends
    WHERE Duration < input_duration;

    -- Delete the archived trends from the original table
    DELETE FROM trends
    WHERE Duration < input_duration;
    
END $$

DELIMITER ;


--PROCEDURE: 
DELIMITER $$

CREATE PROCEDURE UndoArchiveTrends()
BEGIN
    -- Insert all records back to trends table from archivedtrends
    INSERT INTO trends (T_Type, Duration, Impact_level, A_ID)
    SELECT T_Type, Duration, Impact_level, A_ID
    FROM archivedtrends;

    -- Delete the restored records from archivedtrends
    DELETE FROM archivedtrends;
END $$

DELIMITER ;