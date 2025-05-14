#!/bin/bash
set -e


until pg_isready -U postgres > /dev/null 2>&1; do
  echo "Waiting for Primary PostgreSQL to start ..."
  sleep 1
done


psql -v ON_ERROR_STOP=1 --port=5432 --username postgres --dbname postgres <<-EOSQL
    CREATE ROLE replicauser WITH REPLICATION LOGIN PASSWORD '$PG_REPLICA_PASS';
    CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
    GRANT pg_monitor TO replicauser;

EOSQL

echo "Replication user created."
