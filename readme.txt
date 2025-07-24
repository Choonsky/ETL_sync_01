Test ETL for tables synchronization (Oracle -> Postgres) using SCD2 scheme

1. Set up Oracle DB
1a. Create DATA_IN user
1b. Alter this user giving him tablespace (10+ GB)
1c. Run Oracle_init_ddl.sql
1d. Run Oracle_init_dml.sql