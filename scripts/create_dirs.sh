#!/usr/bin/env bash

# Enable debugging
set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error when substituting
echo "Creating directories..."
# Create directories
DIRS=(
    "/backend/examples/logs"
    "/backend/examples/db"
    "/backend/examples/tmp"
    "/backend/var"
)
for dir in "${DIRS[@]}"; do
    echo "Checking directory: '${dir}'"
    if [ ! -d "$dir" ]; then  # Check if the directory does not exist
        echo "Creating directory: '${dir}'"
        mkdir -p "$dir"  # Create the directory
        echo "Directory '${dir}' created successfully."
    else
        echo "Directory '${dir}' already exists, skipping creation."
    fi
done
echo "All directories processed successfully."
