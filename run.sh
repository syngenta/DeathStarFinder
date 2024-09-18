#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <local_repo_folder> <sonarcloud_project_name> <sonarcloud_jwt_token>"
    exit 1
fi

# Assign arguments to variables
LOCAL_REPO_FOLDER=$1
SONARCLOUD_PROJECT_NAME=$2
SONARCLOUD_JWT_TOKEN=$3

# Run complexity.sh and churn.sh scripts
.scripts/complexity.sh "$SONARCLOUD_PROJECT_NAME" "$SONARCLOUD_JWT_TOKEN"
.scripts/churn.sh "$LOCAL_REPO_FOLDER"

# Check if complexity.json and churn.csv are generated
if [ ! -f complexity.json ] || [ ! -f churn.csv ]; then
    echo "Error: complexity.json or churn.csv not generated."
    exit 1
fi

VENV_DIR="./venv"
# Check if venv exists, if not create and activate it
if [ ! -d "$VENV_DIR" ]; then
  python3 -m venv $VENV_DIR
fi

source $VENV_DIR/bin/activate

pip install -r requirements.txt

# Run plot.py script
python src/plot.py

# Deactivate the virtual environment
deactivate

echo "Plot generated and saved successfully."