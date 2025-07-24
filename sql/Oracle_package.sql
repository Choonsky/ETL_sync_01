CREATE OR REPLACE PACKAGE IN_DATA.DATA_PACKAGE AS
    PROCEDURE addSomeData;
END DATA_PACKAGE;

CREATE OR REPLACE PACKAGE BODY IN_DATA.DATA_PACKAGE AS

    PROCEDURE addSomeData IS
        v_data       in_data.data_main%ROWTYPE;
        rowsCount NUMBER := 100000;
    BEGIN
        FOR i IN 1..rowsCount
            LOOP
                select LOWER(REGEXP_REPLACE(RAWTOHEX(SYS_GUID()),
                                            '([A-F0-9]{8})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{12})',
                                            '\1-\2-\3-\4-\5'))
                INTO v_data.ID;
                select LOWER(REGEXP_REPLACE(RAWTOHEX(SYS_GUID()),
                                            '([A-F0-9]{8})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{12})',
                                            '\1-\2-\3-\4-\5'))
                INTO v_data.USER_CREATED;
                select LOWER(REGEXP_REPLACE(RAWTOHEX(SYS_GUID()),
                                            '([A-F0-9]{8})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{12})',
                                            '\1-\2-\3-\4-\5'))
                INTO v_data.USER_UPDATED;
                select LOWER(REGEXP_REPLACE(RAWTOHEX(SYS_GUID()),
                                            '([A-F0-9]{8})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{12})',
                                            '\1-\2-\3-\4-\5'))
                INTO v_data.TRANSACTION_ID;
                select round(DBMS_RANDOM.VALUE(1, 1000000), 2)
                INTO v_data.TRANSACTION_AMOUNT;
                select DBMS_RANDOM.string('a', round(DBMS_RANDOM.VALUE(10, 100)))
                INTO v_data.TRANSACTION_DESCRIPTION;
                insert into in_data.data_main
                values (v_data.id, sysdate, sysdate, v_data.USER_CREATED,
                        v_data.USER_UPDATED, v_data.TRANSACTION_ID, 'CREATED', v_data.TRANSACTION_AMOUNT,
                        'KGS', v_data.TRANSACTION_DESCRIPTION);
            END LOOP;
        commit;
    END;
END DATA_PACKAGE;