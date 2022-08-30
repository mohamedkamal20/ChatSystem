#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /ChatSystem/tmp/pids/server.pid

#mysql --user=root --password=root --host=127.0.0.0 --port=3306 -e "CREATE DATABASE IF NOT EXISTS ChatSystem_development; CREATE DATABASE IF NOT EXISTS ChatSystem_test;" && exit

exec "$@"