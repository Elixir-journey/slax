#!/bin/sh
set -e

echo "=== Running database migrations ==="
mix ecto.migrate

echo "=== Compiling application ==="
mix compile --force  # Ensure the Mix task is available

echo "=== Running database seed ==="
mix run priv/repo/seeds.exs

exec "$@"
