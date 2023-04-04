with stg_order as (
    select *
    from {{ ref('stg_orders') }}
)

, stg_order_detail as (
    select * 
    from {{ ref('stg_order_details')}}
)

, transformed as (
    select 
        stg_order.order_id as order_id
        , stg_order.customer_id
        , stg_order.employee_id
        , stg_order.required_date
        , stg_order.shipped_date
        , stg_order.ship_address
        , stg_order.ship_city
        , stg_order.ship_country
        , stg_order.ship_name
        , stg_order.ship_postal_code
        , stg_order.ship_region
        , stg_order.ship_via
        , stg_order_detail.product_id
        , stg_order_detail.quantity
        , stg_order_detail.unit_price
        , stg_order_detail.discount
    from stg_order 
    left join stg_order_detail 
    on stg_order.order_id = stg_order_detail.order_id
  )

select 
    {{  dbt_utils.generate_surrogate_key(['product_id']) }} as product_key
    , {{  dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key
    , {{  dbt_utils.generate_surrogate_key(['employee_id']) }} as trader_key
    , order_id
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
    , product_id as order_product_id
    , quantity
    , unit_price
    , discount
    , quantity * unit_price * (1 - discount) as value
from transformed