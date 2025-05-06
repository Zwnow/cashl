#!/bin/bash
# entrypoint.sh

# Wait for PostgreSQL to be ready 
until pg_isready -h postgres -p 5432; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

until [ -f "/app/mix.exs" ]; do
  echo "Waiting for mix.exs to be mounted..."
  sleep 1
done

mix local.hex --force
mix deps.get
mix ecto.create
mix ecto.migrate

exec mix phx.server

