--
-- PostgreSQL database dump
--

\restrict f7g6ZC83miwhUKfKrfOfRydavdKBVkoSL0qsZKN1yGBh2NOzJ5Upcev9enw1D4R

-- Dumped from database version 15.15 (Debian 15.15-1.pgdg13+1)
-- Dumped by pg_dump version 15.15 (Debian 15.15-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.access_tokens (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token text NOT NULL,
    sha256 character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.access_tokens OWNER TO postgres;

--
-- Name: access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_tokens_id_seq OWNER TO postgres;

--
-- Name: access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.access_tokens_id_seq OWNED BY public.access_tokens.id;


--
-- Name: account_accesses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_accesses (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.account_accesses OWNER TO postgres;

--
-- Name: account_accesses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_accesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_accesses_id_seq OWNER TO postgres;

--
-- Name: account_accesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_accesses_id_seq OWNED BY public.account_accesses.id;


--
-- Name: account_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_configs (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    key character varying NOT NULL,
    value text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.account_configs OWNER TO postgres;

--
-- Name: account_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_configs_id_seq OWNER TO postgres;

--
-- Name: account_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_configs_id_seq OWNED BY public.account_configs.id;


--
-- Name: account_linked_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_linked_accounts (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    linked_account_id bigint NOT NULL,
    account_type text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.account_linked_accounts OWNER TO postgres;

--
-- Name: account_linked_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_linked_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_linked_accounts_id_seq OWNER TO postgres;

--
-- Name: account_linked_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_linked_accounts_id_seq OWNED BY public.account_linked_accounts.id;


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id bigint NOT NULL,
    name character varying NOT NULL,
    timezone character varying NOT NULL,
    locale character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    uuid character varying NOT NULL,
    archived_at timestamp(6) without time zone
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_id_seq OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    uuid character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_attachments_id_seq OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL,
    uuid character varying
);


ALTER TABLE public.active_storage_blobs OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_blobs_id_seq OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_variant_records_id_seq OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: completed_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.completed_documents (
    id bigint NOT NULL,
    submitter_id bigint NOT NULL,
    sha256 character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.completed_documents OWNER TO postgres;

--
-- Name: completed_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.completed_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.completed_documents_id_seq OWNER TO postgres;

--
-- Name: completed_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.completed_documents_id_seq OWNED BY public.completed_documents.id;


--
-- Name: completed_submitters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.completed_submitters (
    id bigint NOT NULL,
    submitter_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    account_id bigint NOT NULL,
    template_id bigint,
    source character varying NOT NULL,
    sms_count integer NOT NULL,
    completed_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    verification_method character varying,
    is_first boolean
);


ALTER TABLE public.completed_submitters OWNER TO postgres;

--
-- Name: completed_submitters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.completed_submitters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.completed_submitters_id_seq OWNER TO postgres;

--
-- Name: completed_submitters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.completed_submitters_id_seq OWNED BY public.completed_submitters.id;


--
-- Name: console1984_commands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.console1984_commands (
    id bigint NOT NULL,
    statements text,
    sensitive_access_id bigint,
    session_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.console1984_commands OWNER TO postgres;

--
-- Name: console1984_commands_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.console1984_commands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.console1984_commands_id_seq OWNER TO postgres;

--
-- Name: console1984_commands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.console1984_commands_id_seq OWNED BY public.console1984_commands.id;


--
-- Name: console1984_sensitive_accesses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.console1984_sensitive_accesses (
    id bigint NOT NULL,
    justification text,
    session_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.console1984_sensitive_accesses OWNER TO postgres;

--
-- Name: console1984_sensitive_accesses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.console1984_sensitive_accesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.console1984_sensitive_accesses_id_seq OWNER TO postgres;

--
-- Name: console1984_sensitive_accesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.console1984_sensitive_accesses_id_seq OWNED BY public.console1984_sensitive_accesses.id;


--
-- Name: console1984_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.console1984_sessions (
    id bigint NOT NULL,
    reason text,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.console1984_sessions OWNER TO postgres;

--
-- Name: console1984_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.console1984_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.console1984_sessions_id_seq OWNER TO postgres;

--
-- Name: console1984_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.console1984_sessions_id_seq OWNED BY public.console1984_sessions.id;


--
-- Name: console1984_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.console1984_users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.console1984_users OWNER TO postgres;

--
-- Name: console1984_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.console1984_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.console1984_users_id_seq OWNER TO postgres;

--
-- Name: console1984_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.console1984_users_id_seq OWNED BY public.console1984_users.id;


--
-- Name: document_generation_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_generation_events (
    id bigint NOT NULL,
    submitter_id bigint NOT NULL,
    event_name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.document_generation_events OWNER TO postgres;

--
-- Name: document_generation_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_generation_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_generation_events_id_seq OWNER TO postgres;

--
-- Name: document_generation_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_generation_events_id_seq OWNED BY public.document_generation_events.id;


--
-- Name: email_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_events (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    emailable_type character varying NOT NULL,
    emailable_id bigint NOT NULL,
    message_id character varying NOT NULL,
    tag character varying NOT NULL,
    event_type character varying NOT NULL,
    email character varying NOT NULL,
    data text NOT NULL,
    event_datetime timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.email_events OWNER TO postgres;

--
-- Name: email_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.email_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_events_id_seq OWNER TO postgres;

--
-- Name: email_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.email_events_id_seq OWNED BY public.email_events.id;


--
-- Name: email_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_messages (
    id bigint NOT NULL,
    uuid character varying NOT NULL,
    author_id bigint NOT NULL,
    account_id bigint NOT NULL,
    subject text NOT NULL,
    body text NOT NULL,
    sha1 character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.email_messages OWNER TO postgres;

--
-- Name: email_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.email_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_messages_id_seq OWNER TO postgres;

--
-- Name: email_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.email_messages_id_seq OWNED BY public.email_messages.id;


--
-- Name: encrypted_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.encrypted_configs (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    key character varying NOT NULL,
    value text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.encrypted_configs OWNER TO postgres;

--
-- Name: encrypted_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.encrypted_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.encrypted_configs_id_seq OWNER TO postgres;

--
-- Name: encrypted_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.encrypted_configs_id_seq OWNED BY public.encrypted_configs.id;


--
-- Name: encrypted_user_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.encrypted_user_configs (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    key character varying NOT NULL,
    value text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.encrypted_user_configs OWNER TO postgres;

--
-- Name: encrypted_user_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.encrypted_user_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.encrypted_user_configs_id_seq OWNER TO postgres;

--
-- Name: encrypted_user_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.encrypted_user_configs_id_seq OWNED BY public.encrypted_user_configs.id;


--
-- Name: lock_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lock_events (
    id bigint NOT NULL,
    key character varying NOT NULL,
    event_name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.lock_events OWNER TO postgres;

--
-- Name: lock_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lock_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lock_events_id_seq OWNER TO postgres;

--
-- Name: lock_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lock_events_id_seq OWNED BY public.lock_events.id;


--
-- Name: oauth_access_grants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_access_grants (
    id bigint NOT NULL,
    resource_owner_id bigint NOT NULL,
    application_id bigint NOT NULL,
    token character varying NOT NULL,
    expires_in integer NOT NULL,
    redirect_uri text NOT NULL,
    scopes character varying DEFAULT ''::character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    revoked_at timestamp(6) without time zone
);


ALTER TABLE public.oauth_access_grants OWNER TO postgres;

--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth_access_grants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_access_grants_id_seq OWNER TO postgres;

--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth_access_grants_id_seq OWNED BY public.oauth_access_grants.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_access_tokens (
    id bigint NOT NULL,
    resource_owner_id bigint,
    application_id bigint NOT NULL,
    token character varying NOT NULL,
    refresh_token character varying,
    expires_in integer,
    scopes character varying,
    created_at timestamp(6) without time zone NOT NULL,
    revoked_at timestamp(6) without time zone,
    previous_refresh_token character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oauth_access_tokens OWNER TO postgres;

--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_access_tokens_id_seq OWNER TO postgres;

--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth_access_tokens_id_seq OWNED BY public.oauth_access_tokens.id;


--
-- Name: oauth_applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_applications (
    id bigint NOT NULL,
    name character varying NOT NULL,
    uid character varying NOT NULL,
    secret character varying NOT NULL,
    redirect_uri text,
    scopes character varying DEFAULT ''::character varying NOT NULL,
    confidential boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.oauth_applications OWNER TO postgres;

--
-- Name: oauth_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_applications_id_seq OWNER TO postgres;

--
-- Name: oauth_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth_applications_id_seq OWNED BY public.oauth_applications.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: search_entries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.search_entries (
    id bigint NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    account_id bigint NOT NULL,
    tsvector tsvector NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    ngram tsvector
);


ALTER TABLE public.search_entries OWNER TO postgres;

--
-- Name: search_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.search_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_entries_id_seq OWNER TO postgres;

--
-- Name: search_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.search_entries_id_seq OWNED BY public.search_entries.id;


--
-- Name: submission_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.submission_events (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    submitter_id bigint,
    data text NOT NULL,
    event_type character varying NOT NULL,
    event_timestamp timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id bigint
);


ALTER TABLE public.submission_events OWNER TO postgres;

--
-- Name: submission_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.submission_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submission_events_id_seq OWNER TO postgres;

--
-- Name: submission_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.submission_events_id_seq OWNED BY public.submission_events.id;


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.submissions (
    id bigint NOT NULL,
    template_id bigint,
    created_by_user_id bigint,
    archived_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    template_fields text,
    template_schema text,
    template_submitters text,
    source character varying NOT NULL,
    submitters_order character varying NOT NULL,
    slug character varying NOT NULL,
    preferences text NOT NULL,
    account_id bigint NOT NULL,
    expire_at timestamp(6) without time zone,
    name text,
    variables_schema text,
    variables text
);


ALTER TABLE public.submissions OWNER TO postgres;

--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submissions_id_seq OWNER TO postgres;

--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.submissions_id_seq OWNED BY public.submissions.id;


--
-- Name: submitters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.submitters (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    uuid character varying NOT NULL,
    email character varying,
    slug character varying NOT NULL,
    "values" text NOT NULL,
    ua character varying,
    ip character varying,
    sent_at timestamp(6) without time zone,
    opened_at timestamp(6) without time zone,
    completed_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    name character varying,
    phone character varying,
    external_id character varying,
    preferences text NOT NULL,
    metadata text NOT NULL,
    account_id bigint NOT NULL,
    declined_at timestamp(6) without time zone,
    timezone character varying
);


ALTER TABLE public.submitters OWNER TO postgres;

--
-- Name: submitters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.submitters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submitters_id_seq OWNER TO postgres;

--
-- Name: submitters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.submitters_id_seq OWNED BY public.submitters.id;


--
-- Name: template_accesses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.template_accesses (
    id bigint NOT NULL,
    template_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.template_accesses OWNER TO postgres;

--
-- Name: template_accesses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.template_accesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.template_accesses_id_seq OWNER TO postgres;

--
-- Name: template_accesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.template_accesses_id_seq OWNED BY public.template_accesses.id;


--
-- Name: template_folders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.template_folders (
    id bigint NOT NULL,
    name character varying NOT NULL,
    author_id bigint NOT NULL,
    account_id bigint NOT NULL,
    archived_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    parent_folder_id bigint
);


ALTER TABLE public.template_folders OWNER TO postgres;

--
-- Name: template_folders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.template_folders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.template_folders_id_seq OWNER TO postgres;

--
-- Name: template_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.template_folders_id_seq OWNED BY public.template_folders.id;


--
-- Name: template_sharings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.template_sharings (
    id bigint NOT NULL,
    template_id bigint NOT NULL,
    account_id bigint NOT NULL,
    ability character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.template_sharings OWNER TO postgres;

--
-- Name: template_sharings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.template_sharings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.template_sharings_id_seq OWNER TO postgres;

--
-- Name: template_sharings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.template_sharings_id_seq OWNED BY public.template_sharings.id;


--
-- Name: templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.templates (
    id bigint NOT NULL,
    slug character varying NOT NULL,
    name character varying NOT NULL,
    schema text NOT NULL,
    fields text NOT NULL,
    submitters text NOT NULL,
    author_id bigint NOT NULL,
    account_id bigint NOT NULL,
    archived_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    source text NOT NULL,
    folder_id bigint NOT NULL,
    external_id character varying,
    preferences text NOT NULL,
    shared_link boolean DEFAULT false NOT NULL,
    variables_schema text
);


ALTER TABLE public.templates OWNER TO postgres;

--
-- Name: templates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templates_id_seq OWNER TO postgres;

--
-- Name: templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.templates_id_seq OWNED BY public.templates.id;


--
-- Name: user_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_configs (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    key character varying NOT NULL,
    value text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.user_configs OWNER TO postgres;

--
-- Name: user_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_configs_id_seq OWNER TO postgres;

--
-- Name: user_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_configs_id_seq OWNED BY public.user_configs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying NOT NULL,
    role character varying NOT NULL,
    encrypted_password character varying NOT NULL,
    account_id bigint NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp(6) without time zone,
    last_sign_in_at timestamp(6) without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp(6) without time zone,
    archived_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    uuid character varying NOT NULL,
    otp_secret character varying,
    consumed_timestep integer,
    otp_required_for_login boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: webhook_attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.webhook_attempts (
    id bigint NOT NULL,
    webhook_event_id bigint NOT NULL,
    response_body text,
    response_status_code integer NOT NULL,
    attempt integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.webhook_attempts OWNER TO postgres;

--
-- Name: webhook_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.webhook_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.webhook_attempts_id_seq OWNER TO postgres;

--
-- Name: webhook_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.webhook_attempts_id_seq OWNED BY public.webhook_attempts.id;


--
-- Name: webhook_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.webhook_events (
    id bigint NOT NULL,
    uuid character varying NOT NULL,
    webhook_url_id bigint NOT NULL,
    account_id bigint NOT NULL,
    record_id bigint NOT NULL,
    record_type character varying NOT NULL,
    event_type character varying NOT NULL,
    status character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.webhook_events OWNER TO postgres;

--
-- Name: webhook_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.webhook_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.webhook_events_id_seq OWNER TO postgres;

--
-- Name: webhook_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.webhook_events_id_seq OWNED BY public.webhook_events.id;


--
-- Name: webhook_urls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.webhook_urls (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    url text NOT NULL,
    events text NOT NULL,
    sha1 character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    secret text NOT NULL
);


ALTER TABLE public.webhook_urls OWNER TO postgres;

--
-- Name: webhook_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.webhook_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.webhook_urls_id_seq OWNER TO postgres;

--
-- Name: webhook_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.webhook_urls_id_seq OWNED BY public.webhook_urls.id;


--
-- Name: access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_tokens ALTER COLUMN id SET DEFAULT nextval('public.access_tokens_id_seq'::regclass);


--
-- Name: account_accesses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_accesses ALTER COLUMN id SET DEFAULT nextval('public.account_accesses_id_seq'::regclass);


--
-- Name: account_configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_configs ALTER COLUMN id SET DEFAULT nextval('public.account_configs_id_seq'::regclass);


--
-- Name: account_linked_accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_linked_accounts ALTER COLUMN id SET DEFAULT nextval('public.account_linked_accounts_id_seq'::regclass);


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: completed_documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_documents ALTER COLUMN id SET DEFAULT nextval('public.completed_documents_id_seq'::regclass);


--
-- Name: completed_submitters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_submitters ALTER COLUMN id SET DEFAULT nextval('public.completed_submitters_id_seq'::regclass);


--
-- Name: console1984_commands id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.console1984_commands ALTER COLUMN id SET DEFAULT nextval('public.console1984_commands_id_seq'::regclass);


--
-- Name: console1984_sensitive_accesses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.console1984_sensitive_accesses ALTER COLUMN id SET DEFAULT nextval('public.console1984_sensitive_accesses_id_seq'::regclass);


--
-- Name: console1984_sessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.console1984_sessions ALTER COLUMN id SET DEFAULT nextval('public.console1984_sessions_id_seq'::regclass);


--
-- Name: console1984_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.console1984_users ALTER COLUMN id SET DEFAULT nextval('public.console1984_users_id_seq'::regclass);


--
-- Name: document_generation_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_generation_events ALTER COLUMN id SET DEFAULT nextval('public.document_generation_events_id_seq'::regclass);


--
-- Name: email_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_events ALTER COLUMN id SET DEFAULT nextval('public.email_events_id_seq'::regclass);


--
-- Name: email_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_messages ALTER COLUMN id SET DEFAULT nextval('public.email_messages_id_seq'::regclass);


--
-- Name: encrypted_configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encrypted_configs ALTER COLUMN id SET DEFAULT nextval('public.encrypted_configs_id_seq'::regclass);


--
-- Name: encrypted_user_configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encrypted_user_configs ALTER COLUMN id SET DEFAULT nextval('public.encrypted_user_configs_id_seq'::regclass);


--
-- Name: lock_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lock_events ALTER COLUMN id SET DEFAULT nextval('public.lock_events_id_seq'::regclass);


--
-- Name: oauth_access_grants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_access_grants ALTER COLUMN id SET DEFAULT nextval('public.oauth_access_grants_id_seq'::regclass);


--
-- Name: oauth_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.oauth_access_tokens_id_seq'::regclass);


--
-- Name: oauth_applications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_applications ALTER COLUMN id SET DEFAULT nextval('public.oauth_applications_id_seq'::regclass);


--
-- Name: search_entries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.search_entries ALTER COLUMN id SET DEFAULT nextval('public.search_entries_id_seq'::regclass);


--
-- Name: submission_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission_events ALTER COLUMN id SET DEFAULT nextval('public.submission_events_id_seq'::regclass);


--
-- Name: submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions ALTER COLUMN id SET DEFAULT nextval('public.submissions_id_seq'::regclass);


--
-- Name: submitters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submitters ALTER COLUMN id SET DEFAULT nextval('public.submitters_id_seq'::regclass);


--
-- Name: template_accesses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template_accesses ALTER COLUMN id SET DEFAULT nextval('public.template_accesses_id_seq'::regclass);


--
-- Name: template_folders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template_folders ALTER COLUMN id SET DEFAULT nextval('public.template_folders_id_seq'::regclass);


--
-- Name: template_sharings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template_sharings ALTER COLUMN id SET DEFAULT nextval('public.template_sharings_id_seq'::regclass);


--
-- Name: templates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templates ALTER COLUMN id SET DEFAULT nextval('public.templates_id_seq'::regclass);


--
-- Name: user_configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_configs ALTER COLUMN id SET DEFAULT nextval('public.user_configs_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: webhook_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_attempts ALTER COLUMN id SET DEFAULT nextval('public.webhook_attempts_id_seq'::regclass);


--
-- Name: webhook_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_events ALTER COLUMN id SET DEFAULT nextval('public.webhook_events_id_seq'::regclass);


--
-- Name: webhook_urls id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_urls ALTER COLUMN id SET DEFAULT nextval('public.webhook_urls_id_seq'::regclass);


--
-- Data for Name: access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.access_tokens (id, user_id, token, sha256, created_at, updated_at) FROM stdin;
1	1	{"p":"Z9EkzyWUDnJ4pF5pbYXdtx7+/GtmEqQx2o4/EoRCOhmbNte/v/mxxLZX/Q==","h":{"iv":"eQCo9AbPmr1wHsgG","at":"PUUDXx3p6arGaWAmtP6/AQ==","e":"VVMtQVNDSUk="}}	59caeb5ceedd8514c5d3555ace9413db965f15e7a5b7f654baa5021aca281753	2025-11-24 17:55:17.856584	2025-11-24 17:55:17.856584
\.


--
-- Data for Name: account_accesses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_accesses (id, account_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: account_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_configs (id, account_id, key, value, created_at, updated_at) FROM stdin;
1	1	fulltext_search	true	2025-11-24 17:55:04.579378	2025-11-24 17:55:04.579378
\.


--
-- Data for Name: account_linked_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_linked_accounts (id, account_id, linked_account_id, account_type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, name, timezone, locale, created_at, updated_at, uuid, archived_at) FROM stdin;
1	BrasilSupply	Brasilia	en-US	2025-11-24 17:55:03.613065	2025-11-24 17:55:03.613065	23a6b9db-b1c7-45db-a7d0-3d5d8f046989	\N
\.


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_attachments (id, name, uuid, record_type, record_id, blob_id, created_at) FROM stdin;
1	documents	97146598-c54b-4738-90a0-447791d0fab0	Template	1	1	2025-11-24 21:52:55.401909
2	preview_images	9ec08a2c-7858-4145-9e8b-59b43cc2c08f	ActiveStorage::Attachment	1	2	2025-11-24 21:52:57.428667
3	attachments	1fe0717c-eb4d-4dca-b999-34f6265e4195	Submitter	1	3	2025-11-26 11:42:05.203453
4	documents	b560551d-2933-4a63-9328-7eef7e11bc83	Submitter	1	4	2025-11-26 11:42:07.446762
5	attachments	f7c6322b-7807-47e3-8410-886a4e8a5dea	Submitter	2	5	2025-11-26 11:42:38.544694
6	documents	b5a24393-de66-474e-b67f-0eea8b41e861	Submitter	2	6	2025-11-26 11:42:40.571866
7	audit_trail	959ae4c2-5bbc-40fd-a680-77fafc5eef17	Submission	1	7	2025-11-26 11:42:43.679792
8	attachments	60816d41-39a7-42d5-85c5-4f2ed9469d6c	Submitter	3	3	2025-11-26 12:41:04.411879
9	attachments	f647c03d-d27c-4067-a90c-86f7126e30d7	Submitter	3	8	2025-11-26 12:41:16.051664
10	documents	4797f04a-f8ff-4c68-b2ff-edcbcbd8d10e	Submitter	3	9	2025-11-26 12:41:18.939209
11	attachments	5eae2da9-3474-4d8f-a70c-ca1449d8eaaf	Submitter	4	5	2025-11-26 12:41:33.457687
12	attachments	a50f86b6-0905-47fb-9713-ae1c551f7478	Submitter	4	10	2025-11-26 12:41:47.548085
13	documents	8e2ecf8c-8733-4d6d-8f52-5a1652e2887b	Submitter	4	11	2025-11-26 12:41:49.726311
14	audit_trail	3b4cdda2-99c7-4fb1-a762-42bc23761b83	Submission	2	12	2025-11-26 12:41:53.420427
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at, uuid) FROM stdin;
1	tt70m8spa1yx2drws5dpel1y58pa	Contrato.pdf	application/pdf	{"identified":true,"analyzed":true,"sha256":"AZQ71YF1h8GZzAhw0jfvlyFYXdJ0rTUCfctE3vkSRnQ=","pdf":{"number_of_pages":1}}	disk	42022	eQqwghpXaQBKL2No5hpQkA==	2025-11-24 21:52:55.115408	7a19ed97-221a-4876-a087-1009ba1f9013
2	uh00h298xvw0sieowfjm4fzmoizi	0.png	image/png	{"analyzed":true,"identified":true,"width":1400,"height":1812}	disk	40596	ekhZHxiDK+bJIAebpZw8uQ==	2025-11-24 21:52:57.417031	b453504d-4546-4272-998e-de403d1a7667
3	3nws6pv8mia5xi0b1qgrnw0hxik8	signature.png	image/png	{"identified":true,"width":1227,"height":557,"analyzed":true}	disk	61207	N1BdOas8UgIDwP91Ag3zbw==	2025-11-26 11:42:05.077647	94821e19-37d9-4588-aaa1-43c89cbee51e
4	5n4fanqvvevcmh4cq0f9zefn6ri4	Contrato.pdf	application/pdf	{"original_uuid":"97146598-c54b-4738-90a0-447791d0fab0","analyzed":true,"sha256":"1c59xvRoXXlZEECjDOK_L2fpmDd6nKkGIjatOL_8k_E="}	disk	58543	4i/T21NaMz3LZs6laAdm9A==	2025-11-26 11:42:07.336526	59c2a441-1eb5-44d0-b632-d3a6dd8b3b81
5	71sps60g64i04kcy5d3n2qhwctfn	signature.png	image/png	{"identified":true,"width":1338,"height":581,"analyzed":true}	disk	70671	OMtPYB+b1wBjdSEOufC20w==	2025-11-26 11:42:38.504648	917f844c-70f6-41be-9263-36ded91825cd
6	plb6phncf7k9o0pqthowwp9pjbh6	Contrato.pdf	application/pdf	{"original_uuid":"97146598-c54b-4738-90a0-447791d0fab0","analyzed":true,"sha256":"nMu5DQTtOZh0TLwm_WfyrZYNQpyin91PL6nl5T2QARs="}	disk	85963	ShovKXNeMWBLf4cs+FKOdQ==	2025-11-26 11:42:40.552195	df2a28cc-f149-4456-ab71-7a4849f9373c
7	c99ziyl3hype0ftl1d7b0deunaj7	Audit Log - BrasilSupply.pdf	application/pdf	{"identified":true,"analyzed":true}	disk	93160	2rg0gINoDvclRtp0RpJpfA==	2025-11-26 11:42:43.581697	207909bd-e7d1-4478-b46c-291411f82410
8	i518jk2c9m2j5c4mkzmf7d21vjr8	signature.png	image/png	{"identified":true,"width":720,"height":346,"analyzed":true}	disk	25577	ZIasE02Y8B6Vwa4IO+3DKw==	2025-11-26 12:41:15.939214	7e7dbcb5-b7be-4ed4-be00-20e3e5163a9f
9	xi7xrmcuza0kpdc75pbg004ls2xh	Contrato.pdf	application/pdf	{"original_uuid":"97146598-c54b-4738-90a0-447791d0fab0","analyzed":true,"sha256":"1pBw_UmmoSB6MJAhrmQZKvWBxsU4dbfSbxiJPkfFqQI="}	disk	56460	ZUT0CkQsKt6RjA2ENTRPLg==	2025-11-26 12:41:18.788386	63ecd33f-2dd7-4797-a5ef-64d0c26f6f31
10	b8fse2phe3jckcvb8ezvjr523idr	signature.png	image/png	{"identified":true,"width":641,"height":496,"analyzed":true}	disk	28629	ZcIEf53rSFgciJuhFlmUaQ==	2025-11-26 12:41:47.484606	749d5d98-f812-4581-a95e-6ef2a1395a22
11	2ms4kktpsfqbzc0swnq5t2p5qx3w	Contrato.pdf	application/pdf	{"original_uuid":"97146598-c54b-4738-90a0-447791d0fab0","analyzed":true,"sha256":"MfGBwQAQitntlDdMI3sPxjzCH4cCGQKfe2TH3VnQvf0="}	disk	78723	UyWlIXviyuNlX7sTGjJu+A==	2025-11-26 12:41:49.678038	d7c73a12-5e50-425b-b094-35d109cc9afa
12	brt5ualegh4pdt75t2wy8tj1b89q	Audit Log - BrasilSupply.pdf	application/pdf	{"identified":true,"analyzed":true}	disk	90521	UOGNvp/5v7QtaI4v9bzVDQ==	2025-11-26 12:41:53.363197	7cdb1ef3-859b-4c97-9835-0a0b1e4edb19
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2025-11-24 17:18:59.22517	2025-11-24 17:18:59.225178
\.


--
-- Data for Name: completed_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.completed_documents (id, submitter_id, sha256, created_at, updated_at) FROM stdin;
1	1	1c59xvRoXXlZEECjDOK_L2fpmDd6nKkGIjatOL_8k_E=	2025-11-26 11:42:07.636469	2025-11-26 11:42:07.636469
2	2	nMu5DQTtOZh0TLwm_WfyrZYNQpyin91PL6nl5T2QARs=	2025-11-26 11:42:44.314345	2025-11-26 11:42:44.314345
3	3	1pBw_UmmoSB6MJAhrmQZKvWBxsU4dbfSbxiJPkfFqQI=	2025-11-26 12:41:19.178183	2025-11-26 12:41:19.178183
4	4	MfGBwQAQitntlDdMI3sPxjzCH4cCGQKfe2TH3VnQvf0=	2025-11-26 12:41:53.91759	2025-11-26 12:41:53.91759
\.


--
-- Data for Name: completed_submitters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.completed_submitters (id, submitter_id, submission_id, account_id, template_id, source, sms_count, completed_at, created_at, updated_at, verification_method, is_first) FROM stdin;
1	1	1	1	1	api	0	2025-11-26 11:42:05.664227	2025-11-26 11:42:05.934717	2025-11-26 11:42:05.934717	\N	t
2	2	1	1	1	api	0	2025-11-26 11:42:38.668024	2025-11-26 11:42:38.782645	2025-11-26 11:42:38.782645	\N	f
3	3	2	1	1	api	0	2025-11-26 12:41:16.672682	2025-11-26 12:41:17.358509	2025-11-26 12:41:17.358509	\N	t
4	4	2	1	1	api	0	2025-11-26 12:41:47.823851	2025-11-26 12:41:48.179022	2025-11-26 12:41:48.179022	\N	f
\.


--
-- Data for Name: console1984_commands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.console1984_commands (id, statements, sensitive_access_id, session_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: console1984_sensitive_accesses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.console1984_sensitive_accesses (id, justification, session_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: console1984_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.console1984_sessions (id, reason, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: console1984_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.console1984_users (id, username, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: document_generation_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_generation_events (id, submitter_id, event_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_events (id, account_id, emailable_type, emailable_id, message_id, tag, event_type, email, data, event_datetime, created_at) FROM stdin;
1	1	Submitter	2	ecc51711-da11-4343-aec0-67bbca139806	submitter_invitation	send	fornecedor3@forn.com	{"from":["noreply@brasilsupply.com"],"method":"mail/smtp"}	2025-11-26 11:42:08.163678	2025-11-26 11:42:08.270173
2	1	Submitter	2	1f9b297b-03e4-43c0-99ed-396dd3428337	submitter_documents_copy	send	fornecedor3@forn.com	{"from":["noreply@brasilsupply.com"],"method":"mail/smtp"}	2025-11-26 11:42:45.204767	2025-11-26 11:42:45.270703
3	1	Submitter	2	8b0531ea-6cae-4b53-a651-3a3f39854907	submitter_completed	send	joaovitorm.xavier@gmail.com	{"from":["noreply@brasilsupply.com"],"method":"mail/smtp"}	2025-11-26 11:42:45.848938	2025-11-26 11:42:45.863702
4	1	Submitter	4	06a56d84-9c3b-4ef3-91b3-3618a7730038	submitter_invitation	send	fornecedor3@forn.com	{"from":["noreply@brasilsupply.com"],"method":"mail/smtp"}	2025-11-26 12:41:20.056196	2025-11-26 12:41:20.181971
5	1	Submitter	4	021dcc32-f5fb-49b2-99e4-c0d5bfb1ee4a	submitter_completed	send	joaovitorm.xavier@gmail.com	{"from":["noreply@brasilsupply.com"],"method":"mail/smtp"}	2025-11-26 12:41:54.849815	2025-11-26 12:41:54.89162
6	1	Submitter	4	73d87f70-1ef0-4915-ae5a-7477ea358c9e	submitter_documents_copy	send	fornecedor3@forn.com	{"from":["noreply@brasilsupply.com"],"method":"mail/smtp"}	2025-11-26 12:41:55.420886	2025-11-26 12:41:55.493448
\.


--
-- Data for Name: email_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_messages (id, uuid, author_id, account_id, subject, body, sha1, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: encrypted_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.encrypted_configs (id, account_id, key, value, created_at, updated_at) FROM stdin;
1	1	app_url	{"p":"zOWvGjZN8hrXas/is+H9wEGiddnNWOQ=","h":{"iv":"JhNxTblMyFrWwmcd","at":"bElYrqUt/FwInCLWy3yRXA=="}}	2025-11-24 17:55:04.133792	2025-11-24 17:55:04.133792
2	1	esign_certs	{"p":"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","h":{"iv":"wr7GupXm4OKEqZYk","at":"p1Xev0mFz1cxlalj7dEbNw==","c":true}}	2025-11-24 17:55:04.372809	2025-11-24 17:55:04.372809
3	1	action_mailer_smtp	{"p":"PvToqmVntsuYsE3EoW39DDNOitx4+Hok9Wo/M24kRbxlYRGu4yegXo6c1ZIfVyWU6fAsXRCVPNKrFcbjQ9jlRflCS2Twx9sFL+1974iC5ZiLqRtpuDaO98SiCvdOSLlHeepT6QI9+PmPnfWdnQkACRLihQ==","h":{"iv":"6nZvu5DW2MbNvqhp","at":"fayzkca2BAaL3CXo8CFYsQ=="}}	2025-11-26 11:35:56.227439	2025-11-26 11:35:56.227439
\.


--
-- Data for Name: encrypted_user_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.encrypted_user_configs (id, user_id, key, value, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: lock_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lock_events (id, key, event_name, created_at, updated_at) FROM stdin;
1	result_attachments:1	start	2025-11-26 11:42:06.01806	2025-11-26 11:42:06.01806
2	result_attachments:1	complete	2025-11-26 11:42:07.56436	2025-11-26 11:42:07.56436
3	result_attachments:2	start	2025-11-26 11:42:38.796917	2025-11-26 11:42:38.796917
4	result_attachments:2	complete	2025-11-26 11:42:40.636243	2025-11-26 11:42:40.636243
5	audit_trail:1	start	2025-11-26 11:42:40.661346	2025-11-26 11:42:40.661346
6	audit_trail:1	complete	2025-11-26 11:42:43.805052	2025-11-26 11:42:43.805052
7	result_attachments:3	start	2025-11-26 12:41:17.517954	2025-11-26 12:41:17.517954
8	result_attachments:3	complete	2025-11-26 12:41:19.073074	2025-11-26 12:41:19.073074
9	result_attachments:4	start	2025-11-26 12:41:48.219733	2025-11-26 12:41:48.219733
10	result_attachments:4	complete	2025-11-26 12:41:49.77795	2025-11-26 12:41:49.77795
11	audit_trail:2	start	2025-11-26 12:41:49.822308	2025-11-26 12:41:49.822308
12	audit_trail:2	complete	2025-11-26 12:41:53.589135	2025-11-26 12:41:53.589135
\.


--
-- Data for Name: oauth_access_grants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_access_grants (id, resource_owner_id, application_id, token, expires_in, redirect_uri, scopes, created_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: oauth_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_access_tokens (id, resource_owner_id, application_id, token, refresh_token, expires_in, scopes, created_at, revoked_at, previous_refresh_token) FROM stdin;
\.


--
-- Data for Name: oauth_applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_applications (id, name, uid, secret, redirect_uri, scopes, confidential, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20230515182743
20230515182744
20230515193039
20230515205356
20230516180929
20230519144036
20230612182744
20230701075115
20230726062428
20230803200825
20230805124454
20230806140534
20230815190540
20230819113427
20230819190316
20230902171216
20230909213212
20230910084410
20230915200635
20230920195319
20230920202947
20230922072041
20230924184657
20231007052818
20231017213639
20231102171817
20231112224432
20231119222105
20231122203341
20231122203347
20231122212612
20231229220819
20240120192055
20240131212010
20240201210319
20240203113454
20240203113455
20240218082157
20240228074821
20240228083356
20240405165329
20240416170023
20240428072623
20240428112400
20240604070648
20240624102526
20240714172222
20240720063826
20240720063827
20240801125558
20240816064633
20240816072859
20240816075917
20240816121641
20240820180922
20241018115034
20241022125135
20241026161207
20241028162000
20241029192232
20241207172237
20250225111255
20250518070555
20250523121121
20250527102542
20250527102550
20250530080846
20250531085328
20250603105556
20250608163157
20250613160132
20250615091654
20250617072547
20250617074820
20250617075609
20250618085322
20250627130628
20250718121133
20250831125322
20250901110606
20250912090605
20250915060548
20250922053744
20251121090556
20251121092044
20251121093511
20251121113910
\.


--
-- Data for Name: search_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.search_entries (id, record_type, record_id, account_id, tsvector, created_at, updated_at, ngram) FROM stdin;
1	Template	1	1	'brasilsuppli':1	2025-11-24 21:52:47.412253	2025-11-24 21:52:47.412253	'b':1 'br':1
2	Submitter	1	1	'ger.com':2A 'gerente@ger.com':1A	2025-11-26 11:41:44.528655	2025-11-26 11:42:05.828813	'g':2A 'ge':2A
3	Submitter	2	1	'forn.com':2A 'fornecedor3@forn.com':1A	2025-11-26 11:41:44.570481	2025-11-26 11:42:38.772513	'f':2A 'fo':2A
4	Submitter	3	1	'ger.com':2A 'gerente@ger.com':1A	2025-11-26 12:41:01.388098	2025-11-26 12:41:17.09471	'g':2A 'ge':2A
5	Submitter	4	1	'forn.com':2A 'fornecedor3@forn.com':1A	2025-11-26 12:41:01.532185	2025-11-26 12:41:48.101856	'f':2A 'fo':2A
\.


--
-- Data for Name: submission_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.submission_events (id, submission_id, submitter_id, data, event_type, event_timestamp, created_at, updated_at, account_id) FROM stdin;
1	1	1	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	view_form	2025-11-26 11:41:50.328852	2025-11-26 11:41:50.346774	2025-11-26 11:41:50.346774	1
2	1	1	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	start_form	2025-11-26 11:41:58.783822	2025-11-26 11:41:58.787058	2025-11-26 11:41:58.787058	1
3	1	1	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	complete_form	2025-11-26 11:42:05.669545	2025-11-26 11:42:05.673268	2025-11-26 11:42:05.673268	1
4	1	2	{}	send_email	2025-11-26 11:42:08.299284	2025-11-26 11:42:08.306224	2025-11-26 11:42:08.306224	1
5	1	2	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	click_email	2025-11-26 11:42:15.391886	2025-11-26 11:42:15.396519	2025-11-26 11:42:15.396519	1
6	1	2	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	view_form	2025-11-26 11:42:15.443318	2025-11-26 11:42:15.452482	2025-11-26 11:42:15.452482	1
7	1	2	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	start_form	2025-11-26 11:42:20.58341	2025-11-26 11:42:20.584728	2025-11-26 11:42:20.584728	1
8	1	2	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	complete_form	2025-11-26 11:42:38.669342	2025-11-26 11:42:38.681212	2025-11-26 11:42:38.681212	1
9	2	3	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	view_form	2025-11-26 12:41:05.653302	2025-11-26 12:41:05.687819	2025-11-26 12:41:05.687819	1
10	2	3	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	start_form	2025-11-26 12:41:09.94488	2025-11-26 12:41:09.965451	2025-11-26 12:41:09.965451	1
11	2	3	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	complete_form	2025-11-26 12:41:16.721559	2025-11-26 12:41:16.778443	2025-11-26 12:41:16.778443	1
12	2	4	{}	send_email	2025-11-26 12:41:20.217958	2025-11-26 12:41:20.265581	2025-11-26 12:41:20.265581	1
13	2	4	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	click_email	2025-11-26 12:41:33.881446	2025-11-26 12:41:33.887885	2025-11-26 12:41:33.887885	1
14	2	4	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	view_form	2025-11-26 12:41:33.998355	2025-11-26 12:41:34.001284	2025-11-26 12:41:34.001284	1
15	2	4	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	start_form	2025-11-26 12:41:37.639758	2025-11-26 12:41:37.649624	2025-11-26 12:41:37.649624	1
16	2	4	{"ip":"172.18.0.1","ua":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36","sid":"1b20690ef6bef2b1cd1370e1ec74686c","uid":1}	complete_form	2025-11-26 12:41:47.855898	2025-11-26 12:41:47.868165	2025-11-26 12:41:47.868165	1
\.


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.submissions (id, template_id, created_by_user_id, archived_at, created_at, updated_at, template_fields, template_schema, template_submitters, source, submitters_order, slug, preferences, account_id, expire_at, name, variables_schema, variables) FROM stdin;
1	1	1	\N	2025-11-26 11:41:43.868189	2025-11-26 11:42:43.720052	[{"uuid":"9488f909-5a4f-41ae-a97f-12c69e43af4f","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"nome_fornecedor","type":"text","required":true,"preferences":{},"areas":[{"x":0.2499690778327711,"y":0.2183086894774141,"w":0.1880783023256244,"h":0.01776672229334308,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"5271bf1d-20d1-4e7e-8cd0-bd0184a98ad2","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"cnpj","type":"text","required":true,"preferences":{},"areas":[{"x":0.1890575813524651,"y":0.2368880232146123,"w":0.1813597823634292,"h":0.01859277308030813,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"39947dd1-986d-47af-b1cb-942c4574fae4","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"n_proposta","type":"number","required":true,"preferences":{},"areas":[{"x":0.6857798027269768,"y":0.3831918823867273,"w":0.07141095941716968,"h":0.01826844288645302,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"e1090f46-a306-455e-bb2a-6fe45cd7c077","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"n_requisicao","type":"number","required":true,"preferences":{},"areas":[{"x":0.3266833334258109,"y":0.4012229712932059,"w":0.09979438781738281,"h":0.01879829233723479,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"6b8ffbb4-bd04-4c2e-b4a6-c5b373094122","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"data_assin","type":"text","required":true,"preferences":{},"areas":[{"x":0.1224913084702908,"y":0.7786511194884083,"w":0.3114578940651633,"h":0.01922428825953276,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"4ef1a733-25c5-4b7a-bfeb-1c59f56276ae","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"total","type":"text","required":true,"preferences":{},"areas":[{"x":0.4409543817693537,"y":0.4927422189328822,"w":0.1918017647483132,"h":0.0179739382115261,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"511ff0de-f9d9-4c43-bcb7-c19c0f67c9b2","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"prazo_entrega","type":"text","required":true,"preferences":{},"areas":[{"x":0.5656994906338778,"y":0.5308413278821096,"w":0.1563333453554095,"h":0.01803135680036116,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"5e28cc88-bde4-4575-a3b9-473f530b0475","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"n_requisicao","type":"text","required":true,"preferences":{},"areas":[{"x":0.6348761356238163,"y":0.7137724870125046,"w":0.1434438878839667,"h":0.01863340365250088,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"f8dd2210-1102-4344-82b5-42453da30ef7","submitter_uuid":"ef770e09-642e-4111-95a4-2a6ef46264dd","name":"","type":"signature","required":true,"preferences":{},"areas":[{"x":0.6126738305941846,"y":0.8285435203980404,"w":0.2659608091024021,"h":0.04938706137631443,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"93d2cab4-323b-4165-ba18-7f0ea2eee2b1","submitter_uuid":"c9299cd3-2dbb-4777-8628-fcff31f8f36e","name":"","type":"signature","required":true,"preferences":{},"areas":[{"x":0.1164171144121365,"y":0.8336982727050781,"w":0.2555457885587863,"h":0.044952392578125,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]}]	[{"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","name":"Contrato"}]	[{"name":"BrasilSupply - Gerente","uuid":"c9299cd3-2dbb-4777-8628-fcff31f8f36e"},{"name":"Fornecedor","uuid":"ef770e09-642e-4111-95a4-2a6ef46264dd"}]	api	preserved	2PmZbAtnndMVzA	{"send_email":true}	1	\N	\N	\N	{}
2	1	1	\N	2025-11-26 12:40:59.64029	2025-11-26 12:41:53.529655	[{"uuid":"9488f909-5a4f-41ae-a97f-12c69e43af4f","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"nome_fornecedor","type":"text","required":true,"preferences":{},"areas":[{"x":0.2499690778327711,"y":0.2183086894774141,"w":0.1880783023256244,"h":0.01776672229334308,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"5271bf1d-20d1-4e7e-8cd0-bd0184a98ad2","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"cnpj","type":"text","required":true,"preferences":{},"areas":[{"x":0.1890575813524651,"y":0.2368880232146123,"w":0.1813597823634292,"h":0.01859277308030813,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"39947dd1-986d-47af-b1cb-942c4574fae4","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"n_proposta","type":"number","required":true,"preferences":{},"areas":[{"x":0.6857798027269768,"y":0.3831918823867273,"w":0.07141095941716968,"h":0.01826844288645302,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"e1090f46-a306-455e-bb2a-6fe45cd7c077","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"n_requisicao","type":"number","required":true,"preferences":{},"areas":[{"x":0.3266833334258109,"y":0.4012229712932059,"w":0.09979438781738281,"h":0.01879829233723479,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"6b8ffbb4-bd04-4c2e-b4a6-c5b373094122","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"data_assin","type":"text","required":true,"preferences":{},"areas":[{"x":0.1224913084702908,"y":0.7786511194884083,"w":0.3114578940651633,"h":0.01922428825953276,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"4ef1a733-25c5-4b7a-bfeb-1c59f56276ae","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"total","type":"text","required":true,"preferences":{},"areas":[{"x":0.4409543817693537,"y":0.4927422189328822,"w":0.1918017647483132,"h":0.0179739382115261,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"511ff0de-f9d9-4c43-bcb7-c19c0f67c9b2","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"prazo_entrega","type":"text","required":true,"preferences":{},"areas":[{"x":0.5656994906338778,"y":0.5308413278821096,"w":0.1563333453554095,"h":0.01803135680036116,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"5e28cc88-bde4-4575-a3b9-473f530b0475","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"n_requisicao","type":"text","required":true,"preferences":{},"areas":[{"x":0.6348761356238163,"y":0.7137724870125046,"w":0.1434438878839667,"h":0.01863340365250088,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"f8dd2210-1102-4344-82b5-42453da30ef7","submitter_uuid":"ef770e09-642e-4111-95a4-2a6ef46264dd","name":"","type":"signature","required":true,"preferences":{},"areas":[{"x":0.6126738305941846,"y":0.8285435203980404,"w":0.2659608091024021,"h":0.04938706137631443,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"93d2cab4-323b-4165-ba18-7f0ea2eee2b1","submitter_uuid":"c9299cd3-2dbb-4777-8628-fcff31f8f36e","name":"","type":"signature","required":true,"preferences":{},"areas":[{"x":0.1164171144121365,"y":0.8336982727050781,"w":0.2555457885587863,"h":0.044952392578125,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]}]	[{"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","name":"Contrato"}]	[{"name":"BrasilSupply - Gerente","uuid":"c9299cd3-2dbb-4777-8628-fcff31f8f36e"},{"name":"Fornecedor","uuid":"ef770e09-642e-4111-95a4-2a6ef46264dd"}]	api	preserved	Xac7qd7BECRYLx	{"send_email":true}	1	\N	\N	\N	{}
\.


--
-- Data for Name: submitters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.submitters (id, submission_id, uuid, email, slug, "values", ua, ip, sent_at, opened_at, completed_at, created_at, updated_at, name, phone, external_id, preferences, metadata, account_id, declined_at, timezone) FROM stdin;
1	1	c9299cd3-2dbb-4777-8628-fcff31f8f36e	gerente@ger.com	DAASexSraSuJaf	{"93d2cab4-323b-4165-ba18-7f0ea2eee2b1":"1fe0717c-eb4d-4dca-b999-34f6265e4195"}	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	172.18.0.1	\N	2025-11-26 11:41:50.226349	2025-11-26 11:42:05.664227	2025-11-26 11:41:43.929245	2025-11-26 11:42:05.70471	\N	\N	\N	{"send_email":false,"send_sms":false}	{}	1	\N	America/Sao_Paulo
2	1	ef770e09-642e-4111-95a4-2a6ef46264dd	fornecedor3@forn.com	nbW7vqQCrh9msw	{"f8dd2210-1102-4344-82b5-42453da30ef7":"f7c6322b-7807-47e3-8410-886a4e8a5dea"}	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	172.18.0.1	2025-11-26 11:42:08.31404	2025-11-26 11:42:15.425947	2025-11-26 11:42:38.668024	2025-11-26 11:41:43.969771	2025-11-26 11:42:38.695291	\N	\N	\N	{"send_email":true,"send_sms":false}	{}	1	\N	America/Sao_Paulo
3	2	c9299cd3-2dbb-4777-8628-fcff31f8f36e	gerente@ger.com	GrjXzfmVWs8oB4	{"93d2cab4-323b-4165-ba18-7f0ea2eee2b1":"f647c03d-d27c-4067-a90c-86f7126e30d7"}	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	172.18.0.1	\N	2025-11-26 12:41:05.411114	2025-11-26 12:41:16.672682	2025-11-26 12:40:59.682475	2025-11-26 12:41:16.813557	\N	\N	\N	{"send_email":false,"send_sms":false}	{}	1	\N	America/Sao_Paulo
4	2	ef770e09-642e-4111-95a4-2a6ef46264dd	fornecedor3@forn.com	x54NPUYnezsmtG	{"f8dd2210-1102-4344-82b5-42453da30ef7":"a50f86b6-0905-47fb-9713-ae1c551f7478"}	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	172.18.0.1	2025-11-26 12:41:20.285175	2025-11-26 12:41:33.923156	2025-11-26 12:41:47.823851	2025-11-26 12:40:59.702442	2025-11-26 12:41:47.874126	\N	\N	\N	{"send_email":true,"send_sms":false}	{}	1	\N	America/Sao_Paulo
\.


--
-- Data for Name: template_accesses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.template_accesses (id, template_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: template_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.template_folders (id, name, author_id, account_id, archived_at, created_at, updated_at, parent_folder_id) FROM stdin;
1	Default	1	1	\N	2025-11-24 17:55:11.455434	2025-11-24 17:55:11.455434	\N
\.


--
-- Data for Name: template_sharings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.template_sharings (id, template_id, account_id, ability, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.templates (id, slug, name, schema, fields, submitters, author_id, account_id, archived_at, created_at, updated_at, source, folder_id, external_id, preferences, shared_link, variables_schema) FROM stdin;
1	yzSkbyGosyNEUj	BrasilSupply	[{"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","name":"Contrato"}]	[{"uuid":"9488f909-5a4f-41ae-a97f-12c69e43af4f","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"nome_fornecedor","type":"text","required":true,"preferences":{},"areas":[{"x":0.2499690778327711,"y":0.2183086894774141,"w":0.1880783023256244,"h":0.01776672229334308,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"5271bf1d-20d1-4e7e-8cd0-bd0184a98ad2","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"cnpj","type":"text","required":true,"preferences":{},"areas":[{"x":0.1890575813524651,"y":0.2368880232146123,"w":0.1813597823634292,"h":0.01859277308030813,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"39947dd1-986d-47af-b1cb-942c4574fae4","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"n_proposta","type":"number","required":true,"preferences":{},"areas":[{"x":0.6857798027269768,"y":0.3831918823867273,"w":0.07141095941716968,"h":0.01826844288645302,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"e1090f46-a306-455e-bb2a-6fe45cd7c077","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"n_requisicao","type":"number","required":true,"preferences":{},"areas":[{"x":0.3266833334258109,"y":0.4012229712932059,"w":0.09979438781738281,"h":0.01879829233723479,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"6b8ffbb4-bd04-4c2e-b4a6-c5b373094122","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"data_assin","type":"text","required":true,"preferences":{},"areas":[{"x":0.1224913084702908,"y":0.7786511194884083,"w":0.3114578940651633,"h":0.01922428825953276,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"4ef1a733-25c5-4b7a-bfeb-1c59f56276ae","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"total","type":"text","required":true,"preferences":{},"areas":[{"x":0.4409543817693537,"y":0.4927422189328822,"w":0.1918017647483132,"h":0.0179739382115261,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"511ff0de-f9d9-4c43-bcb7-c19c0f67c9b2","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"prazo_entrega","type":"text","required":true,"preferences":{},"areas":[{"x":0.5656994906338778,"y":0.5308413278821096,"w":0.1563333453554095,"h":0.01803135680036116,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"5e28cc88-bde4-4575-a3b9-473f530b0475","submitter_uuid":"3e5076be-f38c-4d27-96b4-03371e535849","name":"n_requisicao","type":"text","required":true,"preferences":{},"areas":[{"x":0.6348761356238163,"y":0.7137724870125046,"w":0.1434438878839667,"h":0.01863340365250088,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"f8dd2210-1102-4344-82b5-42453da30ef7","submitter_uuid":"ef770e09-642e-4111-95a4-2a6ef46264dd","name":"","type":"signature","required":true,"preferences":{},"areas":[{"x":0.6126738305941846,"y":0.8285435203980404,"w":0.2659608091024021,"h":0.04938706137631443,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]},{"uuid":"93d2cab4-323b-4165-ba18-7f0ea2eee2b1","submitter_uuid":"c9299cd3-2dbb-4777-8628-fcff31f8f36e","name":"","type":"signature","required":true,"preferences":{},"areas":[{"x":0.1164171144121365,"y":0.8336982727050781,"w":0.2555457885587863,"h":0.044952392578125,"attachment_uuid":"97146598-c54b-4738-90a0-447791d0fab0","page":0}]}]	[{"name":"BrasilSupply - Gerente","uuid":"c9299cd3-2dbb-4777-8628-fcff31f8f36e"},{"name":"Fornecedor","uuid":"ef770e09-642e-4111-95a4-2a6ef46264dd"},{"name":"Third Party","uuid":"3e5076be-f38c-4d27-96b4-03371e535849"}]	1	1	\N	2025-11-24 21:52:46.563691	2025-11-26 11:36:59.55359	native	1	\N	{}	f	\N
\.


--
-- Data for Name: user_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_configs (id, user_id, key, value, created_at, updated_at) FROM stdin;
1	1	show_app_tour	false	2025-11-26 11:36:08.380565	2025-11-26 11:36:08.380565
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email, role, encrypted_password, account_id, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, failed_attempts, unlock_token, locked_at, archived_at, created_at, updated_at, uuid, otp_secret, consumed_timestep, otp_required_for_login) FROM stdin;
1	Joao	Xavier	joaovitorm.xavier@gmail.com	admin	$2a$10$uLkpRPAAFbIO2Ae51yTfgeSKO3yras4in5qAH72YxYHWGFiuwPdC.	1	\N	\N	2025-11-24 17:55:04.672079	4	2025-11-26 11:32:44.405515	2025-11-26 03:59:26.397229	172.18.0.1	172.18.0.1	0	\N	\N	\N	2025-11-24 17:55:03.697242	2025-11-26 11:32:44.4103	75fffdc2-a40d-49c7-b28d-dd28669bd581	\N	\N	f
\.


--
-- Data for Name: webhook_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.webhook_attempts (id, webhook_event_id, response_body, response_status_code, attempt, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: webhook_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.webhook_events (id, uuid, webhook_url_id, account_id, record_id, record_type, event_type, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: webhook_urls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.webhook_urls (id, account_id, url, events, sha1, created_at, updated_at, secret) FROM stdin;
\.


--
-- Name: access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.access_tokens_id_seq', 1, true);


--
-- Name: account_accesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_accesses_id_seq', 1, false);


--
-- Name: account_configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_configs_id_seq', 1, true);


--
-- Name: account_linked_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_linked_accounts_id_seq', 1, false);


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 1, true);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 14, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 12, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: completed_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.completed_documents_id_seq', 4, true);


--
-- Name: completed_submitters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.completed_submitters_id_seq', 4, true);


--
-- Name: console1984_commands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.console1984_commands_id_seq', 1, false);


--
-- Name: console1984_sensitive_accesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.console1984_sensitive_accesses_id_seq', 1, false);


--
-- Name: console1984_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.console1984_sessions_id_seq', 1, false);


--
-- Name: console1984_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.console1984_users_id_seq', 1, false);


--
-- Name: document_generation_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_generation_events_id_seq', 1, false);


--
-- Name: email_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.email_events_id_seq', 6, true);


--
-- Name: email_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.email_messages_id_seq', 1, false);


--
-- Name: encrypted_configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.encrypted_configs_id_seq', 3, true);


--
-- Name: encrypted_user_configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.encrypted_user_configs_id_seq', 1, false);


--
-- Name: lock_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lock_events_id_seq', 12, true);


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth_access_grants_id_seq', 1, false);


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth_access_tokens_id_seq', 1, false);


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth_applications_id_seq', 1, false);


--
-- Name: search_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.search_entries_id_seq', 5, true);


--
-- Name: submission_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.submission_events_id_seq', 16, true);


--
-- Name: submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.submissions_id_seq', 2, true);


--
-- Name: submitters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.submitters_id_seq', 4, true);


--
-- Name: template_accesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.template_accesses_id_seq', 1, false);


--
-- Name: template_folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.template_folders_id_seq', 1, true);


--
-- Name: template_sharings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.template_sharings_id_seq', 1, false);


--
-- Name: templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.templates_id_seq', 1, true);


--
-- Name: user_configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_configs_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: webhook_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.webhook_attempts_id_seq', 1, false);


--
-- Name: webhook_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.webhook_events_id_seq', 1, false);


--
-- Name: webhook_urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.webhook_urls_id_seq', 1, false);


--
-- Name: access_tokens access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_pkey PRIMARY KEY (id);


--
-- Name: account_accesses account_accesses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_accesses
    ADD CONSTRAINT account_accesses_pkey PRIMARY KEY (id);


--
-- Name: account_configs account_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_configs
    ADD CONSTRAINT account_configs_pkey PRIMARY KEY (id);


--
-- Name: account_linked_accounts account_linked_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_linked_accounts
    ADD CONSTRAINT account_linked_accounts_pkey PRIMARY KEY (id);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: completed_documents completed_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_documents
    ADD CONSTRAINT completed_documents_pkey PRIMARY KEY (id);


--
-- Name: completed_submitters completed_submitters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_submitters
    ADD CONSTRAINT completed_submitters_pkey PRIMARY KEY (id);


--
-- Name: console1984_commands console1984_commands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.console1984_commands
    ADD CONSTRAINT console1984_commands_pkey PRIMARY KEY (id);


--
-- Name: console1984_sensitive_accesses console1984_sensitive_accesses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.console1984_sensitive_accesses
    ADD CONSTRAINT console1984_sensitive_accesses_pkey PRIMARY KEY (id);


--
-- Name: console1984_sessions console1984_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.console1984_sessions
    ADD CONSTRAINT console1984_sessions_pkey PRIMARY KEY (id);


--
-- Name: console1984_users console1984_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.console1984_users
    ADD CONSTRAINT console1984_users_pkey PRIMARY KEY (id);


--
-- Name: document_generation_events document_generation_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_generation_events
    ADD CONSTRAINT document_generation_events_pkey PRIMARY KEY (id);


--
-- Name: email_events email_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_events
    ADD CONSTRAINT email_events_pkey PRIMARY KEY (id);


--
-- Name: email_messages email_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_messages
    ADD CONSTRAINT email_messages_pkey PRIMARY KEY (id);


--
-- Name: encrypted_configs encrypted_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encrypted_configs
    ADD CONSTRAINT encrypted_configs_pkey PRIMARY KEY (id);


--
-- Name: encrypted_user_configs encrypted_user_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encrypted_user_configs
    ADD CONSTRAINT encrypted_user_configs_pkey PRIMARY KEY (id);


--
-- Name: lock_events lock_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lock_events
    ADD CONSTRAINT lock_events_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_grants oauth_access_grants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_applications oauth_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_applications
    ADD CONSTRAINT oauth_applications_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: search_entries search_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.search_entries
    ADD CONSTRAINT search_entries_pkey PRIMARY KEY (id);


--
-- Name: submission_events submission_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission_events
    ADD CONSTRAINT submission_events_pkey PRIMARY KEY (id);


--
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: submitters submitters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submitters
    ADD CONSTRAINT submitters_pkey PRIMARY KEY (id);


--
-- Name: template_accesses template_accesses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template_accesses
    ADD CONSTRAINT template_accesses_pkey PRIMARY KEY (id);


--
-- Name: template_folders template_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template_folders
    ADD CONSTRAINT template_folders_pkey PRIMARY KEY (id);


--
-- Name: template_sharings template_sharings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template_sharings
    ADD CONSTRAINT template_sharings_pkey PRIMARY KEY (id);


--
-- Name: templates templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT templates_pkey PRIMARY KEY (id);


--
-- Name: user_configs user_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_configs
    ADD CONSTRAINT user_configs_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webhook_attempts webhook_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_attempts
    ADD CONSTRAINT webhook_attempts_pkey PRIMARY KEY (id);


--
-- Name: webhook_events webhook_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_events
    ADD CONSTRAINT webhook_events_pkey PRIMARY KEY (id);


--
-- Name: webhook_urls webhook_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_urls
    ADD CONSTRAINT webhook_urls_pkey PRIMARY KEY (id);


--
-- Name: idx_on_account_id_linked_account_id_48ab9f79d2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_on_account_id_linked_account_id_48ab9f79d2 ON public.account_linked_accounts USING btree (account_id, linked_account_id);


--
-- Name: idx_on_record_type_record_id_name_blob_id_0be5805727; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_on_record_type_record_id_name_blob_id_0be5805727 ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_access_tokens_on_sha256; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_access_tokens_on_sha256 ON public.access_tokens USING btree (sha256);


--
-- Name: index_access_tokens_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_access_tokens_on_user_id ON public.access_tokens USING btree (user_id);


--
-- Name: index_account_accesses_on_account_id_and_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_account_accesses_on_account_id_and_user_id ON public.account_accesses USING btree (account_id, user_id);


--
-- Name: index_account_configs_on_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_account_configs_on_account_id ON public.account_configs USING btree (account_id);


--
-- Name: index_account_configs_on_account_id_and_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_account_configs_on_account_id_and_key ON public.account_configs USING btree (account_id, key);


--
-- Name: index_account_linked_accounts_on_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_account_linked_accounts_on_account_id ON public.account_linked_accounts USING btree (account_id);


--
-- Name: index_account_linked_accounts_on_linked_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_account_linked_accounts_on_linked_account_id ON public.account_linked_accounts USING btree (linked_account_id);


--
-- Name: index_accounts_on_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_accounts_on_uuid ON public.accounts USING btree (uuid);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_on_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_active_storage_attachments_on_uuid ON public.active_storage_attachments USING btree (uuid);


--
-- Name: index_active_storage_blobs_on_checksum; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_active_storage_blobs_on_checksum ON public.active_storage_blobs USING btree (checksum);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_blobs_on_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_uuid ON public.active_storage_blobs USING btree (uuid);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_completed_documents_on_sha256; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_completed_documents_on_sha256 ON public.completed_documents USING btree (sha256);


--
-- Name: index_completed_documents_on_submitter_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_completed_documents_on_submitter_id ON public.completed_documents USING btree (submitter_id);


--
-- Name: index_completed_submitters_account_id_completed_at_is_first; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_completed_submitters_account_id_completed_at_is_first ON public.completed_submitters USING btree (account_id, completed_at) WHERE (is_first = true);


--
-- Name: index_completed_submitters_on_account_id_and_completed_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_completed_submitters_on_account_id_and_completed_at ON public.completed_submitters USING btree (account_id, completed_at);


--
-- Name: index_completed_submitters_on_submission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_completed_submitters_on_submission_id ON public.completed_submitters USING btree (submission_id) WHERE (is_first = true);


--
-- Name: index_completed_submitters_on_submitter_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_completed_submitters_on_submitter_id ON public.completed_submitters USING btree (submitter_id);


--
-- Name: index_console1984_commands_on_sensitive_access_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_console1984_commands_on_sensitive_access_id ON public.console1984_commands USING btree (sensitive_access_id);


--
-- Name: index_console1984_sensitive_accesses_on_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_console1984_sensitive_accesses_on_session_id ON public.console1984_sensitive_accesses USING btree (session_id);


--
-- Name: index_console1984_sessions_on_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_console1984_sessions_on_created_at ON public.console1984_sessions USING btree (created_at);


--
-- Name: index_console1984_sessions_on_user_id_and_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_console1984_sessions_on_user_id_and_created_at ON public.console1984_sessions USING btree (user_id, created_at);


--
-- Name: index_console1984_users_on_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_console1984_users_on_username ON public.console1984_users USING btree (username);


--
-- Name: index_document_generation_events_on_submitter_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_document_generation_events_on_submitter_id ON public.document_generation_events USING btree (submitter_id);


--
-- Name: index_document_generation_events_on_submitter_id_and_event_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_document_generation_events_on_submitter_id_and_event_name ON public.document_generation_events USING btree (submitter_id, event_name) WHERE ((event_name)::text = ANY ((ARRAY['start'::character varying, 'complete'::character varying])::text[]));


--
-- Name: index_email_events_on_account_id_and_event_datetime; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_email_events_on_account_id_and_event_datetime ON public.email_events USING btree (account_id, event_datetime);


--
-- Name: index_email_events_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_email_events_on_email ON public.email_events USING btree (email);


--
-- Name: index_email_events_on_email_event_types; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_email_events_on_email_event_types ON public.email_events USING btree (email) WHERE ((event_type)::text = ANY ((ARRAY['bounce'::character varying, 'soft_bounce'::character varying, 'permanent_bounce'::character varying, 'complaint'::character varying, 'soft_complaint'::character varying])::text[]));


--
-- Name: index_email_events_on_emailable; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_email_events_on_emailable ON public.email_events USING btree (emailable_type, emailable_id);


--
-- Name: index_email_events_on_message_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_email_events_on_message_id ON public.email_events USING btree (message_id);


--
-- Name: index_email_messages_on_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_email_messages_on_account_id ON public.email_messages USING btree (account_id);


--
-- Name: index_email_messages_on_sha1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_email_messages_on_sha1 ON public.email_messages USING btree (sha1);


--
-- Name: index_email_messages_on_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_email_messages_on_uuid ON public.email_messages USING btree (uuid);


--
-- Name: index_encrypted_configs_on_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_encrypted_configs_on_account_id ON public.encrypted_configs USING btree (account_id);


--
-- Name: index_encrypted_configs_on_account_id_and_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_encrypted_configs_on_account_id_and_key ON public.encrypted_configs USING btree (account_id, key);


--
-- Name: index_encrypted_user_configs_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_encrypted_user_configs_on_user_id ON public.encrypted_user_configs USING btree (user_id);


--
-- Name: index_encrypted_user_configs_on_user_id_and_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_encrypted_user_configs_on_user_id_and_key ON public.encrypted_user_configs USING btree (user_id, key);


--
-- Name: index_lock_events_on_event_name_and_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_lock_events_on_event_name_and_key ON public.lock_events USING btree (event_name, key) WHERE ((event_name)::text = ANY ((ARRAY['start'::character varying, 'complete'::character varying])::text[]));


--
-- Name: index_lock_events_on_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_lock_events_on_key ON public.lock_events USING btree (key);


--
-- Name: index_oauth_access_grants_on_application_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_oauth_access_grants_on_application_id ON public.oauth_access_grants USING btree (application_id);


--
-- Name: index_oauth_access_grants_on_resource_owner_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_oauth_access_grants_on_resource_owner_id ON public.oauth_access_grants USING btree (resource_owner_id);


--
-- Name: index_oauth_access_grants_on_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_oauth_access_grants_on_token ON public.oauth_access_grants USING btree (token);


--
-- Name: index_oauth_access_tokens_on_application_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_oauth_access_tokens_on_application_id ON public.oauth_access_tokens USING btree (application_id);


--
-- Name: index_oauth_access_tokens_on_refresh_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_refresh_token ON public.oauth_access_tokens USING btree (refresh_token);


--
-- Name: index_oauth_access_tokens_on_resource_owner_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_oauth_access_tokens_on_resource_owner_id ON public.oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: index_oauth_access_tokens_on_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_token ON public.oauth_access_tokens USING btree (token);


--
-- Name: index_oauth_applications_on_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_oauth_applications_on_uid ON public.oauth_applications USING btree (uid);


--
-- Name: index_search_entries_on_account_id_ngram_submission; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_search_entries_on_account_id_ngram_submission ON public.search_entries USING gin (account_id, tsvector) WHERE ((record_type)::text = 'Submission'::text);


--
-- Name: index_search_entries_on_account_id_ngram_submitter; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_search_entries_on_account_id_ngram_submitter ON public.search_entries USING gin (account_id, tsvector) WHERE ((record_type)::text = 'Submitter'::text);


--
-- Name: index_search_entries_on_account_id_ngram_template; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_search_entries_on_account_id_ngram_template ON public.search_entries USING gin (account_id, tsvector) WHERE ((record_type)::text = 'Template'::text);


--
-- Name: index_search_entries_on_account_id_tsvector_submission; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_search_entries_on_account_id_tsvector_submission ON public.search_entries USING gin (account_id, tsvector) WHERE ((record_type)::text = 'Submission'::text);


--
-- Name: index_search_entries_on_account_id_tsvector_submitter; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_search_entries_on_account_id_tsvector_submitter ON public.search_entries USING gin (account_id, tsvector) WHERE ((record_type)::text = 'Submitter'::text);


--
-- Name: index_search_entries_on_account_id_tsvector_template; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_search_entries_on_account_id_tsvector_template ON public.search_entries USING gin (account_id, tsvector) WHERE ((record_type)::text = 'Template'::text);


--
-- Name: index_search_entries_on_record_id_and_record_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_search_entries_on_record_id_and_record_type ON public.search_entries USING btree (record_id, record_type);


--
-- Name: index_submission_events_on_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submission_events_on_account_id ON public.submission_events USING btree (account_id);


--
-- Name: index_submission_events_on_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submission_events_on_created_at ON public.submission_events USING btree (created_at);


--
-- Name: index_submission_events_on_submission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submission_events_on_submission_id ON public.submission_events USING btree (submission_id);


--
-- Name: index_submission_events_on_submitter_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submission_events_on_submitter_id ON public.submission_events USING btree (submitter_id);


--
-- Name: index_submissions_events_on_sms_event_types; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submissions_events_on_sms_event_types ON public.submission_events USING btree (account_id, created_at) WHERE ((event_type)::text = ANY ((ARRAY['send_sms'::character varying, 'send_2fa_sms'::character varying])::text[]));


--
-- Name: index_submissions_on_account_id_and_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submissions_on_account_id_and_id ON public.submissions USING btree (account_id, id);


--
-- Name: index_submissions_on_account_id_and_template_id_and_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submissions_on_account_id_and_template_id_and_id ON public.submissions USING btree (account_id, template_id, id) WHERE (archived_at IS NULL);


--
-- Name: index_submissions_on_account_id_and_template_id_and_id_archived; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submissions_on_account_id_and_template_id_and_id_archived ON public.submissions USING btree (account_id, template_id, id) WHERE (archived_at IS NOT NULL);


--
-- Name: index_submissions_on_created_by_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submissions_on_created_by_user_id ON public.submissions USING btree (created_by_user_id);


--
-- Name: index_submissions_on_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_submissions_on_slug ON public.submissions USING btree (slug);


--
-- Name: index_submissions_on_template_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submissions_on_template_id ON public.submissions USING btree (template_id);


--
-- Name: index_submitters_on_account_id_and_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submitters_on_account_id_and_id ON public.submitters USING btree (account_id, id);


--
-- Name: index_submitters_on_completed_at_and_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submitters_on_completed_at_and_account_id ON public.submitters USING btree (completed_at, account_id);


--
-- Name: index_submitters_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submitters_on_email ON public.submitters USING btree (email);


--
-- Name: index_submitters_on_external_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submitters_on_external_id ON public.submitters USING btree (external_id);


--
-- Name: index_submitters_on_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_submitters_on_slug ON public.submitters USING btree (slug);


--
-- Name: index_submitters_on_submission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_submitters_on_submission_id ON public.submitters USING btree (submission_id);


--
-- Name: index_template_accesses_on_template_id_and_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_template_accesses_on_template_id_and_user_id ON public.template_accesses USING btree (template_id, user_id);


--
-- Name: index_template_folders_on_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_template_folders_on_account_id ON public.template_folders USING btree (account_id);


--
-- Name: index_template_folders_on_author_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_template_folders_on_author_id ON public.template_folders USING btree (author_id);


--
-- Name: index_template_folders_on_parent_folder_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_template_folders_on_parent_folder_id ON public.template_folders USING btree (parent_folder_id);


--
-- Name: index_template_sharings_on_account_id_and_template_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_template_sharings_on_account_id_and_template_id ON public.template_sharings USING btree (account_id, template_id);


--
-- Name: index_template_sharings_on_template_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_template_sharings_on_template_id ON public.template_sharings USING btree (template_id);


--
-- Name: index_templates_on_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_templates_on_account_id ON public.templates USING btree (account_id);


--
-- Name: index_templates_on_account_id_and_folder_id_and_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_templates_on_account_id_and_folder_id_and_id ON public.templates USING btree (account_id, folder_id, id) WHERE (archived_at IS NULL);


--
-- Name: index_templates_on_account_id_and_id_archived; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_templates_on_account_id_and_id_archived ON public.templates USING btree (account_id, id) WHERE (archived_at IS NOT NULL);


--
-- Name: index_templates_on_author_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_templates_on_author_id ON public.templates USING btree (author_id);


--
-- Name: index_templates_on_external_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_templates_on_external_id ON public.templates USING btree (external_id);


--
-- Name: index_templates_on_folder_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_templates_on_folder_id ON public.templates USING btree (folder_id);


--
-- Name: index_templates_on_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_templates_on_slug ON public.templates USING btree (slug);


--
-- Name: index_user_configs_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_user_configs_on_user_id ON public.user_configs USING btree (user_id);


--
-- Name: index_user_configs_on_user_id_and_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_user_configs_on_user_id_and_key ON public.user_configs USING btree (user_id, key);


--
-- Name: index_users_on_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_account_id ON public.users USING btree (account_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: index_users_on_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_uuid ON public.users USING btree (uuid);


--
-- Name: index_webhook_attempts_on_webhook_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_webhook_attempts_on_webhook_event_id ON public.webhook_attempts USING btree (webhook_event_id);


--
-- Name: index_webhook_events_error; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_webhook_events_error ON public.webhook_events USING btree (webhook_url_id, id) WHERE ((status)::text = 'error'::text);


--
-- Name: index_webhook_events_on_uuid_and_webhook_url_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_webhook_events_on_uuid_and_webhook_url_id ON public.webhook_events USING btree (uuid, webhook_url_id);


--
-- Name: index_webhook_events_on_webhook_url_id_and_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_webhook_events_on_webhook_url_id_and_id ON public.webhook_events USING btree (webhook_url_id, id);


--
-- Name: index_webhook_urls_on_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_webhook_urls_on_account_id ON public.webhook_urls USING btree (account_id);


--
-- Name: index_webhook_urls_on_sha1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_webhook_urls_on_sha1 ON public.webhook_urls USING btree (sha1);


--
-- Name: on_session_and_sensitive_chronologically; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX on_session_and_sensitive_chronologically ON public.console1984_commands USING btree (session_id, created_at, sensitive_access_id);


--
-- Name: document_generation_events fk_rails_085330ed31; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_generation_events
    ADD CONSTRAINT fk_rails_085330ed31 FOREIGN KEY (submitter_id) REFERENCES public.submitters(id);


--
-- Name: template_accesses fk_rails_0f863123fb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template_accesses
    ADD CONSTRAINT fk_rails_0f863123fb FOREIGN KEY (template_id) REFERENCES public.templates(id);


--
-- Name: account_accesses fk_rails_176557ded0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_accesses
    ADD CONSTRAINT fk_rails_176557ded0 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: oauth_access_grants fk_rails_330c32d8d9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_access_grants
    ADD CONSTRAINT fk_rails_330c32d8d9 FOREIGN KEY (resource_owner_id) REFERENCES public.users(id);


--
-- Name: submission_events fk_rails_35626e1b39; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission_events
    ADD CONSTRAINT fk_rails_35626e1b39 FOREIGN KEY (submitter_id) REFERENCES public.submitters(id);


--
-- Name: account_linked_accounts fk_rails_3c40e05fc4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_linked_accounts
    ADD CONSTRAINT fk_rails_3c40e05fc4 FOREIGN KEY (linked_account_id) REFERENCES public.accounts(id);


--
-- Name: email_messages fk_rails_409a34bccd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_messages
    ADD CONSTRAINT fk_rails_409a34bccd FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: user_configs fk_rails_5cf2a5cf3f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_configs
    ADD CONSTRAINT fk_rails_5cf2a5cf3f FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: users fk_rails_61ac11da2b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_61ac11da2b FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: template_folders fk_rails_61bf58d5da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template_folders
    ADD CONSTRAINT fk_rails_61bf58d5da FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: templates fk_rails_62c324200c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT fk_rails_62c324200c FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: webhook_urls fk_rails_65d3485cdc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_urls
    ADD CONSTRAINT fk_rails_65d3485cdc FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: submissions fk_rails_6775c667db; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT fk_rails_6775c667db FOREIGN KEY (created_by_user_id) REFERENCES public.users(id);


--
-- Name: oauth_access_tokens fk_rails_732cb83ab7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT fk_rails_732cb83ab7 FOREIGN KEY (application_id) REFERENCES public.oauth_applications(id);


--
-- Name: email_messages fk_rails_7ffd76ae80; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_messages
    ADD CONSTRAINT fk_rails_7ffd76ae80 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: template_folders fk_rails_87e6045a21; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template_folders
    ADD CONSTRAINT fk_rails_87e6045a21 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: access_tokens fk_rails_96fc070778; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT fk_rails_96fc070778 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: encrypted_configs fk_rails_970191b375; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encrypted_configs
    ADD CONSTRAINT fk_rails_970191b375 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: submitters fk_rails_9a9fdc7d97; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submitters
    ADD CONSTRAINT fk_rails_9a9fdc7d97 FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: account_configs fk_rails_a2acef1258; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_configs
    ADD CONSTRAINT fk_rails_a2acef1258 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: template_sharings fk_rails_a8b8b5d769; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template_sharings
    ADD CONSTRAINT fk_rails_a8b8b5d769 FOREIGN KEY (template_id) REFERENCES public.templates(id);


--
-- Name: encrypted_user_configs fk_rails_af70f8b679; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encrypted_user_configs
    ADD CONSTRAINT fk_rails_af70f8b679 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: template_folders fk_rails_af7badda67; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template_folders
    ADD CONSTRAINT fk_rails_af7badda67 FOREIGN KEY (parent_folder_id) REFERENCES public.template_folders(id);


--
-- Name: oauth_access_grants fk_rails_b4b53e07b8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_access_grants
    ADD CONSTRAINT fk_rails_b4b53e07b8 FOREIGN KEY (application_id) REFERENCES public.oauth_applications(id);


--
-- Name: account_linked_accounts fk_rails_babfe524b4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_linked_accounts
    ADD CONSTRAINT fk_rails_babfe524b4 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: submission_events fk_rails_bc10565389; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission_events
    ADD CONSTRAINT fk_rails_bc10565389 FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: submissions fk_rails_e231d41194; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT fk_rails_e231d41194 FOREIGN KEY (template_id) REFERENCES public.templates(id);


--
-- Name: submission_events fk_rails_e5af398185; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission_events
    ADD CONSTRAINT fk_rails_e5af398185 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: email_events fk_rails_ebcdb85e34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_events
    ADD CONSTRAINT fk_rails_ebcdb85e34 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: oauth_access_tokens fk_rails_ee63f25419; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT fk_rails_ee63f25419 FOREIGN KEY (resource_owner_id) REFERENCES public.users(id);


--
-- Name: templates fk_rails_efe27d1756; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT fk_rails_efe27d1756 FOREIGN KEY (folder_id) REFERENCES public.template_folders(id);


--
-- Name: templates fk_rails_fda62a9821; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT fk_rails_fda62a9821 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- PostgreSQL database dump complete
--

\unrestrict f7g6ZC83miwhUKfKrfOfRydavdKBVkoSL0qsZKN1yGBh2NOzJ5Upcev9enw1D4R

