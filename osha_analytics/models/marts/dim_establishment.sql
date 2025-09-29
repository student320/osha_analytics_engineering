{{
    config(
        materialized='table'
    )
}}

with source as (
    select * from {{ ref('int_osha_all_years_unioned') }}
)

select distinct
    {{ dbt_utils.generate_surrogate_key(['establishment_id']) }} as establishment_key,
    establishment_id,
    establishment_name,
    company_name,
    ein,
    size,
    establishment_type
from source
