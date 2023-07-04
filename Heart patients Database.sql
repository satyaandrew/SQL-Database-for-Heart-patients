-- Title: C7084 Assignment 
-- Author: Student 22358100

-- CONTENTS
-- 1. Background
-- 2. Database setup
-- 3. Import Data
-- 4. MySQL Operations
-- 5. Summary of utility and limitations of the database 
-- 6. Conclusion

-- 1. BACKGROUND
-- The given dataset names heart.csv consists of medical data for patients who are experiencing chest pain
-- It is intended to store medical data of patients experiencing chest pain
-- Each row represents a patient, and each column represents a feature of that patient's medical condition

-- 2. DATABASE SETUP

-- CREATING DATABASE
create database Assignment7084;

-- 3. IMPORT DATA
-- I have imported the data by "Load Spatial Daata command"

-- 4. MySQL OPERATIONS

-- VIEW DATABASE
select * from Assignment7084.heart;
-- To view all the details of the table, we used select 

SELECT * FROM assignment7084.heart
WHERE id=72;
-- the queries SELECT, FROM, WHERE To view all the details of a single patient

SELECT * FROM Assignment7084.heart
WHERE chest_pain = 4;
-- by using these queries we can view the people with severe chest pain

select age,sex,chest_pain
from assignment7084.heart
where sex=1 and chest_pain=4
order by age;
-- by using the queries we are viewing male patients only with chest pain

select age,sex,chest_pain
from assignment7084.heart
where age between 50 and 80 and chest_pain = 4 and sex = 1
order by age;
-- this queries to view people with highest chest pain in age between 50 to 80.

select bp,chol,sugar 
from assignment7084.heart
where bp = 180;
-- to know the patients with 180 bp

select *
from assignment7084.heart
where not sugar=0; 
-- where not function is used here to find out the patients with sugar

INSERT INTO assignment7084.heart (id,age,sex,chest_pain,bp,chol,sugar,ecg,maxhr,angina,depress,slope,vessels,thal,last)
VALUES (271,57,1,2,146,250,1,0,158,1,1.7,2,2,7,1);
-- insert into Query is used to add the data of one patient into the table

select * from assignment7084.heart
where id=271;
-- to view the newly inserted patient data.

ALTER TABLE assignment7084.heart
ADD PRIMARY KEY (id);
-- we used Primary key function/query which helps to uniquely identify every recoed in the table
-- alter table function is used where ever we change the settings of table

UPDATE assignment7084.heart
SET chol = 265
WHERE id = 271;
-- updating the database

select * from assignment7084.heart
where id=271;

DELETE FROM assignment7084.heart WHERE id=271;
-- we deleated the 271 id column using delete from function

SELECT MIN(bp)
FROM assignment7084.heart
WHERE bp;
-- by this function we can know the lowest bp value in the entire table

SELECT MAX(chol) 
FROM assignment7084.heart
WHERE chol;
-- by using MAX function we can know what is the max value in a column of a table.

SELECT COUNT(age)
FROM assignment7084.heart
WHERE age; 
-- by using the Count function we can know the count of number of rows

SELECT AVG(bp)
FROM assignment7084.heart
WHERE bp;
-- Average value of a column can be known by using AVG() function, here the average BP for having chest pain is 131.344

SELECT * FROM assignment7084.heart
WHERE bp LIKE '12%';
-- we are using a wildcard % function here to know the values starting with numbers 12. Here, to know the bp values in the range of 120

 SELECT * FROM assignment7084.heart
WHERE chol LIKE '%6%';
-- wildcard %% is used here to show the values of bp having 6 in them

use assignment7084;

CREATE TABLE PatientDetails (
    id int,
    LastName varchar(50),
    FirstName varchar(50),
    Address varchar(50),
    City varchar(50)
);
-- creates a table called "PatientDetails" that contains five columns: id, LastName, FirstName, Address, and City
-- The id column is of type int and will hold an integer
-- The LastName, FirstName, Address, and City columns are of type varchar and will hold characters, and the maximum length for these fields is 50 characters

