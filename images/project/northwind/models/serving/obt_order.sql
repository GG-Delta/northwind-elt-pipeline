with fct_order as (
    select * from {{ ref('fct_order') }}
)
, dim_product as (
    select * from {{ ref('dim_product') }}
)
, dim_supplier as (
    select * from {{ ref('dim_supplier') }}
)
, dim_trader as (
    select * from {{ ref('dim_trader') }}
)
, obt as (
    select
         {{ dbt_utils.star(from=ref('fct_order'), relation_alias='fct_order', except=[
            "product_key", "customer_key", "employee_key"]) }}
         , {{ dbt_utils.star(from=ref('dim_product'), relation_alias='dim_product', except=["product_key"]) }}
         , {{ dbt_utils.star(from=ref('dim_supplier'), relation_alias='dim_supplier', except=["supplier_key"]) }}
         , {{ dbt_utils.star(from=ref('dim_trader'), relation_alias='dim_trader', except=["trader_key"]) }}
    from fct_order
    left join dim_product on fct_order.product_key = dim_product.product_key 
    left join dim_supplier on fct_order.product_key = dim_supplier.product_key 
    left join dim_trader on fct_order.trader_key = dim_trader.trader_key 
)

select * 
from obt
