

create database Hr_Analysis;

use Hr_Analysis;

create view Hr as select *
from 
Hr_Analysis.hr_1 t1
join Hr_Analysis.hr_2 t2 ON t1.employeeNumber = t2.employeeId;


#******view for joined tables**********


SELECT * FROM hr_analysis.hr;




# 1.Average Attrition rate for all Departments *******************************************************************************

select
Department,
count(EmployeeCount) as Total_EMP,
count(Case when attrition = "Yes" then 1 End) attrition,
concat(round(count(Case when attrition = "Yes" then 1 End)/(count(EmployeeCount))*100),'%') as Attrition_rate_DEP
from Hr
group by Department
order by Attrition_rate_DEP;





# 2.Average Hourly rate of Male Research Scientist*******************************************************************************

select 
round(avg(hourlyrate)) Avg_HourlyRate_Male_ResearchScientist
from hr
where jobRole ='Research Scientist' and Gender ="Male";

-- stored Procedure

call Hr_Analysis.Avg_Hourly_rate_jr_gdr('Research Scientist','male');

#Research Scientist,Research Director,Sales Executive,Human Resources,Developer,Manager

select jobrole from hr;



# 3.Attrition rate Vs Monthly income stats ****************************************************************************************************

select
Department,
concat(round(count(Case when attrition = "Yes" then 1 End)/(count(EmployeeCount))*100),'%') as Attrition,
sum(MonthlyIncome) as Income,
round((MonthlyIncome)) as Avg_income
from Hr
group by Department
order by avg_income desc;





# 4.Average working years for each Department ***************************************************************************************************

select
Department,
round(avg(TotalWorkingYears)) as AVG_Working_yr
from hr
group by Department
order by AVG_Working_yr desc;


# 5.Job Role Vs Work life balance **********************************************************************************************************

select
JobRole,
(round(avg (WorkLifeBalance)))as WorkLifeBalance_Rating
from hr
group by jobrole
order by WorkLifeBalance_rating desc;




# 6.Attrition rate Vs Year since last promotion relation *************************************************************************************
select
count(EmployeeNumber) as Number_of_Emp,
concat(round((count(Case when attrition = "Yes" then 1 End)
 /(count(EmployeeNumber))) * 100),'%') Attriton_Rate, 
case
when  YearsSinceLastPromotion <= 4 then "1-5 years"
when  YearsSinceLastPromotion <= 9 then "05-10 years"
when  YearsSinceLastPromotion <= 14 then "10-15 years"
when  YearsSinceLastPromotion <= 19 then "15-20 years"
when  YearsSinceLastPromotion <= 24 then "20-25 years"
when  YearsSinceLastPromotion <=29 then "25-30 years"
when  YearsSinceLastPromotion <= 34 then "30-35 years"
when  YearsSinceLastPromotion <= 39 then "35-40 years"
Else "40< years"
End as Experience,
round(avg(YearsSinceLastPromotion)) as Avg_Yrs_last_pramotions
from hr
group by  Experience 
order by Number_of_Emp desc;






#*************************************************************Thank_you********************************************************************************#





alter table hr_2 rename column `Employee ID` to employeeID;
#(sum(Case when attrition = "Yes" then 1 End)
#/(select count(Case when attrition = "Yes" then 1 End) from hr_1)*100) as arttision_split;


select
round(avg(HourlyRate)) as Avg_Hourly_Rate_Male_Research_Scientist
from Hr_Analysis.hr_1
where JobRole='Research Scientist' and Gender='Male';

-- stored Procedure
call hr_project.Avg_Hourly_rate_jr_gdr('Research Scientist', 'male');

 # 7.find the details of employees under attretion having 5yrs experience in between the age group 27-35
 
select *
from hr_analysis.hr_1 t1
join hr_2 t2 on t1.EmployeeNumber=t2.employeeID
where Age between 27 and 35
and TotalWorkingYears>5;

# 8. Featch the details of employee having max and min salary working in different departement who recive less than 13% hike;

select
Department,
max(MonthlyIncome),min(MonthlyIncome)
from hr_analysis.hr_1 t1
join hr_2 t2 on t1.EmployeeNumber=t2.employeeID
where PercentSalaryHike<13
group by Department;


# 9.calculate average monthely income of all employees who work more than 3 years and ther eaducation bagroud is medicale

select
count(EmployeeCount) as NO_EMP,
EducationField,
avg(MonthlyIncome)
from hr_analysis.hr_1 t1
join hr_2 t2 on t1.EmployeeNumber=t2.employeeID
where TotalWorkingYears>3 and EducationField='Medical';

#10.emplyee max perforemence rating and but no promotion from 4+ years;
select
count(employeeID) NO_EMP,
max(PerformanceRating),
concat(round((count(Case when attrition = "Yes" then 1 End)
 /(count(EmployeeNumber))) * 100),'%') Attriton_Rate
from hr_analysis.hr_1 t1
join hr_2 t2 on t1.EmployeeNumber=t2.employeeID
where YearsSinceLastPromotion>=4;

# 11.who has max and min salary Hike departement wise

select
Department,YearsAtCompany,YearsSinceLastPromotion,
max(PercentSalaryHike) Max_Hike,min(PercentSalaryHike) Min_Hike
from hr_analysis.hr_1 t1
join hr_2 t2 on t1.EmployeeNumber=t2.employeeID
group by Department,YearsAtCompany,YearsSinceLastPromotion;