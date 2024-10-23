--
-- PostgreSQL database cluster dump
--

-- Started on 2024-09-23 12:53:11

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:KqCOQmjsBPfGWtbyTARHrw==$EeyHFQo0W0Zpy4+jScotRcnlljSPT5Z+RilQXwn5ivc=:+6DpiBs9Kkn/DzREJieF87XU8PzBeC3zGkMgv95u3sQ=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-09-23 12:53:11

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

-- Completed on 2024-09-23 12:53:11

--
-- PostgreSQL database dump complete
--

--
-- Database "Master" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-09-23 12:53:11

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
-- TOC entry 4959 (class 1262 OID 16445)
-- Name: Master; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Master" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Bulgarian_Bulgaria.1251';


ALTER DATABASE "Master" OWNER TO postgres;

\connect "Master"

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
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 4959
-- Name: DATABASE "Master"; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE "Master" IS 'master proeject';


--
-- TOC entry 2 (class 3079 OID 16633)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 3 (class 3079 OID 16791)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 296 (class 1255 OID 16860)
-- Name: generate_user_key(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_user_key() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.key := uuid_generate_v4();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_user_key() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 236 (class 1259 OID 17878)
-- Name: OrderDetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OrderDetails" (
    order_detail_id integer NOT NULL,
    quantity integer NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    order_id integer,
    product_id integer
);


ALTER TABLE public."OrderDetails" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17877)
-- Name: OrderDetails_order_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."OrderDetails_order_detail_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."OrderDetails_order_detail_id_seq" OWNER TO postgres;

--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 235
-- Name: OrderDetails_order_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OrderDetails_order_detail_id_seq" OWNED BY public."OrderDetails".order_detail_id;


--
-- TOC entry 238 (class 1259 OID 17885)
-- Name: Orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Orders" (
    order_id integer NOT NULL,
    auth_key character varying(255) NOT NULL,
    date timestamp without time zone NOT NULL,
    total_amount numeric(10,2) NOT NULL
);


ALTER TABLE public."Orders" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17884)
-- Name: Orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Orders_order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Orders_order_id_seq" OWNER TO postgres;

--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 237
-- Name: Orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Orders_order_id_seq" OWNED BY public."Orders".order_id;


--
-- TOC entry 227 (class 1259 OID 16879)
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    key uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    username character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role character varying NOT NULL
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16805)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    price numeric(10,2) NOT NULL,
    quantity integer NOT NULL,
    image_url character varying(255),
    gender character(1) NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16814)
-- Name: femaleproducts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.femaleproducts (
    CONSTRAINT check_gender_female CHECK ((gender = 'F'::bpchar))
)
INHERITS (public.products);


ALTER TABLE public.femaleproducts OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16822)
-- Name: maleproducts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maleproducts (
    CONSTRAINT check_gender_male CHECK ((gender = 'M'::bpchar))
)
INHERITS (public.products);


ALTER TABLE public.maleproducts OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16908)
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    "totalAmount" numeric(10,2) NOT NULL,
    "userUserId" integer
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16929)
-- Name: order_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_details (
    order_detail_id integer NOT NULL,
    quantity integer NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    "orderId" integer,
    "productProductId" integer
);


ALTER TABLE public.order_details OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16928)
-- Name: order_details_order_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_details_order_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_details_order_detail_id_seq OWNER TO postgres;

--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 233
-- Name: order_details_order_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_details_order_detail_id_seq OWNED BY public.order_details.order_detail_id;


--
-- TOC entry 229 (class 1259 OID 16907)
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_id_seq OWNER TO postgres;

--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 229
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_id_seq OWNED BY public."order".id;


--
-- TOC entry 225 (class 1259 OID 16844)
-- Name: orderdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orderdetails (
    order_detail_id integer NOT NULL,
    quantity integer NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    "orderOrderId" integer,
    product_id integer
);


ALTER TABLE public.orderdetails OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16843)
-- Name: orderdetails_order_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orderdetails_order_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orderdetails_order_detail_id_seq OWNER TO postgres;

--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 224
-- Name: orderdetails_order_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orderdetails_order_detail_id_seq OWNED BY public.orderdetails.order_detail_id;


--
-- TOC entry 223 (class 1259 OID 16831)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    auth_key character varying(255) NOT NULL,
    date date DEFAULT ('now'::text)::date NOT NULL,
    total_amount numeric(10,2) NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16830)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 222
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 232 (class 1259 OID 16920)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    product_id integer NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL,
    price numeric(10,2) NOT NULL,
    quantity integer NOT NULL,
    gender character varying NOT NULL
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16919)
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_product_id_seq OWNER TO postgres;

--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 231
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_product_id_seq OWNED BY public.product.product_id;


--
-- TOC entry 218 (class 1259 OID 16804)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- TOC entry 4970 (class 0 OID 0)
-- Dependencies: 218
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- TOC entry 226 (class 1259 OID 16863)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    username character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role character varying NOT NULL,
    key uuid DEFAULT public.uuid_generate_v4() NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16781)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    role character varying(20) NOT NULL,
    profile_picture_url character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    user_id integer NOT NULL,
    "failedLoginAttempts" integer DEFAULT 0 NOT NULL,
    "lockedUntil" timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16896)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 228
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4752 (class 2604 OID 17881)
-- Name: OrderDetails order_detail_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderDetails" ALTER COLUMN order_detail_id SET DEFAULT nextval('public."OrderDetails_order_detail_id_seq"'::regclass);


--
-- TOC entry 4753 (class 2604 OID 17888)
-- Name: Orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders" ALTER COLUMN order_id SET DEFAULT nextval('public."Orders_order_id_seq"'::regclass);


--
-- TOC entry 4742 (class 2604 OID 16817)
-- Name: femaleproducts product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.femaleproducts ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- TOC entry 4743 (class 2604 OID 16825)
-- Name: maleproducts product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maleproducts ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- TOC entry 4749 (class 2604 OID 16911)
-- Name: order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);


--
-- TOC entry 4751 (class 2604 OID 16932)
-- Name: order_details order_detail_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_details ALTER COLUMN order_detail_id SET DEFAULT nextval('public.order_details_order_detail_id_seq'::regclass);


--
-- TOC entry 4746 (class 2604 OID 16847)
-- Name: orderdetails order_detail_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails ALTER COLUMN order_detail_id SET DEFAULT nextval('public.orderdetails_order_detail_id_seq'::regclass);


--
-- TOC entry 4744 (class 2604 OID 16834)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 4750 (class 2604 OID 16923)
-- Name: product product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_product_id_seq'::regclass);


--
-- TOC entry 4741 (class 2604 OID 16808)
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- TOC entry 4739 (class 2604 OID 16897)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4951 (class 0 OID 17878)
-- Dependencies: 236
-- Data for Name: OrderDetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OrderDetails" (order_detail_id, quantity, subtotal, order_id, product_id) FROM stdin;
\.


--
-- TOC entry 4953 (class 0 OID 17885)
-- Dependencies: 238
-- Data for Name: Orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Orders" (order_id, auth_key, date, total_amount) FROM stdin;
\.


