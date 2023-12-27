{{  config(
        materialized='incremental',
        unique_key='timesheet_id'
    )
}}

with __dbt__CTE__timesheets_ab1_558 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    jsonb_extract_path_text(_airbyte_data, 'timesheet_id') as timesheet_id,
    users.user_id as user_id,
    jsonb_extract_path_text(_airbyte_data, 'email') as email,
    jsonb_extract_path_text(_airbyte_data, 'hours_worked') as hours_worked,
    jsonb_extract_path_text(_airbyte_data, 'date_worked') as date_worked,
    jsonb_extract_path_text(_airbyte_data, 'created_at') as created_at
from "target_db"."public"._airbyte_raw_timesheets as _airbyte_raw_timesheets 
inner join "target_db"."public".users as users on 
    users.email = jsonb_extract_path_text(_airbyte_raw_timesheets._airbyte_data, 'email')
-- timesheets
),  __dbt__CTE__timesheets_ab2_558 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
select
    cast("timesheet_id" as 
    varchar
) as "timesheet_id",
    cast("user_id" as 
    uuid
) as "user_id",
    cast("email" as 
    varchar
) as "email",
    cast("hours_worked" as 
    numeric
) as "hours_worked",
    cast("date_worked" as 
    date
) as "date_worked",
    cast("created_at" as 
    timestamp
) as "created_at"
from __dbt__CTE__timesheets_ab1_558
-- timesheets
)

select
    *
from __dbt__CTE__timesheets_ab2_558
-- timesheets
