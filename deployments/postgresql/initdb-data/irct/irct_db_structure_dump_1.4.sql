--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.7
-- Dumped by pg_dump version 9.6.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: irct
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO irct;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: irct_clauseabstract; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_clauseabstract (
    dtype character varying(31) NOT NULL,
    id bigint NOT NULL,
    alias character varying(255),
    logicaloperator character varying(255),
    operationtype_id bigint,
    parameter_id bigint,
    field_id bigint,
    predicatetype_id bigint,
    subquery_id bigint
);


ALTER TABLE irct_clauseabstract OWNER TO irct;

--
-- Name: irct_dataconverterimplementation; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_dataconverterimplementation (
    id bigint NOT NULL,
    dataconverter character varying(255),
    format character varying(255),
    resultdatatype character varying(255)
);


ALTER TABLE irct_dataconverterimplementation OWNER TO irct;

--
-- Name: irct_entity; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_entity (
    id bigint NOT NULL,
    datatype character varying(255),
    description character varying(255),
    displayname character varying(255),
    name character varying(255),
    ontology character varying(255),
    ontologyid character varying(255),
    pui character varying(255)
);


ALTER TABLE irct_entity OWNER TO irct;

--
-- Name: irct_event_parameters; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_event_parameters (
    id bigint NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE irct_event_parameters OWNER TO irct;

--
-- Name: irct_eventconverterimplementation; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_eventconverterimplementation (
    id bigint NOT NULL,
    eventlistener character varying(255),
    name character varying(255)
);


ALTER TABLE irct_eventconverterimplementation OWNER TO irct;

--
-- Name: irct_field; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_field (
    id bigint NOT NULL,
    description character varying(255),
    name character varying(255),
    path character varying(255),
    relationship character varying(255),
    required boolean NOT NULL
);


ALTER TABLE irct_field OWNER TO irct;

--
-- Name: irct_field_datatypes; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_field_datatypes (
    field_id bigint NOT NULL,
    datatypes character varying(255)
);


ALTER TABLE irct_field_datatypes OWNER TO irct;

--
-- Name: irct_field_permittedvalues; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_field_permittedvalues (
    field_id bigint NOT NULL,
    permittedvalues character varying(255)
);


ALTER TABLE irct_field_permittedvalues OWNER TO irct;

--
-- Name: irct_irctjoin; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_irctjoin (
    id bigint NOT NULL,
    description character varying(255),
    displayname character varying(255),
    joinimplementation character varying(255),
    name character varying(255)
);


ALTER TABLE irct_irctjoin OWNER TO irct;

--
-- Name: irct_irctjoin_field; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_irctjoin_field (
    irctjoin_id bigint NOT NULL,
    fields_id bigint NOT NULL
);


ALTER TABLE irct_irctjoin_field OWNER TO irct;

--
-- Name: irct_irctprocess; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_irctprocess (
    id bigint NOT NULL,
    processtype_id bigint
);


ALTER TABLE irct_irctprocess OWNER TO irct;

--
-- Name: irct_irctprocess_resource; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_irctprocess_resource (
    irctprocess_id bigint NOT NULL,
    resources_id bigint NOT NULL
);


ALTER TABLE irct_irctprocess_resource OWNER TO irct;

--
-- Name: irct_jointype; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_jointype (
    id bigint NOT NULL,
    description character varying(255),
    displayname character varying(255),
    name character varying(255)
);


ALTER TABLE irct_jointype OWNER TO irct;

--
-- Name: irct_jointype_datatypes; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_jointype_datatypes (
    jointype_id bigint NOT NULL,
    datatypes character varying(255)
);


ALTER TABLE irct_jointype_datatypes OWNER TO irct;

--
-- Name: irct_jointype_field; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_jointype_field (
    jointype_id bigint NOT NULL,
    fields_id bigint NOT NULL
);


ALTER TABLE irct_jointype_field OWNER TO irct;

--
-- Name: irct_jwt; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_jwt (
    id bigint NOT NULL,
    access text,
    clientid character varying(255),
    idtoken text,
    type character varying(255)
);


ALTER TABLE irct_jwt OWNER TO irct;

--
-- Name: irct_predicatetype; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_predicatetype (
    id bigint NOT NULL,
    defaultpredicate boolean NOT NULL,
    description character varying(255),
    displayname character varying(255),
    name character varying(255)
);


ALTER TABLE irct_predicatetype OWNER TO irct;

--
-- Name: irct_predicatetype_datatypes; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_predicatetype_datatypes (
    predicatetype_id bigint NOT NULL,
    datatypes character varying(255)
);


ALTER TABLE irct_predicatetype_datatypes OWNER TO irct;

--
-- Name: irct_predicatetype_field; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_predicatetype_field (
    predicatetype_id bigint NOT NULL,
    fields_id bigint NOT NULL
);


ALTER TABLE irct_predicatetype_field OWNER TO irct;

--
-- Name: irct_predicatetype_paths; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_predicatetype_paths (
    predicatetype_id bigint NOT NULL,
    paths character varying(255)
);


ALTER TABLE irct_predicatetype_paths OWNER TO irct;

--
-- Name: irct_process_values; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_process_values (
    process_value bigint NOT NULL,
    process_id character varying(255) NOT NULL
);


ALTER TABLE irct_process_values OWNER TO irct;

--
-- Name: irct_processtype; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_processtype (
    id bigint NOT NULL,
    description character varying(255),
    displayname character varying(255),
    name character varying(255)
);


ALTER TABLE irct_processtype OWNER TO irct;

--
-- Name: irct_processtype_fields; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_processtype_fields (
    processtype_id bigint NOT NULL,
    fields_id bigint NOT NULL
);


ALTER TABLE irct_processtype_fields OWNER TO irct;

--
-- Name: irct_processtype_returns; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_processtype_returns (
    processtype_id bigint NOT NULL,
    returns_id bigint NOT NULL
);


ALTER TABLE irct_processtype_returns OWNER TO irct;

--
-- Name: irct_query; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_query (
    id bigint NOT NULL,
    name character varying(255)
);


ALTER TABLE irct_query OWNER TO irct;

--
-- Name: irct_query_clauseabstract; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_query_clauseabstract (
    query_id bigint NOT NULL,
    clauses_id bigint NOT NULL,
    clauses_key bigint NOT NULL
);


ALTER TABLE irct_query_clauseabstract OWNER TO irct;

--
-- Name: irct_query_resource; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_query_resource (
    query_id bigint NOT NULL,
    resources_id bigint NOT NULL
);


ALTER TABLE irct_query_resource OWNER TO irct;

--
-- Name: irct_query_subquery; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_query_subquery (
    query_id bigint NOT NULL,
    subqueries_id bigint NOT NULL,
    subqueries_key character varying(255) NOT NULL
);


ALTER TABLE irct_query_subquery OWNER TO irct;

--
-- Name: irct_resource; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_resource (
    id bigint NOT NULL,
    implementinginterface character varying(255),
    name character varying(255),
    ontologytype character varying(255)
);


ALTER TABLE irct_resource OWNER TO irct;

--
-- Name: irct_resource_datatypes; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_resource_datatypes (
    resource_id bigint NOT NULL,
    datatypes character varying(255)
);


ALTER TABLE irct_resource_datatypes OWNER TO irct;

--
-- Name: irct_resource_field; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_resource_field (
    resource_id bigint NOT NULL,
    supportedselectfields_id bigint NOT NULL
);


ALTER TABLE irct_resource_field OWNER TO irct;

--
-- Name: irct_resource_jointype; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_resource_jointype (
    resource_id bigint NOT NULL,
    supportedjoins_id bigint NOT NULL
);


ALTER TABLE irct_resource_jointype OWNER TO irct;

--
-- Name: irct_resource_logicaloperator; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_resource_logicaloperator (
    id bigint NOT NULL,
    logicaloperator character varying(255) NOT NULL
);


ALTER TABLE irct_resource_logicaloperator OWNER TO irct;

--
-- Name: irct_resource_parameters; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_resource_parameters (
    id bigint NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE irct_resource_parameters OWNER TO irct;

--
-- Name: irct_resource_predicatetype; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_resource_predicatetype (
    resource_id bigint NOT NULL,
    supportedpredicates_id bigint NOT NULL
);


ALTER TABLE irct_resource_predicatetype OWNER TO irct;

--
-- Name: irct_resource_processtype; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_resource_processtype (
    resource_id bigint NOT NULL,
    supportedprocesses_id bigint NOT NULL
);


ALTER TABLE irct_resource_processtype OWNER TO irct;

--
-- Name: irct_resource_relationships; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_resource_relationships (
    resource_id bigint NOT NULL,
    relationships character varying(255)
);


ALTER TABLE irct_resource_relationships OWNER TO irct;

--
-- Name: irct_resource_selectoperationtype; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_resource_selectoperationtype (
    resource_id bigint NOT NULL,
    supportedselectoperations_id bigint NOT NULL
);


ALTER TABLE irct_resource_selectoperationtype OWNER TO irct;

--
-- Name: irct_resource_sortoperationtype; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_resource_sortoperationtype (
    resource_id bigint NOT NULL,
    supportedsortoperations_id bigint NOT NULL
);


ALTER TABLE irct_resource_sortoperationtype OWNER TO irct;

--
-- Name: irct_resource_visualizationtype; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_resource_visualizationtype (
    resource_id bigint NOT NULL,
    supportedvisualizations_id bigint NOT NULL
);


ALTER TABLE irct_resource_visualizationtype OWNER TO irct;

--
-- Name: irct_result; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_result (
    id bigint NOT NULL,
    data character varying(255),
    datatype character varying(255),
    endtime timestamp without time zone,
    jobtype character varying(255),
    message character varying(255),
    resourceactionid character varying(255),
    resultsetlocation character varying(255),
    resultstatus character varying(255),
    starttime timestamp without time zone,
    user_id bigint
);


ALTER TABLE irct_result OWNER TO irct;

--
-- Name: irct_securesession; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_securesession (
    id bigint NOT NULL,
    accesskey character varying(255),
    created timestamp without time zone,
    token_id bigint,
    user_id bigint
);


ALTER TABLE irct_securesession OWNER TO irct;

--
-- Name: irct_select_values; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_select_values (
    select_id bigint NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE irct_select_values OWNER TO irct;

--
-- Name: irct_selectoperationtype; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_selectoperationtype (
    id bigint NOT NULL,
    description character varying(255),
    displayname character varying(255),
    name character varying(255)
);


ALTER TABLE irct_selectoperationtype OWNER TO irct;

--
-- Name: irct_selectoperationtype_datatypes; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_selectoperationtype_datatypes (
    selectoperationtype_id bigint NOT NULL,
    datatypes character varying(255)
);


ALTER TABLE irct_selectoperationtype_datatypes OWNER TO irct;

--
-- Name: irct_selectoperationtype_field; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_selectoperationtype_field (
    selectoperationtype_id bigint NOT NULL,
    fields_id bigint NOT NULL
);


ALTER TABLE irct_selectoperationtype_field OWNER TO irct;

--
-- Name: irct_selectoperationtype_paths; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_selectoperationtype_paths (
    selectoperationtype_id bigint NOT NULL,
    paths character varying(255)
);


ALTER TABLE irct_selectoperationtype_paths OWNER TO irct;

--
-- Name: irct_sortoperationtype; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_sortoperationtype (
    id bigint NOT NULL,
    description character varying(255),
    displayname character varying(255),
    name character varying(255)
);


ALTER TABLE irct_sortoperationtype OWNER TO irct;

--
-- Name: irct_sortoperationtype_datatypes; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_sortoperationtype_datatypes (
    sortoperationtype_id bigint NOT NULL,
    datatypes character varying(255)
);


ALTER TABLE irct_sortoperationtype_datatypes OWNER TO irct;

--
-- Name: irct_sortoperationtype_field; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_sortoperationtype_field (
    sortoperationtype_id bigint NOT NULL,
    fields_id bigint NOT NULL
);


ALTER TABLE irct_sortoperationtype_field OWNER TO irct;

--
-- Name: irct_sortoperationtype_paths; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_sortoperationtype_paths (
    sortoperationtype_id bigint NOT NULL,
    paths character varying(255)
);


ALTER TABLE irct_sortoperationtype_paths OWNER TO irct;

--
-- Name: irct_subquery; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_subquery (
    id bigint NOT NULL,
    name character varying(255),
    parent_id bigint
);


ALTER TABLE irct_subquery OWNER TO irct;

--
-- Name: irct_token; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_token (
    id bigint NOT NULL
);


ALTER TABLE irct_token OWNER TO irct;

--
-- Name: irct_user; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_user (
    id bigint NOT NULL,
    userid character varying(255)
);


ALTER TABLE irct_user OWNER TO irct;

--
-- Name: irct_visualizationtype; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_visualizationtype (
    id bigint NOT NULL,
    description character varying(255),
    displayname character varying(255),
    name character varying(255),
    returns character varying(255)
);


ALTER TABLE irct_visualizationtype OWNER TO irct;

--
-- Name: irct_visualizationtype_field; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_visualizationtype_field (
    visualizationtype_id bigint NOT NULL,
    fields_id bigint NOT NULL
);


ALTER TABLE irct_visualizationtype_field OWNER TO irct;

--
-- Name: irct_where_values; Type: TABLE; Schema: public; Owner: irct
--

CREATE TABLE irct_where_values (
    where_id bigint NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE irct_where_values OWNER TO irct;

--
-- Name: resseq; Type: SEQUENCE; Schema: public; Owner: irct
--

CREATE SEQUENCE resseq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE resseq OWNER TO irct;

--
-- Name: secsurseq; Type: SEQUENCE; Schema: public; Owner: irct
--

CREATE SEQUENCE secsurseq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE secsurseq OWNER TO irct;

--
-- Name: tokenseq; Type: SEQUENCE; Schema: public; Owner: irct
--

CREATE SEQUENCE tokenseq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tokenseq OWNER TO irct;

--
-- Name: userseq; Type: SEQUENCE; Schema: public; Owner: irct
--

CREATE SEQUENCE userseq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userseq OWNER TO irct;

--
-- Name: irct_clauseabstract irct_clauseabstract_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_clauseabstract
    ADD CONSTRAINT irct_clauseabstract_pkey PRIMARY KEY (id);


--
-- Name: irct_dataconverterimplementation irct_dataconverterimplementation_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_dataconverterimplementation
    ADD CONSTRAINT irct_dataconverterimplementation_pkey PRIMARY KEY (id);


--
-- Name: irct_entity irct_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_entity
    ADD CONSTRAINT irct_entity_pkey PRIMARY KEY (id);


--
-- Name: irct_event_parameters irct_event_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_event_parameters
    ADD CONSTRAINT irct_event_parameters_pkey PRIMARY KEY (id, name);


--
-- Name: irct_eventconverterimplementation irct_eventconverterimplementation_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_eventconverterimplementation
    ADD CONSTRAINT irct_eventconverterimplementation_pkey PRIMARY KEY (id);


--
-- Name: irct_field irct_field_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_field
    ADD CONSTRAINT irct_field_pkey PRIMARY KEY (id);


--
-- Name: irct_irctjoin irct_irctjoin_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_irctjoin
    ADD CONSTRAINT irct_irctjoin_pkey PRIMARY KEY (id);


--
-- Name: irct_irctprocess irct_irctprocess_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_irctprocess
    ADD CONSTRAINT irct_irctprocess_pkey PRIMARY KEY (id);


--
-- Name: irct_jointype irct_jointype_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_jointype
    ADD CONSTRAINT irct_jointype_pkey PRIMARY KEY (id);


--
-- Name: irct_jwt irct_jwt_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_jwt
    ADD CONSTRAINT irct_jwt_pkey PRIMARY KEY (id);


--
-- Name: irct_predicatetype irct_predicatetype_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_predicatetype
    ADD CONSTRAINT irct_predicatetype_pkey PRIMARY KEY (id);


--
-- Name: irct_process_values irct_process_values_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_process_values
    ADD CONSTRAINT irct_process_values_pkey PRIMARY KEY (process_value, process_id);


--
-- Name: irct_processtype irct_processtype_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_processtype
    ADD CONSTRAINT irct_processtype_pkey PRIMARY KEY (id);


--
-- Name: irct_query_clauseabstract irct_query_clauseabstract_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_query_clauseabstract
    ADD CONSTRAINT irct_query_clauseabstract_pkey PRIMARY KEY (query_id, clauses_key);


--
-- Name: irct_query irct_query_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_query
    ADD CONSTRAINT irct_query_pkey PRIMARY KEY (id);


--
-- Name: irct_query_resource irct_query_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_query_resource
    ADD CONSTRAINT irct_query_resource_pkey PRIMARY KEY (query_id, resources_id);


--
-- Name: irct_query_subquery irct_query_subquery_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_query_subquery
    ADD CONSTRAINT irct_query_subquery_pkey PRIMARY KEY (query_id, subqueries_key);


--
-- Name: irct_resource_parameters irct_resource_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_parameters
    ADD CONSTRAINT irct_resource_parameters_pkey PRIMARY KEY (id, name);


--
-- Name: irct_resource irct_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource
    ADD CONSTRAINT irct_resource_pkey PRIMARY KEY (id);


--
-- Name: irct_result irct_result_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_result
    ADD CONSTRAINT irct_result_pkey PRIMARY KEY (id);


--
-- Name: irct_securesession irct_securesession_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_securesession
    ADD CONSTRAINT irct_securesession_pkey PRIMARY KEY (id);


--
-- Name: irct_select_values irct_select_values_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_select_values
    ADD CONSTRAINT irct_select_values_pkey PRIMARY KEY (select_id, name);


--
-- Name: irct_selectoperationtype irct_selectoperationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_selectoperationtype
    ADD CONSTRAINT irct_selectoperationtype_pkey PRIMARY KEY (id);


--
-- Name: irct_sortoperationtype irct_sortoperationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_sortoperationtype
    ADD CONSTRAINT irct_sortoperationtype_pkey PRIMARY KEY (id);


--
-- Name: irct_subquery irct_subquery_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_subquery
    ADD CONSTRAINT irct_subquery_pkey PRIMARY KEY (id);


--
-- Name: irct_token irct_token_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_token
    ADD CONSTRAINT irct_token_pkey PRIMARY KEY (id);


--
-- Name: irct_user irct_user_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_user
    ADD CONSTRAINT irct_user_pkey PRIMARY KEY (id);


--
-- Name: irct_visualizationtype irct_visualizationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_visualizationtype
    ADD CONSTRAINT irct_visualizationtype_pkey PRIMARY KEY (id);


--
-- Name: irct_where_values irct_where_values_pkey; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_where_values
    ADD CONSTRAINT irct_where_values_pkey PRIMARY KEY (where_id, name);


--
-- Name: irct_sortoperationtype_field uk_2sb22kbxp05wcu9m0kk02y2fc; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_sortoperationtype_field
    ADD CONSTRAINT uk_2sb22kbxp05wcu9m0kk02y2fc UNIQUE (fields_id);


--
-- Name: irct_irctprocess_resource uk_3f8gvaaavitagnxbodthsqvly; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_irctprocess_resource
    ADD CONSTRAINT uk_3f8gvaaavitagnxbodthsqvly UNIQUE (resources_id);


--
-- Name: irct_resource_visualizationtype uk_46ohmn2gim5oo8fc8f0h3dlxl; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_visualizationtype
    ADD CONSTRAINT uk_46ohmn2gim5oo8fc8f0h3dlxl UNIQUE (supportedvisualizations_id);


--
-- Name: irct_resource_sortoperationtype uk_5xy7olhq2m70w4ptt2slu2rmc; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_sortoperationtype
    ADD CONSTRAINT uk_5xy7olhq2m70w4ptt2slu2rmc UNIQUE (supportedsortoperations_id);


--
-- Name: irct_processtype_fields uk_61nk7bgvi44plyb8xlu1dd6rl; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_processtype_fields
    ADD CONSTRAINT uk_61nk7bgvi44plyb8xlu1dd6rl UNIQUE (fields_id);


--
-- Name: irct_irctjoin_field uk_b0agnp82ei4nj9dlndwm6lqpx; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_irctjoin_field
    ADD CONSTRAINT uk_b0agnp82ei4nj9dlndwm6lqpx UNIQUE (fields_id);


--
-- Name: irct_resource_processtype uk_e0dsgtr4qbn5e3schfgt6o06b; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_processtype
    ADD CONSTRAINT uk_e0dsgtr4qbn5e3schfgt6o06b UNIQUE (supportedprocesses_id);


--
-- Name: irct_resource_jointype uk_fj9wa8o69r5tp3t46tj87f0md; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_jointype
    ADD CONSTRAINT uk_fj9wa8o69r5tp3t46tj87f0md UNIQUE (supportedjoins_id);


--
-- Name: irct_resource_field uk_hw6gxa40jlkfxq790fs12u912; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_field
    ADD CONSTRAINT uk_hw6gxa40jlkfxq790fs12u912 UNIQUE (supportedselectfields_id);


--
-- Name: irct_jointype_field uk_i46grs0obuonkrkghd86102b7; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_jointype_field
    ADD CONSTRAINT uk_i46grs0obuonkrkghd86102b7 UNIQUE (fields_id);


--
-- Name: irct_processtype_returns uk_khxansk9aj74liy0yculqetow; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_processtype_returns
    ADD CONSTRAINT uk_khxansk9aj74liy0yculqetow UNIQUE (returns_id);


--
-- Name: irct_predicatetype_field uk_lsi76so7s8a23it6c052tl8op; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_predicatetype_field
    ADD CONSTRAINT uk_lsi76so7s8a23it6c052tl8op UNIQUE (fields_id);


--
-- Name: irct_selectoperationtype_field uk_ntldysem6e44raax69sglhc68; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_selectoperationtype_field
    ADD CONSTRAINT uk_ntldysem6e44raax69sglhc68 UNIQUE (fields_id);


--
-- Name: irct_resource_selectoperationtype uk_o3jvuet5eh138d9sn626m1rww; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_selectoperationtype
    ADD CONSTRAINT uk_o3jvuet5eh138d9sn626m1rww UNIQUE (supportedselectoperations_id);


--
-- Name: irct_resource_predicatetype uk_sr07d9v1avcafd3hywu1omn0r; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_predicatetype
    ADD CONSTRAINT uk_sr07d9v1avcafd3hywu1omn0r UNIQUE (supportedpredicates_id);


--
-- Name: irct_visualizationtype_field uk_tkrvnlf5sls1a5gyr6fryj6lh; Type: CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_visualizationtype_field
    ADD CONSTRAINT uk_tkrvnlf5sls1a5gyr6fryj6lh UNIQUE (fields_id);


--
-- Name: irct_resource_jointype fk157ewg93x6k2hc5pq2o9b7m8u; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_jointype
    ADD CONSTRAINT fk157ewg93x6k2hc5pq2o9b7m8u FOREIGN KEY (resource_id) REFERENCES irct_resource(id);


--
-- Name: irct_field_datatypes fk1btb43ivgt0gb7nccun598x1r; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_field_datatypes
    ADD CONSTRAINT fk1btb43ivgt0gb7nccun598x1r FOREIGN KEY (field_id) REFERENCES irct_field(id);


--
-- Name: irct_select_values fk1kfbxfmj9n57v4ot23d22935y; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_select_values
    ADD CONSTRAINT fk1kfbxfmj9n57v4ot23d22935y FOREIGN KEY (select_id) REFERENCES irct_clauseabstract(id);


--
-- Name: irct_resource_sortoperationtype fk1lh0j6dglf7qjixt0l8v1w15s; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_sortoperationtype
    ADD CONSTRAINT fk1lh0j6dglf7qjixt0l8v1w15s FOREIGN KEY (supportedsortoperations_id) REFERENCES irct_sortoperationtype(id);


--
-- Name: irct_clauseabstract fk24v7u5vbm65o1cyjm7euc3u42; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_clauseabstract
    ADD CONSTRAINT fk24v7u5vbm65o1cyjm7euc3u42 FOREIGN KEY (field_id) REFERENCES irct_entity(id);


--
-- Name: irct_processtype_returns fk2e7vxokh6jh9b12owyt44fv4w; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_processtype_returns
    ADD CONSTRAINT fk2e7vxokh6jh9b12owyt44fv4w FOREIGN KEY (returns_id) REFERENCES irct_field(id);


--
-- Name: irct_irctprocess_resource fk2gxch4vmo24kgm28aqdyo12a; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_irctprocess_resource
    ADD CONSTRAINT fk2gxch4vmo24kgm28aqdyo12a FOREIGN KEY (resources_id) REFERENCES irct_resource(id);


--
-- Name: irct_resource_selectoperationtype fk2qg6xcb9rxnrfg433x1nw8c1h; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_selectoperationtype
    ADD CONSTRAINT fk2qg6xcb9rxnrfg433x1nw8c1h FOREIGN KEY (resource_id) REFERENCES irct_resource(id);


--
-- Name: irct_sortoperationtype_paths fk31dlbvb21yw2l6u4ry3umamyj; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_sortoperationtype_paths
    ADD CONSTRAINT fk31dlbvb21yw2l6u4ry3umamyj FOREIGN KEY (sortoperationtype_id) REFERENCES irct_sortoperationtype(id);


--
-- Name: irct_selectoperationtype_datatypes fk31fp0p2dkor6dmlcgymlwhir7; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_selectoperationtype_datatypes
    ADD CONSTRAINT fk31fp0p2dkor6dmlcgymlwhir7 FOREIGN KEY (selectoperationtype_id) REFERENCES irct_selectoperationtype(id);


--
-- Name: irct_resource_processtype fk55tay1b3y2av69p04a7s1c5hw; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_processtype
    ADD CONSTRAINT fk55tay1b3y2av69p04a7s1c5hw FOREIGN KEY (supportedprocesses_id) REFERENCES irct_processtype(id);


--
-- Name: irct_visualizationtype_field fk5dqv4bo1vm0ayh6en6vt5xxqj; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_visualizationtype_field
    ADD CONSTRAINT fk5dqv4bo1vm0ayh6en6vt5xxqj FOREIGN KEY (visualizationtype_id) REFERENCES irct_visualizationtype(id);


--
-- Name: irct_resource_processtype fk754p7flstx5udt1nkrq448tw8; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_processtype
    ADD CONSTRAINT fk754p7flstx5udt1nkrq448tw8 FOREIGN KEY (resource_id) REFERENCES irct_resource(id);


--
-- Name: irct_sortoperationtype_datatypes fk79vqbr9k21sgc2teadjmxo9oh; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_sortoperationtype_datatypes
    ADD CONSTRAINT fk79vqbr9k21sgc2teadjmxo9oh FOREIGN KEY (sortoperationtype_id) REFERENCES irct_sortoperationtype(id);


--
-- Name: irct_clauseabstract fk7arynk5ty8dm31qupq8jpsw81; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_clauseabstract
    ADD CONSTRAINT fk7arynk5ty8dm31qupq8jpsw81 FOREIGN KEY (parameter_id) REFERENCES irct_entity(id);


--
-- Name: irct_resource_logicaloperator fk8uennv48271td15cc4yv543dn; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_logicaloperator
    ADD CONSTRAINT fk8uennv48271td15cc4yv543dn FOREIGN KEY (id) REFERENCES irct_resource(id);


--
-- Name: irct_resource_jointype fk8vlgh0i2e5j821rua5cvuh3uy; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_jointype
    ADD CONSTRAINT fk8vlgh0i2e5j821rua5cvuh3uy FOREIGN KEY (supportedjoins_id) REFERENCES irct_jointype(id);


--
-- Name: irct_field_permittedvalues fk96tj2rmftrpsy6lnbhoww9ysk; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_field_permittedvalues
    ADD CONSTRAINT fk96tj2rmftrpsy6lnbhoww9ysk FOREIGN KEY (field_id) REFERENCES irct_field(id);


--
-- Name: irct_irctprocess_resource fk9rjsktj0t8lsvttgg47mwa489; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_irctprocess_resource
    ADD CONSTRAINT fk9rjsktj0t8lsvttgg47mwa489 FOREIGN KEY (irctprocess_id) REFERENCES irct_irctprocess(id);


--
-- Name: irct_selectoperationtype_field fk9rkjqq910sunx8u7qliw8vrvr; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_selectoperationtype_field
    ADD CONSTRAINT fk9rkjqq910sunx8u7qliw8vrvr FOREIGN KEY (selectoperationtype_id) REFERENCES irct_selectoperationtype(id);


--
-- Name: irct_predicatetype_paths fkahes8hdvhs6599qlv4krvt3ll; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_predicatetype_paths
    ADD CONSTRAINT fkahes8hdvhs6599qlv4krvt3ll FOREIGN KEY (predicatetype_id) REFERENCES irct_predicatetype(id);


--
-- Name: irct_result fkam52j7nhyrpb6vdwp9en3owbw; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_result
    ADD CONSTRAINT fkam52j7nhyrpb6vdwp9en3owbw FOREIGN KEY (user_id) REFERENCES irct_user(id);


--
-- Name: irct_irctjoin_field fkascs41982svm11gpk10u3frjd; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_irctjoin_field
    ADD CONSTRAINT fkascs41982svm11gpk10u3frjd FOREIGN KEY (irctjoin_id) REFERENCES irct_irctjoin(id);


--
-- Name: irct_resource_datatypes fkatooxba9oipg8xfnwoalvko4f; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_datatypes
    ADD CONSTRAINT fkatooxba9oipg8xfnwoalvko4f FOREIGN KEY (resource_id) REFERENCES irct_resource(id);


--
-- Name: irct_irctjoin_field fkby0jwsktnxwnmigwjqa4xpb71; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_irctjoin_field
    ADD CONSTRAINT fkby0jwsktnxwnmigwjqa4xpb71 FOREIGN KEY (fields_id) REFERENCES irct_field(id);


--
-- Name: irct_process_values fkc5b0uy7kfs43krlcu5tswedr; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_process_values
    ADD CONSTRAINT fkc5b0uy7kfs43krlcu5tswedr FOREIGN KEY (process_value) REFERENCES irct_irctprocess(id);


--
-- Name: irct_securesession fkcswmrp3qsix4n1gjwlby5cagp; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_securesession
    ADD CONSTRAINT fkcswmrp3qsix4n1gjwlby5cagp FOREIGN KEY (user_id) REFERENCES irct_user(id);


--
-- Name: irct_sortoperationtype_field fkcvf01pbbvfiw3byrm0pyrrx7m; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_sortoperationtype_field
    ADD CONSTRAINT fkcvf01pbbvfiw3byrm0pyrrx7m FOREIGN KEY (sortoperationtype_id) REFERENCES irct_sortoperationtype(id);


--
-- Name: irct_clauseabstract fkdcltxr0bigrhajnpexc9b9fym; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_clauseabstract
    ADD CONSTRAINT fkdcltxr0bigrhajnpexc9b9fym FOREIGN KEY (operationtype_id) REFERENCES irct_selectoperationtype(id);


--
-- Name: irct_processtype_fields fkdr7t4m9coms0aa0plooa3n4f0; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_processtype_fields
    ADD CONSTRAINT fkdr7t4m9coms0aa0plooa3n4f0 FOREIGN KEY (fields_id) REFERENCES irct_field(id);


--
-- Name: irct_query_resource fkdw2nia3e4ovnwgdr3qd0ni2dd; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_query_resource
    ADD CONSTRAINT fkdw2nia3e4ovnwgdr3qd0ni2dd FOREIGN KEY (resources_id) REFERENCES irct_resource(id);


--
-- Name: irct_processtype_returns fke5q67jcecdbae76c3uruksgps; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_processtype_returns
    ADD CONSTRAINT fke5q67jcecdbae76c3uruksgps FOREIGN KEY (processtype_id) REFERENCES irct_processtype(id);


--
-- Name: irct_query_subquery fke6oyhsl0hlgcfgrrp0d01wqgg; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_query_subquery
    ADD CONSTRAINT fke6oyhsl0hlgcfgrrp0d01wqgg FOREIGN KEY (subqueries_id) REFERENCES irct_subquery(id);


--
-- Name: irct_jointype_datatypes fke79588kkft5fwk3svunu7tlsi; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_jointype_datatypes
    ADD CONSTRAINT fke79588kkft5fwk3svunu7tlsi FOREIGN KEY (jointype_id) REFERENCES irct_jointype(id);


--
-- Name: irct_predicatetype_field fkf1k1hqygl28eim538fgcv5sqv; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_predicatetype_field
    ADD CONSTRAINT fkf1k1hqygl28eim538fgcv5sqv FOREIGN KEY (predicatetype_id) REFERENCES irct_predicatetype(id);


--
-- Name: irct_sortoperationtype_field fkffjsyabw8eyqnvt8mnmmbnesl; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_sortoperationtype_field
    ADD CONSTRAINT fkffjsyabw8eyqnvt8mnmmbnesl FOREIGN KEY (fields_id) REFERENCES irct_field(id);


--
-- Name: irct_resource_predicatetype fkg7d7gyebqhj9posxt7r7eqsvh; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_predicatetype
    ADD CONSTRAINT fkg7d7gyebqhj9posxt7r7eqsvh FOREIGN KEY (resource_id) REFERENCES irct_resource(id);


--
-- Name: irct_jointype_field fkgrergeo4ms8tejngfvr2x8m68; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_jointype_field
    ADD CONSTRAINT fkgrergeo4ms8tejngfvr2x8m68 FOREIGN KEY (fields_id) REFERENCES irct_field(id);


--
-- Name: irct_resource_sortoperationtype fkh2i71x7i1l3hrw43697j3xye7; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_sortoperationtype
    ADD CONSTRAINT fkh2i71x7i1l3hrw43697j3xye7 FOREIGN KEY (resource_id) REFERENCES irct_resource(id);


--
-- Name: irct_processtype_fields fkifdlvyyrxvg10cy7uyyrsm5uk; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_processtype_fields
    ADD CONSTRAINT fkifdlvyyrxvg10cy7uyyrsm5uk FOREIGN KEY (processtype_id) REFERENCES irct_processtype(id);


--
-- Name: irct_selectoperationtype_paths fkin3yf92h37eefemggl8w1ilne; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_selectoperationtype_paths
    ADD CONSTRAINT fkin3yf92h37eefemggl8w1ilne FOREIGN KEY (selectoperationtype_id) REFERENCES irct_selectoperationtype(id);


--
-- Name: irct_predicatetype_field fkj0whx0n69rp4twxil5787kjpf; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_predicatetype_field
    ADD CONSTRAINT fkj0whx0n69rp4twxil5787kjpf FOREIGN KEY (fields_id) REFERENCES irct_field(id);


--
-- Name: irct_resource_relationships fkk7pxksifmxnsscop9pw3bi97b; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_relationships
    ADD CONSTRAINT fkk7pxksifmxnsscop9pw3bi97b FOREIGN KEY (resource_id) REFERENCES irct_resource(id);


--
-- Name: irct_resource_field fkl1kgsnvic9clxowre24f4iirv; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_field
    ADD CONSTRAINT fkl1kgsnvic9clxowre24f4iirv FOREIGN KEY (resource_id) REFERENCES irct_resource(id);


--
-- Name: irct_resource_predicatetype fkl2utv9enqbg3d3s60qvg1q95e; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_predicatetype
    ADD CONSTRAINT fkl2utv9enqbg3d3s60qvg1q95e FOREIGN KEY (supportedpredicates_id) REFERENCES irct_predicatetype(id);


--
-- Name: irct_jointype_field fkm3xkiqou3ocb8i3rcym248w2w; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_jointype_field
    ADD CONSTRAINT fkm3xkiqou3ocb8i3rcym248w2w FOREIGN KEY (jointype_id) REFERENCES irct_jointype(id);


--
-- Name: irct_resource_visualizationtype fkm4qj1dvh3x8thrvf5fpsjmdcs; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_visualizationtype
    ADD CONSTRAINT fkm4qj1dvh3x8thrvf5fpsjmdcs FOREIGN KEY (supportedvisualizations_id) REFERENCES irct_visualizationtype(id);


--
-- Name: irct_event_parameters fkmj1crm6736lcmv3vo3ukvb3vg; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_event_parameters
    ADD CONSTRAINT fkmj1crm6736lcmv3vo3ukvb3vg FOREIGN KEY (id) REFERENCES irct_eventconverterimplementation(id);


--
-- Name: irct_query_clauseabstract fkmo21ygkk49mk3h6bb0k3ntdwv; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_query_clauseabstract
    ADD CONSTRAINT fkmo21ygkk49mk3h6bb0k3ntdwv FOREIGN KEY (clauses_id) REFERENCES irct_clauseabstract(id);


--
-- Name: irct_resource_parameters fkncu8mqxv0li4ncfccqhhkkwbg; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_parameters
    ADD CONSTRAINT fkncu8mqxv0li4ncfccqhhkkwbg FOREIGN KEY (id) REFERENCES irct_resource(id);


--
-- Name: irct_clauseabstract fko1hf22o2acojfvguk6x4hv392; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_clauseabstract
    ADD CONSTRAINT fko1hf22o2acojfvguk6x4hv392 FOREIGN KEY (predicatetype_id) REFERENCES irct_predicatetype(id);


--
-- Name: irct_resource_field fkqsc9y5vukhickdd23knk94l9k; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_field
    ADD CONSTRAINT fkqsc9y5vukhickdd23knk94l9k FOREIGN KEY (supportedselectfields_id) REFERENCES irct_field(id);


--
-- Name: irct_resource_selectoperationtype fkri6uwvvj46cyty8d7u5yysnx3; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_selectoperationtype
    ADD CONSTRAINT fkri6uwvvj46cyty8d7u5yysnx3 FOREIGN KEY (supportedselectoperations_id) REFERENCES irct_selectoperationtype(id);


--
-- Name: irct_predicatetype_datatypes fksijeng8sux0t3v3im7trjfp3p; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_predicatetype_datatypes
    ADD CONSTRAINT fksijeng8sux0t3v3im7trjfp3p FOREIGN KEY (predicatetype_id) REFERENCES irct_predicatetype(id);


--
-- Name: irct_selectoperationtype_field fksiw6hsbjf9rh5y763rrpxgs0e; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_selectoperationtype_field
    ADD CONSTRAINT fksiw6hsbjf9rh5y763rrpxgs0e FOREIGN KEY (fields_id) REFERENCES irct_field(id);


--
-- Name: irct_resource_visualizationtype fksm0kka28sixinqpjgf8pubt4u; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_resource_visualizationtype
    ADD CONSTRAINT fksm0kka28sixinqpjgf8pubt4u FOREIGN KEY (resource_id) REFERENCES irct_resource(id);


--
-- Name: irct_where_values fkssbfsy5r0md0pexof95loinrv; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_where_values
    ADD CONSTRAINT fkssbfsy5r0md0pexof95loinrv FOREIGN KEY (where_id) REFERENCES irct_clauseabstract(id);


--
-- Name: irct_clauseabstract fktbyqh9cyk6vko6sh81mv0f60e; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_clauseabstract
    ADD CONSTRAINT fktbyqh9cyk6vko6sh81mv0f60e FOREIGN KEY (subquery_id) REFERENCES irct_subquery(id);


--
-- Name: irct_irctprocess fktc65ymfw29ea8sh3miln9sfrx; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_irctprocess
    ADD CONSTRAINT fktc65ymfw29ea8sh3miln9sfrx FOREIGN KEY (processtype_id) REFERENCES irct_processtype(id);


--
-- Name: irct_visualizationtype_field fktje6bl7ymwpsxvwomd82xy27x; Type: FK CONSTRAINT; Schema: public; Owner: irct
--

ALTER TABLE ONLY irct_visualizationtype_field
    ADD CONSTRAINT fktje6bl7ymwpsxvwomd82xy27x FOREIGN KEY (fields_id) REFERENCES irct_field(id);


--
-- PostgreSQL database dump complete
--

