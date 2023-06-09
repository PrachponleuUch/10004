/*
104008587 Muhammad Mian
103988549 Hugo Tang
103518056 Prachponleu Uch
103989296 Noah Vancam
103987407 Matthew Doyle
*/

drop table ProductSelection;
drop table ProductOffering;
drop table PromotionalProduct;
drop table Booking;
drop table BrochureRequest;
drop table Customer;
drop table TeacherSession;
drop table CourseOfferings;
drop table Teacher;
drop table Course;

Create table Course(
    Ccode varchar2(10),
    Cname varchar2(50),
    Cdesc varchar2(500),
    Cdetails varchar2(500),
    Cdifficulty varchar2(12),
    Cduration varchar2(50),
    constraint C_Ccode_PK primary key (Ccode));

Create table Teacher(
    Tid varchar2(4),
    Tname varchar2(50) constraint Tname_NN Not Null,
    Tphonenum varchar2(11),
    constraint T_Tid_PK primary key (Tid));

Create table CourseOfferings(
    Ccode varchar2(10),
    Odate varchar2(10), --in YYYY-MM-DD format
    Tid varchar2(4) constraint Tid_NN Not Null,
    constraint O_Ccode_Odate_PK primary key (Ccode, Odate),
    constraint O_Ccode_Fk foreign key (Ccode) references Course,
    constraint O_Tid_FK foreign key (Tid) references Teacher);

Create table TeacherSession(
    Tid varchar2(4),
    Ccode varchar2(10),
    Odate varchar2(10),
    constraint TS_Tid_Ccode_Odate_Pk primary key (Tid, Ccode, Odate),
    constraint TS_Tid_FK foreign key (Tid) references Teacher,
    constraint TS_Ccode_Odate_FK foreign key (Ccode, Odate) references CourseOfferings);

Create table Customer(
    Custid varchar2(5),
    Custname varchar2(50),
    Custaddress varchar2(50),
    constraint Cust_Custid_PK primary key (Custid));

Create table BrochureRequest(
    Ccode varchar2(10),
    Custid varchar2(5),
    constraint BR_Ccode_Custid_PK primary key (Ccode, Custid),
    constraint BR_Ccode_FK foreign key (Ccode) references Course,
    constraint BR_Custid_FK foreign key (Custid) references Customer);

Create table Booking(
    Custid varchar2(5),
    Ccode varchar2(10),
    Odate varchar2(10),
    Rating number(3),
    Comments varchar2(100),
    constraint B_Ccode_Odate_Fk foreign key (Ccode, Odate) references CourseOfferings,
    constraint B_Custid_Fk foreign key (Custid) references Customer,
    constraint B_Rating_CK check (Rating >= 1 and Rating <= 5 or Rating = 0),
    constraint B_Custid_Ccode_Odate_PK primary key (Custid, Ccode, Odate));

Create table PromotionalProduct(
    PPid varchar2(4),
    PPdesc varchar2(50),
    PPprice number(3),
    constraint PP_PPid_Pk primary key (PPid));

Create table ProductOffering(
    PPid varchar2(4),
    Ccode varchar2(10),
    Odate varchar2(10),
    constraint PO_PPid_FK foreign key (PPid) references PromotionalProduct,
    constraint PO_Ccode_Odate_FK foreign key (Ccode, Odate) references CourseOfferings,
    constraint PO_PPid_Ccode_Odate_Pk primary key (PPid, Ccode, Odate));

Create table ProductSelection(
    PPid varchar2(4),
    Ccode varchar2(10),
    Odate varchar2(10),
    Custid varchar2(5),
    constraint PS_PPid_Ccode_Odate_FK foreign key (PPid, Ccode, Odate) references ProductOffering,
    constraint PS_Custid_Ccode_Odate_FK foreign key (Custid, Ccode, Odate) references Booking,
    constraint PS_PPid_Custid_Ccode_Odate_PK primary key (PPid, Custid, Ccode, Odate));

INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HAT_BEG000', 'How to change a Dryer Cord', 'If the program on your dryer cord dont fit your outlet, heres a quick fix', 'Under 2 hours', 'Beginner');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HAT_INT001', 'How to install a GFCI Outlet', 'Protect against electrical shocks by installing a GFCI outlet', 'Under 2 hours', 'Intermediate');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HAT_BEG001', 'Top Reasons Your Dishwasher Isnt Drying', 'Troubleshoot dishwasher drying issues in just a few simple steps', 'Under 2 hours', 'Beginner');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HAT_INT002', 'How to Install a Dryer Vent', 'Dryer venting is needed to remove moist and potentially hazardous air from your home', '2-4 hours', 'Intermediate');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HAT_INT003', 'How to Install a Garbage Disposal', 'Learn the steps to set up a garbage disposal to more effectively clean your kitchen', 'Under 2 hours', 'Intermediate');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HAT_ADV000', 'Tankless Gas Water Heater', 'Tankless water heaters quickly supply hot water to your home and can lower your heating bills', '2-4 hours', 'Advanced');

INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HSS_BEG000', 'How to Install a Smoke Detector', 'Install smoke detectors to keep your home and familt safe', 'Under 2 hours', 'Beginner');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HSS_BEG001', 'How to install a Door Lock', 'Boost your homes security with a new deadbolt door lock', 'Under 2 hours', 'Beginner');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HSS_INT000', 'How to Install a Flood Light', 'Safegaurd your home with motion-sensing exterior lighting', '2-4 hours', 'Intermediate');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HSS_ADV001', 'How to install a Fire Escape Ladder', 'Presented by this Old House', '2-4 hours', 'Advanced');


INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HTT_BEG000', 'How to Remove a Stripped Screw', 'Learn how to remove a stripped screw', 'Under 2 hours', 'Beginner');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HTT_BEG002', 'How to Change Table Saw Blade', 'Saftey is your primary concern when changing table saw blades', 'Under 2 hours', 'Beginner');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HTT_ADV002', 'How to Weld Aluminum', 'Up your welding game by learning how to weld aluminium like a pro', 'Over 1 day', 'Advanced');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('HTT_INT005', 'How to Cut Granite Tile', 'Learn how to use a wide range of tools and improve your D.I.Y. skills.', '2-4 Hours', 'Intermediate');

INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('LLT_BEG001', 'Lawn Mower Maintenance', 'get tips on how to keep your lawn mower in peak condition', 'Under 2 hours', 'Beginner');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('LLT_BEG002', 'How to Get Rid of Poison Ivy', 'Tips for identifying and getting rid of posion ivy without huring your yard or skin', 'Under 2 hours', 'Beginner');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('LLT_INT005', 'How to Install a French Drain', 'Install a french drain to direct runoff water out of your yard and prevent flooding', 'Over 1 day', 'Intermediate');
INSERT INTO Course (Ccode, Cname, Cdesc, Cduration, Cdifficulty) VALUES ('LLT_ADV005', 'How to Build a Shed', 'Get more storage space for outdoor tools and supplies by building a shed', 'Over 1 day', 'Advanced');



INSERT INTO Customer (Custid, Custname, Custaddress) VALUES ('C0102', 'Angela Montenegro', '2 Red St, Box Hill 3128');
INSERT INTO Customer (Custid, Custname, Custaddress) VALUES ('C0149', 'Jack Hodgins', '10 Black Rd Kew, 3103');
INSERT INTO Customer (Custid, Custname, Custaddress) VALUES ('C0405', 'Max Keenan', '1 Linda Cres, Hawthorn 3122');
INSERT INTO Customer (Custid, Custname, Custaddress) VALUES ('C1231', 'Zack Addy', '2 Green Way, Kew 3103');
INSERT INTO Customer (Custid, Custname, Custaddress) VALUES ('C2020', 'Camille Saroyan', '7 Kelly St, Hawthorn 3122');
INSERT INTO Customer (Custid, Custname, Custaddress) VALUES ('C3301', 'Lance Sweets', '1 John St, Hawthorn');
INSERT INTO Customer (Custid, Custname, Custaddress) VALUES ('C1471', 'Donald Trump', '10 United St, Kew 3101');
INSERT INTO Customer (Custid, Custname, Custaddress) VALUES ('C0856', 'Joseph Bidden', '10 United St, Kew 3101');


