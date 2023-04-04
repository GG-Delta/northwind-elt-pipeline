with stg_products as (
    select *
    from {{ref('stg_products')}}
)

, stg_categories as (
    select * 
    from {{ ref('stg_categories')}}
)

, transformed as (
    select 
        {{ dbt_utils.generate_surrogate_key(['stg_products.product_id']) }} as product_key -- surrogate key
        , stg_products.product_id -- natural key of original table  
        , stg_products.category_id as product_category_id
        , stg_products.product_name
        , stg_products.quantity_per_unit as product_quantity_per_unit
        , stg_products.discontinued as product_discontinued
        , stg_products.reorder_level as product_reorder_level
        , stg_products.supplier_id as product_supplier_id
        , stg_products.units_in_stock as product_units_in_stock
        , stg_products.units_on_order as product_units_on_order
        , stg_products.unit_price as product_unit_price
        , stg_categories.category_id as product_category_category_id
        , stg_categories.category_name as product_category_name
        , stg_categories.description as product_category_description
        , stg_categories.picture as product_category_picture
    from stg_products 
    left join stg_categories 
    on stg_products.category_id = stg_categories.category_id
  )

select *
from transformed