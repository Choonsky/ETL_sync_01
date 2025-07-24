import oracledb
import psycopg2
import uuid

from datetime import datetime, timezone

try:
    connectionOracle = oracledb.connect(
        user="IN_DATA",
        password="12345",
        dsn="localhost:1521/FREEPDB1"  # Replace with your connection details
    )
    print("Successfully connected to Oracle!")
    cursorOracle = connectionOracle.cursor()
    connectionPostgres = psycopg2.connect(
        dbname='postgres',
        user='postgres',
        password='admin',
        host='localhost')
    print("Successfully connected to PostgreSQL!")
    cursorPostgres = connectionPostgres.cursor()

    connectionPostgres.autocommit = True

# 1. Get last sync date and time
    cursorPostgres.execute("SELECT date_sync FROM sync_log WHERE id = (select max(id) from sync_log)")
    for row in cursorPostgres:
        last_sync = row[0]
    print(f"Last sync: {last_sync}")

# 1a. Set current datetime as last sync date
    cursorPostgres.execute("INSERT INTO sync_log (date_sync) VALUES ('{datetime.now()}')")

# 2. Add all items that have date_created > last sync date
    cursorOracle.prepare("SELECT * FROM in_data.data_main WHERE date_created > :ts")
    cursorOracle.setinputsizes(ts=oracledb.TIMESTAMP)
    cursorOracle.execute(None, {'ts': last_sync})

    for row in cursorOracle:
        cursorPostgres.execute(f"""INSERT INTO result_data (id, id_indata, date_created, date_updated, user_created,
                                                               user_updated, transaction_id, transaction_status_new,
                                                               transaction_amount, transaction_currency,
                                                               transaction_description, version)
                                      VALUES ('{str(uuid.uuid4())}', '{row[0]}', '{row[1]}', '{row[2]}', '{row[3]}', '{row[4]}', 
'{row[5]}', '{row[6]}', '{row[7]}', '{row[8]}', '{row[9]}', 1)""")

# 3. Add all items that have date_created < last sync date, but date_updated > last sync date as increased version
        cursorOracle.prepare("SELECT * FROM in_data.data_main WHERE date_created < :ts AND date_updated > :ts")
        cursorOracle.setinputsizes(ts=oracledb.TIMESTAMP)
        cursorOracle.execute(None, {'ts': last_sync})

        for row in cursorOracle:
            cursorPostgres.execute(f"SELECT max(version) FROM result_data WHERE id_indata = '{row[0]}'")
            for row2 in cursorPostgres:
                next_version = row2[0] + 1
            cursorPostgres.execute(f"""INSERT INTO result_data (id, id_indata, date_created, date_updated, user_created,
                                                                   user_updated, transaction_id, transaction_status_new,
                                                                   transaction_amount, transaction_currency,
                                                                   transaction_description, version)
                                          VALUES ('{str(uuid.uuid4())}', '{row[0]}', '{row[1]}', '{row[2]}', '{row[3]}', '{row[4]}', 
    '{row[5]}', '{row[6]}', '{row[7]}', '{row[8]}', '{row[9]}', {next_version})""")

# 4. Add deleted entries as date_updated = now, version++ and transaction_status_new = _DELETED_
# TODO

# 5. Add new entry to the

    cursorOracle.close()
    connectionOracle.close()
    cursorPostgres.close()
    connectionPostgres.close()

except oracledb.Error as error:
    print(f"Oracle Error: {error}")
except psycopg2.Error as error:
    print(f"Postgres Error: {error}")
except Exception as error:
    print(f"An error occurred: {error}")
