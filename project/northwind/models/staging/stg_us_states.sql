with source_data as (
    select
        state_id
        , state_name
        , state_abbr
        , state_region
    from {{ source('airbyte_schema', 'us_states') }}
)
select *
from source_data