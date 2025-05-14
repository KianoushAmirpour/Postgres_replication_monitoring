#!/bin/bash
set -e

# export PGPASSWORD="$PG_MASTER_PASS"
until pg_isready -h master_postgres -p 5432 -U postgres > /dev/null 2>&1; do
  echo "Waiting for primary to connect..."
  sleep 1
done

echo "master_postgres is now reachable."

 
# Remove any existing data
rm -rf /var/lib/postgresql/data/*

export PGPASSWORD="$PG_REPLICA_PASS"
pg_basebackup -h master_postgres --port=5432 -U replicauser -D /var/lib/postgresql/data -R -C --checkpoint=fast --slot=slot  --wal-method=stream -P



