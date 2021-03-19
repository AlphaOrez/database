/* Themepark.SQL                                 	*/
/* Introduction to SQL 					*/
/* Script file for MySQL DBMS				*/
/* This script file creates the following tables:	*/
/* THEMEPARK, EMPLOYEE, TICKET, ATTRACTION, HOURS	*/
/* and loads the default data rows			*/


DROP TABLE SALES_LINE;
DROP TABLE SALES;
DROP TABLE HOURS;
DROP TABLE ATTRACTION;
DROP TABLE TICKET;
DROP TABLE EMPLOYEE;
DROP TABLE THEMEPARK;

CREATE TABLE THEMEPARK (
PARK_CODE VARCHAR(10) NOT NULL PRIMARY KEY,
PARK_NAME VARCHAR(35) NOT NULL,
PARK_CITY VARCHAR(50) NOT NULL,
PARK_COUNTRY CHAR(2) NOT NULL);

CREATE TABLE EMPLOYEE (
EMP_NUM NUMERIC(4) PRIMARY KEY,
EMP_TITLE VARCHAR(4),
EMP_LNAME VARCHAR(15) NOT NULL,
EMP_FNAME VARCHAR(15) NOT NULL,
EMP_DOB DATE NOT NULL,
EMP_HIRE_DATE DATE,
EMP_AREA_CODE VARCHAR(4) NOT NULL,
EMP_PHONE VARCHAR(12) NOT NULL,
PARK_CODE VARCHAR(10),
INDEX (PARK_CODE),
CONSTRAINT FK_EMP_PARK FOREIGN KEY(PARK_CODE) REFERENCES THEMEPARK(PARK_CODE));

CREATE TABLE TICKET (
TICKET_NO NUMERIC(10) PRIMARY KEY,
TICKET_PRICE NUMERIC(4,2) DEFAULT 00.00 NOT NULL,
TICKET_TYPE VARCHAR(10),
PARK_CODE VARCHAR(10),
INDEX (PARK_CODE),
CONSTRAINT FK_TICKET_PARK FOREIGN KEY(PARK_CODE) REFERENCES THEMEPARK(PARK_CODE));

CREATE TABLE ATTRACTION (
ATTRACT_NO NUMERIC(10) PRIMARY KEY,
ATTRACT_NAME VARCHAR(35),
ATTRACT_AGE NUMERIC(3) DEFAULT 0 NOT NULL,
ATTRACT_CAPACITY NUMERIC(3) NOT NULL,
PARK_CODE VARCHAR(10),
INDEX (PARK_CODE),
CONSTRAINT FK_ATTRACT_PARK FOREIGN KEY(PARK_CODE) REFERENCES THEMEPARK(PARK_CODE));

CREATE TABLE HOURS (
EMP_NUM NUMERIC(4),
ATTRACT_NO NUMERIC(10),
HOURS_PER_ATTRACT NUMERIC(2) NOT NULL,
HOUR_RATE NUMERIC(4,2) NOT NULL,
DATE_WORKED DATE NOT NULL,
INDEX (EMP_NUM),
INDEX (ATTRACT_NO),
CONSTRAINT PK_HOURS PRIMARY KEY(EMP_NUM, ATTRACT_NO, DATE_WORKED),
CONSTRAINT FK_HOURS_EMP  FOREIGN KEY   (EMP_NUM) REFERENCES EMPLOYEE(EMP_NUM),
CONSTRAINT FK_HOURS_ATTRACT FOREIGN KEY (ATTRACT_NO) REFERENCES ATTRACTION(ATTRACT_NO));

CREATE TABLE SALES (
TRANSACTION_NO NUMERIC PRIMARY KEY,
PARK_CODE VARCHAR(10),
SALE_DATE DATE NOT NULL,
INDEX (PARK_CODE),
CONSTRAINT FK_SALES_PARK FOREIGN KEY(PARK_CODE) REFERENCES THEMEPARK(PARK_CODE));

CREATE TABLE SALES_LINE (
TRANSACTION_NO NUMERIC,
LINE_NO NUMERIC(2,0) NOT NULL,
TICKET_NO NUMERIC(10)  NOT NULL,
LINE_QTY NUMERIC(4) DEFAULT 0 NOT NULL,
LINE_PRICE NUMERIC(9,2) DEFAULT 0.00 NOT NULL,
INDEX (TRANSACTION_NO),
INDEX (TICKET_NO),
CONSTRAINT PK_SALES_LINE PRIMARY KEY (TRANSACTION_NO,LINE_NO),
CONSTRAINT FK_SALES_LINE_TICKET FOREIGN KEY (TICKET_NO) REFERENCES TICKET(TICKET_NO),
CONSTRAINT FK_SALES_LINE_SALES FOREIGN KEY (TRANSACTION_NO) REFERENCES SALES(TRANSACTION_NO) 
);

/* CREATING AN INDEX ON EMP_LNAME IN THE  EMPLOYEE TABLE  */

CREATE INDEX EMP_LNAME_INDEX ON EMPLOYEE(EMP_LNAME(8));



/* ThemePark rows						*/
INSERT INTO THEMEPARK VALUES ('FR1001','FairyLand','PARIS','FR');
INSERT INTO THEMEPARK VALUES ('NL1202','Efling','NOORD','NL');
INSERT INTO THEMEPARK VALUES ('SP4533','AdventurePort','BARCELONA','SP');
INSERT INTO THEMEPARK VALUES ('SW2323','Labyrinthe','LAUSANNE','SW');
INSERT INTO THEMEPARK VALUES ('UK2622','MiniLand','WINDSOR','UK');
INSERT INTO THEMEPARK VALUES ('UK3452','PleasureLand','STOKE','UK');
INSERT INTO THEMEPARK VALUES ('ZA1342','GoldTown','JOHANNESBURG','ZA');

