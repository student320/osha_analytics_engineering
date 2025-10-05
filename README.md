# OSHA Workplace Safety Analytics Project
## Project Overview
This project is an Analytics Engineering portfolio project focused on workplace safety data reported to OSHA (Occupational Safety and Health Administration). The goal is to demonstrate end-to-end data modeling, testing, and transformation using dbt, followed by business intelligence reporting in Power BI.

The dataset contains OSHA establishment-level filings across multiple years, including company information, establishment details, industry classifications, location, and reported workplace incidents.

I have completed the data modeling and dbt transformation layer, producing a clean star schema with fact and dimension tables that can support downstream analytics.

Here is an example of my data modelling lineage in dbt:
<img width="1302" height="677" alt="image" src="https://github.com/user-attachments/assets/06ef940a-ca7d-411a-babb-7de309ed3b20" />



Next steps include adding aggregations, ad-hoc analysis, Power BI dashboards, and a requirements/business document to make the project fully production-style.

## Tools & Technologies

dbt (Data Build Tool) – for transformations, testing, and documentation

BigQuery – data warehouse

Power BI (planned) – for interactive dashboarding and insights

GitHub – for version control and project portfolio showcase

## Completed Work (dbt Layer)

### Data Staging: Standardized and cleaned OSHA raw data from multiple years (2016–2022).
### Intermediate Models: Unioned datasets and added derived fields (e.g., FTE-standardized incident rates, high-risk establishment flags).
### Star Schema Design:
- Fact Table: fact_injuries containing standardized metrics and keys.
- Dimension Tables: dim_company, dim_establishment, dim_location, dim_industry, and dim_time.
- Surrogate Keys: Added across most dimensions for consistency and to support Slowly Changing Dimensions (SCD) if applied later.
### Macros: Implemented reusable macros to convert categorical codes (e.g., establishment type, injury record flags) into descriptive labels.
###Data Quality Tests: Included uniqueness, not-null, referential integrity, and custom logic tests.

This provides a single source of truth for OSHA workplace safety data that can be used for analytics, dashboards, and decision-making.

## Work In Progress

The following tasks are planned to complete the project:

Aggregations & Ad-hoc Queries: Build derived metrics such as total cases by year, top industries by incident rates, and state-level comparisons.

## Power BI Dashboards:
Industry risk trends
Establishment-level performance tracking
Fatality and high-risk establishment heatmaps

## Requirements Documentation: 
A business-facing document outlining data sources, business questions, and how the star schema answers them.

## Business Impact
This project simulates how an Analytics Engineer adds value in a real organization:
Ensures clean, reliable, tested data through dbt.
Builds a scalable star schema that business intelligence teams can consume directly.
Provides insights into workplace safety risks that can guide compliance, resource allocation, and employee protection strategies.

## Project Links

dbt Project Files – [(this repo)](https://github.com/student320/osha_analytics_engineering/tree/main/osha_analytics)

Power BI Dashboard – coming soon

Requirements/Business Doc – coming soon
