PGPASSWORD=postgres psql -h localhost -U postgres < db/create.sql
PGPASSWORD=postgres psql -h localhost -U postgres < db/rates.sql
PGPASSWORD=postgres psql -h localhost -U postgres -c "SELECT 'alive'"