--
-- TOC entry 4942 (class 0 OID 16879)
-- Dependencies: 227
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" (key, username, email, password, role) FROM stdin;
\.


--
-- TOC entry 4935 (class 0 OID 16814)
-- Dependencies: 220
-- Data for Name: femaleproducts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.femaleproducts (product_id, name, description, price, quantity, image_url, gender) FROM stdin;
\.


--
-- TOC entry 4936 (class 0 OID 16822)
-- Dependencies: 221
-- Data for Name: maleproducts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maleproducts (product_id, name, description, price, quantity, image_url, gender) FROM stdin;
\.


--
-- TOC entry 4945 (class 0 OID 16908)
-- Dependencies: 230
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."order" (id, date, "totalAmount", "userUserId") FROM stdin;
1	2024-06-16 00:00:00	150.00	1
\.


--
-- TOC entry 4949 (class 0 OID 16929)
-- Dependencies: 234
-- Data for Name: order_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_details (order_detail_id, quantity, subtotal, "orderId", "productProductId") FROM stdin;
1	10	150.00	1	1
\.


--
-- TOC entry 4940 (class 0 OID 16844)
-- Dependencies: 225
-- Data for Name: orderdetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orderdetails (order_detail_id, quantity, subtotal, "orderOrderId", product_id) FROM stdin;
135	1	150.00	82	31
3	1	99.99	\N	\N
4	2	399.98	\N	\N
139	1	10.00	86	21
140	1	10.00	86	19
141	1	10.00	86	23
10	1	99.99	11	2
142	1	10.00	86	25
143	1	10.00	87	16
144	1	10.00	87	16
145	1	150.00	88	31
146	1	150.00	88	31
147	1	150.00	92	31
17	1	99.99	10	2
148	1	150.00	92	31
19	1	99.99	13	2
20	1	10.00	14	23
21	1	15.00	14	2
149	1	150.00	93	31
23	1	15.00	16	2
150	1	150.00	95	31
25	1	10.00	17	23
26	1	15.00	17	2
27	1	10.00	18	23
28	1	15.00	18	2
29	1	10.00	19	9
151	1	150.00	95	31
152	1	150.00	95	31
33	1	10.00	21	23
34	1	10.00	22	10
153	1	10.00	95	25
37	1	10.00	24	23
38	1	15.00	24	2
39	1	15.00	25	2
154	1	10.00	95	25
155	1	10.00	95	25
156	1	10.00	95	24
157	1	10.00	95	24
45	1	15.00	29	2
46	1	10.00	30	23
158	1	15.00	95	2
48	1	10.00	31	19
49	1	10.00	31	20
50	1	10.00	32	23
159	1	10.00	96	23
52	1	10.00	33	23
160	1	10.00	96	23
54	1	10.00	34	23
161	1	10.00	96	23
56	1	10.00	35	23
162	1	15.00	96	2
163	1	15.00	96	2
164	1	101.00	97	34
165	1	10.00	98	12
166	1	15.23	98	36
62	1	15.00	40	2
63	1	15.00	41	2
64	1	15.00	42	2
167	1	15.23	99	36
168	1	10.00	100	12
169	1	10.00	100	12
170	1	15.23	100	36
171	1	15.00	101	2
172	1	10.00	102	13
71	1	15.00	49	2
72	1	10.00	50	23
73	1	15.00	51	2
74	1	10.00	51	23
173	1	10.00	102	14
174	1	150.00	103	31
175	1	150.00	103	31
176	1	10.00	103	12
177	1	10.00	104	14
178	1	10.00	104	14
179	1	15.23	104	36
87	1	10.00	60	23
88	1	15.00	61	2
89	1	10.00	61	23
92	1	15.00	64	2
94	1	15.00	66	2
101	1	15.00	72	2
102	1	10.00	73	23
105	1	10.00	76	25
106	1	10.00	77	25
107	1	10.00	77	24
108	1	15.00	77	2
109	1	10.00	78	25
110	1	10.00	78	24
111	1	15.00	78	2
112	1	10.00	78	23
115	1	10.00	78	21
116	1	10.00	78	20
117	1	10.00	78	19
118	1	10.00	78	18
119	1	10.00	78	17
120	1	10.00	78	16
121	1	10.00	78	15
122	1	10.00	78	14
123	1	10.00	78	13
124	1	10.00	78	12
126	1	10.00	78	10
127	1	10.00	78	9
134	1	10.00	81	23
\.


