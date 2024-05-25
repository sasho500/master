PGDMP      5                |           Master    16.3    16.3 7    '           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            (           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            )           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            *           1262    16445    Master    DATABASE     �   CREATE DATABASE "Master" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Bulgarian_Bulgaria.1251';
    DROP DATABASE "Master";
                postgres    false            +           0    0    DATABASE "Master"    COMMENT     3   COMMENT ON DATABASE "Master" IS 'master proeject';
                   postgres    false    4906                        3079    16633    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                   false            ,           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    2                        3079    16791 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false            -           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    3                       1255    16860    generate_user_key()    FUNCTION     �   CREATE FUNCTION public.generate_user_key() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.key := uuid_generate_v4();
  RETURN NEW;
END;
$$;
 *   DROP FUNCTION public.generate_user_key();
       public          postgres    false            �            1259    16879    Users    TABLE     �   CREATE TABLE public."Users" (
    key uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    username character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role character varying NOT NULL
);
    DROP TABLE public."Users";
       public         heap    postgres    false    3            �            1259    16805    products    TABLE     a  CREATE TABLE public.products (
    product_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    quantity integer NOT NULL,
    image_url character varying(255),
    gender character(1),
    CONSTRAINT products_gender_check CHECK ((gender = ANY (ARRAY['F'::bpchar, 'M'::bpchar])))
);
    DROP TABLE public.products;
       public         heap    postgres    false            �            1259    16814    femaleproducts    TABLE     �   CREATE TABLE public.femaleproducts (
    CONSTRAINT check_gender_female CHECK ((gender = 'F'::bpchar))
)
INHERITS (public.products);
 "   DROP TABLE public.femaleproducts;
       public         heap    postgres    false    220            �            1259    16822    maleproducts    TABLE     �   CREATE TABLE public.maleproducts (
    CONSTRAINT check_gender_male CHECK ((gender = 'M'::bpchar))
)
INHERITS (public.products);
     DROP TABLE public.maleproducts;
       public         heap    postgres    false    220            �            1259    16844    orderdetails    TABLE     �   CREATE TABLE public.orderdetails (
    order_detail_id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    subtotal numeric(10,2) NOT NULL
);
     DROP TABLE public.orderdetails;
       public         heap    postgres    false            �            1259    16843     orderdetails_order_detail_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orderdetails_order_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.orderdetails_order_detail_id_seq;
       public          postgres    false    226            .           0    0     orderdetails_order_detail_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.orderdetails_order_detail_id_seq OWNED BY public.orderdetails.order_detail_id;
          public          postgres    false    225            �            1259    16831    orders    TABLE     �   CREATE TABLE public.orders (
    order_id integer NOT NULL,
    auth_key character varying(255) NOT NULL,
    date date DEFAULT CURRENT_DATE NOT NULL,
    total_amount numeric(10,2) NOT NULL
);
    DROP TABLE public.orders;
       public         heap    postgres    false            �            1259    16830    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.orders_order_id_seq;
       public          postgres    false    224            /           0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;
          public          postgres    false    223            �            1259    16804    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.products_product_id_seq;
       public          postgres    false    220            0           0    0    products_product_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;
          public          postgres    false    219            �            1259    16863    user    TABLE     �   CREATE TABLE public."user" (
    username character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role character varying NOT NULL,
    key uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public."user";
       public         heap    postgres    false    3            �            1259    16781    users    TABLE     M  CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    role character varying(20) NOT NULL,
    profile_picture_url character varying(255) NOT NULL,
    key character varying(255) NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16780    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    218            1           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    217            l           2604    16817    femaleproducts product_id    DEFAULT     �   ALTER TABLE ONLY public.femaleproducts ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 H   ALTER TABLE public.femaleproducts ALTER COLUMN product_id DROP DEFAULT;
       public          postgres    false    221    219            m           2604    16825    maleproducts product_id    DEFAULT     ~   ALTER TABLE ONLY public.maleproducts ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 F   ALTER TABLE public.maleproducts ALTER COLUMN product_id DROP DEFAULT;
       public          postgres    false    219    222            p           2604    16847    orderdetails order_detail_id    DEFAULT     �   ALTER TABLE ONLY public.orderdetails ALTER COLUMN order_detail_id SET DEFAULT nextval('public.orderdetails_order_detail_id_seq'::regclass);
 K   ALTER TABLE public.orderdetails ALTER COLUMN order_detail_id DROP DEFAULT;
       public          postgres    false    226    225    226            n           2604    16834    orders order_id    DEFAULT     r   ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);
 >   ALTER TABLE public.orders ALTER COLUMN order_id DROP DEFAULT;
       public          postgres    false    224    223    224            k           2604    16808    products product_id    DEFAULT     z   ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 B   ALTER TABLE public.products ALTER COLUMN product_id DROP DEFAULT;
       public          postgres    false    219    220    220            j           2604    16784    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    217    218    218            $          0    16879    Users 
   TABLE DATA           G   COPY public."Users" (key, username, email, password, role) FROM stdin;
    public          postgres    false    228   �?                 0    16814    femaleproducts 
   TABLE DATA           k   COPY public.femaleproducts (product_id, name, description, price, quantity, image_url, gender) FROM stdin;
    public          postgres    false    221   �?                 0    16822    maleproducts 
   TABLE DATA           i   COPY public.maleproducts (product_id, name, description, price, quantity, image_url, gender) FROM stdin;
    public          postgres    false    222   d@       "          0    16844    orderdetails 
   TABLE DATA           a   COPY public.orderdetails (order_detail_id, order_id, product_id, quantity, subtotal) FROM stdin;
    public          postgres    false    226   �@                  0    16831    orders 
   TABLE DATA           H   COPY public.orders (order_id, auth_key, date, total_amount) FROM stdin;
    public          postgres    false    224   A                 0    16805    products 
   TABLE DATA           e   COPY public.products (product_id, name, description, price, quantity, image_url, gender) FROM stdin;
    public          postgres    false    220   rA       #          0    16863    user 
   TABLE DATA           F   COPY public."user" (username, email, password, role, key) FROM stdin;
    public          postgres    false    227   �A                 0    16781    users 
   TABLE DATA           c   COPY public.users (user_id, username, password, email, role, profile_picture_url, key) FROM stdin;
    public          postgres    false    218   B       2           0    0     orderdetails_order_detail_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.orderdetails_order_detail_id_seq', 4, true);
          public          postgres    false    225            3           0    0    orders_order_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.orders_order_id_seq', 9, true);
          public          postgres    false    223            4           0    0    products_product_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.products_product_id_seq', 4, true);
          public          postgres    false    219            5           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 5, true);
          public          postgres    false    217            �           2606    16886 $   Users PK_0dd765c72710541899d810e51f7 
   CONSTRAINT     g   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PK_0dd765c72710541899d810e51f7" PRIMARY KEY (key);
 R   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "PK_0dd765c72710541899d810e51f7";
       public            postgres    false    228            �           2606    16878 #   user PK_7b57429bcc6c6265ddd4e92f063 
   CONSTRAINT     f   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_7b57429bcc6c6265ddd4e92f063" PRIMARY KEY (key);
 Q   ALTER TABLE ONLY public."user" DROP CONSTRAINT "PK_7b57429bcc6c6265ddd4e92f063";
       public            postgres    false    227            �           2606    16849    orderdetails orderdetails_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_pkey PRIMARY KEY (order_detail_id);
 H   ALTER TABLE ONLY public.orderdetails DROP CONSTRAINT orderdetails_pkey;
       public            postgres    false    226                       2606    16837    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    224            }           2606    16813    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    220            y           2606    16790    users users_key_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_key_key UNIQUE (key);
 =   ALTER TABLE ONLY public.users DROP CONSTRAINT users_key_key;
       public            postgres    false    218            {           2606    16788    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    218            �           2620    16861    users set_user_key    TRIGGER     t   CREATE TRIGGER set_user_key BEFORE INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.generate_user_key();
 +   DROP TRIGGER set_user_key ON public.users;
       public          postgres    false    286    218            �           2606    16850 '   orderdetails orderdetails_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);
 Q   ALTER TABLE ONLY public.orderdetails DROP CONSTRAINT orderdetails_order_id_fkey;
       public          postgres    false    224    4735    226            �           2606    16855 )   orderdetails orderdetails_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);
 S   ALTER TABLE ONLY public.orderdetails DROP CONSTRAINT orderdetails_product_id_fkey;
       public          postgres    false    4733    220    226            �           2606    16838    orders orders_auth_key_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_auth_key_fkey FOREIGN KEY (auth_key) REFERENCES public.users(key);
 E   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_auth_key_fkey;
       public          postgres    false    218    224    4729            $      x������ � �         c   x�3�tK�M�IU(�O)M.�tI-N.�,(���SH�/RH�H@�M,�,-9M83JJ
���S+srR���s�3s�S��!Z�Z��
�9ݸb���� $�$�         a   x�3��M�IU(�O)M.�tI-N.�,(���SH�/R�I@%M,�,-9-83JJ
���S+srR���s�3s�S��A���
�9}�b���� 4%"N      "   #   x�3��4BKK=KK. ��A\�=... V��          Z   x�m˹� �z9�>��d�	v�6�Yb�&I�Ny`�;<T�cL]�ό^��@lE�/���l�9!-��S�f'=������         l   x�3�(�O)M.1�tI-N.�,(���SH�/R�KXZ�YZrpf��X��V$���%���g�&���@�e�s�q��5�e��!�\S"�5������ �=:      #      x������ � �         &  x���9o�0�g�0�e��t/
t�BIt���ϯ��@�2����G��n�#����D��u<e����J��OGڤ�g��Nlw>O/Ms�o�=ninn��a�2a� A�VL��d
2[�Z��2Q�ʕ��s� ǂ3�[��� FDH)C]V��T�t����^�k�Lțe�joPĤ�8݁��,�B�6Z��L��,쩞��ĥ���'"/T��
"J&U�-A��R'Mk:ʺ�]�U𚷂�~���+~�GzLNh�P$J@��Xi!$�A:�5F��d�׆s��P�w     