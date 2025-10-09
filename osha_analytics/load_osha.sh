#!/bin/bash
PROJECT="osha-analytics-project"
DATASET="osha_data_all"

# Path to a schema file that forces all columns to STRING
SCHEMA_FILE="schema_all_string.json"

for YEAR in {2016..2022}
do
  echo "Loading OSHA data for year $YEAR..."
  bq load \
    --source_format=CSV \
    --skip_leading_rows=1 \
    --allow_quoted_newlines \
    --schema=${SCHEMA_FILE} \
    ${PROJECT}:${DATASET}.osha_${YEAR} \
    gs://osha-raw/${YEAR}/*.csv
  echo "Finished loading $YEAR"
done

echo "All tables loaded successfully!"
