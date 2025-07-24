Test ETL for tables synchronization (Oracle -> Postgres) using SCD2 scheme

1. Set up Oracle DB
1a. Create DATA_IN user
1b. Alter this user giving him tablespace (10+ GB)
1c. Run Oracle_init_ddl.sql
1d. Run Oracle_init_dml.sql
1e. Run Oracle_package.sql
1f. Grant MANAGE SCHEDULER to the DATA_IN user
1f. Run Oracle_job.sql

2. Set up Postgres DB
2a. Run Postgres_init_ddl.sql

3. Run main.py

# TODO: count new|changed|deleted entries and write this info to the sync_log.result field
# TODO: check timezones
# TODO: get DB credentials from the vault