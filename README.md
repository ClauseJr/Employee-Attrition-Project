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
The primary dataset of this analysis is from [kaggle.com](https://www.kaggle.com/)

Get the whole dataset here [Employee_attrition_data](https://www.kaggle.com/datasets/ziya07/employee-attrition-prediction-dataset?select=employee_attrition_dataset_10000.csv)

### Tools Used
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


## Dashboard Screenshot

<img width="641" height="410" alt="Main Dashboard " src="https://github.com/user-attachments/assets/e2fc506c-47a4-4e10-95b7-576eac7b0e76" />


```
   -- ATTRITION RATE BY DEPARTMENT
  
  SELECT 
    department,
    COUNT(*) employee_count,
    SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) current_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2 ) attrition_rate -- 100% exit
  FROM employee_attrition_data
  GROUP BY department
  ORDER BY attrition_rate DESC;
  -- Finace and IT experienced a higher attrition rate of 20%
  -- There was a low attrition rate of 1%-2%, between the highest and the lowest rates per department
```