INSERT INTO PatientDetails (id, LastName, FirstName, Address, City)
VALUES (1, 'Doe', 'John', '123 Main St', 'New York'),
       (2, 'Smith', 'Jane', '456 Park Ave', 'London'),
       (3, 'Johnson', 'Bob', '789 5th Ave', 'Paris');
-- we are inserting three rows of data into the PatientDetails table
-- Each row contains values for all five columns: id, LastName, FirstName, Address, and City

SELECT pd.FirstName, pd.LastName, h.age, h.sex, h.chest_pain, h.bp, h.chol, h.sugar, h.ecg, h.maxhr, h.angina, h.depress, h.slope, h.vessels, h.thal, h.last
FROM assignment7084.PatientDetails pd
JOIN assignment7084.heart h
ON pd.id = h.id;
-- we are selecting columns from both tables (PatientDetails and heart) by joining them based on the id column
-- The join condition is specified using the ON funvction
-- We are also using table aliases (pd and h) to simplify the query

SELECT age, sex, chest_pain, bp, chol, sugar, ecg, maxhr, angina, depress, slope, vessels, thal, last
FROM assignment7084.heart
WHERE id IN (
    SELECT id
    FROM assignment7084.PatientDetails
    WHERE City = 'New York'
);
-- The nested query is used to find the id values in the PatientDetails table where the City is 'New York'
-- The outer query then selects the corresponding rows from the heart table using the IN operator to filter by those id values

SELECT id, age, bp
FROM assignment7084.heart
WHERE sex = 0 AND chol > 240 AND bp < 120
ORDER BY age ASC;
-- In this query we can get the id, age, and bp for all female patients with high cholesterol (above 240) and normal blood pressure (bp less than 120), sorted by age in ascending order

SELECT id, age 
FROM assignment7084.heart 
WHERE sex=0 AND chol > 300;
-- To get the IDs and ages of female patients who have a cholesterol level higher than 300

SELECT AVG(chol)
FROM assignment7084.heart
WHERE sex = 1 AND chest_pain >= 4;
-- his query uses the AVG function to find the average cholesterol level of male patients who have chest pain level of 4 or higher
-- The WHERE clause is used to filter the rows based on the condition that sex is equal to 1 (male) and chest_pain is greater than or equal to 4

SELECT COUNT(*)
FROM assignment7084.heart
WHERE sex = 0 AND bp > 130;
-- This query uses the COUNT function to count the number of female patients who have a blood pressure reading greater than 130
-- The WHERE clause is used to filter the rows based on the condition that sex is equal to 0 (female) and bp is greater than 130

SELECT sex, AVG(age) AS average_age, MAX(chol) AS max_chol, MIN(bp) AS min_bp
FROM assignment7084.heart
WHERE chest_pain > 3
GROUP BY sex
HAVING COUNT(*) > 5
ORDER BY average_age DESC;
-- A query construction is done here, the query constructs a summary of information about patients with chest pain greater than 3, grouped by sex
-- It calculates the average age, maximum cholesterol, and minimum blood pressure for each group
-- filters out groups with less than 5 patients using the HAVING clause and sorts the results by average age in descending order

SELECT MIN(age) AS min_age, MAX(age) AS max_age, AVG(chol) AS avg_chol
FROM assignment7084.heart
WHERE bp > 140;
-- This query uses the MIN, MAX, and AVG functions to find the age range and average cholesterol level of patients who have a blood pressure reading greater than 140
-- The WHERE clause is used to filter the rows based on the condition that bp is greater than 140

CREATE TABLE KidneyProblems (
  id INT PRIMARY KEY,
  age INT,
  sex INT,
  bp INT,
  creatinine FLOAT,
  glucose INT,
  albumin FLOAT
);
-- This creates a new table called KidneyProblems with columns for the patient's id, age, sex, blood pressure, creatinine levels, glucose levels, and albumin levels
-- The id is set as the primary key to ensure each row is unique. 
-- This table is intended to store information about patients with kidney problems, where each row represents a single patient

