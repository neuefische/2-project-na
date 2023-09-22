SELECT
    sum(total_amount) AS total_turnover
from {{ ref('stg_green_taxi') }}