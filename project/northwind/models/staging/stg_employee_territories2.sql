{{ dbt_utils.deduplicate(
    relation=source('airbyte_schema', 'employee_territories'),
    partition_by='employee_id',
    order_by='territory_id',
   )
}}