--
-- TOC entry 4938 (class 0 OID 16831)
-- Dependencies: 223
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, auth_key, date, total_amount) FROM stdin;
8	ca4b02e0-be2d-4616-9c33-17783ab1f8c6	2024-05-14	299.97
9	a3e50ee8-21c2-475e-9ac2-cf1454fed3f9	2024-05-14	299.97
10	ca4b02e0-be2d-4616-9c33-17783ab1f8c6	2024-06-23	299.97
11	ca4b02e0-be2d-4616-9c33-17783ab1f8c6	2024-06-27	299.97
12	ca4b02e0-be2d-4616-9c33-17783ab1f8c6	2024-07-02	40.00
13	ca4b02e0-be2d-4616-9c33-17783ab1f8c6	2024-07-14	299.97
14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiIyZjU2YmZlOC1hMmVlLTQzNDAtOTlmNi0wNTNkZGE0YTA0YmMiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MjA5NzgwNjMsImV4cCI6MTcyMDk4MTY2M30.ARlIHss9gBoc9NZDTCsMzFaQiTrjLb9LP-i6BAQH1D0	2024-07-14	25.00
15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiIyZjU2YmZlOC1hMmVlLTQzNDAtOTlmNi0wNTNkZGE0YTA0YmMiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MjA5NzkyNTksImV4cCI6MTcyMDk4Mjg1OX0.6JEgxg7kV6Gu_RbQIuKR_qjqkcUdIFoOa7U0RlSNI4E	2024-07-14	49.99
16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiIyZjU2YmZlOC1hMmVlLTQzNDAtOTlmNi0wNTNkZGE0YTA0YmMiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MjA5NzkzMDEsImV4cCI6MTcyMDk4MjkwMX0.oeVNmbgxTapQyrAtQqndvb6GPdLr2dyGQrCudEk1J4U	2024-07-14	64.99
17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiIyZjU2YmZlOC1hMmVlLTQzNDAtOTlmNi0wNTNkZGE0YTA0YmMiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MjA5NzkzMDEsImV4cCI6MTcyMDk4MjkwMX0.oeVNmbgxTapQyrAtQqndvb6GPdLr2dyGQrCudEk1J4U	2024-07-14	25.00
18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiIyZjU2YmZlOC1hMmVlLTQzNDAtOTlmNi0wNTNkZGE0YTA0YmMiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MjA5NzkzMDEsImV4cCI6MTcyMDk4MjkwMX0.oeVNmbgxTapQyrAtQqndvb6GPdLr2dyGQrCudEk1J4U	2024-07-14	25.00
19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiIyZjU2YmZlOC1hMmVlLTQzNDAtOTlmNi0wNTNkZGE0YTA0YmMiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MjA5NzkzMDEsImV4cCI6MTcyMDk4MjkwMX0.oeVNmbgxTapQyrAtQqndvb6GPdLr2dyGQrCudEk1J4U	2024-07-14	10.00
20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiIyZjU2YmZlOC1hMmVlLTQzNDAtOTlmNi0wNTNkZGE0YTA0YmMiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MjA5NzkzMDEsImV4cCI6MTcyMDk4MjkwMX0.oeVNmbgxTapQyrAtQqndvb6GPdLr2dyGQrCudEk1J4U	2024-07-14	60.00
21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiIyZjU2YmZlOC1hMmVlLTQzNDAtOTlmNi0wNTNkZGE0YTA0YmMiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MjA5Nzk3NDQsImV4cCI6MTcyMDk4MzM0NH0.vGB79j5vFULqrCmpoStXPdkR8-CwkaGhvmHPWPEM7IA	2024-07-14	10.00
22	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-14	10.00
23	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-14	25.00
24	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-14	25.00
25	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-14	15.00
26	82a84b1d-296e-4068-a6e3-140a807ed222	2024-07-22	60.00
27	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	159.99
28	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	179.99
29	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	15.00
30	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	59.99
31	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	20.00
32	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	74.99
33	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	84.99
34	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	109.99
35	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	259.98
36	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	49.99
37	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	59.99
38	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	224.98
39	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	249.98
40	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	15.00
41	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	15.00
42	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	15.00
43	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	164.99
44	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	314.98
45	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	324.98
46	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	334.98
47	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	394.97
49	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	15.00
50	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	10.00
51	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	35.00
60	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	10.00
61	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	25.00
64	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	15.00
66	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	15.00
67	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	10.00
68	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	10.00
69	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	50.00
72	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	15.00
73	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	10.00
76	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	10.00
77	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	35.00
78	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-07-28	270.00
79	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-08-03	10.00
80	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-08-03	30.00
81	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-08-03	10.00
82	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-08-03	150.00
83	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-08	10.00
84	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-08	15.50
85	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-08	1424.00
86	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-10	40.00
87	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-10	20.00
88	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-10	300.00
92	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-10	300.00
93	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-10	150.00
95	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-10	515.00
96	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-10	60.00
97	ae86cb77-21c8-4379-85e9-1df0ba670f03	2024-09-15	101.00
98	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-16	25.23
99	16137614-044b-4942-8990-3f5dd0c9ca4c	2024-09-16	15.23
100	16137614-044b-4942-8990-3f5dd0c9ca4c	2024-09-16	35.23
101	16137614-044b-4942-8990-3f5dd0c9ca4c	2024-09-16	15.00
102	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-22	20.00
103	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	2024-09-22	310.00
104	95714768-b702-473d-a4c0-e4c764b3fabe	2024-09-22	35.23
\.


--
-- TOC entry 4947 (class 0 OID 16920)
-- Dependencies: 232
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (product_id, name, description, price, quantity, gender) FROM stdin;
1	Updated Product	A product for testing	15.00	90	M
\.


--
-- TOC entry 4934 (class 0 OID 16805)
-- Dependencies: 219
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, name, description, price, quantity, image_url, gender) FROM stdin;
13	Test Product	A product for testing	10.00	100	\N	M
14	Test Product	A product for testing	10.00	100	\N	M
15	Test Product	A product for testing	10.00	100	\N	M
16	Test Product	A product for testing	10.00	100	\N	M
17	Test Product	A product for testing	10.00	100	\N	M
18	Test sasho product	A product for testing	10.00	100	\N	M
19	Test sasho product	A product for testing	10.00	100	\N	M
20	Test sasho product	A product for testing	10.00	100	\N	M
21	Test sasho product	A product for testing	10.00	100	\N	M
23	Skirt	First product 	10.00	100	https://m.media-amazon.com/images/I/617Bqpy6ocL._AC_SY550_.jpg	F
2	Baggy Jeans	Description for Product2	15.00	50	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGRXeKCELKwOIRx5tJ9Y9GfHkBSGnsFQvkMw&s	M
24	Skirt	First product 	10.00	100	https://m.media-amazon.com/images/I/617Bqpy6ocL._AC_SY550_.jpg	F
25	Test	First product 	10.00	100	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuXt8OFO6sZJL0XCqvdexUikWPDoGLiHuuuQ&s	F
9	Test Product	A product for testing	10.00	100	test	F
10	test update12	A product for testing	13233.00	100	haha	M
34	test update1234	A product for testing	101.00	1010	test222	M
36	Gucci shit1	test new validations 	15.23	23	https://i.pinimg.com/564x/92/af/39/92af397ac2de2bf71ae3dc3836d8e3e7.jpg	M
12	Test Product test	A product for testing	10.00	100	https://hips.hearstapps.com/hmg-prod/images/look-1-victoria-f-6683d04283308.jpg?crop=1xw:1xh;center,top&resize=980:*	M
31	Top g	test edit final test	69.00	25	https://i.ebayimg.com/images/g/KTEAAOSwChNkODv0/s-l1600.png	M
\.


--
-- TOC entry 4941 (class 0 OID 16863)
-- Dependencies: 226
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (username, email, password, role, key) FROM stdin;
\.