/* Employee rows						*/
INSERT INTO EMPLOYEE VALUES (100,'Ms','Calderdale','Emma','1972-06-15','1992-03-15','0181','324-9134','FR1001');
INSERT INTO EMPLOYEE VALUES (101,'Ms','Ricardo','Marshel','1978-03-19','1996-04-25','0181','324-4472','UK3452');
INSERT INTO EMPLOYEE VALUES (102,'Mr','Arshad','Arif','1969-11-14','1990-12-20','7253','675-8993','FR1001');
INSERT INTO EMPLOYEE VALUES (103,'Ms','Roberts','Anne','1974-10-16','1994-08-16','0181','898-3456','UK3452');
INSERT INTO EMPLOYEE VALUES (104,'Mr','Denver','Enrica','1980-11-08','2001-10-20','7253','504-4434','ZA1342');
INSERT INTO EMPLOYEE VALUES (105,'Ms','Namowa','Mirrelle','1990-03-14','2006-11-08','0181','890-3243','FR1001');
INSERT INTO EMPLOYEE VALUES (106,'Mrs','Smith','Gemma','1968-02-12','1989-01-05','0181','324-7845','ZA1342');


/* Ticket rows						*/
INSERT INTO TICKET VALUES (11001,24.99,'Adult',	'SP4533');
INSERT INTO TICKET VALUES (11002,14.99,'Child',	'SP4533');
INSERT INTO TICKET VALUES (11003,10.99,'Senior','SP4533');
INSERT INTO TICKET VALUES (13001,18.99,'Child','FR1001');
INSERT INTO TICKET VALUES (13002,34.99,'Adult','FR1001');
INSERT INTO TICKET VALUES (13003,20.99,'Senior','FR1001');
INSERT INTO TICKET VALUES (67832,18.56,'Child','ZA1342');
INSERT INTO TICKET VALUES (67833,28.67,'Adult','ZA1342');
INSERT INTO TICKET VALUES (67855,12.12,'Senior','ZA1342');
INSERT INTO TICKET VALUES (88567,22.50,'Child','UK3452');
INSERT INTO TICKET VALUES (88568,42.10,'Adult','UK3452');
INSERT INTO TICKET VALUES (89720,10.99,'Senior','UK3452');

/* Attraction rows						*/

INSERT INTO ATTRACTION VALUES (10034,'ThunderCoaster',11,34,'FR1001');
INSERT INTO ATTRACTION VALUES (10056,'SpinningTeacups',4,62,'FR1001');
INSERT INTO ATTRACTION VALUES (10067,'FlightToStars',11,24,'FR1001');
INSERT INTO ATTRACTION VALUES (10078,'Ant-Trap',23,30,'FR1001');
INSERT INTO ATTRACTION VALUES (10098,'Carnival',3,120,'FR1001');
INSERT INTO ATTRACTION VALUES (20056,'3D-Lego_Show',3,200,'UK3452');
INSERT INTO ATTRACTION VALUES (30011,'BlackHole2',12,34,'UK3452');
INSERT INTO ATTRACTION VALUES (30012,'Pirates',10,42,'UK3452');
INSERT INTO ATTRACTION VALUES (30044,'UnderSeaWord',4,80,'UK3452');
INSERT INTO ATTRACTION VALUES (98764,'GoldRush',5,80,'ZA1342');
/* Attraction with no name */
INSERT INTO ATTRACTION VALUES (10082,NULL,10,40,'ZA1342');


/* hours rows						*/

INSERT INTO HOURS VALUES (100,10034,6,6.5,'2007-05-18');
INSERT INTO HOURS VALUES (100,10034,6,6.5,'2007-05-20');
INSERT INTO HOURS VALUES (101,10034,6,6.5,'2007-05-18');
INSERT INTO HOURS VALUES (102,30012,3,5.99,'2007-05-23');
INSERT INTO HOURS VALUES (102,30044,6,5.99,'2007-05-21');
INSERT INTO HOURS VALUES (102,30044,3,5.99,'2007-05-22');
INSERT INTO HOURS VALUES (104,30011,6,7.2,'2007-05-21');
INSERT INTO HOURS VALUES (104,30012,6,7.2,'2007-05-22');
INSERT INTO HOURS VALUES (105,10078,3,8.5,'2007-05-18');
INSERT INTO HOURS VALUES (105,10098,3,8.5,'2007-05-18');
INSERT INTO HOURS VALUES (105,10098,6,8.5,'2007-05-19');


/* SALES rows						*/

INSERT INTO SALES VALUES (12781,'FR1001','2007-05-18');
INSERT INTO SALES VALUES (12782,'FR1001','2007-05-18');
INSERT INTO SALES VALUES (12783,'FR1001','2007-05-18');
INSERT INTO SALES VALUES (12784,'FR1001','2007-05-18');
INSERT INTO SALES VALUES (12785,'FR1001','2007-05-18');
INSERT INTO SALES VALUES (12786,'FR1001','2007-05-18');
INSERT INTO SALES VALUES (34534,'UK3452','2007-05-18');
INSERT INTO SALES VALUES (34535,'UK3452','2007-05-18');
INSERT INTO SALES VALUES (34536,'UK3452','2007-05-18');
INSERT INTO SALES VALUES (34537,'UK3452','2007-05-18');
INSERT INTO SALES VALUES (34538,'UK3452','2007-05-18');
INSERT INTO SALES VALUES (34539,'UK3452','2007-05-18');
INSERT INTO SALES VALUES (34540,'UK3452','2007-05-18');
INSERT INTO SALES VALUES (34541,'UK3452','2007-05-18');
INSERT INTO SALES VALUES (67589,'ZA1342','2007-05-18');
INSERT INTO SALES VALUES (67590,'ZA1342','2007-05-18');
INSERT INTO SALES VALUES (67591,'ZA1342','2007-05-18');
INSERT INTO SALES VALUES (67592,'ZA1342','2007-05-18');
INSERT INTO SALES VALUES (67593,'ZA1342','2007-05-18');

