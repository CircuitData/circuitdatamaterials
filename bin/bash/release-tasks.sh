#!/bin/bash

echo "Running Release Tasks"

if [ "$RUN_MIGRATIONS_DURING_RELEASE" == "true" ]; then 
  echo "Running Migrations"
  bundle exec rails db:migrate
fi

if [ "$RUN_CSV_DURING_RELEASE" == "true" ]; then 
  echo "Refreshing Manufacturers and Materials in DB"
  bundle exec rails csv:load
fi

echo "Done running release-tasks.sh"