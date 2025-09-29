{{
    config(
        materialized='table'
    )
}}

with source as (
    select * from {{ ref('int_osha_all_years_unioned') }}
)

select distinct
    {{ dbt_utils.generate_surrogate_key(['company_name','ein']) }} as company_key,
    company_name,
    ein
from source
