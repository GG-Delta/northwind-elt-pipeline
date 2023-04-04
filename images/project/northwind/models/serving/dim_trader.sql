with stg_employees as (
    select
        employee_id
        , address
        , birth_date
        , city
        , country
        , extension
        , hire_date
        , home_phone
        , notes
        , photo
        , photo_path
        , postal_code
        , region
        , reports_to
        , title
        , title_of_courtesy
        -- Adopted function concat() to concatenate first, middle and lastnames
        , concat(coalesce(first_name,''),'  ',coalesce(last_name,'')) as trader_fullname
    from {{ref('stg_employees')}}
)

, stg_territories as (
    select * 
    from {{ ref('stg_territories')}}
)

, stg_employee_territories as (
    select * 
    from {{ ref('stg_employee_territories2')}}
)

, transformed as (
    select 
        {{ dbt_utils.generate_surrogate_key(['stg_employees.employee_id']) }} as trader_key -- surrogate key
        , stg_employees.employee_id as trader_id-- natural key of original table
        , stg_employees.trader_fullname
        , stg_employees.birth_date as trader_birth_date
        , stg_employees.city as trader_city
        , stg_employees.country as trader_country
        , stg_employees.extension as trader_extension
        , stg_employees.hire_date as trader_hire_date
        , stg_employees.home_phone as trader_home_phone
        , stg_employees.notes as trader_notes
        , stg_employees.photo as trader_photo
        , stg_employees.photo_path as trader_photo_path
        , stg_employees.postal_code as trader_postal_code
        , stg_employees.region as trader_region
        , stg_employees.reports_to as trader_reports
        , stg_employees.title as trader_title
        , stg_employees.title_of_courtesy as trader_title_of_courtesy
        , stg_territories.territory_id as trader_territory_id
        , stg_territories.territory_description as trader_territory_description
        , stg_territories.region_id as trader_region_id
        , stg_employee_territories.territory_id
    from stg_employees
    left join (stg_employee_territories left join stg_territories on stg_employee_territories.territory_id = stg_territories.territory_id)
    on stg_employees.employee_id = stg_employee_territories.employee_id
   )

select *
from transformed