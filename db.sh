PGPASSWORD=postgres psql -h localhost -U postgres < db/create.sql
PGPASSWORD=postgres psql -h localhost -U postgres < db/rates.sql
PGPASSWORD=postgres psql -h localhost -U postgres -c "SELECT 'alive'"
curl "http://127.0.0.1:3000/rates?date_from=2021-01-01&date_to=2021-01-31&orig_code=CNGGZ&dest_code=EETLL"
