--
-- PostgreSQL database dump
--

-- Dumped from database version 10.2
-- Dumped by pg_dump version 10.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: contract_number(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION contract_number(contract_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
  contract_type_code VARCHAR(200);
BEGIN
  SELECT code
  FROM dictionaries
  INTO contract_type_code WHERE id = ( SELECT type_id FROM contract WHERE id = contract_id);

  contract_type_code = replace(contract_type_code, '{0}', (SELECT code
                                                           FROM dictionaries
                                                           WHERE id = (SELECT company_id
                                                                       FROM ppk
                                                                       WHERE id = (SELECT ppk_id
                                                                                   FROM contract
                                                                                   WHERE id = contract_id))));
  contract_type_code = replace(contract_type_code, '{1}', (SELECT code
                                                           FROM dictionaries
                                                           WHERE id = (SELECT region_id
                                                                       FROM ppk
                                                                       WHERE id = (SELECT ppk_id
                                                                                   FROM contract
                                                                                   WHERE id = contract_id))));
  contract_type_code = replace(contract_type_code, '{2}', (SELECT code
                                                           FROM dictionaries
                                                           WHERE id = (SELECT dashboard_type_id
                                                                       FROM ppk
                                                                       WHERE id = (SELECT ppk_id
                                                                                   FROM contract
                                                                                   WHERE id = contract_id))));
  contract_type_code = replace(contract_type_code, '{3}', (SELECT dashboard_number :: VARCHAR
                                                           FROM ppk
                                                           WHERE id = (SELECT ppk_id
                                                                       FROM contract
                                                                       WHERE id = contract_id)));
  contract_type_code = replace(contract_type_code, '{4}', (SELECT dashboard_cell
                                                           FROM ppk
                                                           WHERE id = (SELECT ppk_id
                                                                       FROM contract
                                                                       WHERE id = contract_id)));
  RETURN contract_type_code;
END;
$$;


--
-- Name: end_of_month(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION end_of_month(date) RETURNS date
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT (date_trunc('month', $1) + INTERVAL '1 month' - INTERVAL '1 day') :: DATE;
$_$;


--
-- Name: end_of_month(timestamp with time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION end_of_month(timestamp with time zone) RETURNS date
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT (date_trunc('month', $1) + INTERVAL '1 month' - INTERVAL '1 day') :: DATE;
$_$;


--
-- Name: number_to_string(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION number_to_string(n integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
  ans  VARCHAR(100);
  dig1 INTEGER;
  dig2 INTEGER;
  dig3 INTEGER;
BEGIN
  ans:='';
  dig2:=floor(n / 1000);
  dig1:= n - dig2 * 1000;
  IF dig2 > 0
  THEN
    dig3:= dig2 - 100 * floor(dig2 / 100);
    ans:= concat(thousand_to_string(dig2));
    IF dig3 = 1
    THEN
      ans:= concat(ans, ' тисяча');
    ELSE IF dig3 > 1 AND dig3 < 5
    THEN ans:= concat(ans, ' тисячі');
    ELSE ans:= concat(ans, ' тисяч');
    END IF;
    END IF;
  END IF;

  IF dig1 > 0
  THEN
    ans:= concat(ans, ' ', thousand_to_string(dig1));
    IF dig1 = 1
    THEN
      ans:= concat(ans, ' гривня');
    ELSE IF dig1 > 1 AND dig1 < 5
    THEN ans := concat(ans, ' гривні');
    ELSE ans := concat(ans, ' гривень');
    END IF;
    END IF;
  END IF;
  RETURN ans;
END;
$$;


--
-- Name: ppk_number(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ppk_number(ppk_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN (SELECT trim(TRAILING '-' FROM concat(
      (SELECT code
       FROM dictionaries
       WHERE id = p.company_id), '-',
      (SELECT code
       FROM dictionaries
       WHERE id = p.region_id),
      '-',
      (SELECT code
       FROM dictionaries
       WHERE id = p.dashboard_type_id),
      p.dashboard_number,
      lpad(p.dashboard_cell :: TEXT, 3, '0')
  ))
          FROM ppk p
          WHERE p.id = ppk_id);
END;
$$;


--
-- Name: thousand_to_string(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION thousand_to_string(n integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
  ans  VARCHAR(100);
  dig1 INTEGER;
  dig2 INTEGER;
  dig3 INTEGER;
BEGIN
  ans:= '';

  dig3:= floor(n / 100);
  dig2:= floor(n / 10) - dig3 * 10;
  dig1 = n - (dig3 * 100 + dig2 * 10);

  IF dig3 > 0
  THEN
    CASE
      WHEN dig3 = 1
      THEN ans:= concat(ans, 'сто');
      WHEN dig3 = 2
      THEN ans:= concat(ans, 'двісті');
      WHEN dig3 = 3
      THEN ans:= concat(ans, 'триста');
      WHEN dig3 = 4
      THEN ans:= concat(ans, 'чотириста');
      WHEN dig3 = 5
      THEN ans:= concat(ans, 'п''ятсот');
      WHEN dig3 = 6
      THEN ans = concat(ans, 'шістсот');
      WHEN dig3 = 7
      THEN ans = concat(ans, 'сімсот');
      WHEN dig3 = 8
      THEN ans = concat(ans, 'вісімсот');
      WHEN dig3 = 9
      THEN ans := concat(ans, 'дев''ятсот');
    ELSE ans := ans;
    END CASE;
  END IF;

  IF dig2 = 1
  THEN
    CASE
      WHEN (dig2 * 10 + dig1) = 10
      THEN ans := concat(ans, ' десять');
      WHEN (dig2 * 10 + dig1) = 11
      THEN ans := concat(ans, ' одинадцять');
      WHEN (dig2 * 10 + dig1) = 12
      THEN ans := concat(ans, ' двенадцять');
      WHEN (dig2 * 10 + dig1) = 13
      THEN ans := concat(ans, ' тринадцять');
      WHEN (dig2 * 10 + dig1) = 14
      THEN ans := concat(ans, ' чотирнадцять');
      WHEN (dig2 * 10 + dig1) = 15
      THEN ans := concat(ans, ' п''ятнадцять');
      WHEN (dig2 * 10 + dig1) = 16
      THEN ans := concat(ans, ' шістнадцять');
      WHEN (dig2 * 10 + dig1) = 17
      THEN ans := concat(ans, ' сімнадцять');
      WHEN (dig2 * 10 + dig1) = 18
      THEN ans := concat(ans, ' вісімнадцять');
      WHEN (dig2 * 10 + dig1) = 19
      THEN ans := concat(ans, ' дев''ятнацять');
    ELSE ans := ans;
    END CASE;
  ELSE
    IF dig2 > 0
    THEN
      CASE
        WHEN dig2 = 2
        THEN ans := concat(ans, ' двадцять');
        WHEN dig2 = 3
        THEN ans := concat(ans, ' тридцять');
        WHEN dig2 = 4
        THEN ans := concat(ans, ' сорок');
        WHEN dig2 = 5
        THEN ans := concat(ans, ' п''ятдесят');
        WHEN dig2 = 6
        THEN ans := concat(ans, ' шістдесят');
        WHEN dig2 = 7
        THEN ans := concat(ans, ' сімдесят');
        WHEN dig2 = 8
        THEN ans := concat(ans, ' вісімдесят');
        WHEN dig2 = 9
        THEN ans := concat(ans, ' дев''яносто');
      ELSE ans := ans;
      END CASE;
    END IF;
    IF dig1 > 0
    THEN
      CASE
        WHEN dig1 = 1
        THEN ans := concat(ans, ' одна');
        WHEN dig1 = 2
        THEN ans := concat(ans, ' дві');
        WHEN dig1 = 3
        THEN ans := concat(ans, ' три');
        WHEN dig1 = 4
        THEN ans := concat(ans, ' чотири');
        WHEN dig1 = 5
        THEN ans := concat(ans, ' п''ять');
        WHEN dig1 = 6
        THEN ans := concat(ans, ' шість');
        WHEN dig1 = 7
        THEN ans := concat(ans, ' сімь');
        WHEN dig1 = 8
        THEN ans := concat(ans, ' вісім');
        WHEN dig1 = 9
        THEN ans := concat(ans, ' д''евять');
      ELSE ans := ans;
      END CASE;
    END IF;
  END IF;
  RETURN trim(ans);
END;
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: contract; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE contract (
    id integer NOT NULL,
    ppk_id integer,
    type_id integer,
    deposit boolean DEFAULT false,
    social_project boolean DEFAULT false,
    sms_guard_switch boolean DEFAULT false,
    sms_alarm boolean DEFAULT false
);


--
-- Name: contract_state; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE contract_state (
    id integer NOT NULL,
    contract_id integer,
    start_date date,
    end_date date,
    state_id integer,
    payment integer,
    refund integer
);


--
-- Name: contract_state_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW contract_state_view AS
 SELECT contract_number(c.id) AS contract_number,
    c.id AS contract_id,
    c.type_id AS contract_type_id,
    c.ppk_id,
    c.social_project,
    c.sms_alarm,
    c.sms_guard_switch,
    cs.id,
    cs.start_date,
    cs.end_date,
    cs.state_id,
    cs.payment,
    cs.refund,
    c.deposit
   FROM contract c,
    contract_state cs
  WHERE (c.id = cs.contract_id);


--
-- Name: months_ukr; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW months_ukr AS
 SELECT monthers.column1 AS number,
    monthers.column2 AS title
   FROM ( VALUES (1,'Січень'::text), (2,'Лютий'::text), (3,'Березень'::text), (4,'Квітень'::text), (5,'Травень'::text), (6,'Червень'::text), (7,'Липень'::text), (8,'Серпень'::text), (9,'Вересень'::text), (10,'Жовтень'::text), (11,'Листопад'::text), (12,'Грудень'::text)) monthers;


--
-- Name: ppk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ppk (
    id integer NOT NULL,
    dashboard_type_id integer,
    dashboard_number integer,
    region_id integer,
    company_id integer,
    object_type_id integer,
    description character varying(600),
    reaction_time integer,
    payment_note character varying(600) DEFAULT NULL::character varying,
    increase character varying(600) DEFAULT NULL::character varying,
    history character varying(600) DEFAULT NULL::character varying,
    tech_history character varying(600) DEFAULT NULL::character varying,
    manager_id integer,
    manager_company_id integer,
    note character varying(600),
    latitude double precision,
    longitude double precision,
    status_id integer,
    sim_card2 character varying(50),
    dashboard_subtype_id integer,
    came_from_id integer,
    pay_till_day integer DEFAULT 15,
    dashboard_property character varying(100),
    dashboard_cell character varying(3),
    location_street character varying(200),
    location_house integer,
    location_korpus integer,
    location_apartments integer,
    create_date date DEFAULT now(),
    location_city character varying(200),
    location_region character varying(200),
    location_entrance integer,
    location_floor integer,
    sim_card1 character varying(50)
);


--
-- Name: ppk_interval_dates; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW ppk_interval_dates AS
 SELECT dates.ppk_id,
    (dates.start_date + dates.increment) AS date,
    date_part('year'::text, (dates.start_date + dates.increment)) AS year,
    date_part('month'::text, (dates.start_date + dates.increment)) AS month,
    ( SELECT months_ukr.title
           FROM months_ukr
          WHERE ((months_ukr.number)::double precision = date_part('month'::text, (dates.start_date + dates.increment)))) AS month_name,
    ( SELECT (date_part('day'::text, ((end_of_month((dates.start_date + dates.increment)))::timestamp with time zone - date_trunc('month'::text, ((dates.start_date + dates.increment))::timestamp with time zone))) + (1)::double precision)) AS month_duration
   FROM ( SELECT "interval".ppk_id,
            "interval".start_date,
            "interval".end_date,
            generate_series(0, ("interval".end_date - "interval".start_date)) AS increment
           FROM ( SELECT contract_state_view.ppk_id,
                    min(contract_state_view.start_date) AS start_date,
                    max(COALESCE(contract_state_view.end_date, end_of_month(((CURRENT_DATE + '1 mon'::interval))::timestamp with time zone))) AS end_date
                   FROM contract_state_view
                  GROUP BY contract_state_view.ppk_id) "interval") dates;


--
-- Name: ppk_payment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ppk_payment (
    id integer NOT NULL,
    ppk_id integer,
    type_id integer,
    create_date date,
    amount integer,
    description character varying(200)
);


--
-- Name: acc_additional_fee_by_month; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW acc_additional_fee_by_month AS
 SELECT d.ppk_id,
    d.year,
    d.month,
    d.month_name,
    sum(COALESCE(p.amount, 0)) AS amount
   FROM (ppk_interval_dates d
     LEFT JOIN ( SELECT ppk_payment.id,
            ppk_payment.ppk_id,
            ppk_payment.type_id,
            ppk_payment.create_date,
            ppk_payment.amount
           FROM ppk_payment
          WHERE (ppk_payment.type_id = 104)) p ON (((p.ppk_id = d.ppk_id) AND (p.create_date = d.date))))
  GROUP BY d.ppk_id, d.year, d.month, d.month_name
UNION ALL
 SELECT ppk.id AS ppk_id,
    '-1'::integer AS year,
    '-1'::integer AS month,
    'Депозитний місяць'::text AS month_name,
    NULL::bigint AS amount
   FROM ppk;


--
-- Name: acc_aditional_fee_by_month; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW acc_aditional_fee_by_month AS
 SELECT d.ppk_id,
    date_part('year'::text, d.date) AS year,
    date_part('month'::text, d.date) AS month,
    sum(p.amount) AS amount
   FROM (ppk_payment p
     LEFT JOIN ppk_interval_dates d ON (((p.create_date = d.date) AND (p.ppk_id = d.ppk_id))))
  WHERE (p.type_id = 103)
  GROUP BY d.ppk_id, (date_part('year'::text, d.date)), (date_part('month'::text, d.date));


--
-- Name: acc_payment_by_month; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW acc_payment_by_month AS
 SELECT d.ppk_id,
    d.year,
    d.month,
    d.month_name,
    sum(COALESCE(p.amount, 0)) AS amount
   FROM (ppk_interval_dates d
     LEFT JOIN ( SELECT ppk_payment.id,
            ppk_payment.ppk_id,
            ppk_payment.type_id,
            ppk_payment.create_date,
            ppk_payment.amount
           FROM ppk_payment
          WHERE (ppk_payment.type_id = 103)) p ON (((p.ppk_id = d.ppk_id) AND (p.create_date = d.date))))
  GROUP BY d.ppk_id, d.year, d.month, d.month_name;


--
-- Name: acc_subscription_fee_by_month; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW acc_subscription_fee_by_month AS
 SELECT dd.ppk_id,
    dd.contract_id,
    dd.year,
    dd.month,
    dd.month_name,
    COALESCE(round(sum(dd.amount_per_day)), (0)::double precision) AS amount
   FROM ( SELECT d.ppk_id,
            c.id AS contract_id,
            d.year,
            d.month,
            d.month_name,
            ( SELECT ((contract_state.payment)::double precision / d.month_duration)
                   FROM contract_state
                  WHERE ((contract_state.contract_id = c.id) AND ((d.date >= contract_state.start_date) AND (d.date <= COALESCE(contract_state.end_date, end_of_month(((('now'::text)::date + '1 mon'::interval))::timestamp with time zone)))))) AS amount_per_day
           FROM ppk_interval_dates d,
            contract c
          WHERE (d.ppk_id = c.ppk_id)
        UNION ALL
         SELECT contract.ppk_id,
            contract.id AS contract_id,
            '-1'::integer AS int4,
            '-1'::integer AS int4,
            'Депозитний місяць'::text AS text,
                CASE
                    WHEN contract.deposit THEN ( SELECT contract_state.payment
                       FROM contract_state
                      WHERE (contract_state.contract_id = contract.id)
                      ORDER BY contract_state.start_date
                     LIMIT 1)
                    ELSE 0
                END AS "case"
           FROM contract) dd
  GROUP BY dd.ppk_id, dd.contract_id, dd.year, dd.month, dd.month_name;


--
-- Name: access_level; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE access_level (
    id integer NOT NULL,
    name character varying(45) DEFAULT NULL::character varying
);


--
-- Name: access_level_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE access_level_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: access_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE access_level_id_seq OWNED BY access_level.id;


--
-- Name: account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE account (
    id integer NOT NULL,
    login character varying(255) DEFAULT NULL::character varying,
    password character varying(255) DEFAULT NULL::character varying
);


--
-- Name: account_access_level; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE account_access_level (
    account_id integer NOT NULL,
    access_level_id integer NOT NULL
);


--
-- Name: account_access_level_access_level_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE account_access_level_access_level_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_access_level_access_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE account_access_level_access_level_id_seq OWNED BY account_access_level.access_level_id;


--
-- Name: account_access_level_account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE account_access_level_account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_access_level_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE account_access_level_account_id_seq OWNED BY account_access_level.account_id;


--
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE account_id_seq OWNED BY account.id;


--
-- Name: android_account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE android_account (
    id integer NOT NULL,
    name character varying(200),
    password character varying(200)
);


--
-- Name: android_account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE android_account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: android_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE android_account_id_seq OWNED BY android_account.id;


--
-- Name: ppk_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ppk_files (
    id integer NOT NULL,
    ppk_id integer NOT NULL,
    scheme bytea,
    map bytea,
    map_details bytea
);


--
-- Name: contract_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contract_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contract_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contract_files_id_seq OWNED BY ppk_files.id;


--
-- Name: contract_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contract_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contract_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contract_id_seq OWNED BY ppk.id;


--
-- Name: contract_id_seq1; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contract_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contract_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contract_id_seq1 OWNED BY contract.id;


--
-- Name: ppk_person; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ppk_person (
    ppk_id integer NOT NULL,
    person_id integer NOT NULL,
    owner boolean DEFAULT false,
    payer boolean DEFAULT false,
    alarm boolean DEFAULT false,
    advisor boolean DEFAULT false
);


--
-- Name: contract_person_contract_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contract_person_contract_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contract_person_contract_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contract_person_contract_id_seq OWNED BY ppk_person.ppk_id;


--
-- Name: contract_person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contract_person_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contract_person_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contract_person_person_id_seq OWNED BY ppk_person.person_id;


--
-- Name: contract_reports_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE contract_reports_settings (
    id integer NOT NULL,
    contract_type_id integer,
    title character varying(200),
    template character varying(200)
);


--
-- Name: contract_reports_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contract_reports_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contract_reports_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contract_reports_settings_id_seq OWNED BY contract_reports_settings.id;


--
-- Name: contract_state_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contract_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contract_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contract_state_id_seq OWNED BY contract_state.id;


--
-- Name: contract_state_report; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE contract_state_report (
    id integer NOT NULL,
    contract_state_id integer,
    title character varying(200),
    template character varying(200),
    files bytea
);


--
-- Name: contract_state_report_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contract_state_report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contract_state_report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contract_state_report_id_seq OWNED BY contract_state_report.id;


--
-- Name: contract_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW contract_view AS
 SELECT c.id,
    c.ppk_id,
    c.type_id,
    c.deposit,
    c.social_project,
    c.sms_alarm,
    c.sms_guard_switch,
    contract_number(c.id) AS contract_number
   FROM contract c;


--
-- Name: dictionaries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dictionaries (
    id integer NOT NULL,
    parent_id integer,
    code character varying(255) DEFAULT NULL::character varying,
    title character varying(255) DEFAULT NULL::character varying
);


--
-- Name: dictionaries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dictionaries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dictionaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dictionaries_id_seq OWNED BY dictionaries.id;


--
-- Name: person; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE person (
    id integer NOT NULL,
    name character varying(42),
    phone character varying(25),
    email character varying(40),
    fax character varying(20),
    skype character varying(20),
    note character varying(40),
    type_id integer NOT NULL,
    inn character varying(20),
    passport_number character varying(20),
    passport_institute character varying(2000),
    registration character varying(2000),
    fact_address character varying(2000),
    edrpo character varying(17),
    registration_date date,
    ipn character varying(12),
    vat character varying(8),
    account character varying(20),
    bank character varying(200),
    mfo character varying(6),
    cto character varying(200)
);


--
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE person_id_seq OWNED BY person.id;


--
-- Name: ping_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ping_log (
    id integer NOT NULL,
    android_account_id integer,
    stack_trace character varying(2500),
    ts bigint NOT NULL
);


--
-- Name: ping_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ping_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ping_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ping_log_id_seq OWNED BY ping_log.id;


--
-- Name: pong_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pong_log (
    id integer NOT NULL,
    android_account_id integer,
    lat character varying(10),
    lng character varying(10),
    ts bigint NOT NULL
);


--
-- Name: pong_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pong_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pong_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pong_log_id_seq OWNED BY pong_log.id;


--
-- Name: ppk_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ppk_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ppk_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ppk_payment_id_seq OWNED BY ppk_payment.id;


--
-- Name: ppk_person_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW ppk_person_view AS
 SELECT ppkp.ppk_id,
    ppkp.person_id,
    p.name,
    p.cto,
    p.type_id,
    ( SELECT d.title
           FROM dictionaries d
          WHERE (d.id = p.type_id)) AS type,
    p.registration,
    p.fact_address,
    p.account,
    p.bank,
    p.mfo,
    p.edrpo,
    p.ipn,
    p.inn,
    p.vat,
    p.phone,
    p.email,
    p.fax,
    p.skype,
    p.note,
    ppkp.owner,
    ppkp.payer,
    ppkp.alarm,
    ppkp.advisor
   FROM ppk_person ppkp,
    person p
  WHERE (ppkp.person_id = p.id);


--
-- Name: ppk_reminder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ppk_reminder (
    id integer NOT NULL,
    ppk_id integer,
    action_date date DEFAULT now() NOT NULL,
    type_id integer NOT NULL,
    description character varying(255) DEFAULT NULL::character varying
);


--
-- Name: ppk_reminder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ppk_reminder_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ppk_reminder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ppk_reminder_id_seq OWNED BY ppk_reminder.id;


--
-- Name: ppk_required_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ppk_required_documents (
    id integer NOT NULL,
    ppk_id integer,
    valid_till date,
    notes character varying(200),
    title character varying(200) NOT NULL,
    status_id integer NOT NULL
);


--
-- Name: ppk_required_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ppk_required_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ppk_required_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ppk_required_documents_id_seq OWNED BY ppk_required_documents.id;


--
-- Name: ppk_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW ppk_view AS
 SELECT ppk_number(p.id) AS ppk_number,
    p.id,
    p.create_date,
    p.dashboard_type_id,
    p.dashboard_subtype_id,
    p.dashboard_number,
    p.dashboard_cell,
    p.region_id,
    p.company_id,
    p.object_type_id,
    p.description,
    p.reaction_time,
    p.increase,
    p.history,
    p.tech_history,
    p.manager_id,
    p.manager_company_id,
    p.note,
    p.latitude,
    p.longitude,
    p.status_id,
    p.sim_card1,
    p.sim_card2,
    p.came_from_id,
    p.pay_till_day,
    p.dashboard_property,
    p.location_city,
    p.location_region,
    p.location_street,
    p.location_house,
    p.location_korpus,
    p.location_apartments,
    p.location_entrance,
    p.location_floor,
    ( SELECT (count(*) > 0)
           FROM ppk_payment pp
          WHERE ((pp.ppk_id = p.id) AND (pp.type_id = 89))) AS deposit_month,
    COALESCE(( SELECT pp.amount
           FROM ppk_payment pp
          WHERE ((pp.ppk_id = p.id) AND (pp.type_id = 90))), 0) AS balance,
    ( SELECT pp.description
           FROM ppk_payment pp
          WHERE ((pp.ppk_id = p.id) AND (pp.type_id = 90))) AS balance_description,
    ( SELECT (count(*) = 0)
           FROM ppk_required_documents
          WHERE ((ppk_required_documents.ppk_id = p.id) AND (((ppk_required_documents.valid_till IS NULL) AND (ppk_required_documents.status_id = 145)) OR ((ppk_required_documents.valid_till < now()) AND (ppk_required_documents.status_id <> 147))))) AS documents_completed,
    COALESCE(p.status_id, ( SELECT
                CASE
                    WHEN (count(*) > 0) THEN 100
                    ELSE 101
                END AS "case"
           FROM contract c,
            contract_state cs
          WHERE ((c.id = cs.contract_id) AND (c.ppk_id = p.id) AND (cs.state_id = 92)))) AS state_id,
    COALESCE(( SELECT sum(a.fee) AS debit
           FROM ( SELECT sum(round(
                        CASE
                            WHEN (acc_subscription_fee_by_month.month = (3)::double precision) THEN round((acc_subscription_fee_by_month.amount * (0.9678)::double precision))
                            ELSE acc_subscription_fee_by_month.amount
                        END)) AS fee
                   FROM acc_subscription_fee_by_month
                  WHERE (acc_subscription_fee_by_month.ppk_id = p.id)
                UNION ALL
                 SELECT sum(round((acc_additional_fee_by_month.amount)::double precision)) AS sum
                   FROM acc_additional_fee_by_month
                  WHERE (acc_additional_fee_by_month.ppk_id = p.id)) a), (0)::double precision) AS debit,
    ( SELECT COALESCE(sum(acc_payment_by_month.amount), (0)::numeric) AS credit
           FROM acc_payment_by_month
          WHERE (acc_payment_by_month.ppk_id = p.id)) AS credit,
    ( SELECT max(c.refund) AS max
           FROM contract_state_view c
          WHERE (c.ppk_id = p.id)) AS max_refund
   FROM ppk p;


--
-- Name: rank; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW rank AS
 SELECT a.n
   FROM ( SELECT (((a_1.digit + (10 * b.digit)) + (100 * c.digit)) + (1000 * d.digit)) AS n
           FROM (((( SELECT 0 AS digit
                UNION ALL
                 SELECT 1
                UNION ALL
                 SELECT 2
                UNION ALL
                 SELECT 3
                UNION ALL
                 SELECT 4
                UNION ALL
                 SELECT 5
                UNION ALL
                 SELECT 6
                UNION ALL
                 SELECT 7
                UNION ALL
                 SELECT 8
                UNION ALL
                 SELECT 9) a_1
             CROSS JOIN ( SELECT 0 AS digit
                UNION ALL
                 SELECT 1
                UNION ALL
                 SELECT 2
                UNION ALL
                 SELECT 3
                UNION ALL
                 SELECT 4
                UNION ALL
                 SELECT 5
                UNION ALL
                 SELECT 6
                UNION ALL
                 SELECT 7
                UNION ALL
                 SELECT 8
                UNION ALL
                 SELECT 9) b)
             CROSS JOIN ( SELECT 0 AS digit
                UNION ALL
                 SELECT 1
                UNION ALL
                 SELECT 2
                UNION ALL
                 SELECT 3
                UNION ALL
                 SELECT 4
                UNION ALL
                 SELECT 5
                UNION ALL
                 SELECT 6
                UNION ALL
                 SELECT 7
                UNION ALL
                 SELECT 8
                UNION ALL
                 SELECT 9) c)
             CROSS JOIN ( SELECT 0 AS digit
                UNION ALL
                 SELECT 1
                UNION ALL
                 SELECT 2
                UNION ALL
                 SELECT 3
                UNION ALL
                 SELECT 4
                UNION ALL
                 SELECT 5
                UNION ALL
                 SELECT 6
                UNION ALL
                 SELECT 7
                UNION ALL
                 SELECT 8
                UNION ALL
                 SELECT 9) d)) a
  WHERE ((a.n <> 1000) AND (a.n > 0));


--
-- Name: sirius_company; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sirius_company (
    id integer NOT NULL,
    name character varying(200),
    cto character varying(200),
    license character varying(200),
    requisits character varying(2000)
);


--
-- Name: access_level id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY access_level ALTER COLUMN id SET DEFAULT nextval('access_level_id_seq'::regclass);


--
-- Name: account id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY account ALTER COLUMN id SET DEFAULT nextval('account_id_seq'::regclass);


--
-- Name: account_access_level account_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_access_level ALTER COLUMN account_id SET DEFAULT nextval('account_access_level_account_id_seq'::regclass);


--
-- Name: account_access_level access_level_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_access_level ALTER COLUMN access_level_id SET DEFAULT nextval('account_access_level_access_level_id_seq'::regclass);


--
-- Name: android_account id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY android_account ALTER COLUMN id SET DEFAULT nextval('android_account_id_seq'::regclass);


--
-- Name: contract id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract ALTER COLUMN id SET DEFAULT nextval('contract_id_seq1'::regclass);


--
-- Name: contract_reports_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract_reports_settings ALTER COLUMN id SET DEFAULT nextval('contract_reports_settings_id_seq'::regclass);


--
-- Name: contract_state id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract_state ALTER COLUMN id SET DEFAULT nextval('contract_state_id_seq'::regclass);


--
-- Name: contract_state_report id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract_state_report ALTER COLUMN id SET DEFAULT nextval('contract_state_report_id_seq'::regclass);


--
-- Name: dictionaries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dictionaries ALTER COLUMN id SET DEFAULT nextval('dictionaries_id_seq'::regclass);


--
-- Name: person id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY person ALTER COLUMN id SET DEFAULT nextval('person_id_seq'::regclass);


--
-- Name: ping_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ping_log ALTER COLUMN id SET DEFAULT nextval('ping_log_id_seq'::regclass);


--
-- Name: pong_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pong_log ALTER COLUMN id SET DEFAULT nextval('pong_log_id_seq'::regclass);


--
-- Name: ppk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk ALTER COLUMN id SET DEFAULT nextval('contract_id_seq'::regclass);


--
-- Name: ppk_files id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_files ALTER COLUMN id SET DEFAULT nextval('contract_files_id_seq'::regclass);


--
-- Name: ppk_payment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_payment ALTER COLUMN id SET DEFAULT nextval('ppk_payment_id_seq'::regclass);


--
-- Name: ppk_person ppk_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_person ALTER COLUMN ppk_id SET DEFAULT nextval('contract_person_contract_id_seq'::regclass);


--
-- Name: ppk_person person_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_person ALTER COLUMN person_id SET DEFAULT nextval('contract_person_person_id_seq'::regclass);


--
-- Name: ppk_reminder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_reminder ALTER COLUMN id SET DEFAULT nextval('ppk_reminder_id_seq'::regclass);


--
-- Name: ppk_required_documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_required_documents ALTER COLUMN id SET DEFAULT nextval('ppk_required_documents_id_seq'::regclass);


--
-- Data for Name: access_level; Type: TABLE DATA; Schema: public; Owner: -
--

COPY access_level (id, name) FROM stdin;
1	ROLE_USER
2	ROLE_ADMIN
\.


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: -
--

COPY account (id, login, password) FROM stdin;
1	admin	$2a$11$568dxJXP57hWhVPO36o.suTzVDaymaikMQKvHJdAV0DVAFeZuKrUW
\.


--
-- Data for Name: account_access_level; Type: TABLE DATA; Schema: public; Owner: -
--

COPY account_access_level (account_id, access_level_id) FROM stdin;
1	1
\.


--
-- Data for Name: android_account; Type: TABLE DATA; Schema: public; Owner: -
--

COPY android_account (id, name, password) FROM stdin;
1	user1	
2	user2	
\.


--
-- Data for Name: contract; Type: TABLE DATA; Schema: public; Owner: -
--

COPY contract (id, ppk_id, type_id, deposit, social_project, sms_guard_switch, sms_alarm) FROM stdin;
\.


--
-- Data for Name: contract_reports_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY contract_reports_settings (id, contract_type_id, title, template) FROM stdin;
1	10	Сигналізація	jrx file
2	10	Сигналізація нагляд	jrx file
3	10	СІРІУС ДУ 6 міс безк	jrx file
4	10	СІРІУС ДУ підвищення абпл	jrx file
5	10	СІРІУС ДУ підвищення абпл	jrx file
6	10	СІРІУС ДУ підключи друга	jrx file
7	10	СІРІУС ДУ про розрив	jrx file
8	11	Кнопка тривоги	jrx file
9	12	Оренда	jrx file
\.


--
-- Data for Name: contract_state; Type: TABLE DATA; Schema: public; Owner: -
--

COPY contract_state (id, contract_id, start_date, end_date, state_id, payment, refund) FROM stdin;
\.


--
-- Data for Name: contract_state_report; Type: TABLE DATA; Schema: public; Owner: -
--

COPY contract_state_report (id, contract_state_id, title, template, files) FROM stdin;
\.


--
-- Data for Name: dictionaries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dictionaries (id, parent_id, code, title) FROM stdin;
1	\N	\N	Позначення договорів
2	\N	\N	Регіон
3	\N	\N	Компанія
4	\N	\N	Тип пульту
5	\N	\N	Об’єкт
7	\N	\N	Доп. позначення
8	\N	\N	Тип договору
20	2	01	Київська область
21	2	02	Вінницька область
22	2	03	Волинська область
23	2	04	Дніпропетровська область
24	2	05	Донецька область
25	2	06	Житомирська область
26	2	07	Закарпатська область‎
27	2	08	Запорізька область
28	2	09	Івано-Франківська область
29	2	10	Кіровоградська область
30	2	11	Луганська область‎
31	2	12	Львівська область
32	2	13	Миколаївська область
33	2	14	Одеська область
34	2	15	Полтавська область
35	2	16	Рівненська область
36	2	17	Сумська область
37	2	18	Тернопільська область
38	2	19	Харківська область
39	2	20	Херсонська область
40	2	21	Хмельницька область
41	2	22	Черкаська область‎
42	2	23	Чернівецька область‎
43	2	24	Чернігівська область
44	2	25	Крим
45	3	С	Сіріус
46	3	СП	Сіріус Пульт
47	4	0	Без пiдключення на пульт
48	4	1	Макс
49	4	2	Лунь
50	4	3	Грифон
51	4	4	Оріон
52	4	5	Дунай
53	5	\N	Квартира
54	5	\N	Будинок
55	5	\N	Магазин
59	7	Т	тривожна кнопка
60	7	О	оренда обладнання
61	8	0	Зв’язанi
62	8	1	Корпоративнi
65	\N	\N	Партнери
66	\N	\N	Менеджери
67	65	\N	Сiрiус
68	65	\N	Партнери
70	67	\N	Миколенко
71	67	\N	Хрустицька
72	67	\N	Куценко
73	67	\N	Доманський
74	67	\N	Бондар
75	67	\N	Реус
76	5	\N	Кіоск
77	5	\N	Офіс
69	68	\N	Зiновiй
84	68	\N	Захист-12
10	1	{0}-П-{1}-{2}{3}{4}	пультова охорона
11	1	{0}-П-{1}-{2}{3}{4}-Т	тривожна кнопка
12	1	{0}-П-{1}-{2}{3}{4}-О	оренда обладнання
85	1	{0}-П-{1}-{2}{3}{4}-0	Виклик по телефону
86	1	{0}-П-{1}-{2}{3}{4}-1	ГШР біля об’єкту, без реагування
87	1	{0}-П-{1}-{2}{3}{4}-2	ГШР біля об’єкту, з реагуванням
88	\N	Payments	Типи оплат
89	88	Депозитний місяць	Депозитний місяць
90	88	Z внесок	Z внесок
91	6	\N	відсутній
92	6	\N	охороняється
93	6	\N	відключено
94	\N	Типи суб’єктів	Типи суб’єктів
95	94	Юридична особа	Юридична особа
96	94	Фізична особа підприємець	ФОП
97	94	Фізична особа	Фізична особа
98	94	Контактна особа	Контактна особа
6	\N	\N	Стан контракту
99	\N	ППК статус	ППК статус
100	99	Охороняється	Охороняється
101	99	Призупинено	Призупинено
102	99	Відключено	Відключено
103	88	Внесок	Внесок
104	88	Ложна тревога	Ложна тревога
105	\N	ppk_sub_type	Підтип ППК
132	120	Прийшов від	Прийшов від
124	123	2	Подзвонити з приводу АП
125	123	22	Налаштувати обладнання
126	49	234	Lun1
111	50	code1	Grifon
128	48	укук	Макс1
120	\N	Клиент пришел-ушел	Клиент пришел-ушел
129	48	ваа	Макс2
123	\N	Типи нагадувачів	Типи нагадувачів
118	52	code2	Dunay1
127	51		Orion1
130	47	343434	
133	\N	ppk_required_document	Необхідні документи до ППК
134	133	Паспорт	Паспорт
135	133	Ідентифікаційний код	Ідентифікаційний код
136	133	Свідоцтво держ реєстрації	Свідоцтво держ реєстрації
137	133	Справка статуправління	Справка статуправління
138	133	Справка платниика податків	Справка платниика податків
139	133	Документ, що підтвержує повноваження керівника	Документ, що підтвержує повноваження керівника
140	133	Статус	Статут
141	133	Реквізити	Реквізити
142	133	Право власності	Право власності
143	133	Заява	Заява
144	\N	ppk_required_document_status	ppk_required_document_status
145	144	Немає	Немає
146	144	Є	Є
147	144	Не треба	Не треба
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: -
--

COPY person (id, name, phone, email, fax, skype, note, type_id, inn, passport_number, passport_institute, registration, fact_address, edrpo, registration_date, ipn, vat, account, bank, mfo, cto) FROM stdin;
\.


--
-- Data for Name: ping_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ping_log (id, android_account_id, stack_trace, ts) FROM stdin;
1	1	\N	1521627705471
2	1	\N	1521627745785
3	1	\N	1521627819721
4	1	\N	1521627821894
5	1	\N	1521627823909
6	1	\N	1521627825924
7	1	\N	1521627827942
8	1	\N	1521627829956
9	1	\N	1521627831973
10	1	\N	1521627833990
11	1	\N	1521627836004
12	1	\N	1521627838019
13	1	\N	1521627840035
14	1	\N	1521627842051
15	1	\N	1521627844065
16	1	\N	1521627846079
17	1	\N	1521627848096
18	1	\N	1521627850114
19	1	\N	1521627852129
20	1	\N	1521627854143
21	1	\N	1521627856159
22	1	\N	1521627858175
23	1	\N	1521627860190
24	1	\N	1521627862199
25	1	\N	1521627864210
26	1	\N	1521627866222
27	1	\N	1521627868237
28	1	\N	1521627870253
29	1	\N	1521627872276
30	1	\N	1521627874284
31	1	\N	1521627876301
32	1	\N	1521627878315
33	1	\N	1521627880331
34	1	\N	1521627882348
35	1	\N	1521627884362
36	1	\N	1521627886378
37	1	\N	1521627888387
38	1	\N	1521627890410
39	1	\N	1521627892425
40	1	\N	1521627894441
41	1	\N	1521627896457
42	1	\N	1521627898472
43	1	\N	1521627900487
44	1	\N	1521627902518
45	1	\N	1521627904535
46	1	\N	1521627926628
47	1	\N	1521627928643
48	1	\N	1521627930665
49	1	\N	1521627932675
50	1	\N	1521627934693
51	1	\N	1521627936706
52	1	\N	1521627938721
53	1	\N	1521627940737
54	1	\N	1521627942752
55	1	\N	1521627944765
56	1	\N	1521627946784
57	1	\N	1521627948800
58	1	\N	1521627950815
59	1	\N	1521627952830
60	1	\N	1521627954846
61	1	\N	1521627956863
62	1	\N	1521627958881
63	1	\N	1521648243788
64	1	\N	1521648245980
65	1	\N	1521648248009
66	1	\N	1521648250029
67	1	\N	1521648252054
68	1	\N	1521648254074
69	1	\N	1521648318990
70	1	\N	1521648321122
71	1	\N	1521648323150
72	1	\N	1521648325160
73	1	\N	1521648327168
74	1	\N	1521648329180
75	1	\N	1521648794042
76	1	\N	1521648796233
77	1	\N	1521648798247
78	1	\N	1521648800260
79	1	\N	1521648802286
80	1	\N	1521648804298
81	1	\N	1521648806308
82	1	\N	1521648808319
83	1	\N	1521648810329
84	1	\N	1521648812339
85	1	\N	1521649132014
86	1	\N	1521649134152
87	1	\N	1521649136159
88	1	\N	1521649138170
\.


--
-- Data for Name: pong_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY pong_log (id, android_account_id, lat, lng, ts) FROM stdin;
1	1	lat	lng	1521627819721
2	1	lat	lng	1521627821894
3	1	lat	lng	1521627823909
4	1	lat	lng	1521627825924
5	1	lat	lng	1521627827942
6	1	lat	lng	1521627829956
7	1	lat	lng	1521627831973
8	1	lat	lng	1521627833990
9	1	lat	lng	1521627836004
10	1	lat	lng	1521627838019
11	1	lat	lng	1521627840035
12	1	lat	lng	1521627842051
13	1	lat	lng	1521627844065
14	1	lat	lng	1521627846079
15	1	lat	lng	1521627848096
16	1	lat	lng	1521627850114
17	1	lat	lng	1521627852129
18	1	lat	lng	1521627854143
19	1	lat	lng	1521627856159
20	1	lat	lng	1521627858175
21	1	lat	lng	1521627860190
22	1	lat	lng	1521627862199
23	1	lat	lng	1521627864210
24	1	lat	lng	1521627866222
25	1	lat	lng	1521627868237
26	1	lat	lng	1521627870253
27	1	lat	lng	1521627872276
28	1	lat	lng	1521627874284
29	1	lat	lng	1521627876301
30	1	lat	lng	1521627878315
31	1	lat	lng	1521627880331
32	1	lat	lng	1521627882348
33	1	lat	lng	1521627884362
34	1	lat	lng	1521627886378
35	1	lat	lng	1521627888387
36	1	lat	lng	1521627890410
37	1	lat	lng	1521627892425
38	1	lat	lng	1521627894441
39	1	lat	lng	1521627896457
40	1	lat	lng	1521627898472
41	1	lat	lng	1521627900487
42	1	lat	lng	1521627902518
43	1	lat	lng	1521627904535
44	1	lat	lng	1521627926628
45	1	lat	lng	1521627928643
46	1	lat	lng	1521627930665
47	1	lat	lng	1521627932675
48	1	lat	lng	1521627934693
49	1	lat	lng	1521627936706
50	1	lat	lng	1521627938721
51	1	lat	lng	1521627940737
52	1	lat	lng	1521627942752
53	1	lat	lng	1521627944765
54	1	lat	lng	1521627946784
55	1	lat	lng	1521627948800
56	1	lat	lng	1521627950815
57	1	lat	lng	1521627952830
58	1	lat	lng	1521627954846
59	1	lat	lng	1521627956863
60	1	lat	lng	1521627958881
61	1	lat	lng	1521648243788
62	1	lat	lng	1521648245980
63	1	lat	lng	1521648248009
64	1	lat	lng	1521648250029
65	1	lat	lng	1521648252054
66	1	lat	lng	1521648254074
67	1	lat	lng	1521648318990
68	1	lat	lng	1521648321122
69	1	lat	lng	1521648323150
70	1	lat	lng	1521648325160
71	1	lat	lng	1521648327168
72	1	lat	lng	1521648329180
73	1	lat	lng	1521648794042
74	1	lat	lng	1521648796233
75	1	lat	lng	1521648798247
76	1	lat	lng	1521648800260
77	1	lat	lng	1521648802286
78	1	lat	lng	1521648804298
79	1	lat	lng	1521648806308
80	1	lat	lng	1521648808319
81	1	lat	lng	1521648810329
82	1	lat	lng	1521648812339
83	1	lat	lng	1521649132014
84	1	lat	lng	1521649134152
85	1	lat	lng	1521649136159
86	1	lat	lng	1521649138170
\.


--
-- Data for Name: ppk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ppk (id, dashboard_type_id, dashboard_number, region_id, company_id, object_type_id, description, reaction_time, payment_note, increase, history, tech_history, manager_id, manager_company_id, note, latitude, longitude, status_id, sim_card2, dashboard_subtype_id, came_from_id, pay_till_day, dashboard_property, dashboard_cell, location_street, location_house, location_korpus, location_apartments, create_date, location_city, location_region, location_entrance, location_floor, sim_card1) FROM stdin;
\.


--
-- Data for Name: ppk_files; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ppk_files (id, ppk_id, scheme, map, map_details) FROM stdin;
\.


--
-- Data for Name: ppk_payment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ppk_payment (id, ppk_id, type_id, create_date, amount, description) FROM stdin;
\.


--
-- Data for Name: ppk_person; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ppk_person (ppk_id, person_id, owner, payer, alarm, advisor) FROM stdin;
\.


--
-- Data for Name: ppk_reminder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ppk_reminder (id, ppk_id, action_date, type_id, description) FROM stdin;
\.


--
-- Data for Name: ppk_required_documents; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ppk_required_documents (id, ppk_id, valid_till, notes, title, status_id) FROM stdin;
\.


--
-- Data for Name: sirius_company; Type: TABLE DATA; Schema: public; Owner: -
--

COPY sirius_company (id, name, cto, license, requisits) FROM stdin;
45	Приватне підприємство «СІРІУС»	заступника директора з питань пультової охорони Сарнавської Віти Володимирівни	Довіреності № ДС-01-01-18 від 01 січня 2018 року та Ліцензії про надання послуг з охорони власності та громадян: серія АВ № 592009, виданої МВС України 01 серпня 2011 року	ПП «СІРІУС»\r\n        Юридична та поштова адреса:\r\n        03061, м. Київ, вул. Одеська -14\r\n        Р. рахунок № 26000140883\r\n        в «Райффайзен Банк Аваль» м. Київ,\r\n        МФО 380805, код ЄДРПОУ 32344175\r\n        Св-во про реєстрацію платника ПДВ № 36093439\r\n        ІПН 323441726585\r\n        Тел. 044-401-01-51, 228-88-42
46	Товариство з обмеженою відповідальністю «СІРІУС-ПУЛЬТ»	директора Сарнавської Віти Володимирівни	Статуту та Ліцензії про охоронну діяльність: серія АЕ № 262903, виданої МВС України 14 серпня 2013 року	ТОВ «СІРІУС-ПУЛЬТ»\r\n        Юридична та поштова адреса:\r\n        03061, м. Київ, вул. Одеська -14\r\n        Р. рахунок № 26000407344\r\n        в АТ «Райффайзен Банк Аваль» м. Київ,\r\n        МФО 380805, код ЄДРПОУ 38792572\r\n        ІПН 387925726588\r\n        Тел. 044-401-01-51, 044-228-88-42
\.


--
-- Name: access_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('access_level_id_seq', 2, true);


--
-- Name: account_access_level_access_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('account_access_level_access_level_id_seq', 1, false);


--
-- Name: account_access_level_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('account_access_level_account_id_seq', 1, false);


--
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('account_id_seq', 1, true);


--
-- Name: android_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('android_account_id_seq', 2, true);


--
-- Name: contract_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('contract_files_id_seq', 22, true);


--
-- Name: contract_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('contract_id_seq', 253, true);


--
-- Name: contract_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('contract_id_seq1', 98, true);


--
-- Name: contract_person_contract_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('contract_person_contract_id_seq', 1, false);


--
-- Name: contract_person_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('contract_person_person_id_seq', 1, false);


--
-- Name: contract_reports_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('contract_reports_settings_id_seq', 9, true);


--
-- Name: contract_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('contract_state_id_seq', 110, true);


--
-- Name: contract_state_report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('contract_state_report_id_seq', 234, true);


--
-- Name: dictionaries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dictionaries_id_seq', 147, true);


--
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('person_id_seq', 137, true);


--
-- Name: ping_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ping_log_id_seq', 88, true);


--
-- Name: pong_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('pong_log_id_seq', 86, true);


--
-- Name: ppk_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ppk_payment_id_seq', 90, true);


--
-- Name: ppk_reminder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ppk_reminder_id_seq', 26, true);


--
-- Name: ppk_required_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ppk_required_documents_id_seq', 130, true);


--
-- Name: access_level access_level_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY access_level
    ADD CONSTRAINT access_level_pkey PRIMARY KEY (id);


--
-- Name: account_access_level account_access_level_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_access_level
    ADD CONSTRAINT account_access_level_pkey PRIMARY KEY (account_id, access_level_id);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: android_account android_account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY android_account
    ADD CONSTRAINT android_account_pkey PRIMARY KEY (id);


--
-- Name: ppk_files contract_files_contract_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_files
    ADD CONSTRAINT contract_files_contract_id_key UNIQUE (ppk_id);


--
-- Name: ppk_files contract_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_files
    ADD CONSTRAINT contract_files_pkey PRIMARY KEY (id);


--
-- Name: ppk contract_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk
    ADD CONSTRAINT contract_pkey PRIMARY KEY (id);


--
-- Name: contract contract_pkey1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_pkey1 PRIMARY KEY (id);


--
-- Name: contract_reports_settings contract_reports_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract_reports_settings
    ADD CONSTRAINT contract_reports_settings_pkey PRIMARY KEY (id);


--
-- Name: contract_state contract_state_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract_state
    ADD CONSTRAINT contract_state_pkey PRIMARY KEY (id);


--
-- Name: contract_state_report contract_state_report_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract_state_report
    ADD CONSTRAINT contract_state_report_pkey PRIMARY KEY (id);


--
-- Name: dictionaries dictionaries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dictionaries
    ADD CONSTRAINT dictionaries_pkey PRIMARY KEY (id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: ping_log ping_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ping_log
    ADD CONSTRAINT ping_log_pkey PRIMARY KEY (id);


--
-- Name: pong_log pong_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pong_log
    ADD CONSTRAINT pong_log_pkey PRIMARY KEY (id);


--
-- Name: ppk_payment ppk_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_payment
    ADD CONSTRAINT ppk_payment_pkey PRIMARY KEY (id);


--
-- Name: ppk_reminder ppk_reminder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_reminder
    ADD CONSTRAINT ppk_reminder_pkey PRIMARY KEY (id);


--
-- Name: ppk_required_documents ppk_required_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_required_documents
    ADD CONSTRAINT ppk_required_documents_pkey PRIMARY KEY (id);


--
-- Name: sirius_company sirius_company_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sirius_company
    ADD CONSTRAINT sirius_company_pkey PRIMARY KEY (id);


--
-- Name: ppk came_from_id_dictionaries; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk
    ADD CONSTRAINT came_from_id_dictionaries FOREIGN KEY (came_from_id) REFERENCES dictionaries(id);


--
-- Name: ppk contract_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk
    ADD CONSTRAINT contract_company_id_fkey FOREIGN KEY (company_id) REFERENCES dictionaries(id);


--
-- Name: ppk contract_dashboard_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk
    ADD CONSTRAINT contract_dashboard_type_id_fkey FOREIGN KEY (dashboard_type_id) REFERENCES dictionaries(id);


--
-- Name: ppk_files contract_files_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_files
    ADD CONSTRAINT contract_files_contract_id_fkey FOREIGN KEY (ppk_id) REFERENCES ppk(id) ON DELETE CASCADE;


--
-- Name: ppk contract_manager_company_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk
    ADD CONSTRAINT contract_manager_company_id_fk FOREIGN KEY (manager_company_id) REFERENCES dictionaries(id);


--
-- Name: ppk contract_object_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk
    ADD CONSTRAINT contract_object_type_id_fkey FOREIGN KEY (object_type_id) REFERENCES dictionaries(id);


--
-- Name: ppk_person contract_person_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_person
    ADD CONSTRAINT contract_person_contract_id_fkey FOREIGN KEY (ppk_id) REFERENCES ppk(id);


--
-- Name: ppk_person contract_person_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_person
    ADD CONSTRAINT contract_person_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: contract contract_ppk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_ppk_id_fkey FOREIGN KEY (ppk_id) REFERENCES ppk(id);


--
-- Name: ppk contract_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk
    ADD CONSTRAINT contract_region_id_fkey FOREIGN KEY (region_id) REFERENCES dictionaries(id);


--
-- Name: contract_reports_settings contract_reports_settings_contract_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract_reports_settings
    ADD CONSTRAINT contract_reports_settings_contract_type_id_fkey FOREIGN KEY (contract_type_id) REFERENCES dictionaries(id);


--
-- Name: contract_state contract_state_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract_state
    ADD CONSTRAINT contract_state_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES contract(id);


--
-- Name: contract_state_report contract_state_report_contract_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract_state_report
    ADD CONSTRAINT contract_state_report_contract_state_id_fkey FOREIGN KEY (contract_state_id) REFERENCES contract_state(id);


--
-- Name: contract_state contract_state_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract_state
    ADD CONSTRAINT contract_state_state_id_fkey FOREIGN KEY (state_id) REFERENCES dictionaries(id);


--
-- Name: contract contract_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_type_id_fkey FOREIGN KEY (type_id) REFERENCES dictionaries(id);


--
-- Name: dictionaries dictionaries_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dictionaries
    ADD CONSTRAINT dictionaries_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES dictionaries(id);


--
-- Name: account_access_level fk_access_level_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_access_level
    ADD CONSTRAINT fk_access_level_id FOREIGN KEY (access_level_id) REFERENCES access_level(id);


--
-- Name: account_access_level fk_account_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_access_level
    ADD CONSTRAINT fk_account_id FOREIGN KEY (account_id) REFERENCES account(id);


--
-- Name: ppk_required_documents fk_status_dictionaties; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_required_documents
    ADD CONSTRAINT fk_status_dictionaties FOREIGN KEY (status_id) REFERENCES dictionaries(id);


--
-- Name: person person_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_type_id_fkey FOREIGN KEY (type_id) REFERENCES dictionaries(id);


--
-- Name: ping_log ping_log_android_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ping_log
    ADD CONSTRAINT ping_log_android_account_id_fkey FOREIGN KEY (android_account_id) REFERENCES android_account(id);


--
-- Name: pong_log pong_log_android_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pong_log
    ADD CONSTRAINT pong_log_android_account_id_fkey FOREIGN KEY (android_account_id) REFERENCES android_account(id);


--
-- Name: ppk ppk_dashboard_subtype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk
    ADD CONSTRAINT ppk_dashboard_subtype_id_fkey FOREIGN KEY (dashboard_subtype_id) REFERENCES dictionaries(id);


--
-- Name: ppk_payment ppk_payment_ppk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_payment
    ADD CONSTRAINT ppk_payment_ppk_id_fkey FOREIGN KEY (ppk_id) REFERENCES ppk(id);


--
-- Name: ppk_payment ppk_payment_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_payment
    ADD CONSTRAINT ppk_payment_type_id_fkey FOREIGN KEY (type_id) REFERENCES dictionaries(id);


--
-- Name: ppk_reminder ppk_reminder_ppk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_reminder
    ADD CONSTRAINT ppk_reminder_ppk_id_fkey FOREIGN KEY (ppk_id) REFERENCES ppk(id);


--
-- Name: ppk_reminder ppk_reminder_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_reminder
    ADD CONSTRAINT ppk_reminder_type_id_fkey FOREIGN KEY (type_id) REFERENCES dictionaries(id);


--
-- Name: ppk_required_documents ppk_required_documents_ppk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk_required_documents
    ADD CONSTRAINT ppk_required_documents_ppk_id_fkey FOREIGN KEY (ppk_id) REFERENCES ppk(id);


--
-- Name: ppk ppk_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ppk
    ADD CONSTRAINT ppk_status_id_fkey FOREIGN KEY (status_id) REFERENCES dictionaries(id);


--
-- PostgreSQL database dump complete
--

