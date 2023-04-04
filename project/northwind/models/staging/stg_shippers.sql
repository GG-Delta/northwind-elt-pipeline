with source_data as (
    select
        shipper_id
        , company_name
        , phone
    from {{ source('airbyte_schema', 'shippers') }}
)
select *
from source_data