/* SALES_LINE rows						*/


INSERT INTO SALES_LINE VALUES (12781,1,13002,2,69.98);
INSERT INTO SALES_LINE VALUES (12781,2,13001,1,14.99);
INSERT INTO SALES_LINE VALUES (12782,1,13002,2,69.98);
INSERT INTO SALES_LINE VALUES (12783,1,13003,2,41.98);
INSERT INTO SALES_LINE VALUES (12784,2,13001,1,14.99);
INSERT INTO SALES_LINE VALUES (12785,1,13001,1,14.99);
INSERT INTO SALES_LINE VALUES (12785,2,13002,1,34.99);
INSERT INTO SALES_LINE VALUES (12785,3,13002,4,139.96);
INSERT INTO SALES_LINE VALUES (34534,1,88568,4,168.40);
INSERT INTO SALES_LINE VALUES (34534,2,88567,1,22.50);
INSERT INTO SALES_LINE VALUES (34534,3,89720,2,21.98);
INSERT INTO SALES_LINE VALUES (34535,1,88568,2,84.20);
INSERT INTO SALES_LINE VALUES (34536,1,89720,2,21.98);
INSERT INTO SALES_LINE VALUES (34537,1,88568,2,84.20);
INSERT INTO SALES_LINE VALUES (34537,2,88567,1,22.50);
INSERT INTO SALES_LINE VALUES (34538,1,89720,2,21.98);
INSERT INTO SALES_LINE VALUES (34539,1,89720,2,21.98);
INSERT INTO SALES_LINE VALUES (34539,2,88568,2,84.20);
INSERT INTO SALES_LINE VALUES (34540,1,88568,4,168.40);
INSERT INTO SALES_LINE VALUES (34540,2,88567,1,22.50);
INSERT INTO SALES_LINE VALUES (34540,3,89720,2,21.98);
INSERT INTO SALES_LINE VALUES (34541,1,88568,2,84.20);
INSERT INTO SALES_LINE VALUES (67589,1,67833,2,57.34);
INSERT INTO SALES_LINE VALUES (67589,2,67832,2,37.12);
INSERT INTO SALES_LINE VALUES (67590,1,67833,2,57.34);
INSERT INTO SALES_LINE VALUES (67590,2,67832,2,37.12);
INSERT INTO SALES_LINE VALUES (67591,1,67832,1,18.56);
INSERT INTO SALES_LINE VALUES (67591,2,67855,1,12.12);
INSERT INTO SALES_LINE VALUES (67592,1,67833,4,114.68);
INSERT INTO SALES_LINE VALUES (67593,1,67833,2,57.34);
INSERT INTO SALES_LINE VALUES (67593,2,67832,2,37.12);

commit;

                                                   
                                                   
                                                   
                                                   
                                                   
                                                   
                                                   extra commands
                                                   
                                               for the right syntax to use near '-online:
create database themepark-online' at line 1
mysql> create database themepark-online;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '-online' at line 1
mysql> create database themepark_online;
Query OK, 1 row affected (0.00 sec)

mysql> use themepark_online;
Database changed
mysql> source D:\Abdullah\Downloads\themepark.sql
ERROR 1051 (42S02): Unknown table 'themepark_online.sales_line'
ERROR 1051 (42S02): Unknown table 'themepark_online.sales'
ERROR 1051 (42S02): Unknown table 'themepark_online.hours'
ERROR 1051 (42S02): Unknown table 'themepark_online.attraction'
ERROR 1051 (42S02): Unknown table 'themepark_online.ticket'
ERROR 1051 (42S02): Unknown table 'themepark_online.employee'
ERROR 1051 (42S02): Unknown table 'themepark_online.themepark'
Query OK, 0 rows affected (0.03 sec)

Query OK, 0 rows affected (0.03 sec)

Query OK, 0 rows affected (0.03 sec)

Query OK, 0 rows affected (0.03 sec)

Query OK, 0 rows affected (0.03 sec)

Query OK, 0 rows affected (0.03 sec)

Query OK, 0 rows affected (0.04 sec)

Query OK, 0 rows affected (0.10 sec)
Records: 0  Duplicates: 0  Warnings: 0

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

mysql> select * from tickets
    -> ;
ERROR 1146 (42S02): Table 'themepark_online.tickets' doesn't exist
mysql> source "D:\Abdullah\Downloads\themepark.sql"
ERROR:
Failed to open file '"D:\Abdullah\Downloads\themepark.sql"', error: 22
mysql> source "D:\Abdullah\Downloads\themepark.sql"
ERROR:
Failed to open file '"D:\Abdullah\Downloads\themepark.sql"', error: 22
mysql> SELECT PARK_CODE, TICKET_NO, TICKET_TYPE, TICKET_PRICE,  TICKET_PRICE + ROUND((TICKET_PRICE *0.1),2)
    -> from ticket;
