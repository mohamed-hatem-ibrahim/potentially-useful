#!/bin/bash

# Container settings
CONTAINER_NAME="postgres-container"
HOST_DATA_DIR="$PWD/data"

# PostgreSQL credentials
POSTGRES_USER="devuser"
POSTGRES_PASSWORD="devpass"
POSTGRES_DB="devdb"

# Pull the image
docker pull postgres:13.22-trixie

# Create host data directory if it doesn't exist
mkdir -p "$HOST_DATA_DIR"

# Check if container exists
if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "Container $CONTAINER_NAME already exists. Stopping and removing it..."
    docker stop "$CONTAINER_NAME"
    docker rm "$CONTAINER_NAME"
fi

# Run PostgreSQL container
docker run -d \
  --name "$CONTAINER_NAME" \
  -v "$HOST_DATA_DIR":/var/lib/postgresql/data \
  -e POSTGRES_USER="$POSTGRES_USER" \
  -e POSTGRES_PASSWORD="$POSTGRES_PASSWORD" \
  -e POSTGRES_DB="$POSTGRES_DB" \
  -p 5432:5432 \
  postgres:13.22-trixie

echo "PostgreSQL container '$CONTAINER_NAME' is running."
echo "Connect using: psql -h localhost -U $POSTGRES_USER -d $POSTGRES_DB"