INSERT INTO Teacher (Tid, Tname, Tphonenum) VALUES('T01','Robert Chase','0401 112233');
INSERT INTO Teacher (Tid, Tname, Tphonenum) VALUES('T05','Lisa Cuddy','0402 223344');
INSERT INTO Teacher (Tid, Tname, Tphonenum) VALUES('T12','Alison Cameron','0403 334455');
INSERT INTO Teacher (Tid, Tname, Tphonenum) VALUES('T36','James Wilson','0404 445566');
INSERT INTO Teacher (Tid, Tname, Tphonenum) VALUES('T41','Eric Foreman','0405 556677');
INSERT INTO Teacher (Tid, Tname, Tphonenum) VALUES('T43','Amber Volakis','0406 667788');
INSERT INTO Teacher (Tid, Tname, Tphonenum) VALUES('T45','Chris Taub','0413 123456');

INSERT INTO CourseOfferings (Ccode, Odate, Tid) VALUES ('HAT_ADV000', '2021-01-02', 'T12');
INSERT INTO CourseOfferings (Ccode, Odate, Tid) VALUES ('HTT_ADV002', '2021-06-22', 'T36');
INSERT INTO CourseOfferings (Ccode, Odate, Tid) VALUES ('HTT_INT005', '2021-01-13', 'T12');
INSERT INTO CourseOfferings (Ccode, Odate, Tid) VALUES ('LLT_INT005', '2021-09-21', 'T36');
INSERT INTO CourseOfferings (Ccode, Odate, Tid) VALUES ('HSS_INT000', '2021-05-25', 'T41');
INSERT INTO CourseOfferings (Ccode, Odate, Tid) VALUES ('LLT_INT005', '2021-06-01', 'T41');
INSERT INTO CourseOfferings (Ccode, Odate, Tid) VALUES ('HSS_BEG001', '2021-07-06', 'T05');
INSERT INTO CourseOfferings (Ccode, Odate, Tid) VALUES ('HAT_INT003', '2021-07-13', 'T43');
INSERT INTO CourseOfferings (Ccode, Odate, Tid) VALUES ('LLT_BEG001', '2021-06-01', 'T01');
INSERT INTO CourseOfferings (Ccode, Odate, Tid) VALUES ('LLT_ADV005', '2021-06-15', 'T01');
INSERT INTO CourseOfferings (Ccode, Odate, Tid) VALUES ('LLT_BEG002', '2021-01-27', 'T05');

INSERT INTO TeacherSession (Tid, Ccode, Odate) VALUES ('T36' , 'HAT_ADV000', '2021-01-02');
INSERT INTO TeacherSession (Tid, Ccode, Odate) VALUES ('T12' , 'HTT_ADV002', '2021-06-22');
INSERT INTO TeacherSession (Tid, Ccode, Odate) VALUES ('T43' , 'HSS_INT000', '2021-05-25');
INSERT INTO TeacherSession (Tid, Ccode, Odate) VALUES ('T45' , 'HSS_INT000', '2021-05-25');
INSERT INTO TeacherSession (Tid, Ccode, Odate) VALUES ('T43' , 'LLT_INT005', '2021-06-01');
INSERT INTO TeacherSession (Tid, Ccode, Odate) VALUES ('T45' , 'LLT_INT005', '2021-06-01');
INSERT INTO TeacherSession (Tid, Ccode, Odate) VALUES ('T41' , 'HSS_BEG001', '2021-07-06');
INSERT INTO TeacherSession (Tid, Ccode, Odate) VALUES ('T41' , 'HAT_INT003', '2021-07-13');
INSERT INTO TeacherSession (Tid, Ccode, Odate) VALUES ('T45' , 'LLT_BEG001', '2021-06-01');
INSERT INTO TeacherSession (Tid, Ccode, Odate) VALUES ('T45' , 'LLT_ADV005', '2021-06-15');

INSERT INTO BrochureRequest (Ccode, Custid) VALUES ('HAT_ADV000', 'C3301');
INSERT INTO BrochureRequest (Ccode, Custid) VALUES ('HAT_ADV000', 'C0102');
INSERT INTO BrochureRequest (Ccode, Custid) VALUES ('HAT_ADV000', 'C1471');
INSERT INTO BrochureRequest (Ccode, Custid) VALUES ('HAT_ADV000', 'C0856');
INSERT INTO BrochureRequest (Ccode, Custid) VALUES ('HTT_INT005', 'C0102');
INSERT INTO BrochureRequest (Ccode, Custid) VALUES ('HTT_INT005', 'C1231');
	
