CREATE TABLE result_data
(
    -- Creating new UUIDs because there can be many versions
    id                      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    -- Old fields
    id_indata               UUID,
    date_created            DATE   not null,
    date_updated            DATE,
    user_created            UUID   not null,
    user_updated            UUID,
    transaction_id          UUID   not null,
    transaction_status_new  VARCHAR2(8) not null,
    transaction_amount      NUMBER not null,
    transaction_currency    VARCHAR2(3) not null,
    transaction_description NVARCHAR2(200) not null,
    -- New field
    version                 NUMBER not null;
);