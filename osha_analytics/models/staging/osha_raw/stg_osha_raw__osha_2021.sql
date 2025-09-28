with source as (
    select * from {{ source('osha_raw', 'osha_2021') }}
),

renamed as (
    select
        safe_cast(id as int64) as id,
        lower(trim(company_name)) as company_name,
        lower(trim(establishment_name)) as establishment_name,
        safe_cast(establishment_id as int64) as establishment_id,
        safe_cast(establishment_type as int64) as establishment_type,
        safe_cast(size as int64) as size,
        nullif(trim(ein), 'null') as ein,
        lower(trim(street_address)) as street_address,
        lower(trim(city)) as city,
        upper(trim(state)) as state,
        lower(trim(zip_code)) as zip_code,
        safe_cast(naics_code as int64) as naics_code,
        lower(trim(industry_description)) as industry_description,
        safe_cast(annual_average_employees as int64) as annual_average_employees,
        safe_cast(total_hours_worked as int64) as total_hours_worked,
        safe_cast(no_injuries_illnesses as int64) as record_of_injuries_illnesses,
        safe_cast(total_deaths as int64) as total_deaths,
        safe_cast(total_dafw_cases as int64) as total_days_away_from_work_cases,
        safe_cast(total_djtr_cases as int64) as total_job_transfer_or_restriction_cases,
        safe_cast(total_other_cases as int64) as total_other_cases,
        safe_cast(total_dafw_days as int64) as total_days_away_from_work_days,
        safe_cast(total_djtr_days as int64) as total_job_transfer_or_restriction_days,
        safe_cast(total_injuries as int64) as total_injuries,
        safe_cast(total_poisonings as int64) as total_poisonings,
        safe_cast(total_respiratory_conditions as int64) as total_respiratory_conditions,
        safe_cast(total_skin_disorders as int64) as total_skin_disorders,
        safe_cast(total_hearing_loss as int64) as total_hearing_loss,
        safe_cast(total_other_illnesses as int64) as total_other_illnesses,
        safe_cast(year_filing_for as int64) as year_filing_for,
        case
            when safe.parse_timestamp('%m/%d%Y %H:%M:%S', created_timestamp) is not null
                then safe.parse_timestamp('%m/%d/%Y %H/%M/%S', created_timestamp)
            when safe.parse_date('%m/%d%Y', created_timestamp) is not null
                then timestamp(safe.parse_date('%m/%d/%Y', created_timestamp), created_timestamp)
        end as created_timestamp,
        change_reason
    from source
),

 -- deduplicate and keep latest created_timestamp
dedup as (
    select *
    from (
        select *,
               row_number() over (partition by establishment_id, year_filing_for order by created_timestamp desc) as rn
        from renamed
    )
    where rn = 1
)

select * from dedup
