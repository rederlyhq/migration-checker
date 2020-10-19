export PGHOST="$DB_HOST"
export PGPASSWORD="$DB_PASSWORD"
export PGDATABASE="postgres"
export PGUSER="$DB_USER"
psql -f /reset-db.sql

cd /backend

FROM_MIGRATIONS_DB_NAME="from-migration"
FROM_SCRATCH_DB_NAME="from-scratch"

# Migrated DB: Generate db from master, checkout dev, run migrations
export DB_NAME="$FROM_MIGRATIONS_DB_NAME"
export PGDATABASE="$DB_NAME"
psql -f /db.backup
# This doesn't work as I expected it to
# git checkout master
# npm install
# npm run cli # Db is generated
git checkout dev
npm install
npm run sequelize:migrations # Db is migrated

# Scratch DB: Generate db from dev
export DB_NAME="$FROM_SCRATCH_DB_NAME"
npm run cli # Db is generated

# The diff
cd /liquibase;
./liquibase \
  --driver="org.postgresql.Driver" \
  --classpath="postgresql-42.2.16.jar" \
  --url="jdbc:postgresql://$DB_HOST:5432/$FROM_MIGRATIONS_DB_NAME" \
  --username=postgres \
  --password="$DB_PASSWORD" \
  --referenceUrl="jdbc:postgresql://$DB_HOST:5432/$FROM_SCRATCH_DB_NAME" \
  --referenceUsername="$DB_USER" \
  --referencePassword=" " \
  diff;