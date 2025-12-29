# Employee Attrition Analysis - End-to-End Project

## Executive Summary

### Overview Findings

This project provides an in-depth analysis of employee attrition at a technology company.
The goal was to identify the key drivers of turnover and create a dashboard that HR leaders can use to monitor, predict, and reduce attrition.

Attrition is one of the most critical HR metrics because replacing employees is expensive and disruptive.
This analysis explores how demographics, job roles, tenure, and compensation affect attrition.

The interactive Power BI dashboard enables HR to:
  -  Monitor KPIs like attrition rate, employee count, average tenure, and average salary.
  -  Drill down by demographics, job role, and department.
  -  Identify high-risk groups to design targeted retention strategies.

### Data Sources
The primary dataset of this analysis is from [kaggle.com](https://www.kaggle.com/), containing 10,000 employee records.

Get the whole dataset here [Employee_attrition_data](https://www.kaggle.com/datasets/ziya07/employee-attrition-prediction-dataset?select=employee_attrition_dataset_10000.csv)

---
## Tools Used
a. Excel:
  - Power Query for data cleaning and transformation
  - Pivot Tables for initial analysis
  - XLOOKUP for data validation
    
b.  SQL
  - Data Collection and Transformation
  - Trend Analysis
  - Explanatory analysis and Predictive preparation
     
c. Power BI:
  - Power Query Editor for data modeling
  - DAX for calculated measures and columns
  - Custom visuals
  - Bookmarks for interactive storytellings
    
---

## Data Analysis

```sql
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
```

---

## Project Dashboard

<img width="637" height="410" alt="Main Dashboard " src="https://github.com/user-attachments/assets/999e08d7-3018-42bc-a9ee-1deb2d7beeea" />

---

## Key Performance Indicators (KPIs)

The dashboard highlights the following HR-focused KPIs:

-	Total Employee – Total number of employees in the dataset.
-	Total Attrition – Total number of employees who left the company.
-	Overall Attrition Rate (%) – Percentage of employees who left, calculated as (Attrition Count / Employee Count) * 100.
-	Average Age – Mean age of employees.
-	Average Tenure (Years) – Average length of service across employees.
-	Average Monthly Income ($) – Mean salary across employees.

<img width="523" height="47" alt="KPI&#39;S" src="https://github.com/user-attachments/assets/b8e9fe62-66c2-4683-924f-1b7f3b3f1e10" />

These KPIs serve as benchmarks for HR leaders to measure retention and identify the main problem areas.

---

## Key Areas of Analysis

### 1.	Attrition Overview

-	Overall attrition rate across the company.
-	Comparison of attrition vs. retention.
-	Total active employees and leavers.

### 2.	Demographics
-	Younger employees (<35yrs) had nearly 2x the attrition rate compared to older employees.
-	Hinger attrition rates on Male employees who were Divorced and also Married compared Female employees whose attritions' rate were higher when Single.
-	Male employees had a higher attrition rate compared to Female employees though with a minimal difference

<img width="174" height="119" alt="pie age" src="https://github.com/user-attachments/assets/ddaecd07-4627-43ff-b8ac-ee9208984d87" />
<img width="364" height="117" alt="Analysis Graphs" src="https://github.com/user-attachments/assets/4f6de9d6-4191-4500-8663-2f75368ee6b4" />
<img width="176" height="113" alt="bar analysis" src="https://github.com/user-attachments/assets/b78f75e2-1f62-4d9c-9742-d1ba919be3be" />

### 3.	 Job Roles & Departments
-	Finance Representatives experienced the highest attrition rate.
-	Sales also showed above-average turnover.
-	Technical roles (e.g. HR, IT) had lower attrition, suggesting job specialization may increase retention.

### 4.	Tenure & Experience
-	Employees in their first 2-10 years were most likely to leave.
-	Long-tenured employees (>20 years) showed extremely high attrition.
-	This highlights the importance of investing in early career development, mentorship and career transition support.

### 5.	Compensation & Income
-	Employees in lower salary brackets were less likely to leave.
	-	This highlights the possibility of them not getting another job easly hence high retention
-	Middle salary ranges had the highest attrition rates.
-	Very high earners occasionally showed attrition, potentially linked to external opportunities and higher offer bids.

<img width="176" height="113" alt="bar analysis" src="https://github.com/user-attachments/assets/11a48c36-aff4-4a3e-9bd9-4123a4e5e5e0" />

---

## Executive Insights

### 1.	Early Career Risk

-	Employees with less than 10 years of tenure are the most vulnerable to attrition.
-	Highlights the importance of targeted retention strategies during the early stages of employment.

### 2.	Role-Specific Turnover

-	Finance Representatives and Marketing staffs experience the highest turnover rates.
-	These functions require tailored retention initiatives to address unique challenges.

### 3.	Demographic Factors

-	Younger employees and those with middle salaries are more likely to leave.
-	Suggests that good working environment and job satisfaction opportunities may reduce attrition within these groups.

### 4.	Compensation

-	Salary is strongly correlated with retention but based on the experience.
-	Employees in middle income brackets and high-level earners are significantly more likely to leave compared to low income earners. 
-	This is due to the experience and better offers from other companies.

---

## Recommendations

-	Onboarding & Mentorship
  
	Strengthen onboarding programs and provide structured career development support during the first 10 years of employment.

-	Compensation Review
  
	Reevaluate salary bands and incentive structures, particularly for Middle levels and finance employees.

-	Retention Programs by Demographic
  
	Design retention programs around life stages rather than gender, with special attention to employees undergoing life transitions (divorce, new singles, etc.).

-	Work-Life Balance Programs
  
	Expand flexible work options and well-being initiatives, especially targeting younger employees who report higher attrition rates.

---

## Limitations & Caveats

-	The dataset is based on HR Analytics Attrition dataset and may not fully reflect a real company.
-	Some variables (e.g., work-life balance) are self-reported, making them subjective and potentially biased.
-	External factors not included in the dataset (e.g. geographic job market conditions) may also influence attrition.

---

## References
1.	SQL for Data Engineering [Data with Baraa](https://www.youtube.com/watch?v=SSKVgrwhzus)
2.	Data Analytics with [Chandoo](https://www.youtube.com/results?search_query=chandoo)

--- 
