{{ config(materialized='table') }}

with __dbt__CTE__paychecks_ab1_558 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    jsonb_extract_path_text(_airbyte_data, 'paycheck_id') as paycheck_id,
    users.user_id as user_id,
    jsonb_extract_path_text(_airbyte_data, 'email') as email,
    jsonb_extract_path_text(_airbyte_data, 'amount') as amount,
    jsonb_extract_path_text(_airbyte_data, 'created_at') as created_at
from "target_db"."public"._airbyte_raw_paychecks as _airbyte_raw_paychecks
inner join "target_db"."public".users as users on 
    users.email = jsonb_extract_path_text(_airbyte_raw_paychecks._airbyte_data, 'email')
-- timesheets
),  __dbt__CTE__paychecks_ab2_558 as (
    select 
        cast("paycheck_id" as 
        varchar
    ) as "paycheck_id",
        cast("user_id" as 
        uuid
    ) as "user_id",
        cast("email" as 
        varchar
    ) as "email",
        cast("amount" as 
        numeric
    ) as "amount",
        cast("created_at" as 
        timestamp
    ) as "created_at"
    from __dbt__CTE__paychecks_ab1_558
    -- paychecks
)

select
    *
from __dbt__CTE__paychecks_ab2_558
-- timesheets

