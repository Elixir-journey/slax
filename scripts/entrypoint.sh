#!/bin/sh
set -e

echo "=== Running database migrations ==="
mix ecto.migrate

echo "=== Running database seed ==="
mix db.seed

exec "$@"