--
-- TOC entry 4932 (class 0 OID 16781)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (username, password, email, role, profile_picture_url, key, user_id, "failedLoginAttempts", "lockedUntil") FROM stdin;
sasho_test_login2	$2b$10$uHtp5mxSgdAwtBvbpNJNmuEcRxTlqCE0/bZZM8A0mMENiAQVB5ta.	new_user@example.com	user	http://example.com/new_profile_picture.jpg	ac8d0a5d-4583-457f-bb88-699e6bf0d8ac	14	0	\N
sasho_test_login2	$2b$10$MZFvaF9ox70rSPPrm1lZTOz3W4pDqejEdbnxa0P9c8Lp6ZZPhynCq	new_user@example.com	user	http://example.com/new_profile_picture.jpg	f0a35a47-1295-4f26-99ea-d03bfc4010e8	15	0	\N
sasho_test_login3	$2b$10$yuDDPdZt2xsJXEIhaBx0GOg6YHl3layimhvNIWR1eybuzZ/JVzXH.	new_user@example.com	user	http://example.com/new_profile_picture.jpg	d2f70cdd-fac2-495d-a913-b104438a6fc9	16	0	\N
sasho_test_login3	$2b$10$kDCseJNNQ9/f3VvfPoXZGu7ZU5zl0z.hOhse8T2SJpVGypi.grxxS	new_user@example.com	user	http://example.com/new_profile_picture.jpg	2628f865-565d-4867-bc68-56b96c99298d	17	0	\N
sasho_test_login3	$2b$10$fEJBGuinIAq7uhXF1CEITu0LxBN.dqbBlCFR7t6oLLjtJJojCBo7y	new_user@example.com	user	http://example.com/new_profile_picture.jpg	f5c2c7e3-67de-4932-bd46-64d123d70dd7	18	0	\N
sasho_test_login3	$2b$10$0aORth2kgaw/fAhRdku22OjANorI7ZoWoIceGN0fteWXS0.eI2OrG	new_user@example.com	user	http://example.com/new_profile_picture.jpg	47b26a70-e596-4c13-8eaf-d0b411386625	19	0	\N
sasho_test_login3	$2b$10$PZ1a2Je2wismJiZ7fOVZ2.TcIgywdqgoCVxErAujSmZ/eP8veo1pm	new_user@example.com	user	http://example.com/new_profile_picture.jpg	dca81c53-20fe-4fce-be86-c116a678c478	20	0	\N
sasho_test_login3	$2b$10$T3kewbtJWBX3eDTZVJIXzOEEzFT.Yh.15Q5J90lBfqZP8DW848w8.	new_user@example.com	user	http://example.com/new_profile_picture.jpg	6877c6c5-e772-4f4b-b108-7469b1e7748c	21	0	\N
sasho_test_login3	$2b$10$vDbUqASj3j0Nw.oLusNbI.5A7YyPCSJYn0LJ1XKO5lXpez/THBk/i	new_user@example.com	user	http://example.com/new_profile_picture.jpg	a6b34368-8a78-4447-a09b-9036ff96d936	22	0	\N
sasho_test_login6	$2b$10$nZMY2Bh/dROzwKGoHT6fFeXvAuNoYqP5ObuDFMpHYWsS3IKamchVW	new_user@example.com	user	http://example.com/new_profile_picture.jpg	ef5d3412-dc07-4f94-8685-abc95436e234	23	0	\N
sasho_test_login3	$2b$10$FfcJMHhBboMVyd2Ir9xine1rqpLUFd/uo1DWCcAxAkrHLvnRTy7WW	new_user@example.com	user	http://example.com/new_profile_picture.jpg	3f2e88db-5ce0-4a73-923c-7fe97fac82a1	24	0	\N
sasho_test_login3	$2b$10$pjXHYRbQDpY0WIBAbTzvGOi4vXe5jzmywfR7QG2Yw3BIirjX14Yu6	new_user@example.com	user	http://example.com/new_profile_picture.jpg	deb01ab0-aa53-45ff-8a18-4ae622ddb2ea	25	0	\N
sasho_test_login3	$2b$10$7TgZn16463mjvuZc7YbZ2.hfR7.y87EzGmXFJy7TCi6LFeVdRsLfe	new_user@example.com	user	http://example.com/new_profile_picture.jpg	773c3f8e-87cc-45c3-bb55-7ab985872e03	26	0	\N
sasho_test_login3	$2b$10$GpohgfJgBRvfIYIhp0jv/uPyMA0SJE5EZZndL/yp6FtqkIOGYCAkW	new_user@example.com	user	http://example.com/new_profile_picture.jpg	5a73bfcd-665b-4aeb-8af4-7ca5e0d5ccf0	27	0	\N
sasho_test_login3	$2b$10$niEEV5O6BHQ1yk.6LqrTTOxv9FCdRY09VEPHM39npvk5s09dkJUku	new_user@example.com	user	http://example.com/new_profile_picture.jpg	8c1ee4aa-0f95-4f71-af1a-9a2880827d15	28	0	\N
sasho_test_login3	$2b$10$KlTXjExf9PTJZCEJ9ae3YuXfI7My/wphP59X8pWiLs6WrLK1vnUu6	new_user@example.com	user	http://example.com/new_profile_picture.jpg	3d8a5551-d1c5-4e74-ab62-1cc9ca5b481c	29	0	\N
new_user	$2b$10$kO5kug6JPheaiWZzqZQfzeGWi8ImoG0js4diSVjPw8C2Np8RmRXaO	new_user@example.com	user	http://example.com/new_profile_picture.jpg	64ffaea1-ede3-4a40-bf90-239f439716ae	31	0	\N
new_user	$2b$10$mXb0QavlpKSe.3hWEsYc6eAqcw3A0WTd1O4g.nih5yxYo2Kztf.ym	new_user@example.com	user	http://example.com/new_profile_picture.jpg	f8c65f06-f437-4b2f-be10-2a437e901792	32	0	\N
new_user	$2b$10$KGBccjZWVaI1IByWuKIIT.EnpeySqWq2pHDE6LSYE0cYrUCXQaOZ2	new_user@example.com	user	http://example.com/new_profile_picture.jpg	7075e4ba-fe7f-4d27-aa0f-f32a3a75a279	33	0	\N
new_user	$2b$10$SM.SiIIC/jdQckGDRHJ.Xe.7pofZuEQsCA/hHfTUNQE/1OIZ12d2u	new_user@example.com	user	http://example.com/new_profile_picture.jpg	56f873e7-8032-4337-82c9-76c0d88e44f3	34	0	\N
new_user	$2b$10$LC3kU8Sfb4rbD5NI58loMOGP3gOpWJ1H28zN1.xuhA/Q4cO.JZvli	new_user@example.com	user	http://example.com/new_profile_picture.jpg	84a3ab13-0c49-41eb-a76c-732719441a05	35	0	\N
johndoe	$2b$12$RyqbfAJoUT9Z/ZsnZaNkTOTAQTgEUG609FPGZpYz.dg9..ulXDy.W	johndoe@example.com1	user	http://example.com/images/johndoe.jpg	0470e0e7-7327-4fc9-9d99-de91d6872a67	1	0	\N
test_last	$2b$10$xilqpRuvhgouvja9ML7Z.uf5hq3mXTMzcf78jM6gQuMnWGEKjie0e	new_user@example.com	user	http://example.com/new_profile_picture.jpg	e1c73f3b-ea00-4310-a502-e9733430e911	37	0	\N
sasho_test_login3	$2b$12$UGWf2gi5sW.M6rbcqYgrY.LAe54JGNyjXLyFDXpC92r8WOb/L6Uhu	new_user@example.com1	user	http://example.com/new_profile_picture.jpg	ad7977b2-dc8d-4655-b16b-fcc360d12adb	30	0	\N
sasho_test_login		new_user@exampl1.com	user	http://example.com/new_profile_picture.jpg	87a7feab-b497-4007-997b-cadb77512f0a	8	0	\N
sasho_test_login2		12321312313new_user@example.com	user	http://example.com/new_profile_picture.jpg	eede9b25-f01f-4967-bc20-85b0d36a509a	9	0	\N
sasho_test_login2	$2b$12$EtypZKPCWnGbNlHW7ZpRKurqTn6Q2cZb4r.UhKTsNgVaePmLQsm9S	test@example.com	user	http://example.com/new_profile_picture.jpg	7e05a5af-64e5-4a31-8c49-bfb3ea79738a	12	0	\N
sasho_test_login2		test@tes1111111111111111111111111111111111t.com	user	http://example.com/new_profile_picture.jpg	11c92612-1da7-484e-acc8-5b3d6e8d9723	10	0	\N
sasho_test_login2		new_user@example.com999999999999999999999999999999999	user	http://example.com/new_profile_picture.jpg	e3fb8850-64ad-4f81-b789-4880a63b4305	11	0	\N
sasho_test_login2		new_user123@example.com	user	http://example.com/new_profile_picture.jpg	adb64adc-04a5-45f9-938e-1c159a7cd143	13	0	\N
test_last23	$2b$10$OEsqk1zOlTVNwTVZ27Dvyu6XKdWQAoV2s9.LU2MrfkvODoo2gr9gO	new_user@example.com	user	http://example.com/new_profile_picture.jpg	73435a0e-6d57-49e0-97da-21626b06995a	38	0	\N
test_last233	$2b$10$rkkgq8GdAoOC90HRJmheC.GszL1X4tQKMPI6e2BKsWtWioEJyY2NC	new_user@example.com	user	http://example.com/new_profile_picture.jpg	74efce1b-e386-4c80-9fd7-bc37f61a1446	39	0	\N
test_last233	$2b$10$nhj1YuvxaMsU9DtYilF98uhe3NMkGylOZEROD4U1wnEK9HRSjTSD2	new_user@example.com	user	http://example.com/new_profile_picture.jpg	3594dc67-e453-4752-a26d-29b9f257d95f	40	0	\N
test_last233	$2b$10$J2AvGOlL6vBZRLBK9h.dpuZWNjEmD4teY0HhzzEZ.7I0nagy94esi	new_user@example.com	user	http://example.com/new_profile_picture.jpg	3ca633b4-7eb6-4ce1-b08e-eda38c3b11da	41	0	\N
reigster_tokenf	$2b$12$Akg3wejjGjk02tpADdPUROwuUlw.fO0F/bY6Wl7XKKemKJPne/LrC	new_user@example.com	user	http://example.com/new_profile_picture.jpg	1b18095f-abb8-426c-85a3-f587e32e1490	62	0	\N
reigster_tokenff	$2b$12$JSMAJVfa8CjoIKjYuMj9EulfYC5.gAdr3CI/8KdH4URCNvW7xtIqC	new_user@example.com	user	http://example.com/new_profile_picture.jpg	21200477-de54-44b3-b400-b3b81b2ad8ef	63	0	\N
test_final_product	$2b$10$q1rCgevnxpFwrjwtzsF5ZeJ6d6n4GLVhad5Z1quhzgn.7ZdAwLlfW	new_user@example.com	user	http://example.com/new_profile_picture.jpg	7a935c99-a02c-4bbc-a57e-413edde75b66	43	0	\N
test_final_register	$2b$10$YYf7pl.s/VXMNrKl8vx9/urrmpNaS1jFdN6ccuZlkWdQcX4f/w.C.	new_user@example.com	user	http://example.com/new_profile_picture.jpg	603473c4-4c94-402e-8ea2-cc6dcaf84873	42	2	\N
reigster_tokenfff	$2b$12$vwp0A9gc8alZxviuYGeWROKFBSLDRW3fT3P5cK/SdQQ9U.XeKF.k6	new_user@example.com	user	http://example.com/new_profile_picture.jpg	e46fdc79-53c3-4ca0-8ca8-a55a4e70f8b3	64	0	\N
test_final_product12312	$2b$10$QtNP49tSdK5ga5Ahjw/nFe3ZF0ZmJp9v56.iyqoI869EX4si52Gn2	new_user@example.com	user	http://example.com/new_profile_picture.jpg	e8900ca4-ddbf-4b57-934b-a131a4bcc8a4	44	0	\N
test_order_details	$2b$10$nAgHWJuphDgqiFGE3Tt/f.WjK2s5yrBUGdK1bEe3lH4DVEnqvpOi6	new_user@example.com	user	http://example.com/new_profile_picture.jpg	6f91900b-9f68-44cf-b87a-7bad342dcb8f	45	0	\N
test_order_details23	$2b$10$fcC170W2nRNEYw6YbMTnW.x9dodazWNsHD04wNURFcAEYInjTtEJy	new_user@example.com	user	http://example.com/new_profile_picture.jpg	976c5bed-7a84-4c24-962b-e0bc64d430b9	46	0	\N
reigster_tokenfff23	$2b$12$kDQoy0T1Y6t.iFDi7U4i9Oj/.zQd628nweW8NGgF45bvam2.0Cagy	new_user@example.com	user	http://example.com/new_profile_picture.jpg	4edf0caf-0438-45d7-ac7b-ae9b6a3f2de0	65	0	\N
test_security	$2b$12$4T7yUtoSjfPiSHy7.X13p.OvaR6/0BOEuv/g9G/Aeq3J8Rp.Umgvi	new_user@example.com	user	http://example.com/new_profile_picture.jpg	3816648d-8971-4d9c-a679-7473c7bb3773	47	0	\N
test_auth_security	$2b$12$YXlblAy7lKbsxE/COMufrOYw3x6unWLQfp92ut0IpH.Gah8Rjb3sq	new_user@example.com	user	http://example.com/new_profile_picture.jpg	835a4477-5792-488e-96cb-fa43f9b11784	48	0	\N
test_auth_security1	$2b$12$ygKAc1R7idiNcA6BMFpJcuZQM3xoqjlO.HlWlRZnp17NYQ4qesDL.	new_user@example.com	user	http://example.com/new_profile_picture.jpg	f5202bb1-b2a7-4d5e-8852-b129548577d1	49	0	\N
test_update_final23	$2b$12$yF7KYXq94hgIStWwJYQtq.TR5oqI2QZU9S/aN4GjaDGmTmTBX67c6	new_email@example.com	new_role	http://new_profile_picture_url.com	a3e50ee8-21c2-475e-9ac2-cf1454fed3f9	4	0	\N
test_auth_security123	$2b$12$LJgri0tBhm4zwXeKLsBm9OS.GBnCVc7//TodtFcujosumDH1cAE42	new_user@example.com	user	http://example.com/new_profile_picture.jpg	f4433bc0-4f4d-4a29-995f-1c7a4aa92d2f	50	0	\N
test_auth_security1231	$2b$12$WANagbTOmrizDoL61K8As.cCxTpN/Ko33a17in.VfZqRFi6BwYGC.	new_user@example.com	user	http://example.com/new_profile_picture.jpg	226f2716-76c5-4b60-83f7-bfaef5be4f57	51	0	\N
test_auth_security12312	$2b$12$CxQU.iZZkesvNoyGOQ1O.unc/KPMqA5XH/STXw/JIgDpouS1NQbsC	new_user@example.com	user	http://example.com/new_profile_picture.jpg	34b27bd0-e839-4205-b81b-0fcc55807cbb	52	0	\N
test_auth_security123121	$2b$12$r/t4WNPVRANKmaKVZzLtJ.h.gzHJJlJgqk5A/aDMW8UbOXRbCO/Ni	new_user@example.com	user	http://example.com/new_profile_picture.jpg	67f394d9-30ef-46b8-bd26-88c32551677c	53	0	\N
test_auth_security1231211	$2b$12$6WdK6C.EqSfU7vAn00F43udJL5QLgh11mMnTKNkuWUDFpE0HMg.6y	new_user@example.com	user	http://example.com/new_profile_picture.jpg	d3c2e477-82cb-4ce4-bfbe-7879e32c60a3	54	0	\N
test_auth_security1231211112	$2b$12$n28s33EtUOjzsouskRZN.eARt/zJnNIKJ.20ajSQaYvPddOwOkq7O	new_user@example.com	user	http://example.com/new_profile_picture.jpg	23fe72a6-e245-4388-b6ae-e7b60b24eee8	55	0	\N
test_auth_security123121111332	$2b$12$IGJVQzRWzqwQEc1badDQOuYomfTT8wSBXdopccFpXiHu5WGGCQt1i	new_user@example.com	user	http://example.com/new_profile_picture.jpg	daab066d-1ae5-4af5-84c3-cb18a1e2aacc	56	0	\N
reigster_token	$2b$12$UIzalkiu.2pgubylVzP8BOnfNhFOacXnPP2DQOH7gxC9wKWBH1I/6	new_user@example.com	user	http://example.com/new_profile_picture.jpg	4b0ed51a-671a-4ec2-8a44-6a42d48aa63a	57	0	\N
reigster_token1	$2b$12$5CGVB8iX6JzdRub8ROMwn.E0SDzNkB23miIc1ItABikxlCoilOdnW	new_user@example.com	user	http://example.com/new_profile_picture.jpg	9cc034be-213b-40e7-aef7-41f768b764a7	58	0	\N
reigster_token21	$2b$12$1LuPzL0b1BoTxlcXTgXZY.5GELIP0R5IP5BE4P00EPgnygcfJ3voG	new_user@example.com	user	http://example.com/new_profile_picture.jpg	b86222ae-7ce0-4a19-9ce1-c1f9327072b2	59	0	\N
reigster_token213	$2b$12$VJB5C6nCtYDWGLAelBplb.Y8X..Gi/mKhGHtlPcuTTmiumMBiLYaq	new_user@example.com	user	http://example.com/new_profile_picture.jpg	0223fff5-c437-467b-843d-523976770350	60	0	\N
reigster_token2132	$2b$12$yUC0aLkdDa6vohkO6OVaLes/tNtOFb2/L95fSXJBWOKUHngQm9TFC	new_user@example.com	user	http://example.com/new_profile_picture.jpg	1914f928-ab1f-462e-88b1-a23c6ed860db	61	0	\N
test1	$2b$12$Pm4Qoh66BwCjYlirz4PXBufR6vuR0QP4Ywl1i79/VpV6VfNHkON42	new_user@example.com	user	http://example.com/new_profile_picture.jpg	63a9d88a-1717-4a42-9848-03a9d44c39ca	67	2	\N
test2	$2b$12$Y/0ss3xLFsWC23ebxR/HJO6WcLs9TA/t4cvNlWwoh06UO6bVcYUUm	new_user@example.com	user	http://example.com/new_profile_picture.jpg	f06f6ac5-0eb6-4bbb-979c-e817113bec7a	68	4	2024-06-25 23:55:06.435
test23	$2b$10$sTZHmhFW9rqqSH9rwW8DIeZHC0TrNaTrubbGw.IkV5JkR6LAse6jC	new_user@example.com	user	http://example.com/new_profile_picture.jpg	c034d924-4c27-4fd2-b6e1-969040e9018f	69	1	\N
test233	$2b$12$eEp50TyupGLBBupDmoiUC.jxpefB1XUbRtnIOgL2K8p6wJWs14OAO	new_user@example.com	user	http://example.com/new_profile_picture.jpg	711cdc49-f1ad-458e-b33a-ff5100d829ba	70	9	2024-06-26 21:05:51.181
test	$2b$12$tFNvdg9410vfCZ8N.u8mheoi3CKXU2ksh2/DfqxnETaQskDiqJhMO	new_user@example.com	user	http://example.com/new_profile_picture.jpg	3da48730-bcb4-4753-b608-d82a8433e19f	66	1	\N
test2335	$2b$12$RiOPN0FVe7K1CAEpwczdVeFs6k3MXZwfJTZUmGUXX5NS7pc3vW096	new_user@example.com	user	http://example.com/new_profile_picture.jpg	89045d84-a028-4fd7-ac3c-b3f0a00f695f	71	0	\N
test_user122333445555555344	$2b$12$K3SKjtGJu.EjO9oF3c2F8.65urFPM9WSSCAJ9SHseCImuhmNtwwbS	new_user@example.com	user	http://example.com/new_profile_picture.jpg	bc801928-c4e3-4468-8985-6d1f927b9027	83	1	\N
test_user	$2b$12$.gzwFopi6dSwArdFW7X3hezAFW8O9ZnjTQ1tGygbHTxpYhVeFBD9q	new_user@example.com	user	http://example.com/new_profile_picture.jpg	129b624e-e2fb-499a-b216-2e1bc8267052	73	0	\N
test_user1	$2b$12$TWIr1T98MkSe2RiBRmh9F.zeNv6elFc/nr1fGs9JnxZPPT4r09m3y	new_user@example.com	user	http://example.com/new_profile_picture.jpg	0d8fd64f-42af-4b87-8195-2565fe153457	74	1	\N
test_user12	$2b$12$WVJhW0N.OUPFLku1fDcmj.Li8qZd5CZuyP7tv0M2JXScCIoBYc6n6	new_user@example.com	user	http://example.com/new_profile_picture.jpg	9cb6c315-8ac9-4bc6-a758-9d44bf99066a	75	1	\N
test_user1223334455555553444444444	$2b$12$2lECH9wwNjWNNM19HETKIOW9B4vAJXleu3f11geV2RCzeR2aIlzS6	new_user@example.com	user	http://example.com/new_profile_picture.jpg	2e843122-add7-4f98-8f01-6f8c05f1f1f2	84	1	\N
test_user12233344555555534444444441	$2b$12$9aRSJrfF0oUQA28xLOLLpenIvBDj5VnWJr8SlO0rQkTWnwxicbEi2	new_user@example.com	user	http://example.com/new_profile_picture.jpg	91fd4d6f-caa0-41bd-9323-1c198508425c	85	1	\N
test_backend123	$2b$12$5EgMiD0MrjcYj1WGmgSsEueTi83JmIBGpp4np92w84kwOyNB/QALO	new_user@example.com	user	http://example.com/new_profile_picture.jpg	bbec34e4-12ea-4975-b117-118250709268	86	1	\N
sasho	$2b$12$SieO0Dj0NOrKzGJYK1dthuowgXGM1s39JB9xOTAf6yrHpuB9Kncsu	new_user@example.com	admin	http://example.com/new_profile_picture.jpg	2f56bfe8-a2ee-4340-99f6-053dda4a04bc	72	0	2024-07-10 23:16:06.402
test_user1223	$2b$12$vnicgtIkeTD/BYnLfk7.P.hWhwSJHbeITyENeoYZwMQ1WmXu9/9MC	new_user@example.com	user	http://example.com/new_profile_picture.jpg	00e68009-1ecb-47eb-a0ab-f416c1c113d4	76	1	\N
test_user12233	$2b$12$xO.yGllpEdSjncUIByZYJeWR84mUXpmtdAkgbFAZFObJjS7mJzsuG	new_user@example.com	user	http://example.com/new_profile_picture.jpg	78d261cd-8cea-4895-8be6-1cde9b4d366f	77	1	\N
test_user122333	$2b$12$6LUrkZBMrVPHldu0UwxdPeeEsMBI4.Q5Ou5h8JFPdR.vBgjn.kCVS	new_user@example.com	user	http://example.com/new_profile_picture.jpg	96ae60c7-23af-489a-9483-00aeee1f131f	78	1	\N
test_user1223334	$2b$12$m4Vjsg5eEZCvpmXefcG6/ugblFR8Vb407Em1hj8mhJTIAJhkdhtju	new_user@example.com	user	http://example.com/new_profile_picture.jpg	3d3b7842-55ac-4f39-8f24-d3b57ee3936f	79	1	\N
test_user12233344	$2b$12$S5bdQj4y3w3PWQBHmsHzCOsT.9NrWdk.igj5QZipLb3W0REuRZgga	new_user@example.com	user	http://example.com/new_profile_picture.jpg	64ee245d-b72f-43ab-a585-4c7bbf96abef	80	1	\N
test_user1223334455	$2b$12$/duAZSk1BheCexA4YjiNSO5zlC8YsrffN7jMgX3jYWBo9jtulFNZe	new_user@example.com	user	http://example.com/new_profile_picture.jpg	bdd772f3-2a04-4c05-8df8-4dc48048c19a	81	1	\N
test_backend2	$2b$12$nlR5Z0GjnQ4Xb3xWVKKi9OK3JspS.2WiRRNjSPCR9kooug0LRQzF6	new_user@example.com	user	http://example.com/new_profile_picture.jpg	0f59c523-0037-420a-9c99-0d262344316c	87	1	\N
test_test_last	$2b$12$dyMW8R8Yw1e08RIH2JxRreCqNxxnx6bFQg1b9tFtPQvG749suf7Je	Alex.palikov@abv.bg	user	http://example.com/new_profile_picture.jpg	ae86cb77-21c8-4379-85e9-1df0ba670f03	94	0	\N
Sasho500	$2b$12$ePx.72GppywPkFlhWvpPMey8SrhDPsofF1WURbuBH2swUQyxbKZ0a	sasho.palikov@gmail.com	user	http://example.com/new_profile_picture.jpg	d805bcfa-4a79-459a-8ac3-bf5711ebea93	91	3	\N
test1231	$2b$12$tv9dc14NUsvcERI7QPyjUOEixnMzRM8.HbgBD9XaVfzo654koE8TO	sasho.palikov@gmail.com	user	http://example.com/new_profile_picture.jpg	82a84b1d-296e-4068-a6e3-140a807ed222	90	0	\N
fear50	$2b$12$0dQZ3vXes.KKMi1nyvRe0.j0okl4wJOy40Ne7vkTc013V3ZdMPZxO	sasho.palikov@abv.bg	user	http://example.com/new_profile_picture.jpg	68ce464b-bee3-4bda-a27f-4d7227eaf84e	95	0	\N
Sasho5001	$2b$12$rSVSh.YJhSiNkkYaTeKQNub8u9HiakotznBIQkVTFgBC5GkdjAVMu	sasho.palikov@gmail.com	user	http://example.com/new_profile_picture.jpg	27dc36a3-9154-43c4-a408-fbfa404b860b	92	0	\N
test test12	$2b$12$hGrKgqXZzQZiiUybBi.zCembUux8A7odPja/iMOm/yYx69/SK.J1q	ollie45@jaccessedsq.com	user	http://example.com/new_profile_picture.jpg	6fa77e32-0009-4f4a-973a-d8fd4f132a00	98	0	\N
sasho1	$2b$12$MUKeQbJhI9b9NaQYGXUVde0TQBvahGVUnFMQ7HLWBYVuGL6N/DZ9q	test@gmail.com	user	http://example.com/new_profile_picture.jpg	3611cb20-194c-42e0-8560-b839d1832b6e	96	0	\N
test_role	$2b$12$NGUN6b8GxHh4.swBLPv1ouRiGorLDewbHk.nj9uxcwH4uP37d3mZe	new_user@example.com	user	http://example.com/new_profile_picture.jpg	0bb06ce1-2cb9-481c-ae4f-761f29ab4dc8	93	0	\N
test_user122333445555555	$2b$12$85sHBFPH.z/iGXPG52sr7uAxN2bfi2sMSFHUZDrQM6lwmvqa5yPfC	new_user@example.com111	user	http://example.com/new_profile_picture.jpg	09a148d8-9147-49fc-b40a-20371b311bbe	82	1	\N
test order	$2b$12$/VTOKelVLOFHwasadXZ1ZuNI8npOKNM226MjOzsCLCgGuibDnUiNS	ollie45@jaccessedsq.com	user	http://example.com/new_profile_picture.jpg	16137614-044b-4942-8990-3f5dd0c9ca4c	97	0	\N
test final 	$2b$12$NqzEwGaYeiJ7ljxGeXwEheroKagie/uP/6xg6BVp6tJ22jZISiHuq	ollie45@jaccessedsq.com	user	http://example.com/new_profile_picture.jpg	95714768-b702-473d-a4c0-e4c764b3fabe	99	0	\N
\.