+-----------+-----------+-------------+--------------+---------------------------------------------+
| PARK_CODE | TICKET_NO | TICKET_TYPE | TICKET_PRICE | TICKET_PRICE + ROUND((TICKET_PRICE *0.1),2) |
+-----------+-----------+-------------+--------------+---------------------------------------------+
| SP4533    |     11001 | Adult       |        24.99 |                                       27.49 |
| SP4533    |     11002 | Child       |        14.99 |                                       16.49 |
| SP4533    |     11003 | Senior      |        10.99 |                                       12.09 |
| FR1001    |     13001 | Child       |        18.99 |                                       20.89 |
| FR1001    |     13002 | Adult       |        34.99 |                                       38.49 |
| FR1001    |     13003 | Senior      |        20.99 |                                       23.09 |
| ZA1342    |     67832 | Child       |        18.56 |                                       20.42 |
| ZA1342    |     67833 | Adult       |        28.67 |                                       31.54 |
| ZA1342    |     67855 | Senior      |        12.12 |                                       13.33 |
| UK3452    |     88567 | Child       |        22.50 |                                       24.75 |
| UK3452    |     88568 | Adult       |        42.10 |                                       46.31 |
| UK3452    |     89720 | Senior      |        10.99 |                                       12.09 |
+-----------+-----------+-------------+--------------+---------------------------------------------+
12 rows in set (0.01 sec)

mysql> SELECT PARK_CODE, TICKET_NO, TICKET_TYPE, TICKET_PRICE,  TICKET_PRICE + ROUND((TICKET_PRICE *0.1),2) PRICE_INCREASE  FROM TICKET;
+-----------+-----------+-------------+--------------+----------------+
| PARK_CODE | TICKET_NO | TICKET_TYPE | TICKET_PRICE | PRICE_INCREASE |
+-----------+-----------+-------------+--------------+----------------+
| SP4533    |     11001 | Adult       |        24.99 |          27.49 |
| SP4533    |     11002 | Child       |        14.99 |          16.49 |
| SP4533    |     11003 | Senior      |        10.99 |          12.09 |
| FR1001    |     13001 | Child       |        18.99 |          20.89 |
| FR1001    |     13002 | Adult       |        34.99 |          38.49 |
| FR1001    |     13003 | Senior      |        20.99 |          23.09 |
| ZA1342    |     67832 | Child       |        18.56 |          20.42 |
| ZA1342    |     67833 | Adult       |        28.67 |          31.54 |
| ZA1342    |     67855 | Senior      |        12.12 |          13.33 |
| UK3452    |     88567 | Child       |        22.50 |          24.75 |
| UK3452    |     88568 | Adult       |        42.10 |          46.31 |
| UK3452    |     89720 | Senior      |        10.99 |          12.09 |
+-----------+-----------+-------------+--------------+----------------+
12 rows in set (0.00 sec)

mysql> SELECT PARK_CODE, TICKET_TYPE, TICKET_PRICE
    -> FROM TICKET
    -> WHERE TICKET_PRICE > 20;
+-----------+-------------+--------------+
| PARK_CODE | TICKET_TYPE | TICKET_PRICE |
+-----------+-------------+--------------+
| SP4533    | Adult       |        24.99 |
| FR1001    | Adult       |        34.99 |
| FR1001    | Senior      |        20.99 |
| ZA1342    | Adult       |        28.67 |
| UK3452    | Child       |        22.50 |
| UK3452    | Adult       |        42.10 |
+-----------+-------------+--------------+
6 rows in set (0.00 sec)

mysql> SELECT PARK_CODE, TICKET_TYPE, TICKET_PRICE
    -> from ticket;
+-----------+-------------+--------------+
| PARK_CODE | TICKET_TYPE | TICKET_PRICE |
+-----------+-------------+--------------+
| SP4533    | Adult       |        24.99 |
| SP4533    | Child       |        14.99 |
| SP4533    | Senior      |        10.99 |
| FR1001    | Child       |        18.99 |
| FR1001    | Adult       |        34.99 |
| FR1001    | Senior      |        20.99 |
| ZA1342    | Child       |        18.56 |
| ZA1342    | Adult       |        28.67 |
| ZA1342    | Senior      |        12.12 |
| UK3452    | Child       |        22.50 |
| UK3452    | Adult       |        42.10 |
| UK3452    | Senior      |        10.99 |
+-----------+-------------+--------------+
12 rows in set (0.00 sec)

mysql> SELECT PARK_CODE, TICKET_TYPE, TICKET_PRICE
    -> FROM TICKET
    -> where ticket_price <30;
+-----------+-------------+--------------+
| PARK_CODE | TICKET_TYPE | TICKET_PRICE |
+-----------+-------------+--------------+
| SP4533    | Adult       |        24.99 |
| SP4533    | Child       |        14.99 |
| SP4533    | Senior      |        10.99 |
| FR1001    | Child       |        18.99 |
| FR1001    | Senior      |        20.99 |
| ZA1342    | Child       |        18.56 |
| ZA1342    | Adult       |        28.67 |
| ZA1342    | Senior      |        12.12 |
| UK3452    | Child       |        22.50 |
| UK3452    | Senior      |        10.99 |
+-----------+-------------+--------------+
10 rows in set (0.00 sec)

mysql> SELECT PARK_CODE, PARK_NAME, PARK_COUNTRY
    -> FROM THEMEPARK
    -> WHERE PARK_CODE < ‘UK2262’;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '?UK2262?' at line 3