INSERT INTO PromotionalProduct (PPid, PPdesc, PPprice) VALUES ('X01','Garden Hand Tool', 2);
INSERT INTO PromotionalProduct (PPid, PPdesc, PPprice) VALUES ('X02','10-piece spanner set', 3);
INSERT INTO PromotionalProduct (PPid, PPdesc, PPprice) VALUES ('X03','Hobby Hammer', 2);
INSERT INTO PromotionalProduct (PPid, PPdesc, PPprice) VALUES ('X04','Mini Pliers', 3);
INSERT INTO PromotionalProduct (PPid, PPdesc, PPprice) VALUES ('X05','BBQ Lighter', 3);
INSERT INTO PromotionalProduct (PPid, PPdesc, PPprice) VALUES ('X06','Combination Padlock', 2);
INSERT INTO PromotionalProduct (PPid, PPdesc, PPprice) VALUES ('X07','Glue & Repair kit', 1);
INSERT INTO PromotionalProduct (PPid, PPdesc, PPprice) VALUES ('X08','Surprise Pack', 4);
INSERT INTO PromotionalProduct (PPid, PPdesc, PPprice) VALUES ('X09','Build-a-fence DVD', 3);
INSERT INTO PromotionalProduct (PPid, PPdesc, PPprice) VALUES ('X10','Pocket Torch', 2);

INSERT INTO ProductOffering (PPid, Ccode, Odate) VALUES ('X01', 'HSS_INT000', '2021-05-25');
INSERT INTO ProductOffering (PPid, Ccode, Odate) VALUES ('X03', 'HSS_INT000', '2021-05-25');
INSERT INTO ProductOffering (PPid, Ccode, Odate) VALUES ('X07', 'LLT_BEG002', '2021-01-27');
INSERT INTO ProductOffering (PPid, Ccode, Odate) VALUES ('X08', 'LLT_BEG002', '2021-01-27');
INSERT INTO ProductOffering (PPid, Ccode, Odate) VALUES ('X09', 'LLT_BEG002', '2021-01-27');
INSERT INTO ProductOffering (PPid, Ccode, Odate) VALUES ('X02', 'HTT_INT005', '2021-01-13');
INSERT INTO ProductOffering (PPid, Ccode, Odate) VALUES ('X04', 'HTT_INT005', '2021-01-13');
INSERT INTO ProductOffering (PPid, Ccode, Odate) VALUES ('X06', 'HTT_INT005', '2021-01-13');

INSERT INTO Booking (Custid, Ccode, Odate, Rating, Comments) VALUES ('C0102', 'HAT_ADV000', '2021-01-02', 4, 'Well run. Afternoon tea was substandard');
INSERT INTO Booking (Custid, Ccode, Odate, Rating, Comments) VALUES ('C0102', 'HTT_INT005', '2021-01-13', 3, 'Good Course. Well Run. Very Noisy');
INSERT INTO Booking (Custid, Ccode, Odate, Rating, Comments) VALUES ('C1231', 'HAT_ADV000', '2021-01-02', 4, 'Good');
INSERT INTO Booking (Custid, Ccode, Odate, Rating, Comments) VALUES ('C1231', 'HSS_INT000', '2021-05-25', 3, 'Ok');
INSERT INTO Booking (Custid, Ccode, Odate, Rating, Comments) VALUES ('C0405', 'HAT_ADV000', '2021-01-02', 1, 'Ok, but toilet is smelly');
INSERT INTO Booking (Custid, Ccode, Odate, Rating, Comments) VALUES ('C0405', 'HSS_INT000', '2021-05-25', 1, 'Trainer dress not appropriate. Awful. Learnt nothing. Waste of time.');
INSERT INTO Booking (Custid, Ccode, Odate, Rating, Comments) VALUES ('C0405', 'LLT_BEG002', '2021-01-27', 1, 'Today toilet cleaned');
INSERT INTO Booking (Custid, Ccode, Odate, Rating, Comments) VALUES ('C2020', 'HAT_ADV000', '2021-01-02', 4, 'Great');
INSERT INTO Booking (Custid, Ccode, Odate, Rating, Comments) VALUES ('C2020', 'HTT_INT005', '2021-01-13', 3, 'Nice');
INSERT INTO Booking (Custid, Ccode, Odate, Rating, Comments) VALUES ('C0149', 'LLT_BEG002', '2021-01-27', 5, 'Best one so far');
INSERT INTO Booking (Custid, Ccode, Odate, Rating, Comments) VALUES ('C0149', 'HTT_INT005', '2021-01-13', 5, 'None');

