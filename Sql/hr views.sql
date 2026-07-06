---=========================================================================
--NOW THAT I HAVE A CLEAN TABLE WITH COLUMNS I NEED .
--IM GOING TO CREATE VIEWS FOR CONVERSION CALCULATIONS NEEDED

---STEP 3
create view gender_attrition as	
	select 
		gender,
		count(*) as total_employees,
		count(case when attrition = 'Yes' then 1 end) as exited,
		round(count(case when attrition = 'Yes' then 1 end) * 100/ count(*),1) as att_rate
from hr_data
group by gender;
	
create view employee_attrition as
	select
		count(*) as total_employees,
		count(case when attrition = 'Yes' then 1 end) as exited,
		round(count(case when attrition = 'Yes' then 1 end) * 100/ count(*),1) as att_rate
from hr_data;


create view overtime_attrition as
	select 
		overtime ,
		count(*) as total_employees,
		count(case when attrition = 'Yes' then 1 end) as exited,
		round(count(case when attrition = 'Yes' then 1 end) * 100/ count(*),1) as att_rate
from hr_data
group by overtime;


create view department_based_attrition as
	select 
		department,
		count(*) as total_employees,
		count(case when attrition = 'Yes' then 1 end) as exited,
		round(count(case when attrition = 'Yes' then 1 end) * 100/ count(*),1) as att_rate
from hr_data
group by department ;


create view Jobrole_based_attrition as
	select 
		jobrole ,
		count(*) as total_employees,
		count(case when attrition = 'Yes' then 1 end) as exited,
		round(count(case when attrition = 'Yes' then 1 end) * 100/ count(*),1) as att_rate
from hr_data
group by jobrole ;

create view education_level_attrition as
	select 
		case
 	 	when education = 1 then 'Highschool'
 	 	when education = 2 then 'Diploma'
	 	when education = 3 then 'Degree'
 	 	when education = 4 then 'Postgrad'
	 	when education = 5 then 'Doctorate' 
		end as Education_level,
	count(*) as total_employees,
	count(case when attrition = 'Yes' then 1 end) as exited,
	round(count(case when attrition = 'Yes' then 1 end) * 100/ count(*),1) as att_rate,
	round(avg(monthlyincome),0) as Avg_Salary
from hr_data
group by education;

create view tenure as
	select 
		case
 		 when yearsatcompany  <= 2 then '0-2 years'
 		 when yearsatcompany between 3 and 5 then '3-5 years'
	 	when yearsatcompany  between 6 and 9 then '6-9 years'
 	 	when yearsatcompany  >= 10 then '10+ years' 
		end as tenure_period,
	count(*) as total_employees,
	count(case when attrition = 'Yes' then 1 end) as exited,
	round(count(case when attrition = 'Yes' then 1 end) * 100/ count(*),1) as att_rate
from hr_data
group by 1 
order by 1 ;


create view distance_based_attrition as
	select 
	jobrole,
	attrition,
	count(*) as total_employees,
	round(avg(distancefromhome),1) as distance_travelled
from hr_data
group by jobrole,attrition;


create view workplace_satisfaction as
	select 
		case
 	 	when jobsatisfaction  = 1 then 'Low'
 	 	when jobsatisfaction  = 2 then 'Okay'
	 	when jobsatisfaction  = 3 then 'Happy'
 	 	when jobsatisfaction  = 4 then 'Excellent'
		end as job_satisfaction,
	count(*) as total_employees,
	count(case when attrition = 'Yes' then 1 end) as exited,
	round(count(case when attrition = 'Yes' then 1 end) * 100/ count(*),1) as att_rate
from hr_data
group by jobsatisfaction 
order by jobsatisfaction desc;


create view environment_satisfaction as
	select 
		case
 		 when environmentsatisfaction   = 1 then 'Low'
 	 	when environmentsatisfaction   = 2 then 'Okay'
	 	when environmentsatisfaction   = 3 then 'Happy'
 	 	when environmentsatisfaction   = 4 then 'Excellent'
		end as environment_satisfaction,
	count(*) as total_employees,
	count(case when attrition = 'Yes' then 1 end) as exited,
	round(count(case when attrition = 'Yes' then 1 end) * 100/ count(*),1) as att_rate
from hr_data
group by environmentsatisfaction  
order by environmentsatisfaction  desc;

create view worklife_balance as
	select 
		case
 	 	when worklifebalance = 1 then 'Low'
 	 	when worklifebalance = 2 then 'Okay'
	 	when worklifebalance = 3 then 'Happy'
 	 	when worklifebalance = 4 then 'Excellent'
		end as worklife_balance,
	count(*) as total_employees,
	count(case when attrition = 'Yes' then 1 end) as exited,
	round(count(case when attrition = 'Yes' then 1 end) * 100/ count(*),1) as att_rate
from hr_data
group by worklifebalance   
order by worklifebalance desc;