mysql> SELECT PARK_CODE, PARK_NAME, PARK_COUNTRY
    -> FROM TICKET
    -> where park_code <'uk2262';
ERROR 1054 (42S22): Unknown column 'PARK_NAME' in 'field list'
mysql> SELECT PARK_CODE, PARK_NAME, PARK_COUNTRY
    -> FROM THEMEPARK
    -> WHERE PARK_CODE < "UK2262";
+-----------+---------------+--------------+
| PARK_CODE | PARK_NAME     | PARK_COUNTRY |
+-----------+---------------+--------------+
| FR1001    | FairyLand     | FR           |
| NL1202    | Efling        | NL           |
| SP4533    | AdventurePort | SP           |
| SW2323    | Labyrinthe    | SW           |
+-----------+---------------+--------------+
4 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM TICKET
    -> WHERE TICKET_PRICE BETWEEN 30.00 AND 50.00;
+-----------+--------------+-------------+-----------+
| TICKET_NO | TICKET_PRICE | TICKET_TYPE | PARK_CODE |
+-----------+--------------+-------------+-----------+
|     13002 |        34.99 | Adult       | FR1001    |
|     88568 |        42.10 | Adult       | UK3452    |
+-----------+--------------+-------------+-----------+
2 rows in set (0.01 sec)

mysql> select*
    -> from ticket
    -> c\
    -> c/
    -> \c
mysql> select emp_num, attract_no, hours_per_attract
    -> from hours
    -> where hours_per_attract between 5 and 10;
+---------+------------+-------------------+
| emp_num | attract_no | hours_per_attract |
+---------+------------+-------------------+
|     100 |      10034 |                 6 |
|     100 |      10034 |                 6 |
|     101 |      10034 |                 6 |
|     102 |      30044 |                 6 |
|     104 |      30011 |                 6 |
|     104 |      30012 |                 6 |
|     105 |      10098 |                 6 |
+---------+------------+-------------------+
7 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM SALES_LINE
    -> WHERE TRANSACTION_NO IN (12781, 67593);
+----------------+---------+-----------+----------+------------+
| TRANSACTION_NO | LINE_NO | TICKET_NO | LINE_QTY | LINE_PRICE |
+----------------+---------+-----------+----------+------------+
|          12781 |       1 |     13002 |        2 |      69.98 |
|          12781 |       2 |     13001 |        1 |      14.99 |
|          67593 |       1 |     67833 |        2 |      57.34 |
|          67593 |       2 |     67832 |        2 |      37.12 |
+----------------+---------+-----------+----------+------------+
4 rows in set (0.00 sec)

mysql> select *
    -> from ticket
    -> where ticket_type in <'child','senior'>;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '<'child','senior'>' at line 3
mysql> select *
    -> from ticket
    -> where ticket_type in <"child","senior">;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '<"child","senior">' at line 3
mysql> select *
    -> from ticket
    -> where ticket_type in ('child','senior');
+-----------+--------------+-------------+-----------+
| TICKET_NO | TICKET_PRICE | TICKET_TYPE | PARK_CODE |
+-----------+--------------+-------------+-----------+
|     11002 |        14.99 | Child       | SP4533    |
|     11003 |        10.99 | Senior      | SP4533    |
|     13001 |        18.99 | Child       | FR1001    |
|     13003 |        20.99 | Senior      | FR1001    |
|     67832 |        18.56 | Child       | ZA1342    |
|     67855 |        12.12 | Senior      | ZA1342    |
|     88567 |        22.50 | Child       | UK3452    |
|     89720 |        10.99 | Senior      | UK3452    |
+-----------+--------------+-------------+-----------+
8 rows in set (0.00 sec)

mysql> SELECT EMP_LNAME, EMP_FNAME, EMP_NUM
    -> FROM EMPLOYEE
    -> WHERE EMP_FNAME LIKE ‘A%’;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '?A%?' at line 3
mysql> SELECT EMP_LNAME, EMP_FNAME, EMP_NUM
    -> FROM EMPLOYEE
    -> WHERE EMP_FNAME LIKE "A%";
+-----------+-----------+---------+
| EMP_LNAME | EMP_FNAME | EMP_NUM |
+-----------+-----------+---------+
| Arshad    | Arif      |     102 |
| Roberts   | Anne      |     103 |
+-----------+-----------+---------+
2 rows in set (0.00 sec)

mysql> select * from themepark
    -> where park_name like "%land";
+-----------+--------------+-----------+--------------+
| PARK_CODE | PARK_NAME    | PARK_CITY | PARK_COUNTRY |
+-----------+--------------+-----------+--------------+
| FR1001    | FairyLand    | PARIS     | FR           |
| UK2622    | MiniLand     | WINDSOR   | UK           |
| UK3452    | PleasureLand | STOKE     | UK           |
+-----------+--------------+-----------+--------------+
3 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM ATTRACTION
    -> WHERE ATTRACT_NAME IS NULL;
+------------+--------------+-------------+------------------+-----------+
| ATTRACT_NO | ATTRACT_NAME | ATTRACT_AGE | ATTRACT_CAPACITY | PARK_CODE |
+------------+--------------+-------------+------------------+-----------+
|      10082 | NULL         |          10 |               40 | ZA1342    |
+------------+--------------+-------------+------------------+-----------+
1 row in set (0.00 sec)

mysql> SELECT EMP_NUM, ATTRACT_NO
    -> FROM HOURS
    -> WHERE HOURS_PER_ATTRACT > 3
    -> AND DATE_WORKED > '2007-05-18';
