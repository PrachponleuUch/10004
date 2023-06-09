/* 
104008587 Muhammad Mian
103988549 Hugo Tang
103518056 Prachponleu Uch
103989296 Noah Vancam 
*/ 
/*
=============================================================================================================

    TASK 1:              
 
=============================================================================================================
*/
DROP TABLE WORK_SESSION;
DROP TABLE ALLOCATION;
DROP TABLE AUTHOR;
DROP TABLE BOOK;

--Creating Table Book;
CREATE TABLE BOOK(
BID NUMBER(4),
TITLE VARCHAR2(30) NOT NULL,
SELLINGPRICE NUMBER(6,2), 
CONSTRAINT CK_SELLINGPRICE CHECK (SELLINGPRICE>=0),
CONSTRAINT PK_BOOK PRIMARY KEY(BID)
);

--Creating Table Author;
CREATE TABLE AUTHOR(
AUTHID NUMBER(4) CONSTRAINT PK_AUTHOR PRIMARY KEY,
SNAME VARCHAR2(30), 
FNAME VARCHAR2(30), 
CONSTRAINT UN_FNAME UNIQUE (SNAME, FNAME)
);

--Creating Table Allocation;
CREATE TABLE ALLOCATION(
PAYRATE NUMBER (6,2), 
CONSTRAINT CK_PAYRATE CHECK (PAYRATE>=1 AND PAYRATE<=79.99),
BID NUMBER(4),
AUTHID NUMBER(4),
CONSTRAINT PK_ALLOCATION PRIMARY KEY (AUTHID, BID),
CONSTRAINT FK_ALLOCATION FOREIGN KEY (BID) REFERENCES BOOK,
CONSTRAINT FK_ALLLOCATION FOREIGN KEY (AUTHID) REFERENCES AUTHOR  
);

--Insert Data into Book Table
INSERT INTO BOOK (BID,TITLE, SELLINGPRICE) VALUES (101, 'Knitting with Dog Hair', 6.99);
INSERT INTO BOOK (BID,TITLE, SELLINGPRICE) VALUES (105, 'Avoiding Large Ships', 11);
INSERT INTO BOOK (BID,TITLE, SELLINGPRICE) VALUES (107, 'Dealing with stuff', 6.5);
INSERT INTO BOOK (BID,TITLE, SELLINGPRICE) VALUES (108, 'Teach fish to sing', 10.99);
INSERT INTO BOOK (BID,TITLE, SELLINGPRICE) VALUES (109, 'Guide to hands free texting', 10.5);
INSERT INTO BOOK (BID,TITLE, SELLINGPRICE) VALUES (113, 'You call that a lecture?', 17.5);

--Insert Data into Author Table;
INSERT INTO AUTHOR (AUTHID, SNAME, FNAME) VALUES (40, 'Abbott', 'Tony');
INSERT INTO AUTHOR (AUTHID, SNAME, FNAME) VALUES (42, 'Bishop', 'Bronwyn');
INSERT INTO AUTHOR (AUTHID, SNAME, FNAME) VALUES (44, 'Fischer', 'Tim');
INSERT INTO AUTHOR (AUTHID, SNAME, FNAME) VALUES (45, 'Grossman', 'Paul');
INSERT INTO AUTHOR (AUTHID, SNAME, FNAME) VALUES (47, 'Ziggle', 'Annie');
INSERT INTO AUTHOR (AUTHID, SNAME, FNAME) VALUES (48, 'Zhao', 'Cheng');
INSERT INTO AUTHOR (AUTHID, SNAME, FNAME) VALUES (50, 'Phan', 'Annie');   

