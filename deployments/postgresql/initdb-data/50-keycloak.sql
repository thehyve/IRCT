-- pre-requisites manually added
CREATE DATABASE keycloak;
CREATE ROLE keycloak LOGIN PASSWORD 'keycloak';
grant all on schema public to keycloak;
grant all privileges on all tables in schema public to keycloak;

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    client_template_id character varying(36),
    use_template_config boolean DEFAULT false NOT NULL,
    use_template_scope boolean DEFAULT false NOT NULL,
    use_template_mappers boolean DEFAULT false NOT NULL
);


ALTER TABLE client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE client_attributes OWNER TO keycloak;

--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE client_default_roles OWNER TO keycloak;

--
-- Name: client_identity_prov_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_identity_prov_mapping (
    client_id character varying(36) NOT NULL,
    identity_provider_id character varying(36) NOT NULL,
    retrieve_token boolean DEFAULT false NOT NULL
);


ALTER TABLE client_identity_prov_mapping OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE client_node_registrations OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_session_role OWNER TO keycloak;

--
-- Name: client_template; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_template (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255),
    full_scope_allowed boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    bearer_only boolean DEFAULT false NOT NULL,
    public_client boolean DEFAULT false NOT NULL
);


ALTER TABLE client_template OWNER TO keycloak;

--
-- Name: client_template_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_template_attributes (
    template_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE client_template_attributes OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE credential (
    id character varying(36) NOT NULL,
    device character varying(255),
    hash_iterations integer,
    salt bytea,
    type character varying(255),
    value character varying(4000),
    user_id character varying(36),
    created_date bigint,
    counter integer DEFAULT 0,
    digits integer DEFAULT 6,
    period integer DEFAULT 30,
    algorithm character varying(36) DEFAULT NULL::character varying
);


ALTER TABLE credential OWNER TO keycloak;

--
-- Name: credential_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE credential_attribute (
    id character varying(36) NOT NULL,
    credential_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE credential_attribute OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255)
);


ALTER TABLE databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE databasechangeloglock OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE event_entity OWNER TO keycloak;

--
-- Name: fed_credential_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_credential_attribute (
    id character varying(36) NOT NULL,
    credential_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE fed_credential_attribute OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint
);


ALTER TABLE fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_consent_prot_mapper (
    user_consent_id character varying(36) NOT NULL,
    protocol_mapper_id character varying(36) NOT NULL
);


ALTER TABLE fed_user_consent_prot_mapper OWNER TO keycloak;

--
-- Name: fed_user_consent_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_consent_role (
    user_consent_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE fed_user_consent_role OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_credential (
    id character varying(36) NOT NULL,
    device character varying(255),
    hash_iterations integer,
    salt bytea,
    type character varying(255),
    value character varying(255),
    created_date bigint,
    counter integer DEFAULT 0,
    digits integer DEFAULT 6,
    period integer DEFAULT 30,
    algorithm character varying(36) DEFAULT 'HmacSHA1'::character varying,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36),
    realm_id character varying(36)
);


ALTER TABLE keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(36),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36),
    scope_param_required boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE migration_model (
    id character varying(36) NOT NULL,
    version character varying(36)
);


ALTER TABLE migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text
);


ALTER TABLE offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    last_session_refresh integer,
    offline_flag character varying(4) NOT NULL,
    data text
);


ALTER TABLE offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    consent_text character varying(255),
    client_id character varying(36),
    client_template_id character varying(36)
);


ALTER TABLE protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0
);


ALTER TABLE realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE realm_default_groups OWNER TO keycloak;

--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE realm_default_roles OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255)
);


ALTER TABLE required_action_provider OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL
);


ALTER TABLE resource_server OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL
);


ALTER TABLE resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    uri character varying(255),
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(36) NOT NULL,
    resource_server_id character varying(36) NOT NULL
);


ALTER TABLE resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL
);


ALTER TABLE resource_server_scope OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE scope_policy OWNER TO keycloak;

--
-- Name: template_scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE template_scope_mapping (
    template_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE template_scope_mapping OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint
);


ALTER TABLE user_consent OWNER TO keycloak;

--
-- Name: user_consent_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_consent_prot_mapper (
    user_consent_id character varying(36) NOT NULL,
    protocol_mapper_id character varying(36) NOT NULL
);


ALTER TABLE user_consent_prot_mapper OWNER TO keycloak;

