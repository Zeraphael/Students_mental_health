--- Create data base
create database students_mental_health;

--- Create table
create table Students(
Date_time text,
Gender text,
Age int,
Course text,
Year_of_study text,
Cgpa text,
Martial_status text,
Depression text,
Anxiety text,
Panic_attack text,
Seek_specialist text);

-- Show all data
select * from students;

-- Show all students with all mental health problems
select * from students where Depression = "Yes" and Anxiety = "Yes" and Panic_attack = "Yes" and Seek_specialist = "Yes";

-- Show all students with at least one mental health problems
select count(*) from students where Depression = "Yes" or Anxiety = "Yes" or Panic_attack = "Yes" or Seek_specialist = "Yes";

-- Show all female students with all mental health problems
select count(*) from students where Gender ="Female" and (Depression = "Yes" or Anxiety = "Yes" or Panic_attack = "Yes" or Seek_specialist = "Yes");

-- Show all male students with all mental health problems
select count(*) from students where Gender ="Male" and (Depression = "Yes" or Anxiety = "Yes" or Panic_attack = "Yes" or Seek_specialist = "Yes");

--- Corelation between age and mental health
select distinct(Age), Depression, Anxiety, Panic_attack, Seek_specialist from students
order by Age;

 --- Show all  students with all mental health problems at age of 18
select count(*) from students where Age =18 And (Depression = "Yes" or Anxiety = "Yes" or Panic_attack = "Yes" or Seek_specialist ="Yes") ;

-- all students with mental problems at each age
select Age, count(*) as total from students where Depression = "Yes" or Anxiety = "Yes" or Panic_attack = "Yes" or Seek_specialist ="Yes" 
group by Age
order by total desc;
-- Corelation between course taken and mental health
select Course, count(*) as total from students where Depression = "Yes" or Anxiety = "Yes" or Panic_attack = "Yes" or Seek_specialist ="Yes" 
group by Course
order by total desc limit 5;
-- Corelation between cgpa and mental health
select Cgpa, count(*) as total from students where Depression = "Yes" or Anxiety = "Yes" or Panic_attack = "Yes" or Seek_specialist ="Yes" 
group by Cgpa
order by total desc;
-- Corelation between year of study and mental health
select Year_of_study, count(*) as total from students where Depression = "Yes" or Anxiety = "Yes" or Panic_attack = "Yes" or Seek_specialist ="Yes" 
group by Year_of_study
order by total desc;
-- cgpa and seek specialist
SELECT Cgpa, COUNT(*) AS total
FROM Students
WHERE Seek_specialist = 'Yes'
GROUP BY Cgpa
ORDER BY total DESC;

-- Issues that happen together
SELECT Depression, Anxiety,  COUNT(*) AS total
FROM Students
WHERE Depression = 'Yes' AND Anxiety = 'Yes';
--- students that seek specialist grouped by gender
SELECT Gender, COUNT(*) AS total
FROM Students
WHERE Seek_specialist = 'Yes'
GROUP BY Gender;
--- students with issues but who do not seek help
SELECT COUNT(*) 
FROM Students 
WHERE (Depression = 'Yes' OR Anxiety = 'Yes' OR Panic_attack = 'Yes') 
AND Seek_specialist = 'No';

SELECT substr(Date_time, 1, 7) AS month, COUNT(*) as total
FROM Students
WHERE Depression = 'Yes' OR Anxiety = 'Yes'
GROUP BY month
ORDER BY month;
--- variation by month
SELECT substr(Date_time, 1, 7) AS month, COUNT(*) as total
FROM Students
WHERE Depression = 'Yes' OR Anxiety = 'Yes'
GROUP BY month
ORDER BY month;

---  Analysis by martial status
SELECT Martial_status, COUNT(*) AS total
FROM Students
WHERE Depression = 'Yes' OR Anxiety = 'Yes' OR Panic_attack = 'Yes'
GROUP BY Martial_status
ORDER BY total DESC;
--- Combination of all issues
SELECT 
    Depression,
    Anxiety,
    Panic_attack,
    COUNT(*) AS total
FROM Students
GROUP BY Depression, Anxiety, Panic_attack
ORDER BY total DESC;
-- Combinatinon of multiple fields
SELECT Gender, Year_of_study, COUNT(*) AS total
FROM Students
WHERE Depression = 'Yes' OR Anxiety = 'Yes'
GROUP BY Gender, Year_of_study
ORDER BY total DESC;
--- Cgpa and mental health analysis
SELECT 
    Cgpa, 
    SUM(CASE WHEN Seek_specialist = 'Yes' THEN 1 ELSE 0 END) AS sought_help,
    SUM(CASE WHEN Seek_specialist = 'No' THEN 1 ELSE 0 END) AS did_not_seek
FROM Students
GROUP BY Cgpa
ORDER BY Cgpa;
-- Percentage of all students with mental health issues
SELECT 
    (SELECT COUNT(*) FROM Students 
     WHERE Depression = 'Yes' OR Anxiety = 'Yes' OR Panic_attack = 'Yes') * 100.0 
    / COUNT(*) AS percent_affected
FROM Students;