+---------+------------+
| EMP_NUM | ATTRACT_NO |
+---------+------------+
|     100 |      10034 |
|     102 |      30044 |
|     104 |      30011 |
|     104 |      30012 |
|     105 |      10098 |
+---------+------------+
5 rows in set (0.00 sec)

mysql> select *from attraction
    -> where attract_age<=10
    -> and attract_capacity<100
    -> and attract_name is not null;
+------------+-----------------+-------------+------------------+-----------+
| ATTRACT_NO | ATTRACT_NAME    | ATTRACT_AGE | ATTRACT_CAPACITY | PARK_CODE |
+------------+-----------------+-------------+------------------+-----------+
|      10056 | SpinningTeacups |           4 |               62 | FR1001    |
|      30012 | Pirates         |          10 |               42 | UK3452    |
|      30044 | UnderSeaWord    |           4 |               80 | UK3452    |
|      98764 | GoldRush        |           5 |               80 | ZA1342    |
+------------+-----------------+-------------+------------------+-----------+
4 rows in set (0.00 sec)

mysql> SELECT PARK_NAME, PARK_COUNTRY
    -> FROM THEMEPARK
    -> WHERE PARK_COUNTRY = 'FR'
    -> OR PARK_COUNTRY = 'UK';
+--------------+--------------+
| PARK_NAME    | PARK_COUNTRY |
+--------------+--------------+
| FairyLand    | FR           |
| MiniLand     | UK           |
| PleasureLand | UK           |
+--------------+--------------+
3 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM ATTRACTION
    -> WHERE (PARK_CODE LIKE ‘FR%’
    -> AND ATTRACT_CAPACITY <50) OR (ATTRACT_CAPACITY > 100);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '?FR%?
AND ATTRACT_CAPACITY <50) OR (ATTRACT_CAPACITY > 100)' at line 3
mysql> AND ATTRACT_CAPACITY <50) OR (ATTRACT_CAPACITY > 100);SELECT *
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'AND ATTRACT_CAPACITY <50) OR (ATTRACT_CAPACITY > 100)' at line 1
    -> FROM ATTRACTION
    -> WHERE (PARK_CODE LIKE ‘FR%’
    -> AND ATTRACT_CAPACITY <50) OR (ATTRACT_CAPACITY > 100);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '?FR%?
AND ATTRACT_CAPACITY <50) OR (ATTRACT_CAPACITY > 100)' at line 3
mysql> SELECT *
    -> FROM ATTRACTION
    -> WHERE (PARK_CODE LIKE "FR%"
    -> AND ATTRACT_CAPACITY <50) OR (ATTRACT_CAPACITY > 100);
+------------+----------------+-------------+------------------+-----------+
| ATTRACT_NO | ATTRACT_NAME   | ATTRACT_AGE | ATTRACT_CAPACITY | PARK_CODE |
+------------+----------------+-------------+------------------+-----------+
|      10034 | ThunderCoaster |          11 |               34 | FR1001    |
|      10067 | FlightToStars  |          11 |               24 | FR1001    |
|      10078 | Ant-Trap       |          23 |               30 | FR1001    |
|      10098 | Carnival       |           3 |              120 | FR1001    |
|      20056 | 3D-Lego_Show   |           3 |              200 | UK3452    |
+------------+----------------+-------------+------------------+-----------+
5 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM EMPLOYEE
    -> WHERE NOT (EMP_NUM = 106);
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
| EMP_NUM | EMP_TITLE | EMP_LNAME  | EMP_FNAME | EMP_DOB    | EMP_HIRE_DATE | EMP_AREA_CODE | EMP_PHONE | PARK_CODE |
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
|     100 | Ms        | Calderdale | Emma      | 1972-06-15 | 1992-03-15    | 0181          | 324-9134  | FR1001    |
|     101 | Ms        | Ricardo    | Marshel   | 1978-03-19 | 1996-04-25    | 0181          | 324-4472  | UK3452    |
|     102 | Mr        | Arshad     | Arif      | 1969-11-14 | 1990-12-20    | 7253          | 675-8993  | FR1001    |
|     103 | Ms        | Roberts    | Anne      | 1974-10-16 | 1994-08-16    | 0181          | 898-3456  | UK3452    |
|     104 | Mr        | Denver     | Enrica    | 1980-11-08 | 2001-10-20    | 7253          | 504-4434  | ZA1342    |
|     105 | Ms        | Namowa     | Mirrelle  | 1990-03-14 | 2006-11-08    | 0181          | 890-3243  | FR1001    |
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
6 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM EMPLOYEE
    -> ORDER BY EMP_HIRE_DATE DESC;
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
| EMP_NUM | EMP_TITLE | EMP_LNAME  | EMP_FNAME | EMP_DOB    | EMP_HIRE_DATE | EMP_AREA_CODE | EMP_PHONE | PARK_CODE |
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
|     105 | Ms        | Namowa     | Mirrelle  | 1990-03-14 | 2006-11-08    | 0181          | 890-3243  | FR1001    |
|     104 | Mr        | Denver     | Enrica    | 1980-11-08 | 2001-10-20    | 7253          | 504-4434  | ZA1342    |
|     101 | Ms        | Ricardo    | Marshel   | 1978-03-19 | 1996-04-25    | 0181          | 324-4472  | UK3452    |
|     103 | Ms        | Roberts    | Anne      | 1974-10-16 | 1994-08-16    | 0181          | 898-3456  | UK3452    |
|     100 | Ms        | Calderdale | Emma      | 1972-06-15 | 1992-03-15    | 0181          | 324-9134  | FR1001    |
|     102 | Mr        | Arshad     | Arif      | 1969-11-14 | 1990-12-20    | 7253          | 675-8993  | FR1001    |
|     106 | Mrs       | Smith      | Gemma     | 1968-02-12 | 1989-01-05    | 0181          | 324-7845  | ZA1342    |
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
7 rows in set (0.01 sec)

