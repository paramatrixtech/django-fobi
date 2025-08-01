#!/bin/sh

# Enable debugging
set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error when substituting
set -o pipefail  # Prevent errors in a pipeline from being masked

# Activate the virtual environment
source /venv/bin/activate

# Create dirs if necessary
echo "Creating directories..."
if [ -f ./scripts/create_dirs.sh ]; then
    echo "Found create_dirs.sh script."
    /backend/scripts/create_dirs.sh
    if [ $? -eq 0 ]; then
        echo "Directories created successfully."
    else
        echo "Failed to create directories." >&2
        exit 1
    fi
else
    echo "create_dirs.sh script not found!" >&2
    exit 1
fi

# Apply database migrations
echo "Apply database migrations"
if [ -f ./examples/simple/manage.py ]; then
    # Apply migrations
    python /backend/examples/simple/manage.py migrate --noinput --settings=settings.docker
    if [ $? -eq 0 ]; then
        echo "Database migrations applied successfully."
    else
        echo "Failed to apply database migrations." >&2
        exit 1
    fi
else
    echo "manage.py script not found!" >&2
    exit 1
fi

# Start server
echo "Starting server..."
if [ -f ./examples/simple/manage.py ]; then
    exec python /backend/examples/simple/manage.py runserver 0.0.0.0:8000 --settings=settings.docker --traceback -v 3
else
    echo "manage.py script not found!" >&2
    exit 1
fi
