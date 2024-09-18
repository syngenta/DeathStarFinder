#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <project folder>"
  exit 1
fi

PROJECT_FOLDER=$1
REPO_URL="git@github.com:syngenta/truegitcodechurn.git"
REPO_DIR="truegitcodechurn"
VENV_DIR="./venv"

# Check if the repository is present, if not, clone it
if [ ! -d "$REPO_DIR" ]; then
  git clone $REPO_URL
fi

# Check if the virtual environment is present, if not, create it
if [ ! -d "$VENV_DIR" ]; then
  python3 -m venv $VENV_DIR
fi

# Activate the virtual environment
source $VENV_DIR/bin/activate

# Set the PYTHONPATH to include the repository directory
export PYTHONPATH=$(pwd)/$REPO_DIR

# Install the requirements
pip install -r $REPO_DIR/requirements.txt

# Run the code
python $REPO_DIR/gitcodechurn/entry.py $PROJECT_FOLDER --aggregate-file-data --csv > churn.csv

echo "Code churn data saved to churn.csv"
# Deactivate the virtual environment
deactivate