mysql> SELECT *
    -> FROM EMPLOYEE
    -> ORDER BY EMP_LNAME, EMP_FNAME;
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
| EMP_NUM | EMP_TITLE | EMP_LNAME  | EMP_FNAME | EMP_DOB    | EMP_HIRE_DATE | EMP_AREA_CODE | EMP_PHONE | PARK_CODE |
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
|     102 | Mr        | Arshad     | Arif      | 1969-11-14 | 1990-12-20    | 7253          | 675-8993  | FR1001    |
|     100 | Ms        | Calderdale | Emma      | 1972-06-15 | 1992-03-15    | 0181          | 324-9134  | FR1001    |
|     104 | Mr        | Denver     | Enrica    | 1980-11-08 | 2001-10-20    | 7253          | 504-4434  | ZA1342    |
|     105 | Ms        | Namowa     | Mirrelle  | 1990-03-14 | 2006-11-08    | 0181          | 890-3243  | FR1001    |
|     101 | Ms        | Ricardo    | Marshel   | 1978-03-19 | 1996-04-25    | 0181          | 324-4472  | UK3452    |
|     103 | Ms        | Roberts    | Anne      | 1974-10-16 | 1994-08-16    | 0181          | 898-3456  | UK3452    |
|     106 | Mrs       | Smith      | Gemma     | 1968-02-12 | 1989-01-05    | 0181          | 324-7845  | ZA1342    |
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
7 rows in set (0.00 sec)

mysql> SELECT TICKET_TYPE, PARK_CODE
    -> FROM TICKET
    -> WHERE (TICKET_PRICE > 15 AND TICKET_TYPE LIKE 'Child') ORDER BY TICKET_NO DESC;
+-------------+-----------+
| TICKET_TYPE | PARK_CODE |
+-------------+-----------+
| Child       | UK3452    |
| Child       | ZA1342    |
| Child       | FR1001    |
+-------------+-----------+
3 rows in set (0.00 sec)

mysql> select distinct(park_code)
    -> from attraction;
+-----------+
| park_code |
+-----------+
| FR1001    |
| UK3452    |
| ZA1342    |
+-----------+
3 rows in set (0.00 sec)

mysql>  SELECT PARK_CODE, TICKET_TYPE, TICKET_PRICE
    ->     -> FROM TICKET
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'FROM TICKET' at line 2
mysql> select * from themepark where park_code not like 'UK%';
+-----------+---------------+--------------+--------------+
| PARK_CODE | PARK_NAME     | PARK_CITY    | PARK_COUNTRY |
+-----------+---------------+--------------+--------------+
| FR1001    | FairyLand     | PARIS        | FR           |
| NL1202    | Efling        | NOORD        | NL           |
| SP4533    | AdventurePort | BARCELONA    | SP           |
| SW2323    | Labyrinthe    | LAUSANNE     | SW           |
| ZA1342    | GoldTown      | JOHANNESBURG | ZA           |
+-----------+---------------+--------------+--------------+
5 rows in set (0.00 sec)

mysql> select * from sales where sale_date = '2007-05-18';
+----------------+-----------+------------+
| TRANSACTION_NO | PARK_CODE | SALE_DATE  |
+----------------+-----------+------------+
|          12781 | FR1001    | 2007-05-18 |
|          12782 | FR1001    | 2007-05-18 |
|          12783 | FR1001    | 2007-05-18 |
|          12784 | FR1001    | 2007-05-18 |
|          12785 | FR1001    | 2007-05-18 |
|          12786 | FR1001    | 2007-05-18 |
|          34534 | UK3452    | 2007-05-18 |
|          34535 | UK3452    | 2007-05-18 |
|          34536 | UK3452    | 2007-05-18 |
|          34537 | UK3452    | 2007-05-18 |
|          34538 | UK3452    | 2007-05-18 |
|          34539 | UK3452    | 2007-05-18 |
|          34540 | UK3452    | 2007-05-18 |
|          34541 | UK3452    | 2007-05-18 |
|          67589 | ZA1342    | 2007-05-18 |
|          67590 | ZA1342    | 2007-05-18 |
|          67591 | ZA1342    | 2007-05-18 |
|          67592 | ZA1342    | 2007-05-18 |
|          67593 | ZA1342    | 2007-05-18 |
+----------------+-----------+------------+
19 rows in set (0.00 sec)

mysql> select * from ticket where ticket_price between 20 and 30;
+-----------+--------------+-------------+-----------+
| TICKET_NO | TICKET_PRICE | TICKET_TYPE | PARK_CODE |
+-----------+--------------+-------------+-----------+
|     11001 |        24.99 | Adult       | SP4533    |
|     13003 |        20.99 | Senior      | FR1001    |
|     67833 |        28.67 | Adult       | ZA1342    |
|     88567 |        22.50 | Child       | UK3452    |
+-----------+--------------+-------------+-----------+
4 rows in set (0.00 sec)

