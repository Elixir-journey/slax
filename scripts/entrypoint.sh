#!/bin/sh
set -e

echo "=== Running database migrations ==="
mix ecto.migrate

exec "$@"
