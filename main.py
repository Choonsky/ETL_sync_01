import oracledb
import psycopg2

try:
    # Establish a connection with Oracle
    connectionOracle = oracledb.connect(
        user="IN_DATA",
        password="12345",
        dsn="localhost:1521/FREEPDB1"  # Replace with your connection details
    )
    print("Successfully connected to Oracle!")

    connectionPostgres = psycopg2.connect(
        dbname='postgres',
        user='postgres',
        password='admin',
        host='localhost')
    print("Successfully connected to PostgreSQL!")

    # Create an Oracle cursor object
    cursorOracle = connectionOracle.cursor()

    # Execute a query
    cursorOracle.execute("SELECT count(*) FROM in_data.data_main")  # Replace with your table name

    # Fetch and print the results
    for row in cursorOracle:
        print(row)

    # Close the cursor and connection
    cursorOracle.close()
    connectionOracle.close()

except oracledb.Error as error:
    print(f"Oracle Error: {error}")
except psycopg2.Error as error:
    print(f"Postgres Error: {error}")
except Exception as error:
    print(f"An error occurred: {error}")
