with source_data as (
    select
        product_id
        , category_id
        , product_name
        , quantity_per_unit
        , discontinued
        , reorder_level
        , supplier_id
        , units_in_stock
        , units_on_order
        , unit_price
    from {{ source('airbyte_schema', 'products') }}
)
select *
from source_data