INSERT INTO ProductSelection (Ccode, Odate, Custid, PPid) VALUES ('HTT_INT005', '2021-01-13', 'C0102', 'X02'); 
INSERT INTO ProductSelection (Ccode, Odate, Custid, PPid) VALUES ('HTT_INT005', '2021-01-13', 'C0102', 'X04');
INSERT INTO ProductSelection (Ccode, Odate, Custid, PPid) VALUES ('HTT_INT005', '2021-01-13', 'C2020', 'X06');
INSERT INTO ProductSelection (Ccode, Odate, Custid, PPid) VALUES ('LLT_BEG002', '2021-01-27', 'C0405', 'X07');
INSERT INTO ProductSelection (Ccode, Odate, Custid, PPid) VALUES ('LLT_BEG002', '2021-01-27', 'C0405', 'X08');
INSERT INTO ProductSelection (Ccode, Odate, Custid, PPid) VALUES ('LLT_BEG002', '2021-01-27', 'C0405', 'X09');
INSERT INTO ProductSelection (Ccode, Odate, Custid, PPid) VALUES ('LLT_BEG002', '2021-01-27', 'C0149', 'X07');



-- 6
--Query A
SELECT B.Ccode as CourseCode, CO.Cdesc as Description, O.Odate as ODate, C.Custname as CustomerName
FROM Course CO 
INNER JOIN CourseOfferings O
ON CO.Ccode = O.Ccode
INNER JOIN Booking B
ON B.Ccode = O.Ccode
INNER JOIN Customer C
ON C.Custid = B.Custid
ORDER BY B.Ccode, CO.Cdesc, O.Odate, C.Custname;

--Query B
SELECT P.Ccode as CourseCode, P.Odate as ODate, C.Custname as CustomerName, P.PPid as ProductSelected
FROM ProductSelection P
INNER JOIN Customer C
ON P.Custid = C.Custid
ORDER BY P.Ccode, P.Odate, C.Custname, P.PPid;
--Query C
SELECT C.Custname as CustName, B.Ccode as CourseCode, CO.Cname as CourseName 
FROM BrochureRequest B
INNER JOIN Customer C
ON B.Custid = C.Custid
INNER JOIN Course CO
ON B.Ccode = CO.Ccode
ORDER BY C.Custname, B.Ccode, CO.Cname;
--Query D
drop view countbookings;

Create VIEW countbookings as
SELECT B.Ccode, C.Cdesc, B.Odate, count(*) as TotalBookings
FROM Booking B
INNER JOIN Course C
ON C.Ccode = B.Ccode
GROUP BY B.Ccode, B.Odate, C.Cdesc
ORDER BY B.Ccode, C.Cdesc;

SELECT * from countbookings;
--Query E
SELECT Ccode, Cdesc, Sum(TotalBookings) as TotalBookings
FROM countbookings
GROUP BY Ccode, Cdesc;

--7
--Query A
SELECT B.Ccode as CourseCode, C.Cdesc as Description, Count(*) as Count
FROM Booking B
INNER JOIN Course C
ON C.Ccode = B.Ccode
GROUP BY B.Ccode, C.Cdesc
ORDER BY B.Ccode, C.Cdesc;
--Query B
SELECT T.Tname as Teacher, O.Ccode as CourseCode, O.Odate as ODate, Avg(B.Rating) as AVG
from CourseOfferings O
INNER JOIN Teacher T
on O.Tid = T.Tid
INNER JOIN Booking B
on O.Odate = B.Odate and O.Ccode = B.Ccode
GROUP by B.Rating,T.Tname,O.Odate,O.Ccode
ORDER by Avg(B.rating) DESC;
--Query C
SELECT PP.PPid, Count(PS.PPid)
from PromotionalProduct PP
left join ProductSelection PS
on PP.PPid = PS.PPid
GROUP BY PP.PPid
ORDER by PP.PPid;
--Query D
SELECT AVG(Rating) as Rating
FROM Booking;
--Query E
SELECT B.Ccode as CourseCode, C.Cdesc as Description
FROM Booking B
INNER JOIN Course C
ON C.Ccode = B.Ccode
WHERE Rating > (SELECT AVG(Rating) FROM Booking);