#!/bin/bash
set -e

# Wait for database
until psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -c '\q'; do
  >&2 echo "Database unavailable - sleeping"
  sleep 1
done

# Migrate if needed
if [ "$RUN_MIGRATIONS" = "true" ]; then
  rails db:migrate
fi

exec "$@"