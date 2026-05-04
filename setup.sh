#!/bin/bash

# Setup script for task-runner-docker
# This script clones the backend and frontend repositories and sets them up

set -e

echo "🚀 Setting up task-runner environment..."

# Load configuration from config.env if it exists
if [ -f "config.env" ]; then
    echo "📋 Loading configuration from config.env..."
    export $(grep -v '^#' config.env | xargs)
fi

# Default configuration if not set in config.env
BACKEND_REPO_URL="${BACKEND_REPO_UR}"
FRONTEND_REPO_URL="${FRONTEND_REPO_URL}"

# Create directories if they don't exist
mkdir -p task-runner-back
mkdir -p task-runner-front

# Clone backend if directory is empty
if [ ! "$(ls -A task-runner-back)" ]; then
    echo "📦 Cloning backend repository..."
    git clone $BACKEND_REPO_URL task-runner-back
else
    echo "✅ Backend directory already exists and contains files"
fi

# Clone frontend if directory is empty
if [ ! "$(ls -A task-runner-front)" ]; then
    echo "📦 Cloning frontend repository..."
    git clone $FRONTEND_REPO_URL task-runner-front
else
    echo "✅ Frontend directory already exists and contains files"
fi

echo "✅ Setup completed! You can now run 'docker-compose up -d --build'"