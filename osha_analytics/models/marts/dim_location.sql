{{
    config(
        materialized='table'
    )
}}

with source as (
    select * from {{ ref('int_osha_all_years_unioned') }}
)

select distinct
    {{ dbt_utils.generate_surrogate_key(['state','city','zip_code']) }} as location_key,
    street_address,
    city,
    state,
    zip_code
from source
