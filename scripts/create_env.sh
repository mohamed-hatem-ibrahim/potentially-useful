#!/bin/bash

# Name of the environment (change if needed)
ENV_NAME="django"

# Check if the environment already exists
if conda info --envs | grep -q "^$ENV_NAME"; then
    echo "Conda environment '$ENV_NAME' already exists."
    echo "Activating it..."
    conda activate "$ENV_NAME"
    exit 0
fi

# Create the environment from environment.yml
if [ -f "environment.yml" ]; then
    echo "Creating Conda environment '$ENV_NAME' from environment.yml..."
    conda env create -f environment.yml
else
    echo "No environment.yml found. Creating empty environment '$ENV_NAME'..."
    conda create -y -n "$ENV_NAME" python=3.12
fi

# Activate the environment
echo "Activating environment '$ENV_NAME'..."
conda activate "$ENV_NAME"

echo "Done! Environment '$ENV_NAME' is ready."
