{{ config(materialized='table') }}


with __dbt__CTE__timesheets as ( 
    SELECT user_id,   
	EXTRACT(YEAR FROM date_worked) AS work_year,
	EXTRACT(QUARTER FROM date_worked) AS work_quarter,
	EXTRACT(MONTH FROM date_worked) AS work_month,
	EXTRACT(WEEK FROM date_worked) AS work_week,
	sum(hours_worked) as hours_worked
FROM
    {{ ref('transformed_timesheets') }}
GROUP BY 
    user_id,rollup(work_year, work_quarter, work_month, work_week)
ORDER BY
   user_id, work_year, work_quarter, work_month, work_week
)


select 
    user_id,
    hours_worked as number_of_hours_worked,
    CASE 
        WHEN work_week is NOT NULL THEN 'weekly' || ' ' || work_week::varchar || ' ' || work_year::varchar
        WHEN work_month is NOT NULL THEN 'monthly' || ' ' || work_month::varchar || ' ' || work_year::varchar
        WHEN work_quarter is NOT NULL THEN 'quarterly' || ' ' || work_quarter::varchar || ' ' || work_year::varchar
        WHEN work_year is NOT NULL THEN 'yearly' || ' ' || work_year::varchar
        ELSE 'total'
    END AS time_dimension
from __dbt__CTE__timesheets
