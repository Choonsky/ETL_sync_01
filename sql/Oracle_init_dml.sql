CREATE TABLE in_data.data_main

(
    -- UUID as in v19 Oracle. For the last version we can use 'id STRING AS UUID'
    id           CHAR(36) CHECK (REGEXP_LIKE(id, '^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$')) primary key,

    date_created DATE not null,
    date_updated DATE,

    user_created CHAR(36) not null,
    user_updated CHAR(36),

    transaction_id CHAR(36) not null,
    transaction_status_new VARCHAR2(8) not null,
    transaction_amount NUMBER not null,
    transaction_currency VARCHAR2(3) not null,
    transaction_description NVARCHAR2(200) not null
);
