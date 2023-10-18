{{ config(materialized='table', schema='int') }}

with total_revenue as (
    select 
        sum(total_amount)
    from {{ ref('stg_green_taxi') }}
    group by 1 
),
avg_tips_with_type as (
    select 
        payment_type.payment_type,
        avg_tip_amount
    from avg_tips
    join payment_type on payment_type.payment_type_id = avg_tips.payment_type
)

select 
    payment_type,
    avg_tip_amount
from avg_tips_with_type