INSERT INTO KidneyProblems (id, age, sex, bp, creatinine, glucose, albumin)
VALUES
(1, 42, 0, 140, 0.9, 100, 3.5),
(2, 56, 1, 132, 1.2, 97, 4.1),
(3, 30, 1, 118, 1.0, 102, 3.8),
(4, 45, 0, 125, 1.1, 92, 4.0),
(5, 50, 1, 135, 0.8, 110, 3.7),
(6, 62, 1, 130, 1.2, 88, 4.2),
(7, 39, 0, 120, 1.3, 94, 3.5),
(8, 51, 1, 138, 0.9, 101, 4.0),
(9, 56, 0, 124, 1.4, 102, 3.3),
(10, 40, 1, 126, 0.7, 93, 4.1),
(11, 45, 1, 136, 1.2, 100, 3.8),
(12, 35, 0, 130, 1.0, 96, 3.9),
(13, 48, 1, 140, 1.3, 92, 3.6),
(14, 50, 0, 124, 1.1, 110, 3.9),
(15, 39, 1, 110, 0.9, 102, 4.2),
(16, 60, 1, 130, 1.0, 88, 3.8),
(17, 37, 0, 120, 1.1, 94, 3.4),
(18, 52, 1, 128, 0.8, 101, 3.7),
(19, 46, 0, 132, 1.2, 102, 3.2),
(20, 43, 1, 130, 0.7, 93, 4.0),
(21, 55, 1, 136, 1.1, 100, 3.6),
(22, 42, 0, 128, 1.0, 96, 3.5),
(23, 47, 1, 140, 1.3, 92, 3.9),
(24, 48, 0, 126, 1.0, 110, 3.8),
(25, 41, 1, 118, 1.1, 102, 3.7),
(26, 61, 1, 132, 0.8, 88, 4.1),
(27, 38, 0, 130, 1.2, 94, 3.6),
(28, 54, 1, 138, 0.9, 101, 3.9);
-- we are inserting 28 rows of data into the table KidneyProblems with the columns id, age, sex, bp, creatinine, glucose, albumin
-- Each row represents information about a patient with kidney problems

ALTER TABLE KidneyProblems
ADD COLUMN patient_id INT,
ADD CONSTRAINT fk_patient_id
FOREIGN KEY (patient_id) REFERENCES heart(id);
-- adds a new column called "patient_id" to the "KidneyProblems" table and sets it as a foreign key referencing the "id" column in the "heart" table
-- This allows us to create a relationship between the two tables based on the patient ID, so we can easily access information from both tables

SELECT h.*, k.*
FROM assignment7084.heart h
JOIN KidneyProblems k ON h.id = k.patient_id;
-- This query uses a JOIN clause to combine the data from both tables based on their common id column
-- The resulting output will include all columns from both tables for any records where the id values match

-- 5. SUMMARY OF UTILITY AND LIMITATIONS OF THE DATABASE

-- Utility
-- The utility of the  database is that it provides a structured way to store and retrieve information about heart patients
-- By using these SQL queries, we can easily extract specific information from the database, such as patients with certain medical conditions or test results
-- The database also allows for the analysis of the data, such as finding the maximum or minimum values of a particular field, or calculating the average values of a column
-- The SELECT queries are used to view and filter specific information from the tables, such as patients with severe chest pain, patients with sugar levels, patients with specific blood pressure values, and newly inserted patients
-- The INSERT INTO query is used to add a new patient record, the UPDATE query is used to update a patient's cholesterol level, and the DELETE query is used to remove a patient's record from the database
-- The script also includes aggregate functions such as MIN, MAX, COUNT, and AVG to calculate the minimum, maximum, count, and average of specific columns
-- The JOIN query is used to combine the tables based on the id column. It includes nested queries that filter patients based on their cities of residence

-- Limitations
-- No Information is given about the "maxhr" "angina" "depress"	"slope"	"vessels"	"thal"	"last" columns of the the heart dataset
-- So the data in these columns is not used

-- 6. CONCLUSION
-- It can be concluded that the database provides a useful and structured way to store and retrieve information about heart patients
-- SQL queries are used to extract specific information, filter data based on certain criteria, and perform analysis on the data
-- The database provides a useful tool for managing and analyzing patient data, but limitations should be taken into consideration when using it for clinical purposes