#!/bin/bash
set -e  # Exit immediately if any command exits with a non-zero status.

echo "=== Cleaning local artifacts ==="
rm -rf deps _build

echo "=== Verify application builds locally ==="
mix build_app

echo "=== Removing Docker volumes ==="
docker-compose down -v

echo "=== Rebuilding Docker images (no cache) ==="
docker-compose build --no-cache

echo "=== Starting Docker containers (detached)==="
docker-compose up -d