--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 235
-- Name: OrderDetails_order_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OrderDetails_order_detail_id_seq"', 1, false);


--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 237
-- Name: Orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Orders_order_id_seq"', 1, false);


--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 233
-- Name: order_details_order_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_details_order_detail_id_seq', 1, true);


--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 229
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_id_seq', 1, true);


--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 224
-- Name: orderdetails_order_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orderdetails_order_detail_id_seq', 179, true);


--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 222
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 104, true);


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 231
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_product_id_seq', 1, true);


--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 218
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 37, true);


--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 228
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 99, true);


--
-- TOC entry 4769 (class 2606 OID 16886)
-- Name: Users PK_0dd765c72710541899d810e51f7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PK_0dd765c72710541899d810e51f7" PRIMARY KEY (key);


--
-- TOC entry 4771 (class 2606 OID 16913)
-- Name: order PK_1031171c13130102495201e3e20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "PK_1031171c13130102495201e3e20" PRIMARY KEY (id);


--
-- TOC entry 4775 (class 2606 OID 16934)
-- Name: order_details PK_155920e0b604d7f884bcfab6209; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT "PK_155920e0b604d7f884bcfab6209" PRIMARY KEY (order_detail_id);


--
-- TOC entry 4773 (class 2606 OID 16927)
-- Name: product PK_1de6a4421ff0c410d75af27aeee; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PK_1de6a4421ff0c410d75af27aeee" PRIMARY KEY (product_id);