--Insert Data into Allocation Table;
INSERT INTO ALLOCATION (BID, AUTHID, PAYRATE) VALUES (101, 42, 25);
INSERT INTO ALLOCATION (BID, AUTHID, PAYRATE) VALUES (101, 45, 32);
INSERT INTO ALLOCATION (BID, AUTHID, PAYRATE) VALUES (108, 47, 35);
INSERT INTO ALLOCATION (BID, AUTHID, PAYRATE) VALUES (113, 48, 40);
INSERT INTO ALLOCATION (BID, AUTHID, PAYRATE) VALUES (109, 47, 42);
INSERT INTO ALLOCATION (BID, AUTHID, PAYRATE) VALUES (105, 42, 28);
INSERT INTO ALLOCATION (BID, AUTHID, PAYRATE) VALUES (105, 47, 26);
INSERT INTO ALLOCATION (BID, AUTHID, PAYRATE) VALUES (105, 40, 19);
INSERT INTO ALLOCATION (BID, AUTHID, PAYRATE) VALUES (107, 42, 35);
INSERT INTO ALLOCATION (BID, AUTHID, PAYRATE) VALUES (108, 40, 45);

--Checking if this statement will fail since we are adding a duplicate combination of sname & fname, 'Tony Abbott' already 
--exists in the author table
INSERT INTO AUTHOR (AUTHID,SNAME,FNAME) VALUES (420,'Abbott','Tony');
--Checking if this stement will fail since we put 'Nut Null' for title attribute when creating the Book table
INSERT INTO BOOK (BID,TITLE, SELLINGPRICE) VALUES (069, NULL, 6.99);
--Checking if this statement will fail since we put a check condition that for sellingprice to be greater than 0 and not negative
INSERT INTO BOOK (BID,TITLE, SELLINGPRICE) VALUES (069,'HAIRY POTTER', -6.99);
--Checking if this statement will fail as there is a check condition of payrate that it has to be greater than one and 
--less than 79.99
INSERT INTO ALLOCATION (BID,AUTHID,PAYRATE) VALUES (101,42, 69420);

--Query 1;
SELECT BID, AUTHID, PAYRATE
FROM ALLOCATION
ORDER BY BID, AUTHID;

--Query 2; 
SELECT B.BID, B.TITLE, AL.AUTHID, AL.PAYRATE
FROM ALLOCATION AL
INNER JOIN BOOK B
ON B.BID = AL.BID
ORDER BY BID, AUTHID;

--Query 3;
SELECT B.BID, B.TITLE, B.SELLINGPRICE, A.AUTHID, A.FNAME, A.SNAME, AL.PAYRATE
FROM ALLOCATION AL
INNER JOIN  BOOK B
ON AL.BID = B.BID
INNER JOIN AUTHOR A
ON AL.AUTHID = A.AUTHID
ORDER BY BID, AUTHID;

--Query 4;
SELECT AVG(SELLINGPRICE) AS "Average Price"
FROM BOOK

--Query 5; 
SELECT *
FROM BOOK
WHERE SELLINGPRICE < (SELECT AVG(SELLINGPRICE) FROM BOOK);

--Query 6;
SELECT BID, COUNT(*) 
FROM ALLOCATION 
GROUP BY BID
ORDER BY 2;

--Query 7;
SELECT ALLOCATION.BID, BOOK.TITLE,COUNT(*)
FROM ALLOCATION
INNER JOIN BOOK 
ON ALLOCATION.BID = BOOK.BID
GROUP BY (ALLOCATION.BID,BOOK.TITLE)
ORDER BY COUNT(*), ALLOCATION.BID;

--Query 8;
SELECT AL.BID, B.TITLE, COUNT(*)
FROM ALLOCATION AL
INNER JOIN BOOK B
ON AL.BID = B.BID
HAVING COUNT(*) > 1
GROUP BY AL.BID, B.TITLE
ORDER BY COUNT(*);

--Query 9;
SELECT AU.AUTHID, AU.SNAME, AU.FNAME, AL.BID
FROM ALLOCATION AL
INNER JOIN AUTHOR AU
ON AU.AUTHID=AL.AUTHID
ORDER BY AU.AUTHID, AL.BID;

--Query 10;
SELECT AU.AUTHID, AU.SNAME, AU.FNAME, AL.BID
FROM ALLOCATION AL
RIGHT JOIN AUTHOR AU
ON AU.AUTHID=AL.AUTHID
ORDER BY AU.AUTHID, AL.BID;

