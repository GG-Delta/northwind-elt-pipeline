with source_data as (
    select
        order_id
        , customer_id
        , employee_id
        , required_date
        , shipped_date
        , ship_address
        , ship_city
        , ship_country
        , ship_name
        , ship_postal_code
        , ship_region
        , ship_via
    from {{ source('airbyte_schema', 'orders') }}
)
select *
from source_data