{{
    config(
        materialized='table'
    )
}}

with source as (
    select * from {{ ref('int_osha_all_years_unioned') }}
)

select distinct
    {{ dbt_utils.generate_surrogate_key(['year_filing_for']) }} as time_key,
    year_filing_for
from source
