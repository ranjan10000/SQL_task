CREATE TABLE RANJITHKUMAR_EMPLOYEES
(
ID INT PRIMARY KEY,
FIRST_NAME VARCHAR(40),
LAST_NAME VARCHAR(40),
SALARY DECIMAL(8,2),
DEPARTMENT_ID INT,
YEAR_OF_JOINING DATETIME,
YEAR_OF_RELIEVING DATETIME
)

INSERT INTO RANJITHKUMAR_EMPLOYEES (ID,FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_ID,YEAR_OF_JOINING,YEAR_OF_RELIEVING)
VALUES
(100,'RANJITH','KUMAR',100000,10,'01/01/2000','02/02/2022'),
(101,'SARAVANAN','MURUGAN',50000,20,'05/05/2001','01/01/2005'),
(102,'VIJAY','KANTH',20000,50,'08/08/2005','10/10/2020'),
(103,'AJITH','KUMAR',10000,90,'12/12/2008','12/12/2019'),
(104,'LOGESH','KUMAR',5000,90,'11/10/2009','09/10/2018'),
(105,'SURYA','SIVAKUMAR',35000,10,'10/08/2010','12/09/2022'),
(106,'ARUN','PANDI',8000,50,'03/05/2010','06/17/2017'),
(107,'GAYATHRI','',25000,10,'08/17/2002','07/22/2015'),
(108,'RAJA','SEKAR',40000,10,'05/05/1999','03/29/2021'),
(109,'SANMUGA','PERUMAL',30000,90,'04/22/2002','05/03/2014'),
(110,'SHANKAR','SARAN',38000,90,'08/09/2000','06/04/2005'),

(121,'SAM','SARAN',18000,50,'08/19/2005','06/04/2008'),
(122,'HARRIS','JAYARAJ',56000,50,'04/20/2006','06/04/2012')
(123,'PRAGASH','GV',7000,22,'04/20/2007','06/04/2013'),

INSERT INTO RANJITHKUMAR_EMPLOYEES (ID,FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_ID,YEAR_OF_JOINING,YEAR_OF_RELIEVING)
VALUES


SELECT * FROM RANJITHKUMAR_EMPLOYEES

SELECT FIRST_NAME  FROM RANJITHKUMAR_EMPLOYEES WHERE FIRST_NAME LIKE 'S%'

SELECT FIRST_NAME,LAST_NAME FROM RANJITHKUMAR_EMPLOYEES WHERE FIRST_NAME LIKE 'S%' AND LAST_NAME LIKE '%N'

SELECT * FROM RANJITHKUMAR_EMPLOYEES WHERE DEPARTMENT_ID = 90 AND FIRST_NAME LIKE 'S%'

SELECT * FROM RANJITHKUMAR_EMPLOYEES WHERE DEPARTMENT_ID LIKE '%_2'

SELECT * FROM RANJITHKUMAR_EMPLOYEES WHERE DEPARTMENT_ID IN(10,20,50,90)

SELECT * FROM RANJITHKUMAR_EMPLOYEES WHERE SALARY BETWEEN 5000 AND 7000

CREATE TABLE RANJITHKUMAR_DEPARTMENTS
(
DEPARTMENT_ID INT ,
MANAGER_ID INT,
DEPARTMENT_NAME VARCHAR(50)
)
DROP TABLE RANJITHKUMAR_DEPARTMENTS

INSERT INTO RANJITHKUMAR_DEPARTMENTS(DEPARTMENT_ID,MANAGER_ID,DEPARTMENT_NAME)
VALUES
(20,208,'MANAGER'),(20,209,'MANAGER'),(30,210,'HR')
(10,200,'DEVELOPER'),(10,201,'DEVELOPER'),(90,204,'TEST ENGINEER'),(90,205,'TEST ENGINEER'),(50,206,'FINANCE'),(22,207,'SALES')