--
-- TOC entry 4777 (class 2606 OID 17883)
-- Name: OrderDetails PK_6b3543859fd5e28964bef84a8a2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderDetails"
    ADD CONSTRAINT "PK_6b3543859fd5e28964bef84a8a2" PRIMARY KEY (order_detail_id);


--
-- TOC entry 4779 (class 2606 OID 17890)
-- Name: Orders PK_6e8c9a313479da38ab0430e3d7f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "PK_6e8c9a313479da38ab0430e3d7f" PRIMARY KEY (order_id);


--
-- TOC entry 4767 (class 2606 OID 16878)
-- Name: user PK_7b57429bcc6c6265ddd4e92f063; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_7b57429bcc6c6265ddd4e92f063" PRIMARY KEY (key);


--
-- TOC entry 4757 (class 2606 OID 16905)
-- Name: users PK_96aac72f1574b88752e9fb00089; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_96aac72f1574b88752e9fb00089" PRIMARY KEY (user_id);


--
-- TOC entry 4765 (class 2606 OID 16849)
-- Name: orderdetails orderdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_pkey PRIMARY KEY (order_detail_id);


--
-- TOC entry 4763 (class 2606 OID 16837)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 4761 (class 2606 OID 16813)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4759 (class 2606 OID 16790)
-- Name: users users_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_key_key UNIQUE (key);


