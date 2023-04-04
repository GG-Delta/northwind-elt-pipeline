with source_data as (
    select
        category_id
        , category_name
        , description
        , picture
    from {{ source('airbyte_schema', 'categories') }}
)
select *
from source_data