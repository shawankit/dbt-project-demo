{{  config(
        materialized='incremental',
        unique_key=['paycheck_id', 'email'],
        incremental_strategy='delete+insert',
    )
}}

with __dbt__CTE__paychecks_ab1_558 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    paychecks_stg.paycheck_id as paycheck_id,
    users.user_id as user_id,
    paychecks_stg.email as email,
    paychecks_stg.amount as amount,
    paychecks_stg.created_at as created_at,
    paychecks_stg._airbyte_emitted_at as _airbyte_emitted_at
from "target_db"."_airbyte_public".paychecks_stg as paychecks_stg
inner join "target_db"."public".users as users on 
    users.email = paychecks_stg.email
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

