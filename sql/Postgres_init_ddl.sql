CREATE TABLE IF NOT EXISTS public.result_data
(
    id uuid NOT NULL,
    id_indata uuid NOT NULL,
    date_created date NOT NULL,
    date_updated date,
    user_created uuid NOT NULL,
    user_updated uuid,
    transaction_id uuid NOT NULL,
    transaction_status_new character varying(8) COLLATE pg_catalog."default" NOT NULL,
    transaction_amount numeric NOT NULL,
    transaction_currency character(3) COLLATE pg_catalog."default" NOT NULL,
    transaction_description character varying(200) COLLATE pg_catalog."default",
    version smallint NOT NULL,
    CONSTRAINT result_data_pkey PRIMARY KEY (id)
)