---KAGGLE DATASET IBM HR Analytics Employee Attrition & Performance
---PURPOSE
---THIS SCRIPT FOCUSES ON IMPORTING,TABLE CREATION,INSPECTION AND CLEANING
---ANALYSED BY MUSA NTULI
---Step 1 Table creation
create table raw_employee_data(
	Age int, 
	attrition varchar,
	BusinessTravel varchar,
	DailyRate int,
	Department varchar,
	DistanceFromHome int,
	Education int,
	EducationField varchar,
	EmployeeCount int,
	EmployeeNumber int,
	EnvironmentSatisfaction int,
	Gender varchar,
	HourlyRate int,
	JobInvolvement	int,
	JobLevel int,
	JobRole	varchar,
	JobSatisfaction	int,
	MaritalStatus varchar,
	MonthlyIncome int,
	MonthlyRate int,
	NumCompaniesWorked int,
	Over18	varchar,
	OverTime varchar,
	PercentSalaryHike int,
	PerformanceRating int,
	RelationshipSatisfaction int,
	StandardHours int,
	StockOptionLevel int,
	TotalWorkingYears int,
	TrainingTimesLastYear int,
	WorkLifeBalance int,
	YearsAtCompany int,
	YearsInCurrentRole int,
	YearsSinceLastPromotion int,
	YearsWithCurrManager int 
	) 
	---I ASSIGNED DATATYPES TO THE COLUMNS ALREADY
	---'INT' FOR COLUMNS WITH NUMBERS, MADE EASY CAUSE THERE ARE NO DECIMALS
	---'VARCHAR' FOR COLUMNS WITH TEXTS
	
---STEP 2 
---INSPECT THE DATA, CREATE A TABLE WITH COLUMNS I NEED FOR THE ANALYSIS AND ALSO CLEAN THE DATA.
select
	count(employeenumber) ---To check for duplicates in employeenumber column
	from raw_employee_data
	group by employeenumber 
	having count(*)>1;
select 
	count(attrition)
	from raw_employee_data;

select 
count(case attrition when 'Yes' then 1 end )as employees_exited,---COUNTS THE AMOUNT OF ROWS THAT HAVE YES
count(case attrition when 'No' then 1 end )as still_here, ---COUNTS THE AMOUNT OF ROWS THAT NO
count(*) as total_rows---COUNTS THE TOTAL ROWS , TO COMPARE AGAINTS THE COLUMNS ABOVE
from raw_employee_data; 
---Out of 1470 employees ,237 left. WILL USE A SIMILAR QUERY LATER FOR CONVERSION RATES
select *
from raw_employee_data
where monthlyincome is null;---Null checks

select *
from raw_employee_data
where monthlyrate is null;
---BOTH CHECKS RETURNED NOTHING MEANING THERE ARE NO NULL VALUES IN THOSE COLUMNS
---HAD THE QUERIES RETURNED NULLS VALUE I WAS GOING TO USE COUNT() TO SEE HOW MANY.
select 
count(case employeecount  when 1 then 1 end )as count,
count(case over18  when 'Y' then 1 end )as legal, 
count(case standardhours   when 80 then 1 end )as minimum,
count(*)  as total_rows
from raw_employee_data;---THOSE 3 COLUMNS SHOULD ALL CONSIST OF THE SAME DATA,I JUST DOUBLE CHECKED IF THEY DO.
---NO DUPLICATES,NULLS WERE FOUND IN KEY COLUMNS .
---==============================================================
---2.1 NOW TO CREATE A TABLE WITH DATA I NEED FOR CONVERSIONS.
create table hr_data as 
	select 
	EmployeeNumber,
	Age, 
	Gender,
	MonthlyIncome,
	OverTime,
	YearsAtCompany,
	Department, 
	JobRole,
	Education,
	Attrition,
	DistanceFromHome,
	WorkLifeBalance,
	JobSatisfaction,
	EnvironmentSatisfaction,
	BusinessTravel
from raw_employee_data;
---I DIDNT NEED TO ASSIGN DATA TYPES CAUSE I ALREADY DID THAT ON STEP 1.
---CREATED THE MAIN CLEAN TABLE IM GOING TO USE FOR CONVERSIONS
---====================================================================
---SUMMARY
---CREATED EMPTY TABLES TO MAKE IMPORTING DATA EASIER, ASSIGNED DATATYPES ALREADY.
---INSPECTED THE DATA , FOUND NO NULLS,DUPLICATES AND IRREGULAR DATA.
---CREATED A CLEAN TABLE TO USE FOR VIEWS 
