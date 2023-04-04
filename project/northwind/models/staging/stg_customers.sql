with source_data as (
    select
        customer_id
        , address
        , city
        , company_name
        , contact_name
        , contact_title
        , country
        , fax
        , phone
        , postal_code
        , region
    from {{ source('airbyte_schema', 'customers') }}
)
select *
from source_data