SELECT * FROM RANJITHKUMAR_DEPARTMENTS
SELECT FIRST_NAME,E.DEPARTMENT_ID,SALARY,MANAGER_ID FROM RANJITHKUMAR_EMPLOYEES E INNER JOIN RANJITHKUMAR_DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID

 SELECT * FROM RANJITHKUMAR_EMPLOYEES ORDER BY  FIRST_NAME DESC

 SELECT FIRST_NAME,DEPARTMENT_ID,SALARY FROM RANJITHKUMAR_EMPLOYEES ORDER BY DEPARTMENT_ID , SALARY DESC

 SELECT LEFT(FIRST_NAME,3) FROM RANJITHKUMAR_EMPLOYEES 

 SELECT RIGHT(LAST_NAME,2) FROM RANJITHKUMAR_EMPLOYEES

 SELECT FIRST_NAME FROM RANJITHKUMAR_EMPLOYEES WHERE FIRST_NAME LIKE 'A%'

 SELECT MAX(SALARY) FROM RANJITHKUMAR_EMPLOYEES

 
 SELECT  MAX(SALARY) FROM RANJITHKUMAR_EMPLOYEES WHERE SALARY< (SELECT MAX(SALARY) FROM RANJITHKUMAR_EMPLOYEES)

 SELECT AVG(SALARY) FROM RANJITHKUMAR_EMPLOYEES WHERE DEPARTMENT_ID = 90

 SELECT COUNT (FIRST_NAME) FROM RANJITHKUMAR_EMPLOYEES WHERE DEPARTMENT_ID = 10

 SELECT AVG(SALARY) FROM RANJITHKUMAR_EMPLOYEES WHERE YEAR_OF_RELIEVING<GETDATE()

 SELECT DATENAME(MONTH,YEAR_OF_JOINING) FROM RANJITHKUMAR_EMPLOYEES GROUP BY DATENAME(MONTH,YEAR_OF_JOINING) HAVING COUNT(*)>3

 SELECT LAST_NAME,YEAR_OF_JOINING AS STARTINGDATE FROM  RANJITHKUMAR_EMPLOYEES WHERE YEAR(YEAR_OF_JOINING) BETWEEN 2000 AND 2005
  
 SELECT YEAR(YEAR_OF_JOINING) AS YEAR,COUNT(*) AS COUNT FROM RANJITHKUMAR_EMPLOYEES GROUP BY YEAR(YEAR_OF_JOINING) HAVING COUNT(*)>=2

--21 SELECT ID FROM RANJITHKUMAR_EMPLOYEES GROUP BY SALARY HAVING AVG(SALARY) > 10000

SELECT ID,DATEDIFF(DAY,YEAR_OF_JOINING,YEAR_OF_RELIEVING) AS DATES FROM RANJITHKUMAR_EMPLOYEES

SELECT FIRST_NAME AS NAME FROM RANJITHKUMAR_EMPLOYEES WHERE YEAR_OF_JOINING = 2022

SELECT UPPER(FIRST_NAME) AS FIRST_NAME,LOWER(LAST_NAME) AS LAST_NAME FROM RANJITHKUMAR_EMPLOYEES

SELECT FIRST_NAME ,LEN(FIRST_NAME ) AS LENGTH_OF_FIRST_NAME FROM  RANJITHKUMAR_EMPLOYEES WHERE LAST_NAME LIKE '__N%'

SELECT FIRST_NAME,LAST_NAME,DATEDIFF(YEAR,DATENAME(MONTH,YEAR_OF_JOINING),YEAR_OF_RELIEVING) AS EXPERIENCE FROM  RANJITHKUMAR_EMPLOYEES 

SELECT FIRST_NAME,LAST_NAME FROM  RANJITHKUMAR_EMPLOYEES WHERE MONTH(YEAR_OF_JOINING)=5

SELECT ID,FIRST_NAME,LAST_NAME,SALARY  FROM  RANJITHKUMAR_EMPLOYEES WHERE SALARY > (SELECT AVG(SALARY) FROM  RANJITHKUMAR_EMPLOYEES)

CREATE TABLE RANJITHKUMAR_EMPLOYEES
(
ID INT PRIMARY KEY,
FIRST_NAME VARCHAR(40),
LAST_NAME VARCHAR(40),
SALARY DECIMAL(8,2),
DEPARTMENT_ID INT FOREIGN KEY REFERENCES RANJITHKUMAR_DEPARTMENTS,
YEAR_OF_JOINING DATETIME,
YEAR_OF_RELIEVING DATETIME
)

UPDATE RANJITHKUMAR_EMPLOYEES SET LAST_NAME ='AAA' WHERE ID = 107

SELECT * FROM RANJITHKUMAR_EMPLOYEES

CREATE VIEW RANJITHKUMAR_VIEW AS SELECT ID,FIRST_NAME,LAST_NAME,RANJITHKUMAR_EMPLOYEES.DEPARTMENT_ID,DEPARTMENT_NAME FROM RANJITHKUMAR_EMPLOYEES INNER JOIN RANJITHKUMAR_DEPARTMENTS ON RANJITHKUMAR_EMPLOYEES.DEPARTMENT_ID = RANJITHKUMAR_DEPARTMENTS.DEPARTMENT_ID
SELECT * FROM RANJITHKUMAR_VIEW

CREATE SYNONYM RANJAN FOR RANJITHKUMAR_EMPLOYEES

SELECT * FROM RANJAN

CREATE PROCEDURE RANJAN_PROCEDURE 
AS  
SELECT * FROM RANJITHKUMAR_EMPLOYEES WHERE YEAR_OF_JOINING BETWEEN '01/01/2000' AND '03/02/2022'
GO
EXEC RANJAN_PROCEDURE 

CREATE PROCEDURE RAJAN_PROCEDURE 
AS  
INSERT INTO RANJITHKUMAR_DEPARTMENTS VALUES(30,202,'HR')
GO
EXEC RAJAN_PROCEDURE 

SELECT REPLACE( '2002-01-03','-','')+REPLACE('00:02:35', ':','')

SELECT REPLACE('2002-01-03','-','')-- +REPLACE(CONVERT(VARCHAR, 'EANJAN'),'E','R')