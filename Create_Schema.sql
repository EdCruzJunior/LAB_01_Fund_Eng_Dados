-- Database: Acidentes_Rodovias

-- DROP DATABASE IF EXISTS "Acidentes_Rodovias";

CREATE DATABASE "Acidentes_Rodovias"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United Kingdom.1252'
    LC_CTYPE = 'English_United Kingdom.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


-- SCHEMA: dw_acidentes

-- DROP SCHEMA IF EXISTS dw_acidentes ;

CREATE SCHEMA IF NOT EXISTS dw_acidentes
    AUTHORIZATION postgres;


-- Table: dw_acidentes.dim_acidente

-- DROP TABLE IF EXISTS dw_acidentes.dim_acidente;

CREATE TABLE IF NOT EXISTS dw_acidentes.dim_acidente
(
    id_acidente_tipo integer NOT NULL DEFAULT nextval('dw_acidentes.dim_acidente_id_acidente_tipo_seq'::regclass),
    classe character varying(100) COLLATE pg_catalog."default",
    subclasse character varying(100) COLLATE pg_catalog."default",
    causa_provavel text COLLATE pg_catalog."default",
    CONSTRAINT dim_acidente_pkey PRIMARY KEY (id_acidente_tipo)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dw_acidentes.dim_acidente
    OWNER to postgres;



-- Table: dw_acidentes.dim_concessionaria

-- DROP TABLE IF EXISTS dw_acidentes.dim_concessionaria;

CREATE TABLE IF NOT EXISTS dw_acidentes.dim_concessionaria
(
    id_concessionaria integer NOT NULL DEFAULT nextval('dw_acidentes.dim_concessionaria_id_concessionaria_seq'::regclass),
    concessionaria character varying(100) COLLATE pg_catalog."default",
    jurisdicao character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT dim_concessionaria_pkey PRIMARY KEY (id_concessionaria)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dw_acidentes.dim_concessionaria
    OWNER to postgres;



-- Table: dw_acidentes.dim_condicoes

-- DROP TABLE IF EXISTS dw_acidentes.dim_condicoes;

CREATE TABLE IF NOT EXISTS dw_acidentes.dim_condicoes
(
    id_condicao integer NOT NULL DEFAULT nextval('dw_acidentes.dim_condicoes_id_condicao_seq'::regclass),
    visibilidade character varying(50) COLLATE pg_catalog."default",
    condicao_meteorologica character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT dim_condicoes_pkey PRIMARY KEY (id_condicao)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dw_acidentes.dim_condicoes
    OWNER to postgres;




-- Table: dw_acidentes.dim_localizacao

-- DROP TABLE IF EXISTS dw_acidentes.dim_localizacao;

CREATE TABLE IF NOT EXISTS dw_acidentes.dim_localizacao
(
    id_localizacao integer NOT NULL DEFAULT nextval('dw_acidentes.dim_localizacao_id_localizacao_seq'::regclass),
    rodovia character varying(50) COLLATE pg_catalog."default",
    km numeric(6,2),
    sentido character varying(10) COLLATE pg_catalog."default",
    latitude numeric(10,6),
    longitude numeric(10,6),
    CONSTRAINT dim_localizacao_pkey PRIMARY KEY (id_localizacao)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dw_acidentes.dim_localizacao
    OWNER to postgres;



-- Table: dw_acidentes.dim_municipio

-- DROP TABLE IF EXISTS dw_acidentes.dim_municipio;

CREATE TABLE IF NOT EXISTS dw_acidentes.dim_municipio
(
    id_municipio integer NOT NULL DEFAULT nextval('dw_acidentes.dim_municipio_id_municipio_seq'::regclass),
    municipio character varying(100) COLLATE pg_catalog."default",
    regiao_administrativa character varying(100) COLLATE pg_catalog."default",
    regional_der character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT dim_municipio_pkey PRIMARY KEY (id_municipio)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dw_acidentes.dim_municipio
    OWNER to postgres;



-- Table: dw_acidentes.dim_tempo

-- DROP TABLE IF EXISTS dw_acidentes.dim_tempo;

CREATE TABLE IF NOT EXISTS dw_acidentes.dim_tempo
(
    id_tempo integer NOT NULL DEFAULT nextval('dw_acidentes.dim_tempo_id_tempo_seq'::regclass),
    data date,
    hora time without time zone,
    ano integer,
    mes integer,
    dia integer,
    CONSTRAINT dim_tempo_pkey PRIMARY KEY (id_tempo)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dw_acidentes.dim_tempo
    OWNER to postgres;




-- Table: dw_acidentes.fact_acidentes

-- DROP TABLE IF EXISTS dw_acidentes.fact_acidentes;

CREATE TABLE IF NOT EXISTS dw_acidentes.fact_acidentes
(
    id_fato integer NOT NULL DEFAULT nextval('dw_acidentes.fact_acidentes_id_fato_seq'::regclass),
    id_tempo integer,
    id_localizacao integer,
    id_municipio integer,
    id_condicao integer,
    id_acidente_tipo integer,
    id_concessionaria integer,
    veiculos_envolvidos integer,
    vitima_ilesa integer,
    vitima_leve integer,
    vitima_moderada integer,
    vitima_grave integer,
    vitima_fatal integer,
    CONSTRAINT fact_acidentes_pkey PRIMARY KEY (id_fato),
    CONSTRAINT fact_acidentes_id_acidente_tipo_fkey FOREIGN KEY (id_acidente_tipo)
        REFERENCES dw_acidentes.dim_acidente (id_acidente_tipo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fact_acidentes_id_concessionaria_fkey FOREIGN KEY (id_concessionaria)
        REFERENCES dw_acidentes.dim_concessionaria (id_concessionaria) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fact_acidentes_id_condicao_fkey FOREIGN KEY (id_condicao)
        REFERENCES dw_acidentes.dim_condicoes (id_condicao) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fact_acidentes_id_localizacao_fkey FOREIGN KEY (id_localizacao)
        REFERENCES dw_acidentes.dim_localizacao (id_localizacao) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fact_acidentes_id_municipio_fkey FOREIGN KEY (id_municipio)
        REFERENCES dw_acidentes.dim_municipio (id_municipio) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fact_acidentes_id_tempo_fkey FOREIGN KEY (id_tempo)
        REFERENCES dw_acidentes.dim_tempo (id_tempo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dw_acidentes.fact_acidentes
    OWNER to postgres;