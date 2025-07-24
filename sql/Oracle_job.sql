BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
            job_name => 'update_data',
            job_type => 'STORED_PROCEDURE',
            job_action => 'IN_DATA.DATA_PACKAGE.addSomeData',
            start_date => SYSTIMESTAMP,
            repeat_interval => 'FREQ=MINUTELY;INTERVAL=1', /* every minute */
            --end_date => SYSTIMESTAMP + 1,
            comments => 'Fill data table');
END;