--
-- Name: user_consent_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_consent_role (
    user_consent_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE user_consent_role OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(36),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO authentication_execution VALUES ('527ce789-15f8-48d0-9d66-9280d85b137b', NULL, 'auth-cookie', 'master', '7f9ebc0f-d271-4922-87d7-f639c4983865', 2, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('4a23ecc8-1500-4b3c-afe9-a6ca584c3988', NULL, 'auth-spnego', 'master', '7f9ebc0f-d271-4922-87d7-f639c4983865', 3, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('c4d05336-eca4-4c81-a8cc-0403d0cc1e40', NULL, 'identity-provider-redirector', 'master', '7f9ebc0f-d271-4922-87d7-f639c4983865', 2, 25, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('57b3f73a-750e-4a3f-a883-7bf97023ae08', NULL, NULL, 'master', '7f9ebc0f-d271-4922-87d7-f639c4983865', 2, 30, true, '6ec78dda-a994-4c6f-ac85-fd932909cba8', NULL);
INSERT INTO authentication_execution VALUES ('40e9b935-e903-4104-a702-eee40d3c9e7f', NULL, 'auth-username-password-form', 'master', '6ec78dda-a994-4c6f-ac85-fd932909cba8', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('be5496b1-788b-440b-852b-596e48f8e4b1', NULL, 'auth-otp-form', 'master', '6ec78dda-a994-4c6f-ac85-fd932909cba8', 1, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('bb2c1f79-10b5-4c27-b7b0-7fcfa156811e', NULL, 'direct-grant-validate-username', 'master', '4f09ffad-2003-4f45-9d22-9637e4e65b1a', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('f6713918-0165-464a-9c78-fb953ba30ecc', NULL, 'direct-grant-validate-password', 'master', '4f09ffad-2003-4f45-9d22-9637e4e65b1a', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('5e5950be-daf6-4a23-9ac9-b383b54cc36c', NULL, 'direct-grant-validate-otp', 'master', '4f09ffad-2003-4f45-9d22-9637e4e65b1a', 1, 30, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('980eb6a4-7914-4449-b3c6-b3dbecf96cb2', NULL, 'registration-page-form', 'master', '90d8ee07-fcaa-4e47-bf9d-32d9fb8d2d74', 0, 10, true, 'd8fff6f1-29a2-4f46-a87a-7422ad59aa39', NULL);
INSERT INTO authentication_execution VALUES ('69e0c850-272c-4db5-b6d9-b8096c70953b', NULL, 'registration-user-creation', 'master', 'd8fff6f1-29a2-4f46-a87a-7422ad59aa39', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('aece8eea-1134-452a-acfd-a0781c51fd0d', NULL, 'registration-profile-action', 'master', 'd8fff6f1-29a2-4f46-a87a-7422ad59aa39', 0, 40, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('53e96952-20af-4fca-9d9d-3297d4f75c97', NULL, 'registration-password-action', 'master', 'd8fff6f1-29a2-4f46-a87a-7422ad59aa39', 0, 50, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('8c29816a-8747-45fc-8113-9eb4677be787', NULL, 'registration-recaptcha-action', 'master', 'd8fff6f1-29a2-4f46-a87a-7422ad59aa39', 3, 60, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('d5e77f1e-4365-4116-b74d-17fb64cb8ede', NULL, 'reset-credentials-choose-user', 'master', '5a26dd99-f4a2-4502-a359-24f7cb211b03', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('ea226872-405c-4ed1-aca7-51c83ccae508', NULL, 'reset-credential-email', 'master', '5a26dd99-f4a2-4502-a359-24f7cb211b03', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('bc168f52-3ffa-41ae-af82-a9992263ef5f', NULL, 'reset-password', 'master', '5a26dd99-f4a2-4502-a359-24f7cb211b03', 0, 30, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('e0a9c958-4269-4089-be1d-4aa8b4be860f', NULL, 'reset-otp', 'master', '5a26dd99-f4a2-4502-a359-24f7cb211b03', 1, 40, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('4f0049d1-76ce-4cd8-9414-9d7ee3ae233d', NULL, 'client-secret', 'master', '937d2eac-4765-4b47-bdc2-542aeef4155a', 2, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('96a33917-93a1-432a-8dd6-7bf833b42af2', NULL, 'client-jwt', 'master', '937d2eac-4765-4b47-bdc2-542aeef4155a', 2, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('32588e4e-738c-4b7c-aba6-89a46b220990', NULL, 'idp-review-profile', 'master', 'f3c34abf-8ebe-47d4-b5cd-051de90e1312', 0, 10, false, NULL, '313de267-8aff-4db9-9369-1fd367f5e2cb');
INSERT INTO authentication_execution VALUES ('d3b87788-e491-4875-8159-0f9273d558fb', NULL, 'idp-create-user-if-unique', 'master', 'f3c34abf-8ebe-47d4-b5cd-051de90e1312', 2, 20, false, NULL, 'f186a599-43ce-4a3e-a976-30fcf7efd1bf');
INSERT INTO authentication_execution VALUES ('bb9eda92-51fc-49c5-85d6-874714306cfa', NULL, NULL, 'master', 'f3c34abf-8ebe-47d4-b5cd-051de90e1312', 2, 30, true, 'ca24acf5-98fc-4804-b0d1-862607a01782', NULL);
INSERT INTO authentication_execution VALUES ('766fd7b5-4670-40e0-8036-df5c6f286279', NULL, 'idp-confirm-link', 'master', 'ca24acf5-98fc-4804-b0d1-862607a01782', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('ba149af1-7be9-42a0-b698-6f25d514df9b', NULL, 'idp-email-verification', 'master', 'ca24acf5-98fc-4804-b0d1-862607a01782', 2, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('2a6c0a11-d706-4851-afbe-826ff72ab8fd', NULL, NULL, 'master', 'ca24acf5-98fc-4804-b0d1-862607a01782', 2, 30, true, 'ad452cf1-20c9-4029-bedb-63af4d2084b5', NULL);
INSERT INTO authentication_execution VALUES ('cb31b342-e142-489d-bb00-c33563e4214b', NULL, 'idp-username-password-form', 'master', 'ad452cf1-20c9-4029-bedb-63af4d2084b5', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('642f3bf6-be8b-40f0-a795-a5a7f8606f1e', NULL, 'auth-otp-form', 'master', 'ad452cf1-20c9-4029-bedb-63af4d2084b5', 1, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('e230f151-a3e4-47cd-bfa8-b2e476f55686', NULL, 'http-basic-authenticator', 'master', '7acc26ec-e8dc-4213-83db-bb52c6643b61', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('963f8488-1bd1-4fe6-9bb1-ee271c77dd0d', NULL, 'docker-http-basic-authenticator', 'master', '3ce52383-e86b-4995-8c85-9a41515a381a', 0, 10, false, NULL, NULL);


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO authentication_flow VALUES ('7f9ebc0f-d271-4922-87d7-f639c4983865', 'browser', 'browser based authentication', 'master', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('6ec78dda-a994-4c6f-ac85-fd932909cba8', 'forms', 'Username, password, otp and other auth forms.', 'master', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('4f09ffad-2003-4f45-9d22-9637e4e65b1a', 'direct grant', 'OpenID Connect Resource Owner Grant', 'master', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('90d8ee07-fcaa-4e47-bf9d-32d9fb8d2d74', 'registration', 'registration flow', 'master', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('d8fff6f1-29a2-4f46-a87a-7422ad59aa39', 'registration form', 'registration form', 'master', 'form-flow', false, true);
INSERT INTO authentication_flow VALUES ('5a26dd99-f4a2-4502-a359-24f7cb211b03', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'master', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('937d2eac-4765-4b47-bdc2-542aeef4155a', 'clients', 'Base authentication for clients', 'master', 'client-flow', true, true);
INSERT INTO authentication_flow VALUES ('f3c34abf-8ebe-47d4-b5cd-051de90e1312', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'master', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('ca24acf5-98fc-4804-b0d1-862607a01782', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'master', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('ad452cf1-20c9-4029-bedb-63af4d2084b5', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'master', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('7acc26ec-e8dc-4213-83db-bb52c6643b61', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'master', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('3ce52383-e86b-4995-8c85-9a41515a381a', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'master', 'basic-flow', true, true);


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO authenticator_config VALUES ('313de267-8aff-4db9-9369-1fd367f5e2cb', 'review profile config', 'master');
INSERT INTO authenticator_config VALUES ('f186a599-43ce-4a3e-a976-30fcf7efd1bf', 'create unique user config', 'master');


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO authenticator_config_entry VALUES ('313de267-8aff-4db9-9369-1fd367f5e2cb', 'missing', 'update.profile.on.first.login');
INSERT INTO authenticator_config_entry VALUES ('f186a599-43ce-4a3e-a976-30fcf7efd1bf', 'false', 'require.password.update.after.registration');


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO client VALUES ('a3d7e809-8221-47af-902b-21d17c33e2ad', true, true, 'master-realm', 0, false, 'cfde091a-f7e7-46db-a778-43c2e181d02e', NULL, true, NULL, false, 'master', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', true, false, 'account', 0, false, '5f71eae1-62ad-4589-8f1a-aa4000586801', '/auth/realms/master/account', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('9b65be77-1ef3-4b2e-b27b-b13e908c8536', true, false, 'broker', 0, false, '0739df67-798d-4af0-8dac-119f230520df', NULL, false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('a7f35ea7-017e-4463-995c-137fe9f6fd43', true, false, 'security-admin-console', 0, true, 'ca528b74-3460-417b-8c22-0aaa2ca5ad32', '/auth/admin/master/console/index.html', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('390082ea-2f59-42a5-ae2d-189b40334cf4', true, false, 'admin-cli', 0, true, '0d6f012e-44fc-4b25-8b18-7744e0557de1', NULL, false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, NULL, false, false, false);
INSERT INTO client VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', true, true, 'i2b2-local', 0, true, '38ae4b8e-c8fc-4033-8dc5-65d20d0436ca', NULL, false, NULL, false, 'master', 'openid-connect', -1, false, false, NULL, false, 'client-secret', NULL, NULL, NULL, true, true, true, NULL, false, false, false);


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO client_attributes VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', 'false', 'saml.assertion.signature');
INSERT INTO client_attributes VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', 'false', 'saml.multivalued.roles');
INSERT INTO client_attributes VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', 'false', 'saml.force.post.binding');
INSERT INTO client_attributes VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', 'false', 'saml.encrypt');
INSERT INTO client_attributes VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', 'false', 'saml_force_name_id_format');
INSERT INTO client_attributes VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', 'false', 'saml.client.signature');
INSERT INTO client_attributes VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', 'false', 'saml.authnstatement');
INSERT INTO client_attributes VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', 'false', 'saml.server.signature');
INSERT INTO client_attributes VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO client_attributes VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', 'false', 'saml.onetimeuse.condition');


--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO client_default_roles VALUES ('c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', '4d30dbf3-f4fe-4308-be40-58ba7aff657d');
INSERT INTO client_default_roles VALUES ('c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', '3023f236-8fd7-4fbb-99cd-11c5f3bae9ce');


--
-- Data for Name: client_identity_prov_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_template; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_template_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO component VALUES ('4f566287-92ba-4133-9ca2-415f13cb6c97', 'Trusted Hosts', 'master', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO component VALUES ('924a76aa-d37c-4403-afb9-231d33737d0b', 'Consent Required', 'master', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO component VALUES ('fe19aab8-dfaa-49e2-a273-ee896344a2a1', 'Full Scope Disabled', 'master', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO component VALUES ('6865a00c-e5a2-4af5-8e44-0c89e9d28568', 'Max Clients Limit', 'master', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO component VALUES ('80f7776d-bceb-4534-bddd-41b070499f94', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO component VALUES ('e16ceffd-267c-4fac-a566-d429f651082f', 'Allowed Client Templates', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO component VALUES ('8d4a8036-0313-456c-a385-91f80bdb5e72', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO component VALUES ('bc8129be-415b-4b0c-8445-8b1376a5f442', 'Allowed Client Templates', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO component VALUES ('64650578-c2db-413d-9bdf-6261ec3be4df', 'rsa-generated', 'master', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO component VALUES ('67469bb9-353d-4948-ad7c-a4e071b1ca3e', 'hmac-generated', 'master', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO component VALUES ('97834432-768e-4960-b45e-f3bdc038f9b7', 'aes-generated', 'master', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO component_config VALUES ('8c579955-208b-4ce6-b7b4-ea30370ecda8', '6865a00c-e5a2-4af5-8e44-0c89e9d28568', 'max-clients', '200');
INSERT INTO component_config VALUES ('d8fe0e37-7f5b-475a-9c64-b67a4b36da70', '8d4a8036-0313-456c-a385-91f80bdb5e72', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO component_config VALUES ('d04d7f3f-dee9-46ab-acce-0227f8723735', '8d4a8036-0313-456c-a385-91f80bdb5e72', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO component_config VALUES ('b09a0860-7db1-440f-8064-c1c19906700a', '8d4a8036-0313-456c-a385-91f80bdb5e72', 'consent-required-for-all-mappers', 'true');
INSERT INTO component_config VALUES ('cbd3d563-db64-4344-a3ab-126f060df6e1', '8d4a8036-0313-456c-a385-91f80bdb5e72', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO component_config VALUES ('23fbda8b-f3e5-4120-aa2a-f351c7d48fca', '8d4a8036-0313-456c-a385-91f80bdb5e72', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO component_config VALUES ('e93a7684-2a3a-4266-88d4-2ad0168f7e28', '8d4a8036-0313-456c-a385-91f80bdb5e72', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO component_config VALUES ('b57987e4-10d3-4416-9de1-248c0485d3e2', '8d4a8036-0313-456c-a385-91f80bdb5e72', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO component_config VALUES ('d0adaa5c-b29d-4a50-8529-61dea34dd164', '8d4a8036-0313-456c-a385-91f80bdb5e72', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO component_config VALUES ('75ac7b97-8d11-4aac-ad6d-513d0a82a018', '8d4a8036-0313-456c-a385-91f80bdb5e72', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO component_config VALUES ('c2d6decc-c3d0-4dfa-a91d-a338fe6920a2', '4f566287-92ba-4133-9ca2-415f13cb6c97', 'client-uris-must-match', 'true');
INSERT INTO component_config VALUES ('9483222d-d3ac-4798-afc9-012542d843a6', '4f566287-92ba-4133-9ca2-415f13cb6c97', 'host-sending-registration-request-must-match', 'true');
INSERT INTO component_config VALUES ('8a0d5009-dbe9-4f01-94dd-b41cf97e99d0', '80f7776d-bceb-4534-bddd-41b070499f94', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO component_config VALUES ('3534edf3-b53d-4e6b-a168-bfa987da4227', '80f7776d-bceb-4534-bddd-41b070499f94', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO component_config VALUES ('95c490ae-4b41-445c-9a82-fe580ac63518', '80f7776d-bceb-4534-bddd-41b070499f94', 'consent-required-for-all-mappers', 'true');
INSERT INTO component_config VALUES ('00870c31-e15b-47d6-824b-5b7da8fd3386', '80f7776d-bceb-4534-bddd-41b070499f94', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO component_config VALUES ('678a757e-33ff-4b58-b26e-f2fc170d30d6', '80f7776d-bceb-4534-bddd-41b070499f94', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO component_config VALUES ('f4ba069f-4fda-4b65-a2bd-8e18cbe139de', '80f7776d-bceb-4534-bddd-41b070499f94', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO component_config VALUES ('8d56ca2d-1a2f-4ba8-be07-4f8cfc7e913d', '80f7776d-bceb-4534-bddd-41b070499f94', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO component_config VALUES ('27062706-367e-4665-82b5-a632fb25dabb', '80f7776d-bceb-4534-bddd-41b070499f94', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO component_config VALUES ('700037c8-200f-4743-9e6b-7d94fca9e72f', '80f7776d-bceb-4534-bddd-41b070499f94', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO component_config VALUES ('6e502eb4-003f-496b-9d6d-ae257bbf307c', '64650578-c2db-413d-9bdf-6261ec3be4df', 'priority', '100');
INSERT INTO component_config VALUES ('43e462d7-de16-459c-a9e2-ab3769f6928f', '64650578-c2db-413d-9bdf-6261ec3be4df', 'privateKey', 'MIIEogIBAAKCAQEArJwAlZVaoUNy2oObVlPtjb7KzKCYDODNpoyN1L6CZyZ62DEfN9g8hqKMN9ru7FHmMwqOU4HjUdre74GVHaM80P6BP/sr4Uq2MwFm3hAGVvBfDODwljh5alqwFUdGTXUZGNP0zTp2fiDpA82xkyIno2l4YPHWoNNfVfFqjOHyKEChqpiRLC5GajjIZUTdu6jkB0pRwfAL3e2Wlf3gdtrN0sh7JdRE2J1Uf+luLusWTeMWriOiLBQ5RtFUa5TJTnwEs+5MZF23RBgv4vxWbi0xGg8SzvUAf4hXuA4PaMW6S+Jwbx0qU2JjXyJzRfUuQHA+bzUeDgFY9FbTqtVPFGaTbQIDAQABAoIBACfdX8UsWWIlUcFl49psR9EU34GjFXrj8JsmmxsnZLauDHEh5zPenRv7Lqc3yTaLM79WEMj4lqexBQwLwYS2zrT2EqPUPq4psyrUiA2BZfVuToWK7gXDxUbq6v//Fh2Njd5OFZvQhM1cjHR0bS6uFLmJAmRhdlBugPY4a4NeK69f2xF6eIOD0y14/Ejy8G739ZRzsNOKQ09mFngwBYmiCsJ9n3qCHJz+/YoY/R1zrt7GPGEDInfDIxCXqnD1C35yDqaRZfg3Dyf5gv5i/di6/0CB6ePQpfeSihlMw1Pa3PKcp5vpyDFrL9nUFzAEh4Q2TWoxszlt1d7zGQKK5gRf5AECgYEA/rkZElBiW0YYlnzCsJNlhdeXuZbk7GQOYHGTmfH7z+Ebshh0MQ1SUxtaeH23YC0LWTpesGrvIKX7mAzuJzqvrAfK3D+NH3XKt0YflSYQOe2W4eTiApnnIayyHF3kJRgfBleiOhnCrhBS+ucPMJaFdGEFAS4jOz2pmrSUdKqoK4kCgYEArXmF0j3SB4iWjvdnxKsZE0mFCskqIKpsX0360kNBJnWXpOxVZyh1UEIUhUdg903y4iINaOkZ0WTZETJHb/Ry0pKzMTLv3ARHVQdh9dpdgc28NbBBXy29U5yP9tIVQaAd5Z3zj/fOxgBEFlbaOiIbM5YM+gw68r2Pl099U2Owu8UCgYAIgA7JIKuXlig95V3t3I1XwREMHW/4P4KHT2L4kS2xCzcMY2qFNIeZxGDpgnB7IiWtzZfZVUgzk7ZopY3Q+1FfcUcgwHIqKZkhMpLdPE7wT/BoC2ZLZe1jn0q2TZ/OaRan9IayX6eyfVL3knxcR7meX5p2Jp8AXBdr1TjbB9Li2QKBgBWOlGKb7A2jm5IIjIyT9nm/GRlOBj4o726ochLO6LmuwzlrZPF8xZdDnukxBYu11Ajl0mTHEr5CmfbZGKeA6QPh1wK2Ibhlj7exQysaB6SpvEmvrW/2byCExB8X3CxbiVuPVUT+tmNEhTGBeXzf4CF49APeoTSo+b8D0b8bFEtBAoGADqWcBEE+bO8XsNn0BRGXTQDUV7MNtwds+acJ/M6xJZQ06jb/hRldwDYjzvF3JZFU0uWN+GwOI1kh1rYmch2moEyLqKuAy5Cds63zp9akvgcGNoTAOPkBl/oOoiF+vM8B0hR+vDEaxdOMwEV0j9a0x3Rv7SlP+gl14IvkDMF2u8E=');
INSERT INTO component_config VALUES ('b262937a-1be5-41cb-be3a-9f40b1a4a35e', '64650578-c2db-413d-9bdf-6261ec3be4df', 'certificate', 'MIICmzCCAYMCBgFjpheQWzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMTgwNTI4MDkzMDUyWhcNMjgwNTI4MDkzMjMyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCsnACVlVqhQ3Lag5tWU+2NvsrMoJgM4M2mjI3UvoJnJnrYMR832DyGoow32u7sUeYzCo5TgeNR2t7vgZUdozzQ/oE/+yvhSrYzAWbeEAZW8F8M4PCWOHlqWrAVR0ZNdRkY0/TNOnZ+IOkDzbGTIiejaXhg8dag019V8WqM4fIoQKGqmJEsLkZqOMhlRN27qOQHSlHB8Avd7ZaV/eB22s3SyHsl1ETYnVR/6W4u6xZN4xauI6IsFDlG0VRrlMlOfASz7kxkXbdEGC/i/FZuLTEaDxLO9QB/iFe4Dg9oxbpL4nBvHSpTYmNfInNF9S5AcD5vNR4OAVj0VtOq1U8UZpNtAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACeLcczSHnd3DHjhlGIAHOOi4zD5hfegdofsLAkttinQ2/KCoyrlgQfw3rHoU7VG7Wfe7kwu6LagP72ycBbZU3XawLxvl8ufvFYj8tTLumH7b3J2S1zXH8pMNg6rf9ZBGDlLKTdssXdK2DXUpqjgxHbXrtwbFAbNQgVwAZwPuUlNePTkzjrpCHrn8OA8DG9cCmcfh62vRj07B2XtTXa9HP8K8lsqOBRfPVphXJ6+pVds2fZPStjVTJaXRCH62+bAiA9HC9Q9ad4k5upaZGqN5jz9IggoIZpDTVFd+7XhEI5nNmWoJHt7r7zUN2Qs4TbGW3ue60Ljb6At7XM/cLImL+Y=');
INSERT INTO component_config VALUES ('ecbd05fc-efb9-4868-8972-925c01a44514', '97834432-768e-4960-b45e-f3bdc038f9b7', 'priority', '100');
INSERT INTO component_config VALUES ('a0bf43da-679e-47be-91b2-b2fd4c39a8b3', '97834432-768e-4960-b45e-f3bdc038f9b7', 'kid', '7d7b6e98-95ef-4cc2-a39d-76c94fb43817');
INSERT INTO component_config VALUES ('075b50ba-a3f4-4c11-9938-2cfd0d0cc2b6', '97834432-768e-4960-b45e-f3bdc038f9b7', 'secret', 'iCMX8z4S-BO22mdO1XFTuw');
INSERT INTO component_config VALUES ('2f963e6f-9026-4f91-93aa-7b54e901cf7d', '67469bb9-353d-4948-ad7c-a4e071b1ca3e', 'kid', '2646ca2d-ceec-480d-996e-3de94d646e1c');
INSERT INTO component_config VALUES ('ea1cf171-557f-4b34-a870-06ed1c48ca98', '67469bb9-353d-4948-ad7c-a4e071b1ca3e', 'secret', 'elar8aiGR6l7WhLQNe7AHiQPcRwNEwwSDKhVJ-je2XQ');
INSERT INTO component_config VALUES ('835c12b5-aeea-4b28-92f0-9e406a6e7ee7', '67469bb9-353d-4948-ad7c-a4e071b1ca3e', 'priority', '100');


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', 'ff54ab95-0072-44f3-a615-936ac848475f');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '15e4d6dc-a9de-43b6-b01d-f816ef452bc7');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', 'e08f7c23-4d20-4706-a682-dc38b5f06d5e');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '25ac6b99-c227-4b29-88b9-18915fe55ad8');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', 'fd4f7779-0d91-43a8-be62-06e8a0dde5cb');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '04c6bef5-9415-4bb1-8bb5-33ff3d949d56');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', 'bb5f6814-178a-4fb4-b293-59beb317f0ab');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '2c107ce5-4a91-46f1-a813-f85ad63812fa');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '715a0f3e-63e7-4b94-aecb-ba9fded30c8a');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '19c290ec-8ad5-41a1-abbf-90a43f68665c');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '19093ea6-1471-40b2-b8fa-5c430ab967f2');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '12f29e02-da62-4c41-aa45-465b25e7201c');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '1ab19b62-5b34-4941-8178-a1f23a64da42');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '101a6ac0-238a-4f17-af38-c2c5ac89ef78');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', 'ac12b7a4-2a68-4636-b1bf-1d65743bff94');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '2731766b-c9a8-499a-9d77-273ec910b682');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '83bfa7f3-1d8b-4cdc-b350-a0d3fb8c034e');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', '903e1b84-bf33-4cc5-887d-d69fd975e3cb');
INSERT INTO composite_role VALUES ('25ac6b99-c227-4b29-88b9-18915fe55ad8', '903e1b84-bf33-4cc5-887d-d69fd975e3cb');
INSERT INTO composite_role VALUES ('25ac6b99-c227-4b29-88b9-18915fe55ad8', 'ac12b7a4-2a68-4636-b1bf-1d65743bff94');
INSERT INTO composite_role VALUES ('fd4f7779-0d91-43a8-be62-06e8a0dde5cb', '2731766b-c9a8-499a-9d77-273ec910b682');
INSERT INTO composite_role VALUES ('3023f236-8fd7-4fbb-99cd-11c5f3bae9ce', '6b7da9c3-9222-49d6-94fa-9a35feae628f');
INSERT INTO composite_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', 'f4b4db2b-bf06-487c-9264-320e6443f72e');


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO credential VALUES ('836cf4ae-2525-4d83-85a0-211d2696bc46', NULL, 27500, '\x71011a5bd18049142b63d53fb883ced4', 'password', '77mz0Iv2v8xBllYYGJ0M5rmqaDgaqJORY1SDBtCD10yQSLy1kB5ov4tcAYZdxvu8hSD9ad0zzjolqKErk6+95A==', 'a47d6459-35f7-4b7a-9ea1-fe723d7b3298', NULL, 0, 0, 0, 'pbkdf2-sha256');
INSERT INTO credential VALUES ('a3403581-9330-41ff-9be9-0aed1880dcdf', NULL, 27500, '\xb71a65070f2de8226e6e6dc6ce4d615d', 'password', 'tJc9mvKngETLWdZK/yY83xFX338+7lkb/H8njTFSVN/jlx1d9vJ9xcQD3TFQdocRk7irTdQcmICca5grmDpAyg==', 'ad794315-2dd9-41b2-9b75-41a25414d689', 1528106686162, 0, 0, 0, 'pbkdf2-sha256');


--
-- Data for Name: credential_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO databasechangelog VALUES ('1.0.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2018-05-28 09:32:24.037883', 1, 'EXECUTED', '7:00a57f7a6fb456639b34e62972e0ec02', 'createTable (x29), addPrimaryKey (x21), addUniqueConstraint (x9), addForeignKeyConstraint (x32)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.0.0.Final', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2018-05-28 09:32:24.184677', 2, 'MARK_RAN', '7:f061c3934594ee60a9b2343f5100ae4e', 'createTable (x29), addPrimaryKey (x21), addUniqueConstraint (x6), addForeignKeyConstraint (x30)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2018-05-28 09:32:24.290285', 3, 'EXECUTED', '7:0310eb8ba07cec616460794d42ade0fa', 'delete (x3), createTable (x3), addColumn (x5), addPrimaryKey (x3), addForeignKeyConstraint (x3), customChange', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2018-05-28 09:32:24.309693', 4, 'EXECUTED', '7:5d25857e708c3233ef4439df1f93f012', 'renameColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2018-05-28 09:32:24.411521', 5, 'EXECUTED', '7:c7a54a1041d58eb3817a4a883b4d4e84', 'delete (x4), createTable (x8), addColumn (x2), addPrimaryKey (x6), addForeignKeyConstraint (x9), addUniqueConstraint (x2), addColumn, dropForeignKeyConstraint (x2), dropUniqueConstraint, renameColumn (x3), addUniqueConstraint, addForeignKeyConstra...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2018-05-28 09:32:24.427102', 6, 'MARK_RAN', '7:2e01012df20974c1c2a605ef8afe25b7', 'delete (x4), createTable (x8), addColumn (x2), addPrimaryKey (x6), addForeignKeyConstraint (x9), addUniqueConstraint (x2), addColumn, dropForeignKeyConstraint (x2), dropUniqueConstraint, renameColumn (x3), customChange, dropForeignKeyConstraint, d...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2018-05-28 09:32:24.557009', 7, 'EXECUTED', '7:0f08df48468428e0f30ee59a8ec01a41', 'delete (x5), createTable (x3), addColumn, createTable (x4), addPrimaryKey (x7), addForeignKeyConstraint (x6), renameColumn, addColumn (x2), update, dropColumn, dropForeignKeyConstraint, renameColumn, addForeignKeyConstraint, dropForeignKeyConstrai...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2018-05-28 09:32:24.5885', 8, 'MARK_RAN', '7:a77ea2ad226b345e7d689d366f185c8c', 'delete (x5), createTable (x3), addColumn, createTable (x4), addPrimaryKey (x7), addForeignKeyConstraint (x6), renameColumn, addUniqueConstraint, addColumn (x2), update, dropColumn, dropForeignKeyConstraint, renameColumn, addForeignKeyConstraint, r...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2018-05-28 09:32:24.633753', 9, 'EXECUTED', '7:a3377a2059aefbf3b90ebb4c4cc8e2ab', 'update (x3)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2018-05-28 09:32:24.758444', 10, 'EXECUTED', '7:04c1dbedc2aa3e9756d1a1668e003451', 'delete (x6), createTable (x7), addColumn, createTable, addColumn (x2), update, dropDefaultValue, dropColumn, addColumn, update (x4), addPrimaryKey (x4), dropPrimaryKey, dropColumn, addPrimaryKey (x4), addForeignKeyConstraint (x8), dropDefaultValue...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2018-05-28 09:32:24.8671', 11, 'EXECUTED', '7:36ef39ed560ad07062d956db861042ba', 'delete (x7), addColumn (x5), dropColumn, renameTable (x2), update (x10), createTable (x3), customChange, dropPrimaryKey, addPrimaryKey (x4), addForeignKeyConstraint (x2), dropColumn, addColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2018-05-28 09:32:24.875471', 12, 'MARK_RAN', '7:d909180b2530479a716d3f9c9eaea3d7', 'delete (x7), addColumn (x5), dropColumn, renameTable, dropForeignKeyConstraint, renameTable, addForeignKeyConstraint, update (x10), createTable (x3), customChange, dropPrimaryKey, addPrimaryKey (x4), addForeignKeyConstraint (x2), dropColumn, addCo...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2018-05-28 09:32:24.950517', 13, 'EXECUTED', '7:cf12b04b79bea5152f165eb41f3955f6', 'delete (x7), dropDefaultValue, dropColumn, addColumn (x3)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2018-05-28 09:32:24.984038', 14, 'EXECUTED', '7:7e32c8f05c755e8675764e7d5f514509', 'addColumn (x3), createTable (x2), addPrimaryKey (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2018-05-28 09:32:24.986605', 15, 'MARK_RAN', '7:980ba23cc0ec39cab731ce903dd01291', 'delete (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2018-05-28 09:32:24.989244', 16, 'MARK_RAN', '7:2fa220758991285312eb84f3b4ff5336', 'dropPrimaryKey (x2), addColumn, update, dropColumn, addColumn, update, dropColumn, addPrimaryKey (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2018-05-28 09:32:24.991803', 17, 'EXECUTED', '7:d41d8cd98f00b204e9800998ecf8427e', 'Empty', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2018-05-28 09:32:25.050575', 18, 'EXECUTED', '7:91ace540896df890cc00a0490ee52bbc', 'createTable (x5), addColumn (x2), dropDefaultValue, dropColumn, addPrimaryKey, addForeignKeyConstraint, addPrimaryKey, addForeignKeyConstraint, addPrimaryKey, addForeignKeyConstraint, addPrimaryKey, addForeignKeyConstraint (x2), addUniqueConstrain...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2018-05-28 09:32:25.107147', 19, 'EXECUTED', '7:c31d1646dfa2618a9335c00e07f89f24', 'addColumn, createTable (x3), dropNotNullConstraint, addColumn (x2), createTable, addPrimaryKey, addUniqueConstraint, addForeignKeyConstraint (x5), addPrimaryKey, addForeignKeyConstraint (x2), addPrimaryKey, addForeignKeyConstraint, update', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2018-05-28 09:32:25.113692', 20, 'EXECUTED', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue, update', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2018-05-28 09:32:25.118149', 21, 'MARK_RAN', '7:f987971fe6b37d963bc95fee2b27f8df', 'addColumn, createTable (x3), dropNotNullConstraint, addColumn (x2), createTable, addPrimaryKey, addUniqueConstraint, addForeignKeyConstraint (x5), addPrimaryKey, addForeignKeyConstraint (x2), addPrimaryKey, addForeignKeyConstraint, update', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2018-05-28 09:32:25.123606', 22, 'MARK_RAN', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue, update', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2018-05-28 09:32:25.148788', 23, 'EXECUTED', '7:ed2dc7f799d19ac452cbcda56c929e47', 'update (x9), customChange, dropForeignKeyConstraint (x2), dropUniqueConstraint, dropTable, dropForeignKeyConstraint (x2), dropTable, dropForeignKeyConstraint (x2), dropUniqueConstraint, dropTable, createIndex', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2018-05-28 09:32:25.153975', 24, 'EXECUTED', '7:80b5db88a5dda36ece5f235be8757615', 'modifyDataType (x3)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2018-05-28 09:32:25.155824', 25, 'MARK_RAN', '7:1437310ed1305a9b93f8848f301726ce', 'modifyDataType (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2018-05-28 09:32:25.178676', 26, 'EXECUTED', '7:b82ffb34850fa0836be16deefc6a87c4', 'createIndex (x11)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2018-05-28 09:32:25.235017', 27, 'EXECUTED', '7:9cc98082921330d8d9266decdd4bd658', 'createTable, addPrimaryKey, addUniqueConstraint, createTable, addPrimaryKey, addForeignKeyConstraint, addUniqueConstraint, createTable, addPrimaryKey, addForeignKeyConstraint, addUniqueConstraint, createTable, addPrimaryKey, addForeignKeyConstrain...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2018-05-28 09:32:25.242051', 28, 'EXECUTED', '7:03d64aeed9cb52b969bd30a7ac0db57e', 'update', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.1.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2018-05-28 09:32:25.29999', 29, 'EXECUTED', '7:e01599a82bf8d6dc22a9da506e22e868', 'createTable (x11), addPrimaryKey (x11), addForeignKeyConstraint (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2018-05-28 09:32:25.316126', 30, 'EXECUTED', '7:53188c3eb1107546e6f765835705b6c1', 'addColumn, createTable (x2), modifyDataType, addForeignKeyConstraint (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2018-05-28 09:32:25.341606', 31, 'EXECUTED', '7:d6e6f3bc57a0c5586737d1351725d4d4', 'createTable, addPrimaryKey, dropDefaultValue, dropColumn, addColumn (x2), customChange, dropColumn (x4), addColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2018-05-28 09:32:25.347561', 32, 'EXECUTED', '7:454d604fbd755d9df3fd9c6329043aa5', 'customChange', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2018-05-28 09:32:25.352302', 33, 'EXECUTED', '7:57e98a3077e29caf562f7dbf80c72600', 'customChange, modifyDataType', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2018-05-28 09:32:25.35552', 34, 'MARK_RAN', '7:e4c7e8f2256210aee71ddc42f538b57a', 'modifyDataType (x13), addColumn, sql, dropColumn, renameColumn, modifyDataType (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2018-05-28 09:32:25.377569', 35, 'EXECUTED', '7:09a43c97e49bc626460480aa1379b522', 'modifyDataType (x5), dropUniqueConstraint, modifyDataType (x3), addUniqueConstraint, dropPrimaryKey, modifyDataType, addNotNullConstraint, addPrimaryKey, modifyDataType (x5), dropUniqueConstraint, modifyDataType, addUniqueConstraint, modifyDataType', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2018-05-28 09:32:25.393929', 36, 'EXECUTED', '7:26bfc7c74fefa9126f2ce702fb775553', 'addColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2018-05-28 09:32:25.398393', 37, 'EXECUTED', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2018-05-28 09:32:25.401817', 38, 'EXECUTED', '7:37fc1781855ac5388c494f1442b3f717', 'addColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2018-05-28 09:32:25.425939', 39, 'EXECUTED', '7:13a27db0dae6049541136adad7261d27', 'addColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2018-05-28 09:32:25.436235', 40, 'MARK_RAN', '7:550300617e3b59e8af3a6294df8248a3', 'addNotNullConstraint', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2018-05-28 09:32:25.442653', 41, 'MARK_RAN', '7:e3a9482b8931481dc2772a5c07c44f17', 'dropIndex, addNotNullConstraint, createIndex', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2018-05-28 09:32:25.582766', 42, 'EXECUTED', '7:a72a7858967bd414835d19e04d880312', 'addColumn, dropPrimaryKey, dropColumn, addPrimaryKey, createTable, addPrimaryKey, addForeignKeyConstraint, createIndex (x45)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2018-05-28 09:32:25.616794', 43, 'EXECUTED', '7:94edff7cf9ce179e7e85f0cd78a3cf2c', 'addColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2018-05-28 09:32:25.62097', 44, 'EXECUTED', '7:6a48ce645a3525488a90fbf76adf3bb3', 'addColumn (x3)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2018-05-28 09:32:25.6383', 45, 'EXECUTED', '7:e64b5dcea7db06077c6e57d3b9e5ca14', 'customChange', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2018-05-28 09:32:25.640642', 46, 'MARK_RAN', '7:fd8cf02498f8b1e72496a20afc75178c', 'dropIndex (x3)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2018-05-28 09:32:25.677577', 47, 'EXECUTED', '7:542794f25aa2b1fbabb7e577d6646319', 'addNotNullConstraint (x3), dropUniqueConstraint (x3), dropForeignKeyConstraint, dropColumn, dropForeignKeyConstraint, dropColumn, dropForeignKeyConstraint, dropColumn, dropPrimaryKey, dropUniqueConstraint, dropColumn, renameColumn (x4), addUniqueC...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2018-05-28 09:32:25.692897', 48, 'EXECUTED', '7:edad604c882df12f74941dac3cc6d650', 'addColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2018-05-28 09:32:25.729047', 49, 'EXECUTED', '7:0f88b78b7b46480eb92690cbf5e44900', 'addPrimaryKey (x7), dropForeignKeyConstraint, addPrimaryKey, addForeignKeyConstraint, addNotNullConstraint, addPrimaryKey, addNotNullConstraint, addPrimaryKey, addNotNullConstraint, addPrimaryKey, addNotNullConstraint, addPrimaryKey, addNotNullCon...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2018-05-28 09:32:25.765905', 50, 'EXECUTED', '7:d560e43982611d936457c327f872dd59', 'createIndex (x11)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2018-05-28 09:32:25.76932', 51, 'EXECUTED', '7:c155566c42b4d14ef07059ec3b3bbd8e', 'modifyDataType', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2018-05-28 09:32:25.777335', 52, 'EXECUTED', '7:b40376581f12d70f3c89ba8ddf5b7dea', 'update', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2018-05-28 09:32:25.779627', 53, 'EXECUTED', '7:a1132cc395f7b95b3646146c2e38f168', 'update', '', NULL, '3.4.1', NULL, NULL);


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO databasechangeloglock VALUES (1, false, NULL, NULL);


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_credential_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_consent_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_consent_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO keycloak_role VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', 'master', false, '${role_admin}', 'admin', 'master', NULL, 'master', false);
INSERT INTO keycloak_role VALUES ('ff54ab95-0072-44f3-a615-936ac848475f', 'master', false, '${role_create-realm}', 'create-realm', 'master', NULL, 'master', false);
INSERT INTO keycloak_role VALUES ('15e4d6dc-a9de-43b6-b01d-f816ef452bc7', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_create-client}', 'create-client', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('e08f7c23-4d20-4706-a682-dc38b5f06d5e', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_view-realm}', 'view-realm', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('25ac6b99-c227-4b29-88b9-18915fe55ad8', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_view-users}', 'view-users', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('fd4f7779-0d91-43a8-be62-06e8a0dde5cb', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_view-clients}', 'view-clients', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('04c6bef5-9415-4bb1-8bb5-33ff3d949d56', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_view-events}', 'view-events', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('bb5f6814-178a-4fb4-b293-59beb317f0ab', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('2c107ce5-4a91-46f1-a813-f85ad63812fa', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_view-authorization}', 'view-authorization', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('715a0f3e-63e7-4b94-aecb-ba9fded30c8a', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_manage-realm}', 'manage-realm', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('19c290ec-8ad5-41a1-abbf-90a43f68665c', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_manage-users}', 'manage-users', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('19093ea6-1471-40b2-b8fa-5c430ab967f2', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_manage-clients}', 'manage-clients', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('12f29e02-da62-4c41-aa45-465b25e7201c', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_manage-events}', 'manage-events', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('1ab19b62-5b34-4941-8178-a1f23a64da42', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('101a6ac0-238a-4f17-af38-c2c5ac89ef78', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_manage-authorization}', 'manage-authorization', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('ac12b7a4-2a68-4636-b1bf-1d65743bff94', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_query-users}', 'query-users', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('2731766b-c9a8-499a-9d77-273ec910b682', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_query-clients}', 'query-clients', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('83bfa7f3-1d8b-4cdc-b350-a0d3fb8c034e', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_query-realms}', 'query-realms', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('903e1b84-bf33-4cc5-887d-d69fd975e3cb', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_query-groups}', 'query-groups', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('4d30dbf3-f4fe-4308-be40-58ba7aff657d', 'c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', true, '${role_view-profile}', 'view-profile', 'master', 'c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', NULL, false);
INSERT INTO keycloak_role VALUES ('3023f236-8fd7-4fbb-99cd-11c5f3bae9ce', 'c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', true, '${role_manage-account}', 'manage-account', 'master', 'c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', NULL, false);
INSERT INTO keycloak_role VALUES ('6b7da9c3-9222-49d6-94fa-9a35feae628f', 'c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', true, '${role_manage-account-links}', 'manage-account-links', 'master', 'c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', NULL, false);
INSERT INTO keycloak_role VALUES ('b99088b5-08f2-4b7a-8c17-af76e8bba8b0', '9b65be77-1ef3-4b2e-b27b-b13e908c8536', true, '${role_read-token}', 'read-token', 'master', '9b65be77-1ef3-4b2e-b27b-b13e908c8536', NULL, false);
INSERT INTO keycloak_role VALUES ('f4b4db2b-bf06-487c-9264-320e6443f72e', 'a3d7e809-8221-47af-902b-21d17c33e2ad', true, '${role_impersonation}', 'impersonation', 'master', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL, false);
INSERT INTO keycloak_role VALUES ('79df5b84-bcc6-43a4-9eab-238d1bb42bf7', 'master', false, '${role_offline-access}', 'offline_access', 'master', NULL, 'master', true);
INSERT INTO keycloak_role VALUES ('9bfff960-50af-45ed-95f7-28ea575569f7', 'master', false, '${role_uma_authorization}', 'uma_authorization', 'master', NULL, 'master', false);


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO migration_model VALUES ('SINGLETON', '3.4.2');


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO protocol_mapper VALUES ('ebb80ab6-071b-437c-ac67-4d9658959b6c', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL);
INSERT INTO protocol_mapper VALUES ('72610978-402f-4f74-90ae-9250848f0bd9', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL);
INSERT INTO protocol_mapper VALUES ('3ca35758-0e8a-44a2-9c16-9b6ce7fdd1cb', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL);
INSERT INTO protocol_mapper VALUES ('7e218412-ef71-4e10-92f1-c8f1d1b485ad', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL);
INSERT INTO protocol_mapper VALUES ('7c23e20d-b7bd-4a53-9e40-9d8ea5d5459b', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL);
INSERT INTO protocol_mapper VALUES ('0f113882-675b-4bcd-8f19-a59bd061f16d', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'a3d7e809-8221-47af-902b-21d17c33e2ad', NULL);
INSERT INTO protocol_mapper VALUES ('cb8b5a6e-c352-4072-91cb-d14fa5d44c0e', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', NULL);
INSERT INTO protocol_mapper VALUES ('9891551f-aee3-425a-80d7-e3aeb40ff75a', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', NULL);
INSERT INTO protocol_mapper VALUES ('ad57cab1-188e-445c-a013-c2281a7e7b81', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', NULL);
INSERT INTO protocol_mapper VALUES ('b67f51f4-f10f-41a4-be3d-d8df1dca8665', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', NULL);
INSERT INTO protocol_mapper VALUES ('53c99177-cc8b-48de-843e-8e111a0e5f4b', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', NULL);
INSERT INTO protocol_mapper VALUES ('df07793b-e481-4303-a6c3-422f6f7165cf', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', NULL);
INSERT INTO protocol_mapper VALUES ('1cb3f13a-f488-41c0-ace6-423cf921066e', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '9b65be77-1ef3-4b2e-b27b-b13e908c8536', NULL);
INSERT INTO protocol_mapper VALUES ('d96410ae-7a88-4d2c-bfbd-5cee19daea67', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '9b65be77-1ef3-4b2e-b27b-b13e908c8536', NULL);
INSERT INTO protocol_mapper VALUES ('1781a549-c9e4-432b-8c2d-3cf05f7df158', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '9b65be77-1ef3-4b2e-b27b-b13e908c8536', NULL);
INSERT INTO protocol_mapper VALUES ('44a60fdb-3299-46c9-bca8-c75f6e20b7ca', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '9b65be77-1ef3-4b2e-b27b-b13e908c8536', NULL);
INSERT INTO protocol_mapper VALUES ('c30a00ca-e607-4b7b-92ce-b18f93c00d3d', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '9b65be77-1ef3-4b2e-b27b-b13e908c8536', NULL);
INSERT INTO protocol_mapper VALUES ('965c4b14-17d3-486f-8b97-b5c99cefdab1', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '9b65be77-1ef3-4b2e-b27b-b13e908c8536', NULL);
INSERT INTO protocol_mapper VALUES ('dc80ba80-27f9-4474-aec8-907e218dc2df', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'a7f35ea7-017e-4463-995c-137fe9f6fd43', NULL);
INSERT INTO protocol_mapper VALUES ('9064e6ad-5753-4db7-8686-c68a786b2256', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'a7f35ea7-017e-4463-995c-137fe9f6fd43', NULL);
INSERT INTO protocol_mapper VALUES ('1a415351-7c00-4bb5-95f6-802d7d19d36d', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'a7f35ea7-017e-4463-995c-137fe9f6fd43', NULL);
INSERT INTO protocol_mapper VALUES ('8ebc494c-f894-48f0-b6df-75b5295fc90c', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'a7f35ea7-017e-4463-995c-137fe9f6fd43', NULL);
INSERT INTO protocol_mapper VALUES ('6d7c9cbf-8e25-4098-8340-591fa79fa7ec', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'a7f35ea7-017e-4463-995c-137fe9f6fd43', NULL);
INSERT INTO protocol_mapper VALUES ('98253612-c34d-4988-890b-377ae9b1ea01', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'a7f35ea7-017e-4463-995c-137fe9f6fd43', NULL);
INSERT INTO protocol_mapper VALUES ('207ac33e-252a-443c-b5a2-4878312c73b7', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', false, '${locale}', 'a7f35ea7-017e-4463-995c-137fe9f6fd43', NULL);
INSERT INTO protocol_mapper VALUES ('e0352c54-f216-45a8-a92f-561bde59e39b', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '390082ea-2f59-42a5-ae2d-189b40334cf4', NULL);
INSERT INTO protocol_mapper VALUES ('850b163d-ebd7-4155-9dbb-8aa3638e845d', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '390082ea-2f59-42a5-ae2d-189b40334cf4', NULL);
INSERT INTO protocol_mapper VALUES ('372e6c50-3104-4b7d-8133-48221aae7f6b', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '390082ea-2f59-42a5-ae2d-189b40334cf4', NULL);
INSERT INTO protocol_mapper VALUES ('aeeb31d2-f60a-4954-be1b-3e00f0095704', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '390082ea-2f59-42a5-ae2d-189b40334cf4', NULL);
INSERT INTO protocol_mapper VALUES ('66bce5a4-1d01-439b-837e-96384478757c', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '390082ea-2f59-42a5-ae2d-189b40334cf4', NULL);
INSERT INTO protocol_mapper VALUES ('6e898aa7-0f1d-4c65-8157-e010b604e758', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '390082ea-2f59-42a5-ae2d-189b40334cf4', NULL);
INSERT INTO protocol_mapper VALUES ('1c94508b-4817-420c-b5a4-9d51055f4e16', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', NULL);
INSERT INTO protocol_mapper VALUES ('be086d1b-2520-45e6-b04f-c7fc1495a55f', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', NULL);
INSERT INTO protocol_mapper VALUES ('b7434262-d402-4a5f-be3a-acba2bebed5a', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', NULL);
INSERT INTO protocol_mapper VALUES ('d1eb5b91-8815-433d-b36f-628832432564', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', NULL);
INSERT INTO protocol_mapper VALUES ('c160351a-42bb-4019-93cd-025976f7a0b8', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', NULL);
INSERT INTO protocol_mapper VALUES ('e2d1cadd-ef34-4239-ae49-f161cfdb5be4', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', NULL);


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO protocol_mapper_config VALUES ('ebb80ab6-071b-437c-ac67-4d9658959b6c', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('ebb80ab6-071b-437c-ac67-4d9658959b6c', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('ebb80ab6-071b-437c-ac67-4d9658959b6c', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('72610978-402f-4f74-90ae-9250848f0bd9', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('72610978-402f-4f74-90ae-9250848f0bd9', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('72610978-402f-4f74-90ae-9250848f0bd9', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('72610978-402f-4f74-90ae-9250848f0bd9', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('72610978-402f-4f74-90ae-9250848f0bd9', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('72610978-402f-4f74-90ae-9250848f0bd9', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('3ca35758-0e8a-44a2-9c16-9b6ce7fdd1cb', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3ca35758-0e8a-44a2-9c16-9b6ce7fdd1cb', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('3ca35758-0e8a-44a2-9c16-9b6ce7fdd1cb', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3ca35758-0e8a-44a2-9c16-9b6ce7fdd1cb', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3ca35758-0e8a-44a2-9c16-9b6ce7fdd1cb', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('3ca35758-0e8a-44a2-9c16-9b6ce7fdd1cb', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('7e218412-ef71-4e10-92f1-c8f1d1b485ad', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7e218412-ef71-4e10-92f1-c8f1d1b485ad', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('7e218412-ef71-4e10-92f1-c8f1d1b485ad', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7e218412-ef71-4e10-92f1-c8f1d1b485ad', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7e218412-ef71-4e10-92f1-c8f1d1b485ad', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('7e218412-ef71-4e10-92f1-c8f1d1b485ad', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('7c23e20d-b7bd-4a53-9e40-9d8ea5d5459b', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7c23e20d-b7bd-4a53-9e40-9d8ea5d5459b', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('7c23e20d-b7bd-4a53-9e40-9d8ea5d5459b', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7c23e20d-b7bd-4a53-9e40-9d8ea5d5459b', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7c23e20d-b7bd-4a53-9e40-9d8ea5d5459b', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('7c23e20d-b7bd-4a53-9e40-9d8ea5d5459b', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('0f113882-675b-4bcd-8f19-a59bd061f16d', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0f113882-675b-4bcd-8f19-a59bd061f16d', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('cb8b5a6e-c352-4072-91cb-d14fa5d44c0e', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('cb8b5a6e-c352-4072-91cb-d14fa5d44c0e', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('cb8b5a6e-c352-4072-91cb-d14fa5d44c0e', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('9891551f-aee3-425a-80d7-e3aeb40ff75a', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9891551f-aee3-425a-80d7-e3aeb40ff75a', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('9891551f-aee3-425a-80d7-e3aeb40ff75a', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9891551f-aee3-425a-80d7-e3aeb40ff75a', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9891551f-aee3-425a-80d7-e3aeb40ff75a', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('9891551f-aee3-425a-80d7-e3aeb40ff75a', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('ad57cab1-188e-445c-a013-c2281a7e7b81', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('ad57cab1-188e-445c-a013-c2281a7e7b81', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('ad57cab1-188e-445c-a013-c2281a7e7b81', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('ad57cab1-188e-445c-a013-c2281a7e7b81', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('ad57cab1-188e-445c-a013-c2281a7e7b81', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('ad57cab1-188e-445c-a013-c2281a7e7b81', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('b67f51f4-f10f-41a4-be3d-d8df1dca8665', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b67f51f4-f10f-41a4-be3d-d8df1dca8665', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b67f51f4-f10f-41a4-be3d-d8df1dca8665', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b67f51f4-f10f-41a4-be3d-d8df1dca8665', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b67f51f4-f10f-41a4-be3d-d8df1dca8665', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b67f51f4-f10f-41a4-be3d-d8df1dca8665', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('53c99177-cc8b-48de-843e-8e111a0e5f4b', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('53c99177-cc8b-48de-843e-8e111a0e5f4b', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('53c99177-cc8b-48de-843e-8e111a0e5f4b', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('53c99177-cc8b-48de-843e-8e111a0e5f4b', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('53c99177-cc8b-48de-843e-8e111a0e5f4b', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('53c99177-cc8b-48de-843e-8e111a0e5f4b', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('df07793b-e481-4303-a6c3-422f6f7165cf', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('df07793b-e481-4303-a6c3-422f6f7165cf', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1cb3f13a-f488-41c0-ace6-423cf921066e', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('1cb3f13a-f488-41c0-ace6-423cf921066e', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('1cb3f13a-f488-41c0-ace6-423cf921066e', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('d96410ae-7a88-4d2c-bfbd-5cee19daea67', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d96410ae-7a88-4d2c-bfbd-5cee19daea67', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('d96410ae-7a88-4d2c-bfbd-5cee19daea67', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d96410ae-7a88-4d2c-bfbd-5cee19daea67', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d96410ae-7a88-4d2c-bfbd-5cee19daea67', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('d96410ae-7a88-4d2c-bfbd-5cee19daea67', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('1781a549-c9e4-432b-8c2d-3cf05f7df158', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1781a549-c9e4-432b-8c2d-3cf05f7df158', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('1781a549-c9e4-432b-8c2d-3cf05f7df158', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1781a549-c9e4-432b-8c2d-3cf05f7df158', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1781a549-c9e4-432b-8c2d-3cf05f7df158', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('1781a549-c9e4-432b-8c2d-3cf05f7df158', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('44a60fdb-3299-46c9-bca8-c75f6e20b7ca', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('44a60fdb-3299-46c9-bca8-c75f6e20b7ca', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('44a60fdb-3299-46c9-bca8-c75f6e20b7ca', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('44a60fdb-3299-46c9-bca8-c75f6e20b7ca', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('44a60fdb-3299-46c9-bca8-c75f6e20b7ca', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('44a60fdb-3299-46c9-bca8-c75f6e20b7ca', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('c30a00ca-e607-4b7b-92ce-b18f93c00d3d', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c30a00ca-e607-4b7b-92ce-b18f93c00d3d', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('c30a00ca-e607-4b7b-92ce-b18f93c00d3d', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c30a00ca-e607-4b7b-92ce-b18f93c00d3d', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c30a00ca-e607-4b7b-92ce-b18f93c00d3d', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('c30a00ca-e607-4b7b-92ce-b18f93c00d3d', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('965c4b14-17d3-486f-8b97-b5c99cefdab1', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('965c4b14-17d3-486f-8b97-b5c99cefdab1', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('dc80ba80-27f9-4474-aec8-907e218dc2df', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('dc80ba80-27f9-4474-aec8-907e218dc2df', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('dc80ba80-27f9-4474-aec8-907e218dc2df', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('9064e6ad-5753-4db7-8686-c68a786b2256', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9064e6ad-5753-4db7-8686-c68a786b2256', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('9064e6ad-5753-4db7-8686-c68a786b2256', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9064e6ad-5753-4db7-8686-c68a786b2256', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9064e6ad-5753-4db7-8686-c68a786b2256', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('9064e6ad-5753-4db7-8686-c68a786b2256', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('1a415351-7c00-4bb5-95f6-802d7d19d36d', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1a415351-7c00-4bb5-95f6-802d7d19d36d', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('1a415351-7c00-4bb5-95f6-802d7d19d36d', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1a415351-7c00-4bb5-95f6-802d7d19d36d', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1a415351-7c00-4bb5-95f6-802d7d19d36d', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('1a415351-7c00-4bb5-95f6-802d7d19d36d', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('8ebc494c-f894-48f0-b6df-75b5295fc90c', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8ebc494c-f894-48f0-b6df-75b5295fc90c', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('8ebc494c-f894-48f0-b6df-75b5295fc90c', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8ebc494c-f894-48f0-b6df-75b5295fc90c', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8ebc494c-f894-48f0-b6df-75b5295fc90c', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('8ebc494c-f894-48f0-b6df-75b5295fc90c', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('6d7c9cbf-8e25-4098-8340-591fa79fa7ec', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('6d7c9cbf-8e25-4098-8340-591fa79fa7ec', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('6d7c9cbf-8e25-4098-8340-591fa79fa7ec', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('6d7c9cbf-8e25-4098-8340-591fa79fa7ec', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('6d7c9cbf-8e25-4098-8340-591fa79fa7ec', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('6d7c9cbf-8e25-4098-8340-591fa79fa7ec', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('98253612-c34d-4988-890b-377ae9b1ea01', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('98253612-c34d-4988-890b-377ae9b1ea01', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('207ac33e-252a-443c-b5a2-4878312c73b7', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('207ac33e-252a-443c-b5a2-4878312c73b7', 'locale', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('207ac33e-252a-443c-b5a2-4878312c73b7', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('207ac33e-252a-443c-b5a2-4878312c73b7', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('207ac33e-252a-443c-b5a2-4878312c73b7', 'locale', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('207ac33e-252a-443c-b5a2-4878312c73b7', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('e0352c54-f216-45a8-a92f-561bde59e39b', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('e0352c54-f216-45a8-a92f-561bde59e39b', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('e0352c54-f216-45a8-a92f-561bde59e39b', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('850b163d-ebd7-4155-9dbb-8aa3638e845d', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('850b163d-ebd7-4155-9dbb-8aa3638e845d', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('850b163d-ebd7-4155-9dbb-8aa3638e845d', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('850b163d-ebd7-4155-9dbb-8aa3638e845d', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('850b163d-ebd7-4155-9dbb-8aa3638e845d', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('850b163d-ebd7-4155-9dbb-8aa3638e845d', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('372e6c50-3104-4b7d-8133-48221aae7f6b', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('372e6c50-3104-4b7d-8133-48221aae7f6b', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('372e6c50-3104-4b7d-8133-48221aae7f6b', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('372e6c50-3104-4b7d-8133-48221aae7f6b', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('372e6c50-3104-4b7d-8133-48221aae7f6b', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('372e6c50-3104-4b7d-8133-48221aae7f6b', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('aeeb31d2-f60a-4954-be1b-3e00f0095704', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('aeeb31d2-f60a-4954-be1b-3e00f0095704', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('aeeb31d2-f60a-4954-be1b-3e00f0095704', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('aeeb31d2-f60a-4954-be1b-3e00f0095704', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('aeeb31d2-f60a-4954-be1b-3e00f0095704', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('aeeb31d2-f60a-4954-be1b-3e00f0095704', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('66bce5a4-1d01-439b-837e-96384478757c', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('66bce5a4-1d01-439b-837e-96384478757c', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('66bce5a4-1d01-439b-837e-96384478757c', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('66bce5a4-1d01-439b-837e-96384478757c', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('66bce5a4-1d01-439b-837e-96384478757c', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('66bce5a4-1d01-439b-837e-96384478757c', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('6e898aa7-0f1d-4c65-8157-e010b604e758', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('6e898aa7-0f1d-4c65-8157-e010b604e758', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1c94508b-4817-420c-b5a4-9d51055f4e16', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('1c94508b-4817-420c-b5a4-9d51055f4e16', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('1c94508b-4817-420c-b5a4-9d51055f4e16', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('be086d1b-2520-45e6-b04f-c7fc1495a55f', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('be086d1b-2520-45e6-b04f-c7fc1495a55f', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('be086d1b-2520-45e6-b04f-c7fc1495a55f', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('be086d1b-2520-45e6-b04f-c7fc1495a55f', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('be086d1b-2520-45e6-b04f-c7fc1495a55f', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('be086d1b-2520-45e6-b04f-c7fc1495a55f', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('b7434262-d402-4a5f-be3a-acba2bebed5a', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b7434262-d402-4a5f-be3a-acba2bebed5a', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b7434262-d402-4a5f-be3a-acba2bebed5a', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b7434262-d402-4a5f-be3a-acba2bebed5a', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b7434262-d402-4a5f-be3a-acba2bebed5a', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b7434262-d402-4a5f-be3a-acba2bebed5a', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('d1eb5b91-8815-433d-b36f-628832432564', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d1eb5b91-8815-433d-b36f-628832432564', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('d1eb5b91-8815-433d-b36f-628832432564', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d1eb5b91-8815-433d-b36f-628832432564', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d1eb5b91-8815-433d-b36f-628832432564', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('d1eb5b91-8815-433d-b36f-628832432564', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('c160351a-42bb-4019-93cd-025976f7a0b8', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c160351a-42bb-4019-93cd-025976f7a0b8', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('c160351a-42bb-4019-93cd-025976f7a0b8', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c160351a-42bb-4019-93cd-025976f7a0b8', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c160351a-42bb-4019-93cd-025976f7a0b8', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('c160351a-42bb-4019-93cd-025976f7a0b8', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('e2d1cadd-ef34-4239-ae49-f161cfdb5be4', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e2d1cadd-ef34-4239-ae49-f161cfdb5be4', 'true', 'access.token.claim');


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO realm VALUES ('master', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'a3d7e809-8221-47af-902b-21d17c33e2ad', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '7f9ebc0f-d271-4922-87d7-f639c4983865', '90d8ee07-fcaa-4e47-bf9d-32d9fb8d2d74', '4f09ffad-2003-4f45-9d22-9637e4e65b1a', '5a26dd99-f4a2-4502-a359-24f7cb211b03', '937d2eac-4765-4b47-bdc2-542aeef4155a', 2592000, false, 900, true, false, '3ce52383-e86b-4995-8c85-9a41515a381a', 0);


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'nosniff', 'master');
INSERT INTO realm_attribute VALUES ('_browser_header.xRobotsTag', 'none', 'master');
INSERT INTO realm_attribute VALUES ('_browser_header.xFrameOptions', 'SAMEORIGIN', 'master');
INSERT INTO realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';', 'master');
INSERT INTO realm_attribute VALUES ('_browser_header.xXSSProtection', '1; mode=block', 'master');
INSERT INTO realm_attribute VALUES ('_browser_header.strictTransportSecurity', 'max-age=31536000; includeSubDomains', 'master');
INSERT INTO realm_attribute VALUES ('bruteForceProtected', 'false', 'master');
INSERT INTO realm_attribute VALUES ('permanentLockout', 'false', 'master');
INSERT INTO realm_attribute VALUES ('maxFailureWaitSeconds', '900', 'master');
INSERT INTO realm_attribute VALUES ('minimumQuickLoginWaitSeconds', '60', 'master');
INSERT INTO realm_attribute VALUES ('waitIncrementSeconds', '60', 'master');
INSERT INTO realm_attribute VALUES ('quickLoginCheckMilliSeconds', '1000', 'master');
INSERT INTO realm_attribute VALUES ('maxDeltaTimeSeconds', '43200', 'master');
INSERT INTO realm_attribute VALUES ('failureFactor', '30', 'master');
INSERT INTO realm_attribute VALUES ('displayName', 'Keycloak', 'master');
INSERT INTO realm_attribute VALUES ('displayNameHtml', '<div class="kc-logo-text"><span>Keycloak</span></div>', 'master');


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO realm_default_roles VALUES ('master', '79df5b84-bcc6-43a4-9eab-238d1bb42bf7');
INSERT INTO realm_default_roles VALUES ('master', '9bfff960-50af-45ed-95f7-28ea575569f7');


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO realm_events_listeners VALUES ('master', 'jboss-logging');


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO realm_required_credential VALUES ('password', 'password', true, true, 'master');


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO redirect_uris VALUES ('c4f7f87e-5e27-43b0-ad58-77cdd49dcbf7', '/auth/realms/master/account/*');
INSERT INTO redirect_uris VALUES ('a7f35ea7-017e-4463-995c-137fe9f6fd43', '/auth/admin/master/console/*');
INSERT INTO redirect_uris VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', 'http://localhost:4200');


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO required_action_provider VALUES ('deac2596-f12d-465f-8140-fa2446ddceca', 'VERIFY_EMAIL', 'Verify Email', 'master', true, false, 'VERIFY_EMAIL');
INSERT INTO required_action_provider VALUES ('d35a3fec-c898-4311-8067-15b26cd98454', 'UPDATE_PROFILE', 'Update Profile', 'master', true, false, 'UPDATE_PROFILE');
INSERT INTO required_action_provider VALUES ('bf5ac1c8-e7db-4a92-aadc-c358fbc9a44f', 'CONFIGURE_TOTP', 'Configure OTP', 'master', true, false, 'CONFIGURE_TOTP');
INSERT INTO required_action_provider VALUES ('0d56106e-7eef-4df1-8a54-2ecdc5068084', 'UPDATE_PASSWORD', 'Update Password', 'master', true, false, 'UPDATE_PASSWORD');
INSERT INTO required_action_provider VALUES ('e7224738-3425-4e29-9c19-29b125fdb2b5', 'terms_and_conditions', 'Terms and Conditions', 'master', false, false, 'terms_and_conditions');


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: template_scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_consent_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_consent_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO user_entity VALUES ('a47d6459-35f7-4b7a-9ea1-fe723d7b3298', NULL, '41f9d2a1-e1e9-4bee-a7dd-a5abb88fe4f7', false, true, NULL, NULL, NULL, 'master', 'keycloak', 1527499952525, NULL, 0);
INSERT INTO user_entity VALUES ('ad794315-2dd9-41b2-9b75-41a25414d689', 'test@test.com', 'test@test.com', true, true, NULL, NULL, NULL, 'master', 'test', 1528106674211, NULL, 0);


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO user_role_mapping VALUES ('79df5b84-bcc6-43a4-9eab-238d1bb42bf7', 'a47d6459-35f7-4b7a-9ea1-fe723d7b3298');
INSERT INTO user_role_mapping VALUES ('4d30dbf3-f4fe-4308-be40-58ba7aff657d', 'a47d6459-35f7-4b7a-9ea1-fe723d7b3298');
INSERT INTO user_role_mapping VALUES ('3023f236-8fd7-4fbb-99cd-11c5f3bae9ce', 'a47d6459-35f7-4b7a-9ea1-fe723d7b3298');
INSERT INTO user_role_mapping VALUES ('9bfff960-50af-45ed-95f7-28ea575569f7', 'a47d6459-35f7-4b7a-9ea1-fe723d7b3298');
INSERT INTO user_role_mapping VALUES ('c7915e9c-2a04-4152-bbef-79fcf410b5b0', 'a47d6459-35f7-4b7a-9ea1-fe723d7b3298');
INSERT INTO user_role_mapping VALUES ('79df5b84-bcc6-43a4-9eab-238d1bb42bf7', 'ad794315-2dd9-41b2-9b75-41a25414d689');
INSERT INTO user_role_mapping VALUES ('4d30dbf3-f4fe-4308-be40-58ba7aff657d', 'ad794315-2dd9-41b2-9b75-41a25414d689');
INSERT INTO user_role_mapping VALUES ('3023f236-8fd7-4fbb-99cd-11c5f3bae9ce', 'ad794315-2dd9-41b2-9b75-41a25414d689');
INSERT INTO user_role_mapping VALUES ('9bfff960-50af-45ed-95f7-28ea575569f7', 'ad794315-2dd9-41b2-9b75-41a25414d689');


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO web_origins VALUES ('5b5455bb-f01c-4ddf-ae76-ce5b56df5ffd', 'http://localhost:4200');


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- Name: client_identity_prov_mapping constr_client_iden_prov_map; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_identity_prov_mapping
    ADD CONSTRAINT constr_client_iden_prov_map PRIMARY KEY (client_id, identity_provider_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: fed_user_consent_prot_mapper constr_user_consent_protm_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_consent_prot_mapper
    ADD CONSTRAINT constr_user_consent_protm_pk PRIMARY KEY (user_consent_id, protocol_mapper_id);


--
-- Name: fed_user_consent_role constr_user_consent_role_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_consent_role
    ADD CONSTRAINT constr_user_consent_role_pk PRIMARY KEY (user_consent_id, role_id);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: credential_attribute constraint_credential_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY credential_attribute
    ADD CONSTRAINT constraint_credential_attr PRIMARY KEY (id);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: fed_credential_attribute constraint_fed_credential_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_credential_attribute
    ADD CONSTRAINT constraint_fed_credential_attr PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: user_consent_prot_mapper constraint_grntcsnt_prm_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent_prot_mapper
    ADD CONSTRAINT constraint_grntcsnt_prm_pm PRIMARY KEY (user_consent_id, protocol_mapper_id);


--
-- Name: user_consent_role constraint_grntcsnt_role_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent_role
    ADD CONSTRAINT constraint_grntcsnt_role_pm PRIMARY KEY (user_consent_id, role_id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_template_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (template_id, name);


--
-- Name: client_template pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: template_scope_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY template_scope_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (template_id, role_id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_identity_prov_mapping uk_7caelwnibji49avxsrtuf6xj12; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_identity_prov_mapping
    ADD CONSTRAINT uk_7caelwnibji49avxsrtuf6xj12 UNIQUE (identity_provider_id, client_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_template uk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template
    ADD CONSTRAINT uk_cli_template UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON authentication_flow USING btree (realm_id);


--
-- Name: idx_client_client_templ_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_client_templ_id ON client USING btree (client_template_id);


--
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_def_roles_client ON client_default_roles USING btree (client_id);


--
-- Name: idx_client_id_prov_map_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id_prov_map_client ON client_identity_prov_mapping USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON client_session USING btree (session_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON component_config USING btree (component_id);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON composite_role USING btree (child_role);


--
-- Name: idx_consent_protmapper; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_consent_protmapper ON user_consent_prot_mapper USING btree (user_consent_id);


--
-- Name: idx_consent_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_consent_role ON user_consent_role USING btree (user_consent_id);


--
-- Name: idx_credential_attr_cred; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_credential_attr_cred ON credential_attribute USING btree (credential_id);


--
-- Name: idx_fed_cred_attr_cred; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fed_cred_attr_cred ON fed_credential_attribute USING btree (credential_id);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON keycloak_role USING btree (realm);


--
-- Name: idx_proto_mapp_client_templ; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_proto_mapp_client_templ ON protocol_mapper USING btree (client_template_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_roles_realm ON realm_default_roles USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON scope_policy USING btree (policy_id);


--
-- Name: idx_templ_scope_mapp_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_templ_scope_mapp_role ON template_scope_mapping USING btree (role_id);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON offline_client_session USING btree (user_session_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: client_identity_prov_mapping fk_56elwnibji49avxsrtuf6xj23; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_identity_prov_mapping
    ADD CONSTRAINT fk_56elwnibji49avxsrtuf6xj23 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_identity_prov_mapping fk_7celwnibji49avxsrtuf6xj12; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_identity_prov_mapping
    ADD CONSTRAINT fk_7celwnibji49avxsrtuf6xj12 FOREIGN KEY (identity_provider_id) REFERENCES identity_provider(internal_id);


--
-- Name: client_default_roles fk_8aelwnibji49avxsrtuf6xjow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT fk_8aelwnibji49avxsrtuf6xjow FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: client_template_attributes fk_cl_templ_attr_templ; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template_attributes
    ADD CONSTRAINT fk_cl_templ_attr_templ FOREIGN KEY (template_id) REFERENCES client_template(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: client fk_cli_tmplt_client; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client
    ADD CONSTRAINT fk_cli_tmplt_client FOREIGN KEY (client_template_id) REFERENCES client_template(id);


--
-- Name: protocol_mapper fk_cli_tmplt_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper
    ADD CONSTRAINT fk_cli_tmplt_mapper FOREIGN KEY (client_template_id) REFERENCES client_template(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: credential_attribute fk_cred_attr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY credential_attribute
    ADD CONSTRAINT fk_cred_attr FOREIGN KEY (credential_id) REFERENCES credential(id);


--
-- Name: realm_default_groups fk_def_groups_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT fk_def_groups_group FOREIGN KEY (group_id) REFERENCES keycloak_group(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: fed_credential_attribute fk_fed_cred_attr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_credential_attribute
    ADD CONSTRAINT fk_fed_cred_attr FOREIGN KEY (credential_id) REFERENCES fed_user_credential(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES keycloak_role(id);


--
-- Name: user_consent_prot_mapper fk_grntcsnt_prm_gr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent_prot_mapper
    ADD CONSTRAINT fk_grntcsnt_prm_gr FOREIGN KEY (user_consent_id) REFERENCES user_consent(id);


--
-- Name: user_consent_role fk_grntcsnt_role_gr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent_role
    ADD CONSTRAINT fk_grntcsnt_role_gr FOREIGN KEY (user_consent_id) REFERENCES user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_role_mapping
    ADD CONSTRAINT fk_group_role_role FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: realm_default_roles fk_h4wpd7w4hsoolni3h0sw7btje; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT fk_h4wpd7w4hsoolni3h0sw7btje FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES identity_provider_mapper(id);


--
-- Name: keycloak_role fk_kjho5le2c0ral09fl8cm9wfw9; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT fk_kjho5le2c0ral09fl8cm9wfw9 FOREIGN KEY (client) REFERENCES client(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: scope_mapping fk_p3rh9grku11kqfrs4fltt7rnq; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_mapping
    ADD CONSTRAINT fk_p3rh9grku11kqfrs4fltt7rnq FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES protocol_mapper(id);


--
-- Name: client_template fk_realm_cli_tmplt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template
    ADD CONSTRAINT fk_realm_cli_tmplt FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES user_federation_provider(id);


--
-- Name: template_scope_mapping fk_templ_scope_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY template_scope_mapping
    ADD CONSTRAINT fk_templ_scope_role FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: template_scope_mapping fk_templ_scope_templ; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY template_scope_mapping
    ADD CONSTRAINT fk_templ_scope_templ FOREIGN KEY (template_id) REFERENCES client_template(id);


--
-- Name: realm fk_traf444kk6qrkms7n56aiwq5y; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm
    ADD CONSTRAINT fk_traf444kk6qrkms7n56aiwq5y FOREIGN KEY (master_admin_client) REFERENCES client(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

