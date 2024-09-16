create Database HR_Analysis;

select * from hr_1;
select * from hr_2;

alter table hr_1 rename column ï»¿Age to Age;
alter table hr_2 rename column ï»¿EmployeeID to EmployeeID;


-- --KPI 1----Average Attrition rate for all Departments

SELECT 
    Department,
    AVG(CASE
        WHEN Attrition = 'yes' THEN 1
        ELSE 0
    END) AS Avg_Attrition_Rate
FROM
    hr_1
GROUP BY Department;

-- --KPI 2----Average Hourly rate of Male Research Scientist

SELECT 
    AVG(HourlyRate) AS Avg_Hourly_Rate
FROM
    hr_1
WHERE
    gender = 'Male'
        AND JobRole = 'Research Scientist';

-- --KPI 3----Attrition rate Vs Monthly income stats

SELECT 
    sum(case when Attrition = 'yes' then 1 else 0 end) AS Attrition_rate,
    h2.MonthlyIncome AS Monthly_Income
FROM
    hr_1 h1
        JOIN
    hr_2 h2 ON h1.EmployeeNumber = h2.EmployeeID
GROUP BY Monthly_Income
ORDER BY Monthly_Income DESC;

-- --KPI 4----Average working years for each Department

SELECT 
    h1.Department,
    AVG(h2.TotalWorkingYears) AS Avg_Working_years
FROM
    hr_1 h1
        JOIN
    hr_2 h2 ON h1.EmployeeNumber = h2.EmployeeID
GROUP BY Department
ORDER BY Avg_Working_years DESC;

-- --KPI 5----Job Role Vs Work life balance

SELECT 
    h1.jobRole as Job_Role, SUM(h2.WorkLifeBalance) AS Work_life_balance
FROM
    hr_1 h1
        JOIN
    hr_2 h2 ON h1.EmployeeNumber = h2.EmployeeID
GROUP BY h1.jobRole
ORDER BY Work_life_balance DESC;

-- --KPI 6----Attrition rate Vs Year since last promotion relation

SELECT 
    h2.YearsSinceLastPromotion AS Year_Since_last_Promotion,
    SUM(CASE
        WHEN h1.Attrition = 'yes' THEN 1
        ELSE 0
    END) AS Attrition_Rate
FROM
    hr_1 h1
        JOIN
    hr_2 h2 ON h1.EmployeeNumber = h2.EmployeeID
GROUP BY Year_Since_last_Promotion
ORDER BY Year_Since_last_Promotion ASC;