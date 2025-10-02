with source as (
    select * from {{ source('osha_raw', 'osha_2022') }}
),

renamed as (
    select
        safe_cast(safe_cast(id as float64) as int64) as id, -- all int cols for 20201 were entered with decimals, cast to float then int
        lower(trim(company_name)) as company_name,
        lower(trim(establishment_name)) as establishment_name,
        safe_cast(safe_cast(establishment_id as float64) as int64) as establishment_id,
        safe_cast(safe_cast(establishment_type as float64) as int64) as establishment_type,
        safe_cast(safe_cast(size as float64) as int64) as size,
        nullif(trim(ein), 'null') as ein,
        lower(trim(street_address)) as street_address,
        lower(trim(city)) as city,
        upper(trim(state)) as state,
        lower(trim(zip_code)) as zip_code,
        safe_cast(safe_cast(naics_code as float64) as int64) as naics_code,
        lower(trim(industry_description)) as industry_description,
        safe_cast(safe_cast(annual_average_employees as float64) as int64) as annual_average_employees,
        safe_cast(safe_cast(total_hours_worked as float64) as int64) as total_hours_worked,
        safe_cast(safe_cast(no_injuries_illnesses as float64) as int64) as record_of_injuries_illnesses,
        safe_cast(safe_cast(total_deaths as float64) as int64) as total_deaths,
        safe_cast(safe_cast(total_dafw_cases as float64) as int64) as total_days_away_from_work_cases,
        safe_cast(safe_cast(total_djtr_cases as float64) as int64) as total_job_transfer_or_restriction_cases,
        safe_cast(safe_cast(total_other_cases as float64) as int64) as total_other_cases,
        safe_cast(safe_cast(total_dafw_days as float64) as int64) as total_days_away_from_work_days,
        safe_cast(safe_cast(total_djtr_days as float64) as int64) as total_job_transfer_or_restriction_days,
        safe_cast(safe_cast(total_injuries as float64) as int64) as total_injuries,
        safe_cast(safe_cast(total_poisonings as float64) as int64) as total_poisonings,
        safe_cast(safe_cast(total_respiratory_conditions as float64) as int64) as total_respiratory_conditions,
        safe_cast(safe_cast(total_skin_disorders as float64) as int64) as total_skin_disorders,
        safe_cast(safe_cast(total_hearing_loss as float64) as int64) as total_hearing_loss,
        safe_cast(safe_cast(total_other_illnesses as float64) as int64) as total_other_illnesses,
        safe_cast(safe_cast(year_filing_for as float64) as int64) as year_filing_for,
        parse_timestamp('%m/%d/%Y',created_timestamp) as created_timestamp,
        change_reason
    from source
)

select * from renamed
