{{
    config(
        materialized='table'
    )
}}

with source as (
    select * from {{ ref('int_osha_all_years_unioned') }}
)

select
    -- surrogate key for fact
    {{ dbt_utils.generate_surrogate_key(['establishment_id','year_filing_for']) }} as fact_injuries_id,

    -- foreign keys
    {{ dbt_utils.generate_surrogate_key(['establishment_id']) }} as establishment_key,
    {{ dbt_utils.generate_surrogate_key(['naics_code']) }} as industry_key,
    {{ dbt_utils.generate_surrogate_key(['state','city','zip_code']) }} as location_key,
    {{ dbt_utils.generate_surrogate_key(['year_filing_for']) }} as time_key,

    -- measures
    annual_average_employees,
    total_hours_worked,
    total_deaths,
    cases_away_from_work,
    cases_job_transfer_or_restriction,
    cases_other,
    away_from_work_days,
    job_transfer_or_restriction_days,
    total_injuries,
    total_poisonings,
    total_respiratory_conditions,
    total_skin_disorders,
    total_hearing_loss,
    total_other_illnesses,

    -- calculated metrics
    incident_rate_fte,
    days_away_cases_rate_fte,
    job_transfer_or_restriction_rate_fte,
    fatality_rate_fte,

    -- flags
    high_risk_establishment

from source
