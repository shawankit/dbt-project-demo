{{  config(
        materialized='incremental',
        unique_key='timesheet_id',
        incremental_strategy='delete+insert',
    )
}}

with __dbt__CTE__timesheets_ab1_558 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    timesheets_stg.timesheet_id as timesheet_id,
    users.user_id as user_id,
    timesheets_stg.email as email,
    timesheets_stg.hours_worked as hours_worked,
    timesheets_stg.date_worked as date_worked,
    timesheets_stg.created_at as created_at,
    timesheets_stg._airbyte_emitted_at as _airbyte_emitted_at
from "target_db"."_airbyte_public".timesheets_stg as timesheets_stg
inner join "target_db"."public".users as users on 
    users.email = timesheets_stg.email
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