mysql> select * from attraction where attract_capacity > 60 and park_code = 'FR1001';
+------------+-----------------+-------------+------------------+-----------+
| ATTRACT_NO | ATTRACT_NAME    | ATTRACT_AGE | ATTRACT_CAPACITY | PARK_CODE |
+------------+-----------------+-------------+------------------+-----------+
|      10056 | SpinningTeacups |           4 |               62 | FR1001    |
|      10098 | Carnival        |           3 |              120 | FR1001    |
+------------+-----------------+-------------+------------------+-----------+
2 rows in set (0.00 sec)

mysql> select attract_no, hour_rate, round(hour_rate*1.2,2) as increased_rate from hours;
+------------+-----------+----------------+
| attract_no | hour_rate | increased_rate |
+------------+-----------+----------------+
|      10034 |      6.50 |           7.80 |
|      10034 |      6.50 |           7.80 |
|      10034 |      6.50 |           7.80 |
|      30012 |      5.99 |           7.19 |
|      30044 |      5.99 |           7.19 |
|      30044 |      5.99 |           7.19 |
|      30011 |      7.20 |           8.64 |
|      30012 |      7.20 |           8.64 |
|      10078 |      8.50 |          10.20 |
|      10098 |      8.50 |          10.20 |
|      10098 |      8.50 |          10.20 |
+------------+-----------+----------------+
11 rows in set (0.00 sec)

mysql> select distinct(emp_num) from hours;
+---------+
| emp_num |
+---------+
|     100 |
|     101 |
|     102 |
|     104 |
|     105 |
+---------+
5 rows in set (0.00 sec)

mysql> select * from sales order by sale_date desc;
+----------------+-----------+------------+
| TRANSACTION_NO | PARK_CODE | SALE_DATE  |
+----------------+-----------+------------+
|          12781 | FR1001    | 2007-05-18 |
|          12782 | FR1001    | 2007-05-18 |
|          12783 | FR1001    | 2007-05-18 |
|          12784 | FR1001    | 2007-05-18 |
|          12785 | FR1001    | 2007-05-18 |
|          12786 | FR1001    | 2007-05-18 |
|          34534 | UK3452    | 2007-05-18 |
|          34535 | UK3452    | 2007-05-18 |
|          34536 | UK3452    | 2007-05-18 |
|          34537 | UK3452    | 2007-05-18 |
|          34538 | UK3452    | 2007-05-18 |
|          34539 | UK3452    | 2007-05-18 |
|          34540 | UK3452    | 2007-05-18 |
|          34541 | UK3452    | 2007-05-18 |
|          67589 | ZA1342    | 2007-05-18 |
|          67590 | ZA1342    | 2007-05-18 |
|          67591 | ZA1342    | 2007-05-18 |
|          67592 | ZA1342    | 2007-05-18 |
|          67593 | ZA1342    | 2007-05-18 |
+----------------+-----------+------------+
19 rows in set (0.00 sec)

mysql> select transaction_no, line_price from sales_line where line_price > 50;
+----------------+------------+
| transaction_no | line_price |
+----------------+------------+
|          12781 |      69.98 |
|          12782 |      69.98 |
|          12785 |     139.96 |
|          34534 |     168.40 |
|          34535 |      84.20 |
|          34537 |      84.20 |
|          34539 |      84.20 |
|          34540 |     168.40 |
|          34541 |      84.20 |
|          67589 |      57.34 |
|          67590 |      57.34 |
|          67592 |     114.68 |
|          67593 |      57.34 |
+----------------+------------+
13 rows in set (0.00 sec)

mysql> SELECT * FROM Table ORDER BY ID DESC LIMIT 2
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Table ORDER BY ID DESC LIMIT 2' at line 1
mysql> SELECT EMP_NUM, EMP_FNAME FROM EMPLOYEE ORDER BY EMP_NUM DESC LIMIT 2;
+---------+-----------+
| EMP_NUM | EMP_FNAME |
+---------+-----------+
|     106 | Gemma     |
|     105 | Mirrelle  |
+---------+-----------+
2 rows in set (0.00 sec)

mysql> select transaction_no, line_price from sales_line where line_price > 50;
+----------------+------------+
| transaction_no | line_price |
+----------------+------------+
|          12781 |      69.98 |
|          12782 |      69.98 |
|          12785 |     139.96 |
|          34534 |     168.40 |
|          34535 |      84.20 |
|          34537 |      84.20 |
|          34539 |      84.20 |
|          34540 |     168.40 |
|          34541 |      84.20 |
|          67589 |      57.34 |
|          67590 |      57.34 |
|          67592 |     114.68 |
|          67593 |      57.34 |
+----------------+------------+
13 rows in set (0.00 sec)

mysql> SELECT EMP_NUM, EMP_FNAME FROM EMPLOYEE ORDER BY EMP_NUM DESC LIMIT 2;
+---------+-----------+
| EMP_NUM | EMP_FNAME |
+---------+-----------+
|     106 | Gemma     |
|     105 | Mirrelle  |
+---------+-----------+
2 rows in set (0.00 sec)

mysql> select * from employee
    -> where(emp_num=100 or emp_num=105)
    -> ;
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
| EMP_NUM | EMP_TITLE | EMP_LNAME  | EMP_FNAME | EMP_DOB    | EMP_HIRE_DATE | EMP_AREA_CODE | EMP_PHONE | PARK_CODE |
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
|     100 | Ms        | Calderdale | Emma      | 1972-06-15 | 1992-03-15    | 0181          | 324-9134  | FR1001    |
|     105 | Ms        | Namowa     | Mirrelle  | 1990-03-14 | 2006-11-08    | 0181          | 890-3243  | FR1001    |
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
2 rows in set (0.00 sec)

mysql>




 

