#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <project name> <JWT-Session token>"
  exit 1
fi

PROJECT_NAME=$1
JWT_SESSION=$2

curl "https://sonarcloud.io/api/measures/component_tree?additionalFields=metrics&ps=500&asc=false&metricSort=complexity&s=metric&metricSortFilter=withMeasuresOnly&component=${PROJECT_NAME}&metricKeys=complexity&strategy=leaves" \
--compressed \
-H "Accept: application/json" \
-H "Accept-Encoding: gzip, deflate, br, zstd" \
-H "Cookie:JWT-SESSION=${JWT_SESSION};" \
-o tmp/complexity.json