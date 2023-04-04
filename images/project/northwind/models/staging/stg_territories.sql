with source_data as (
    select
        territory_id
        , region_id
        , territory_description
    from {{ source('airbyte_schema', 'territories') }}
)
select *
from source_data