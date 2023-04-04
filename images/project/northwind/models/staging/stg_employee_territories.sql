with source_data as (
    select
        employee_id
        , territory_id
    from {{ source('airbyte_schema', 'employee_territories') }}
)
select *
from source_data