--Query 11;
SELECT AU.AUTHID, AU.SNAME, AU.SNAME, AL.BID, B.TITLE
FROM ALLOCATION AL
RIGHT JOIN AUTHOR AU
ON AU.AUTHID=AL.AUTHID
LEFT JOIN BOOK B
ON B.BID = AL.BID
ORDER BY AU.AUTHID, AL.BID, B.TITLE;
/*
============================================================================================================

  TASK 2:
 
=============================================================================================================
*/

--2A
--Creating Table WORK_SESSION;
CREATE TABLE WORK_SESSION(
AUTHID NUMBER(4),
BID NUMBER(4),
WYEAR NUMBER(4), 
CONSTRAINT CK_WYEAR CHECK (WYEAR >= 2019 AND WYEAR <= 2020),
WWEEK NUMBER(2), 
CONSTRAINT CK_WWEEK CHECK (WWEEK >=1 AND WWEEK <= 52),
WHOURS NUMBER(4,2), 
CONSTRAINT CK_WHOURS CHECK (WHOURS >= 0.5 AND WHOURS <= 99.99),
CONSTRAINT PK_WORK_SESSION PRIMARY KEY (WYEAR, WWEEK, BID, AUTHID),
CONSTRAINT FK_WORK_SESSION FOREIGN KEY (AUTHID, BID) REFERENCES ALLOCATION
);

--2B
--Insert Data into WORK_SESSION Table
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(101, 42, 2020, 5, 5);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(101, 42, 2020, 6, 4);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(101, 42, 2020, 7, 5);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(101, 45, 2020, 5, 10);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(101, 45, 2020, 7, 10);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(105, 42, 2020, 5, 6);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(105, 47, 2020, 4, 8);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(105, 47, 2020, 6, 7);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(105, 47, 2020, 8, 8);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(108, 40, 2019, 52, 4);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(108, 40, 2020, 4, 15);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(108, 40, 2020, 6, 6);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(108, 47, 2020, 8, 4);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(109, 47, 2020, 5, 5);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(109, 47, 2020, 6, 5);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(113, 48, 2020, 10, 15);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(113, 48, 2020, 11, 4);
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(113, 48, 2020, 12, 1);

--2C)
--FOREIGN KEY VIOLATION ERROR
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(199, 48, 2020, 1, 1);
--FOREIGN KEY VIOLATION ERROR
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(109, 41, 2020, 2, 2);
-- CHECK CONSTRAINT VIOLATION
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(101, 42, 2022, 9, 6);
--CHECK CONSTRAINT VIOLATION
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(101, 45, 2020, 55, 3);
--CHECK CONSTRAINT VIOLATION
INSERT INTO WORK_SESSION(BID, AUTHID, WYEAR, WWEEK, WHOURS) VALUES(108, 40, 2020, 7, 120);

--2D)

--Query1;
SELECT AUTHID, WYEAR, WWEEK, WHOURS
FROM WORK_SESSION
ORDER BY AUTHID, WYEAR, WWEEK; 
--Query 2;
SELECT AUTHID, WYEAR, SUM(WHOURS) as "Total Hours"
FROM WORK_SESSION
GROUP by (AUTHID, WYEAR);
--Query 3;
SELECT BID, AUTHID, WYEAR, WWEEK, WHOURS
FROM WORK_SESSION
ORDER BY BID, AUTHID, WYEAR, WWEEK;
--Query 4;
SELECT BID, AUTHID, WYEAR, SUM(WHOURS) as "Total Hours"
FROM WORK_SESSION
GROUP BY (BID, AUTHID, WYEAR)
ORDER BY BID, AUTHID, WYEAR;
--Query 5;
SELECT W.BID, W.AUTHID, W.WYEAR, SUM(W.WHOURS*A.PAYRATE) AS "Total Pay"
FROM WORK_SESSION W
INNER JOIN ALLOCATION A
ON A.BID = W.BID AND A.AUTHID = W.AUTHID
GROUP BY (W.BID, W.AUTHID, W.WYEAR)
ORDER BY W.BID, W.AUTHID, W.WYEAR;

/*
============================================================================================================

  TASK 3:
 
=============================================================================================================
*/
DROP TABLE WORK_SESSION;
DROP TABLE ALLOCATION;
DROP TABLE AUTHOR;
DROP TABLE BOOK;