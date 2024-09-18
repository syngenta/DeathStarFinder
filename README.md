# Deathstarfinder Project

## Overview
This project is designed to analyze code complexity and churn, and generate visual plots based on the analysis. It uses SonarCloud for code quality checks and Python for data processing and visualization.

## Prerequisites
- Python 3.x
- pip (Python package installer)
- SonarCloud account and project

## Installation
1. Clone the repository:
    ```sh
    git clone <repository_url>
    cd <repository_folder>
    ```

2. Create and activate a virtual environment:
    ```sh
    python3 -m venv .venv
    source .venv/bin/activate
    ```

3. Install the required Python packages:
    ```sh
    pip install -r requirements.txt
    ```

## Usage
1. Run the `run.sh` script with the required arguments:
    ```sh
    ./run.sh <local_repo_folder> <sonarcloud_project_name> <sonarcloud_jwt_token>
    ```

    - `<local_repo_folder>`: The local folder of the repository to verify.
    - `<sonarcloud_project_name>`: The name of the project on SonarCloud.
    - `<sonarcloud_jwt_token>`: The JWT session token from SonarCloud.

2. The script will:
    - Run `complexity.sh` and `churn.sh` scripts.
    - Check if `complexity.json` and `churn.csv` are generated.
    - Create and activate a virtual environment if it does not exist.
    - Install the required Python packages.
    - Run the `plot.py` script to generate and save the plot.

## License
This project is licensed under the MIT License. See the `LICENSE` file for more details.