# IBM HR Attrition Analysis

## Project Objective

The objective of this project was to analyse employee attrition using
PostgreSQL and Power BI to identify the factors most associated with
employees leaving the company. I cleaned and prepared the data in
PostgreSQL, built an interactive Power BI dashboard, and used the
findings to make practical recommendations that could help improve
employee retention.

------------------------------------------------------------------------

## Dataset

-   **Source:** IBM HR Analytics Employee Attrition & Performance
    (Kaggle)
-   Fictional dataset created by IBM for educational purposes
-   **1,470 employee records**
-   **35 columns (15 used for the analysis)**

------------------------------------------------------------------------

## Tools Used

-   PostgreSQL
-   DBeaver
-   Power BI
-   DAX

------------------------------------------------------------------------

# Dashboard Preview

### Interactive Dashboard

![Overview GIF](Screenshots/Overview%20GIF.gif)

### Departing Page

![Departing Page](Screenshots/Departing%20Page.png)

### Reasons Page

![Reasons Page](Screenshots/Reasons%20Page.png)

------------------------------------------------------------------------

# Project Workflow

### 1. Created the database table and imported the data

I created the raw table and assigned data types upfront instead of importing everything as text. INT was used for numeric columns since there were no decimals in this dataset, and VARCHAR for text columns. This made the import straightforward and meant I did not have to cast or convert columns later.

### 2. Data Inspection

Before building anything I ran quality checks on the raw data.

I used COUNT() and HAVING COUNT(*) > 1 to check for duplicate employee numbers. I also checked key columns for null values and verified that three columns, EmployeeCount, Over18 and StandardHours, had the same value across every single row, which meant they added nothing to the analysis and were excluded.

I found:


No duplicate employee numbers
No null values in any key columns
EmployeeCount, Over18 and StandardHours were all constant and excluded

### 3. Data Preparation

Once the inspection was done I created a new table called hr_data by selecting only the 15 columns I needed from the raw table. I did not need to reassign data types because I had already done that at the import stage.

### 4. SQL Analysis

From hr_data I built 11 summary views covering attrition by gender, department, job role, overtime, education level, tenure period, distance from home, job satisfaction, environment satisfaction and work life balance.

I also built a row level base view called hr_data_view with flag columns for attrition and overtime pre-calculated in SQL. This view was specifically designed to be imported into Power BI for DAX-driven interactivity.

The reason I kept the summary views and the base view separate was intentional. The summary views are pre-aggregated so they load fast and feed static charts directly. The base view feeds all DAX measures and responds to slicers in real time.

One thing I picked up during this step was that GROUP BY 1 was needed instead of referencing the column alias directly. PostgreSQL processes GROUP BY before it resolves aliases so using the position number was the clean fix.

### 5. Power BI Dashboard

I imported the base view into Power BI. From the base view I built DAX measures for the KPI cards and conditional measures to compare things like overtime vs non-overtime attrition rates. I also created calculated columns to decode the numeric education, satisfaction and tenure fields into readable labels using SWITCH.

I used DIVIDE instead of a regular division / throughout to handle division by zero safely, which is the same concept as NULLIF in SQL.

The dashboard has four pages: Overview, Departing, Reasons, and a Summary and Recommendations page. A department slicer on the Departing and Reasons pages filters every visual on those pages at once.

### 6. Findings and Recommendations

I summarised the main findings, linked them to business recommendations
and created an employee lifecycle process map showing where attrition
risks occur.

------------------------------------------------------------------------

# Key Findings

-   Overall attrition rate was **16.12%** (237 out of 1,470 employees).
-   Employees working overtime had an attrition rate of **30.53%**,
    compared to **10.44%** for employees who did not work overtime.
-   Sales Representatives recorded the highest job role attrition at
    **39.76%**, while the Sales department recorded the highest
    departmental attrition at **20.63%**.
-   Lower job satisfaction, environment satisfaction and work-life
    balance scores were consistently linked to higher attrition.
-   Employees who left generally earned less than those who stayed
    within the same education level.

------------------------------------------------------------------------

# Recommendations

-   Reduce excessive overtime by improving workload planning and
    staffing levels.
-   Strengthen retention in the Sales department through better career
    development, flexible working and performance-based incentives.
-   Improve onboarding with mentorship, structured training and regular
    check-ins during employees' first two years.
-   Conduct regular employee check-ins and monitor satisfaction to
    identify issues before employees decide to leave.
-   Introduce structured exit interviews to better understand why
    employees leave.

![Recommendations](Screenshots/Recommendations.png)

------------------------------------------------------------------------

# Project Files

-   `HR_RAW_TO_CLEAN.sql` -- data import, cleaning and preparation
-   `hrdata_to_attrition_views.sql` -- SQL analysis views and Power BI
    base view
-   HR_Analytics_Dashboard.pbix -- Power BI dashboard
-   `process_map.png` -- Employee lifecycle process map

------------------------------------------------------------------------

# Limitations

-   This project uses the IBM HR Analytics fictional dataset created for
    learning purposes.
-   The dataset is a single snapshot and cannot show trends over time.
-   Attrition is recorded only as Yes or No and does not distinguish
    between voluntary and involuntary exits.
-   The analysis identifies relationships in the data but cannot prove
    cause and effect.
