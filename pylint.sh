#!/bin/bash

# Enforce strict error handling
set -euxo pipefail  

# Run Pylint inside the Docker container
echo "🔍 Running Pylint checks inside Docker container..."

# Check if the container is already running
CONTAINER_NAME="django-todo"
if docker ps | grep -q $CONTAINER_NAME; then
    echo "✅ Container '$CONTAINER_NAME' is running."
else
    echo "❗ Container '$CONTAINER_NAME' is NOT running. Please ensure your container is up before running Pylint."
    exit 1
fi

# Execute Pylint inside the running container
docker exec $CONTAINER_NAME pylint $(find . -type f -name "*.py") | tee pylint.log

echo "✅ Pylint checks completed!"
