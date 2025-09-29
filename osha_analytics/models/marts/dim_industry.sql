{{
    config(
        materialized='table'
    )
}}

with source as (
    select * from {{ ref('int_osha_all_years_unioned') }}
)

select distinct
    {{ dbt_utils.generate_surrogate_key(['naics_code']) }} as industry_key,
    naics_code,
    industry_description
from source
