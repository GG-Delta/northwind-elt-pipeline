with source_data as (
    select
        employee_id
        , address
        , birth_date
        , city
        , country
        , extension
        , first_name
        , hire_date
        , home_phone
        , last_name
        , notes
        , photo
        , photo_path
        , postal_code
        , region
        , reports_to
        , title
        , title_of_courtesy
    from {{ source('airbyte_schema', 'employees') }}
)
select *
from source_data