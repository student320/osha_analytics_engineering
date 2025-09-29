with staging as (
    select * from {{ ref("stg_osha_raw__osha_2016") }}
    union all
    select * from {{ ref("stg_osha_raw__osha_2017") }}
    union all
    select * from {{ ref("stg_osha_raw__osha_2018") }}
    union all
    select * from {{ ref("stg_osha_raw__osha_2019") }}
    union all 
    select * from {{ ref("stg_osha_raw__osha_2020") }}
    union all
    select * from {{ ref("stg_osha_raw__osha_2021") }}
    union all
    select * from {{ ref("stg_osha_raw__osha_2022") }}
),

table_union as (
    select
        id,
        company_name,
        establishment_name,
        ein,
        street_address,
        city,
        state,
        zip_code,
        naics_code,
        industry_description,
        annual_average_employees,
        total_hours_worked,
        {{ get_record_of_injuries_illnesses_description('record_of_injuries_illnesses') }} as record_of_injuries_illnesses,
        total_deaths,
        total_days_away_from_work_cases as cases_away_from_work,
        total_job_transfer_or_restriction_cases as cases_job_transfer_or_restriction,
        total_other_cases as cases_other,
        total_days_away_from_work_days as away_from_work_days,
        total_job_transfer_or_restriction_days as job_transfer_or_restriction_days,
        total_injuries,
        total_poisonings,
        total_respiratory_conditions,
        total_skin_disorders,
        total_hearing_loss,
        total_other_illnesses,
        establishment_id,
        {{ get_establishment_type_description('establishment_type') }} as establishment_type,
        {{ get_size_description('size') }} as size,
        year_filing_for,

        -- calculated columns, OSHA FTE-standardized rates (per 100 full-time equivalents), 100*40*50 = 200,000 hours   
        round(((total_injuries + total_poisonings + total_other_illnesses) * 200000.0 / nullif(total_hours_worked,0)),2) as incident_rate_fte,
        round((total_days_away_from_work_cases * 200000.0 / nullif(total_hours_worked,0)),2) as days_away_cases_rate_fte,
        round((total_job_transfer_or_restriction_cases * 200000.0 / nullif(total_hours_worked,0)),2) as job_transfer_or_restriction_rate_fte,
        round((total_deaths * 200000.0 / nullif(total_hours_worked,0)),2) as fatality_rate_fte,
        
        -- flag for high risk establishments
        case when total_deaths > 1 then 'yes' else 'no' end as high_risk_establishment
    from staging
)

select * from table_union
