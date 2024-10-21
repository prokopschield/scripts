#!/bin/bash

# Exit script if any command fails
set -e

# Install docker
curl https://raw.githubusercontent.com/prokopschield/scripts/main/docker.sh | bash

# Create the /loki directory
mkdir -p /loki

# Change directory to /loki
cd /loki

# Download the docker-compose.yaml file from Loki repository
wget https://raw.githubusercontent.com/grafana/loki/v3.0.0/production/docker-compose.yaml -O docker-compose.yaml

# Start the Docker containers using docker compose
docker compose up -d
