-- Tables récupérées une par une sur pgadmin
-- Jamais testé si cela fonctionnait

-- Table: public.log

DROP TABLE IF EXISTS log_table;

CREATE TABLE IF NOT EXISTS log_table
(
    id integer NOT NULL,
    url character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "time" time with time zone NOT NULL,
    ip character varying(255) COLLATE pg_catalog."default" NOT NULL,
    created_at TIMESTAMP with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP with time zone,
    CONSTRAINT log_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS log_table
    OWNER to lcaro;

-- ____________________________________________________________
-- Table: public.user

DROP TABLE IF EXISTS user_table;

CREATE TABLE IF NOT EXISTS user_table
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    password text COLLATE pg_catalog."default" NOT NULL,
    firstname text COLLATE pg_catalog."default",
    created_at TIMESTAMP with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP with time zone,
    role text COLLATE pg_catalog."default" DEFAULT 'user'::text,
    CONSTRAINT user_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS user_table
    OWNER to lcaro;


-- ______________________________________________________

-- Table: public.trek

DROP TABLE IF EXISTS trek CASCADE;

CREATE TABLE IF NOT EXISTS trek
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    boucle character varying(50) COLLATE pg_catalog."default" NOT NULL,
    time_length character varying(50) COLLATE pg_catalog."default" NOT NULL,
    start_point character varying(100) COLLATE pg_catalog."default",
    gps_coordonate character varying(50) COLLATE pg_catalog."default",
    gpx character varying(100) COLLATE pg_catalog."default",
    resume text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    distance integer NOT NULL,
    denivele integer NOT NULL,
    max_height integer NOT NULL,
    min_height integer NOT NULL,
    summit_id integer NOT NULL,
    difficulty_id integer NOT NULL,
    created_at TIMESTAMP with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP with time zone,
    map character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT trek_pkey PRIMARY KEY (id),
    CONSTRAINT trek_difficulty_id FOREIGN KEY (difficulty_id)
        REFERENCES public.difficulty (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT trek_summit_id FOREIGN KEY (summit_id)
        REFERENCES public.summit (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS trek
    OWNER to lcaro;
-- ____________________________________________________________


-- Table: public.difficulty

DROP TABLE IF EXISTS difficulty CASCADE;

CREATE TABLE IF NOT EXISTS difficulty
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    created_at TIMESTAMP with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP with time zone,
    CONSTRAINT difficulty_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS difficulty
    OWNER to lcaro;

-- ________________________________________________________________

-- Table: public.summit

DROP TABLE IF EXISTS summit CASCADE;

CREATE TABLE IF NOT EXISTS summit
(
    id integer NOT NULL,
    created_at TIMESTAMP with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP with time zone,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT summit_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS summit
    OWNER to lcaro;

-- _____________________________________________________

-- Table: public.tag

DROP TABLE IF EXISTS tag CASCADE;

CREATE TABLE IF NOT EXISTS tag
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    created_at TIMESTAMP with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP with time zone,
    CONSTRAINT tag_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS tag
    OWNER to lcaro;


-- _____________________________________________________________________

-- Table: public.tag_has_trek

DROP TABLE IF EXISTS tag_has_trek CASCADE;

CREATE TABLE IF NOT EXISTS tag_has_trek
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    tag_id integer NOT NULL,
    trek_id integer NOT NULL,
    created_at TIMESTAMP with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP with time zone,
    CONSTRAINT tag_has_rando_pkey PRIMARY KEY (id),
    CONSTRAINT tag_has_trek_tag_id_trek_id_key UNIQUE (tag_id, trek_id),
    CONSTRAINT tag_has_trek_tag_id_fkey FOREIGN KEY (tag_id)
        REFERENCES public.tag (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT tag_has_trek_trek_id_fkey FOREIGN KEY (trek_id)
        REFERENCES public.trek (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS tag_has_trek
    OWNER to lcaro;

-- ___________________________________________________________