--
-- TOC entry 4788 (class 2620 OID 16861)
-- Name: users set_user_key; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_user_key BEFORE INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.generate_user_key();


--
-- TOC entry 4780 (class 2606 OID 18427)
-- Name: orderdetails FK_10ddb8c0972f64d6ab563c08321; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT "FK_10ddb8c0972f64d6ab563c08321" FOREIGN KEY ("orderOrderId") REFERENCES public.orders(order_id);


--
-- TOC entry 4785 (class 2606 OID 17927)
-- Name: OrderDetails FK_145601fb04d0e5f5d43742871ed; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderDetails"
    ADD CONSTRAINT "FK_145601fb04d0e5f5d43742871ed" FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 4783 (class 2606 OID 16935)
-- Name: order_details FK_147bc15de4304f89a93c7eee969; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT "FK_147bc15de4304f89a93c7eee969" FOREIGN KEY ("orderId") REFERENCES public."order"(id);


--
-- TOC entry 4781 (class 2606 OID 18451)
-- Name: orderdetails FK_2137607ee0cf7db567847b5fa70; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT "FK_2137607ee0cf7db567847b5fa70" FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- TOC entry 4786 (class 2606 OID 17957)
-- Name: OrderDetails FK_4ed6eb1b70354fc6182b9521237; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderDetails"
    ADD CONSTRAINT "FK_4ed6eb1b70354fc6182b9521237" FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 4784 (class 2606 OID 16940)
