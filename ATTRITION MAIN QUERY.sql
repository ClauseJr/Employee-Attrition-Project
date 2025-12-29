

SELECT * FROM employee_attrition_data;


SELECT 
	COUNT(*) 
FROM employee_attrition_data;

-- CALCULATING THE TOTAL INCOME

SELECT
	ROUND(AVG(monthly_income),2) total_income 
FROM employee_attrition_data;

-- CALCULATING SUM OF SALARY BY GENDER

SELECT 
	DISTINCT gender, 
	SUM(monthly_income) total_income
FROM employee_attrition_data
GROUP BY gender;

-- CALCULATING SUM OF SALARY BY GENDER AND DEPARTMENT

SELECT
	DISTINCT department,
	gender,
	SUM(monthly_income) total_income
FROM employee_attrition_data
GROUP BY department, gender;

-- CALCULATING SUM OF SALARY BY DEPARTMENT

SELECT 
	department,
	COUNT(*) employee_count
FROM employee_attrition_data
GROUP BY department
ORDER BY employee_count DESC;

-- CALCULATING THE ATTRITION RATE

SELECT 
	attrition,
	COUNT(*) employee_count,
	ROUND(COUNT(*) * 100/ SUM(COUNT(*)) OVER(),2) attrition_rate
FROM employee_attrition_data
GROUP BY attrition; 
-- Total attrition = 1997
-- Attrition rate = 19.97%

-- ATTRITION RATE BY DEPARTMENT

SELECT 
	department,
	COUNT(*) employee_count,
	SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) current_employees,
	SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) attrition_count,
	ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2 ) attrition_rate
FROM employee_attrition_data
GROUP BY department
ORDER BY attrition_rate DESC;
-- Finace and IT experienced a higher attrition rate of 20%
-- There was a low attrition rate of 1%-2%, between the highest and the lowest rates per department


-- ATTRITION RATE BY JOB SATISFACTION 

SELECT
    job_satisfaction,
    COUNT(*) total_employees,
    SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) current_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) attrition_rate
FROM employee_attrition_data
GROUP BY job_satisfaction
ORDER BY job_satisfaction;
-- Job satisfaction 1 - Disatisfied
	-- Experienced a relatively lower attrition rate of 19.17%
	-- Financial constraints preventing job change
	-- Toxic environment but afraid to leave
-- Job satisfaction 2 - At least Satisfied
-- Job satisfaction 3 - Moderatetly satisfied
-- Job satisfaction 4 - Satisfied
	-- Experienced the highest attrition rate of 22.16%
	-- Satisfied with current role but see no advancement path
	-- Not satisfied enough to resist better offers
-- Job satisfaction 5 - Very Satisfied
	-- Experienced the Lowest attrition rate of 18.71%
	-- Satisfied with the role

-- ATTRITION RATE BY PERFORMANCE RATINGS

SELECT
	performance_rating,
	COUNT(*) total_employee,
	SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) current_employess,
	SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) attrition_count,
	ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*) , 2) attrition_rate
FROM employee_attrition_data
GROUP BY performance_rating
ORDER BY performance_rating;

-- ATTRITION RATE BY WORK ENVIRONMENT SATISFACTION

SELECT 
	work_environment_satisfaction,
	COUNT(*) total_employees,
	SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) current_employess,
	SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) attrition_count,
	ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*) , 2) attrition_rate
FROM employee_attrition_data
GROUP BY work_environment_satisfaction
ORDER BY work_environment_satisfaction

-- ATTRITION RATE BY MARITAL STATUS AND GENDER

SELECT 
	marital_status,
	gender,
	COUNT(*) total_employees,
	SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) current_employess,
	SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) attrition_count,
	ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*) , 2) attrition_rate
FROM employee_attrition_data
GROUP BY gender, marital_status
ORDER BY marital_status;

-- ATTRITION RATE BY JOB INVOLVEMENT

SELECT 
	job_involvement,
	COUNT(*) total_employees,
	SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) current_employees,
	SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) attrition_count,
	ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100/ COUNT(*),2) attrition_rate
FROM employee_attrition_data
GROUP BY job_involvement
ORDER BY job_involvement
	
-- ATTRITION RATE BY WORK LIFE BALANCE

SELECT
	work_life_balance,
	COUNT(*) total_employees,
	SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) current_employees,
	SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) attrition_count,
	ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100/ COUNT(*),2) attrition_rate
FROM employee_attrition_data
GROUP BY work_life_balance
ORDER BY work_life_balance

-- ATTRITION RATE BY JOB ROLES

SELECT 
	job_role,
	COUNT(*) total_employees,
	SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) current_employees,
	SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) attrition_count,
	ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100/ COUNT(*),2) attrition_rate
FROM employee_attrition_data
GROUP BY job_role


-- HIGHEST RISKS OF EMPLOYEES


WITH employee_risk AS
(
	SELECT
		marital_status,
		Department,	
		Job_Role,
		Monthly_Income,
		age,
		risK_score,
		ROW_NUMBER() OVER(PARTITION BY Department ORDER BY risK_score DESC ) risk_rank
	FROM
	(
		SELECT
			employee_id,
			age,
			marital_status,
			Department,	
			Job_Role,
			Job_Level,	
			Monthly_Income,
			Years_Since_Last_Promotion,
			Job_Satisfaction,
			Performance_Rating,
			Overtime,	
			Absenteeism,
			Work_Environment_Satisfaction,	
			Job_Involvement,
			CASE
				WHEN Years_Since_Last_Promotion > 3 THEN 1
				ELSE 0
			END +
			CASE 
				WHEN Job_Satisfaction <= 2 THEN 1
				ELSE 0
			END +
			CASE 
				WHEN Performance_Rating <= 2 THEN 1
				ELSE 0
			END +
			CASE
				WHEN Overtime = 'Yes' THEN 1
				ELSE 0
			END +
			CASE 
				WHEN Absenteeism > 15 THEN 1
				ELSE 0
			END +
			CASE 
				WHEN Work_Environment_Satisfaction <= 2 THEN 1
				ELSE 0
			END +
			CASE
				WHEN Job_Involvement <= 2 THEN 1
				ELSE 0
			END risK_score
		FROM employee_attrition_data
		WHERE attrition = 'No'
	)
)
SELECT
	Department,	
	marital_status,
	Job_Role,
	Monthly_Income,
	age,
	risK_score,
	risk_rank
FROM employee_risk
WHERE risk_rank <= 3


