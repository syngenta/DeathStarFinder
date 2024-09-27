#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <project folder>"
  exit 1
fi

PROJECT_FOLDER=$1
REPO_URL="git@github.com:syngenta/truegitcodechurn.git"
REPO_DIR="truegitcodechurn"

# Check if the repository is present, if not, clone it
if [ ! -d "$REPO_DIR" ]; then
  git clone $REPO_URL
fi

# Set the PYTHONPATH to include the repository directory
export PYTHONPATH=$(pwd)/$REPO_DIR

# Run the code
python $REPO_DIR/gitcodechurn/entry.py $PROJECT_FOLDER --since-last-year --aggregate-file-data --csv > tmp/churn.csv

echo "Code churn data saved to churn.csv"
# Deactivate the virtual environment
deactivate