-- Name: order_details FK_ddb2c034675723bd0455135b33a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT "FK_ddb2c034675723bd0455135b33a" FOREIGN KEY ("productProductId") REFERENCES public.product(product_id);


--
-- TOC entry 4787 (class 2606 OID 17901)
-- Name: Orders FK_de340eb0aa28b0441d676ec50d5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "FK_de340eb0aa28b0441d676ec50d5" FOREIGN KEY (auth_key) REFERENCES public.users(key);


--
-- TOC entry 4782 (class 2606 OID 16914)
-- Name: order FK_f2118217784d0e73e2b050bd564; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_f2118217784d0e73e2b050bd564" FOREIGN KEY ("userUserId") REFERENCES public.users(user_id);


-- Completed on 2024-09-23 12:53:12

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-09-23 12:53:12

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
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 4822 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16429)
-- Name: orderdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orderdetails (
    order_detail_id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    subtotal numeric(10,2) NOT NULL
);


ALTER TABLE public.orderdetails OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16428)
-- Name: orderdetails_order_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orderdetails_order_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orderdetails_order_detail_id_seq OWNER TO postgres;

--
-- TOC entry 4823 (class 0 OID 0)
-- Dependencies: 222
-- Name: orderdetails_order_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orderdetails_order_detail_id_seq OWNED BY public.orderdetails.order_detail_id;


--
-- TOC entry 221 (class 1259 OID 16416)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    date date DEFAULT CURRENT_DATE NOT NULL,
    total_amount numeric(10,2) NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16415)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 4824 (class 0 OID 0)
-- Dependencies: 220
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 219 (class 1259 OID 16407)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    quantity integer NOT NULL,
    image_url character varying(255)
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16406)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- TOC entry 4825 (class 0 OID 0)
-- Dependencies: 218
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- TOC entry 217 (class 1259 OID 16398)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    role character varying(20) NOT NULL,
    profile_picture_url character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16397)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 4826 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4654 (class 2604 OID 16432)
-- Name: orderdetails order_detail_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails ALTER COLUMN order_detail_id SET DEFAULT nextval('public.orderdetails_order_detail_id_seq'::regclass);


--
-- TOC entry 4652 (class 2604 OID 16419)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 4651 (class 2604 OID 16410)
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- TOC entry 4650 (class 2604 OID 16401)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4816 (class 0 OID 16429)
-- Dependencies: 223
-- Data for Name: orderdetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orderdetails (order_detail_id, order_id, product_id, quantity, subtotal) FROM stdin;
\.


--
-- TOC entry 4814 (class 0 OID 16416)
-- Dependencies: 221
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, user_id, date, total_amount) FROM stdin;
\.


--
-- TOC entry 4812 (class 0 OID 16407)
-- Dependencies: 219
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, name, description, price, quantity, image_url) FROM stdin;
\.


--
-- TOC entry 4810 (class 0 OID 16398)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, username, password, email, role, profile_picture_url) FROM stdin;
\.


--
-- TOC entry 4827 (class 0 OID 0)
-- Dependencies: 222
-- Name: orderdetails_order_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orderdetails_order_detail_id_seq', 1, false);


--
-- TOC entry 4828 (class 0 OID 0)
-- Dependencies: 220
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);


--
-- TOC entry 4829 (class 0 OID 0)
-- Dependencies: 218
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 1, false);


--
-- TOC entry 4830 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- TOC entry 4662 (class 2606 OID 16434)
-- Name: orderdetails orderdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_pkey PRIMARY KEY (order_detail_id);


--
-- TOC entry 4660 (class 2606 OID 16422)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 4658 (class 2606 OID 16414)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4656 (class 2606 OID 16405)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4664 (class 2606 OID 16435)
-- Name: orderdetails orderdetails_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 4665 (class 2606 OID 16440)
-- Name: orderdetails orderdetails_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 4663 (class 2606 OID 16423)
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


-- Completed on 2024-09-23 12:53:12

--
-- PostgreSQL database dump complete
--

-- Completed on 2024-09-23 12:53:12

--
-- PostgreSQL database cluster dump complete
--

