with stg_suppliers as (
    select *
    from {{ref('stg_suppliers')}}
)

, stg_products as (
    select * 
    from {{ ref('stg_products')}}
)


, transformed as (
    select 
        {{ dbt_utils.generate_surrogate_key(['stg_suppliers.supplier_id']) }} as supplier_key -- surrogate key
        , {{ dbt_utils.generate_surrogate_key(['stg_products.product_id']) }} as product_key -- surrogate key
        , stg_suppliers.supplier_id -- natural key of original table  
        , stg_suppliers.region as supplier_region
        , stg_suppliers.postal_code as supplier_postal_code
        , stg_suppliers.address as supplier_address
        , stg_suppliers.city as supplier_city
        , stg_suppliers.company_name as supplier_company_name
        , stg_suppliers.contact_name as supplier_contact_name
        , stg_suppliers.contact_title as supplier_contact_title
        , stg_suppliers.country as supplier_country
        , stg_suppliers.fax as supplier_fax
        , stg_suppliers.homepage as supplier_homepage
        , stg_suppliers.phone as supplier_phone
    from stg_suppliers 
    left join stg_products 
    on stg_suppliers.supplier_id = stg_products.supplier_id
   )

select *
from transformed