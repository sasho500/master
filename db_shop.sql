PGDMP  1                    |           Master    16.3    16.3 ]    \           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ]           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ^           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            _           1262    16445    Master    DATABASE     �   CREATE DATABASE "Master" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Bulgarian_Bulgaria.1251';
    DROP DATABASE "Master";
                postgres    false            `           0    0    DATABASE "Master"    COMMENT     3   COMMENT ON DATABASE "Master" IS 'master proeject';
                   postgres    false    4959                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            a           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    6            (           1255    16860    generate_user_key()    FUNCTION     �   CREATE FUNCTION public.generate_user_key() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.key := uuid_generate_v4();
  RETURN NEW;
END;
$$;
 *   DROP FUNCTION public.generate_user_key();
       public          postgres    false    6            �            1259    17878    OrderDetails    TABLE     �   CREATE TABLE public."OrderDetails" (
    order_detail_id integer NOT NULL,
    quantity integer NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    order_id integer,
    product_id integer
);
 "   DROP TABLE public."OrderDetails";
       public         heap    postgres    false    6            �            1259    17877     OrderDetails_order_detail_id_seq    SEQUENCE     �   CREATE SEQUENCE public."OrderDetails_order_detail_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public."OrderDetails_order_detail_id_seq";
       public          postgres    false    236    6            b           0    0     OrderDetails_order_detail_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public."OrderDetails_order_detail_id_seq" OWNED BY public."OrderDetails".order_detail_id;
          public          postgres    false    235            �            1259    17885    Orders    TABLE     �   CREATE TABLE public."Orders" (
    order_id integer NOT NULL,
    auth_key character varying(255) NOT NULL,
    date timestamp without time zone NOT NULL,
    total_amount numeric(10,2) NOT NULL
);
    DROP TABLE public."Orders";
       public         heap    postgres    false    6            �            1259    17884    Orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Orders_order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."Orders_order_id_seq";
       public          postgres    false    238    6            c           0    0    Orders_order_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."Orders_order_id_seq" OWNED BY public."Orders".order_id;
          public          postgres    false    237            �            1259    16879    Users    TABLE     �   CREATE TABLE public."Users" (
    key uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    username character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role character varying NOT NULL
);
    DROP TABLE public."Users";
       public         heap    postgres    false    6    6    6            �            1259    16805    products    TABLE       CREATE TABLE public.products (
    product_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    price numeric(10,2) NOT NULL,
    quantity integer NOT NULL,
    image_url character varying(255),
    gender character(1) NOT NULL
);
    DROP TABLE public.products;
       public         heap    postgres    false    6            �            1259    16814    femaleproducts    TABLE     �   CREATE TABLE public.femaleproducts (
    CONSTRAINT check_gender_female CHECK ((gender = 'F'::bpchar))
)
INHERITS (public.products);
 "   DROP TABLE public.femaleproducts;
       public         heap    postgres    false    219    6            �            1259    16822    maleproducts    TABLE     �   CREATE TABLE public.maleproducts (
    CONSTRAINT check_gender_male CHECK ((gender = 'M'::bpchar))
)
INHERITS (public.products);
     DROP TABLE public.maleproducts;
       public         heap    postgres    false    219    6            �            1259    16908    order    TABLE     �   CREATE TABLE public."order" (
    id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    "totalAmount" numeric(10,2) NOT NULL,
    "userUserId" integer
);
    DROP TABLE public."order";
       public         heap    postgres    false    6            �            1259    16929    order_details    TABLE     �   CREATE TABLE public.order_details (
    order_detail_id integer NOT NULL,
    quantity integer NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    "orderId" integer,
    "productProductId" integer
);
 !   DROP TABLE public.order_details;
       public         heap    postgres    false    6            �            1259    16928 !   order_details_order_detail_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_details_order_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.order_details_order_detail_id_seq;
       public          postgres    false    6    234            d           0    0 !   order_details_order_detail_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.order_details_order_detail_id_seq OWNED BY public.order_details.order_detail_id;
          public          postgres    false    233            �            1259    16907    order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.order_id_seq;
       public          postgres    false    6    230            e           0    0    order_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.order_id_seq OWNED BY public."order".id;
          public          postgres    false    229            �            1259    16844    orderdetails    TABLE     �   CREATE TABLE public.orderdetails (
    order_detail_id integer NOT NULL,
    quantity integer NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    "orderOrderId" integer,
    product_id integer
);
     DROP TABLE public.orderdetails;
       public         heap    postgres    false    6            �            1259    16843     orderdetails_order_detail_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orderdetails_order_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.orderdetails_order_detail_id_seq;
       public          postgres    false    6    225            f           0    0     orderdetails_order_detail_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.orderdetails_order_detail_id_seq OWNED BY public.orderdetails.order_detail_id;
          public          postgres    false    224            �            1259    16831    orders    TABLE     �   CREATE TABLE public.orders (
    order_id integer NOT NULL,
    auth_key character varying(255) NOT NULL,
    date date DEFAULT ('now'::text)::date NOT NULL,
    total_amount numeric(10,2) NOT NULL
);
    DROP TABLE public.orders;
       public         heap    postgres    false    6            �            1259    16830    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.orders_order_id_seq;
       public          postgres    false    223    6            g           0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;
          public          postgres    false    222            �            1259    16920    product    TABLE     �   CREATE TABLE public.product (
    product_id integer NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL,
    price numeric(10,2) NOT NULL,
    quantity integer NOT NULL,
    gender character varying NOT NULL
);
    DROP TABLE public.product;
       public         heap    postgres    false    6            �            1259    16919    product_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.product_product_id_seq;
       public          postgres    false    6    232            h           0    0    product_product_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.product_product_id_seq OWNED BY public.product.product_id;
          public          postgres    false    231            �            1259    16804    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.products_product_id_seq;
       public          postgres    false    219    6            i           0    0    products_product_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;
          public          postgres    false    218            �            1259    16863    user    TABLE     �   CREATE TABLE public."user" (
    username character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role character varying NOT NULL,
    key uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public."user";
       public         heap    postgres    false    6    6    6            �            1259    16781    users    TABLE     �  CREATE TABLE public.users (
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
    DROP TABLE public.users;
       public         heap    postgres    false    6            �            1259    16896    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    217    6            j           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    228            �           2604    17881    OrderDetails order_detail_id    DEFAULT     �   ALTER TABLE ONLY public."OrderDetails" ALTER COLUMN order_detail_id SET DEFAULT nextval('public."OrderDetails_order_detail_id_seq"'::regclass);
 M   ALTER TABLE public."OrderDetails" ALTER COLUMN order_detail_id DROP DEFAULT;
       public          postgres    false    236    235    236            �           2604    17888    Orders order_id    DEFAULT     v   ALTER TABLE ONLY public."Orders" ALTER COLUMN order_id SET DEFAULT nextval('public."Orders_order_id_seq"'::regclass);
 @   ALTER TABLE public."Orders" ALTER COLUMN order_id DROP DEFAULT;
       public          postgres    false    238    237    238            �           2604    16817    femaleproducts product_id    DEFAULT     �   ALTER TABLE ONLY public.femaleproducts ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 H   ALTER TABLE public.femaleproducts ALTER COLUMN product_id DROP DEFAULT;
       public          postgres    false    220    218            �           2604    16825    maleproducts product_id    DEFAULT     ~   ALTER TABLE ONLY public.maleproducts ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 F   ALTER TABLE public.maleproducts ALTER COLUMN product_id DROP DEFAULT;
       public          postgres    false    221    218            �           2604    16911    order id    DEFAULT     f   ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);
 9   ALTER TABLE public."order" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229    230            �           2604    16932    order_details order_detail_id    DEFAULT     �   ALTER TABLE ONLY public.order_details ALTER COLUMN order_detail_id SET DEFAULT nextval('public.order_details_order_detail_id_seq'::regclass);
 L   ALTER TABLE public.order_details ALTER COLUMN order_detail_id DROP DEFAULT;
       public          postgres    false    234    233    234            �           2604    16847    orderdetails order_detail_id    DEFAULT     �   ALTER TABLE ONLY public.orderdetails ALTER COLUMN order_detail_id SET DEFAULT nextval('public.orderdetails_order_detail_id_seq'::regclass);
 K   ALTER TABLE public.orderdetails ALTER COLUMN order_detail_id DROP DEFAULT;
       public          postgres    false    225    224    225            �           2604    16834    orders order_id    DEFAULT     r   ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);
 >   ALTER TABLE public.orders ALTER COLUMN order_id DROP DEFAULT;
       public          postgres    false    222    223    223            �           2604    16923    product product_id    DEFAULT     x   ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_product_id_seq'::regclass);
 A   ALTER TABLE public.product ALTER COLUMN product_id DROP DEFAULT;
       public          postgres    false    232    231    232            �           2604    16808    products product_id    DEFAULT     z   ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 B   ALTER TABLE public.products ALTER COLUMN product_id DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    16897    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    228    217            W          0    17878    OrderDetails 
   TABLE DATA           c   COPY public."OrderDetails" (order_detail_id, quantity, subtotal, order_id, product_id) FROM stdin;
    public          postgres    false    236   �q       Y          0    17885    Orders 
   TABLE DATA           J   COPY public."Orders" (order_id, auth_key, date, total_amount) FROM stdin;
    public          postgres    false    238   �q       N          0    16879    Users 
   TABLE DATA           G   COPY public."Users" (key, username, email, password, role) FROM stdin;
    public          postgres    false    227   r       G          0    16814    femaleproducts 
   TABLE DATA           k   COPY public.femaleproducts (product_id, name, description, price, quantity, image_url, gender) FROM stdin;
    public          postgres    false    220   9r       H          0    16822    maleproducts 
   TABLE DATA           i   COPY public.maleproducts (product_id, name, description, price, quantity, image_url, gender) FROM stdin;
    public          postgres    false    221   Vr       Q          0    16908    order 
   TABLE DATA           H   COPY public."order" (id, date, "totalAmount", "userUserId") FROM stdin;
    public          postgres    false    230   sr       U          0    16929    order_details 
   TABLE DATA           k   COPY public.order_details (order_detail_id, quantity, subtotal, "orderId", "productProductId") FROM stdin;
    public          postgres    false    234   �r       L          0    16844    orderdetails 
   TABLE DATA           g   COPY public.orderdetails (order_detail_id, quantity, subtotal, "orderOrderId", product_id) FROM stdin;
    public          postgres    false    225   �r       J          0    16831    orders 
   TABLE DATA           H   COPY public.orders (order_id, auth_key, date, total_amount) FROM stdin;
    public          postgres    false    223   /t       S          0    16920    product 
   TABLE DATA           Y   COPY public.product (product_id, name, description, price, quantity, gender) FROM stdin;
    public          postgres    false    232   cw       F          0    16805    products 
   TABLE DATA           e   COPY public.products (product_id, name, description, price, quantity, image_url, gender) FROM stdin;
    public          postgres    false    219   �w       M          0    16863    user 
   TABLE DATA           F   COPY public."user" (username, email, password, role, key) FROM stdin;
    public          postgres    false    226   _y       D          0    16781    users 
   TABLE DATA           �   COPY public.users (username, password, email, role, profile_picture_url, key, user_id, "failedLoginAttempts", "lockedUntil") FROM stdin;
    public          postgres    false    217   |y       k           0    0     OrderDetails_order_detail_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public."OrderDetails_order_detail_id_seq"', 1, false);
          public          postgres    false    235            l           0    0    Orders_order_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Orders_order_id_seq"', 1, false);
          public          postgres    false    237            m           0    0 !   order_details_order_detail_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.order_details_order_detail_id_seq', 1, true);
          public          postgres    false    233            n           0    0    order_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.order_id_seq', 1, true);
          public          postgres    false    229            o           0    0     orderdetails_order_detail_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.orderdetails_order_detail_id_seq', 135, true);
          public          postgres    false    224            p           0    0    orders_order_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.orders_order_id_seq', 82, true);
          public          postgres    false    222            q           0    0    product_product_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.product_product_id_seq', 1, true);
          public          postgres    false    231            r           0    0    products_product_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.products_product_id_seq', 31, true);
          public          postgres    false    218            s           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 90, true);
          public          postgres    false    228            �           2606    16886 $   Users PK_0dd765c72710541899d810e51f7 
   CONSTRAINT     g   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PK_0dd765c72710541899d810e51f7" PRIMARY KEY (key);
 R   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "PK_0dd765c72710541899d810e51f7";
       public            postgres    false    227            �           2606    16913 $   order PK_1031171c13130102495201e3e20 
   CONSTRAINT     f   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "PK_1031171c13130102495201e3e20" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public."order" DROP CONSTRAINT "PK_1031171c13130102495201e3e20";
       public            postgres    false    230            �           2606    16934 ,   order_details PK_155920e0b604d7f884bcfab6209 
   CONSTRAINT     y   ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT "PK_155920e0b604d7f884bcfab6209" PRIMARY KEY (order_detail_id);
 X   ALTER TABLE ONLY public.order_details DROP CONSTRAINT "PK_155920e0b604d7f884bcfab6209";
       public            postgres    false    234            �           2606    16927 &   product PK_1de6a4421ff0c410d75af27aeee 
   CONSTRAINT     n   ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PK_1de6a4421ff0c410d75af27aeee" PRIMARY KEY (product_id);
 R   ALTER TABLE ONLY public.product DROP CONSTRAINT "PK_1de6a4421ff0c410d75af27aeee";
       public            postgres    false    232            �           2606    17883 +   OrderDetails PK_6b3543859fd5e28964bef84a8a2 
   CONSTRAINT     z   ALTER TABLE ONLY public."OrderDetails"
    ADD CONSTRAINT "PK_6b3543859fd5e28964bef84a8a2" PRIMARY KEY (order_detail_id);
 Y   ALTER TABLE ONLY public."OrderDetails" DROP CONSTRAINT "PK_6b3543859fd5e28964bef84a8a2";
       public            postgres    false    236            �           2606    17890 %   Orders PK_6e8c9a313479da38ab0430e3d7f 
   CONSTRAINT     m   ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "PK_6e8c9a313479da38ab0430e3d7f" PRIMARY KEY (order_id);
 S   ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "PK_6e8c9a313479da38ab0430e3d7f";
       public            postgres    false    238            �           2606    16878 #   user PK_7b57429bcc6c6265ddd4e92f063 
   CONSTRAINT     f   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_7b57429bcc6c6265ddd4e92f063" PRIMARY KEY (key);
 Q   ALTER TABLE ONLY public."user" DROP CONSTRAINT "PK_7b57429bcc6c6265ddd4e92f063";
       public            postgres    false    226            �           2606    16905 $   users PK_96aac72f1574b88752e9fb00089 
   CONSTRAINT     i   ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_96aac72f1574b88752e9fb00089" PRIMARY KEY (user_id);
 P   ALTER TABLE ONLY public.users DROP CONSTRAINT "PK_96aac72f1574b88752e9fb00089";
       public            postgres    false    217            �           2606    16849    orderdetails orderdetails_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_pkey PRIMARY KEY (order_detail_id);
 H   ALTER TABLE ONLY public.orderdetails DROP CONSTRAINT orderdetails_pkey;
       public            postgres    false    225            �           2606    16837    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    223            �           2606    16813    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    219            �           2606    16790    users users_key_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_key_key UNIQUE (key);
 =   ALTER TABLE ONLY public.users DROP CONSTRAINT users_key_key;
       public            postgres    false    217            �           2620    16861    users set_user_key    TRIGGER     t   CREATE TRIGGER set_user_key BEFORE INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.generate_user_key();
 +   DROP TRIGGER set_user_key ON public.users;
       public          postgres    false    217    296            �           2606    18427 +   orderdetails FK_10ddb8c0972f64d6ab563c08321    FK CONSTRAINT     �   ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT "FK_10ddb8c0972f64d6ab563c08321" FOREIGN KEY ("orderOrderId") REFERENCES public.orders(order_id);
 W   ALTER TABLE ONLY public.orderdetails DROP CONSTRAINT "FK_10ddb8c0972f64d6ab563c08321";
       public          postgres    false    223    225    4763            �           2606    17927 +   OrderDetails FK_145601fb04d0e5f5d43742871ed    FK CONSTRAINT     �   ALTER TABLE ONLY public."OrderDetails"
    ADD CONSTRAINT "FK_145601fb04d0e5f5d43742871ed" FOREIGN KEY (order_id) REFERENCES public.orders(order_id);
 Y   ALTER TABLE ONLY public."OrderDetails" DROP CONSTRAINT "FK_145601fb04d0e5f5d43742871ed";
       public          postgres    false    236    4763    223            �           2606    16935 ,   order_details FK_147bc15de4304f89a93c7eee969    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT "FK_147bc15de4304f89a93c7eee969" FOREIGN KEY ("orderId") REFERENCES public."order"(id);
 X   ALTER TABLE ONLY public.order_details DROP CONSTRAINT "FK_147bc15de4304f89a93c7eee969";
       public          postgres    false    234    4771    230            �           2606    18451 +   orderdetails FK_2137607ee0cf7db567847b5fa70    FK CONSTRAINT     �   ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT "FK_2137607ee0cf7db567847b5fa70" FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.orderdetails DROP CONSTRAINT "FK_2137607ee0cf7db567847b5fa70";
       public          postgres    false    4761    219    225            �           2606    17957 +   OrderDetails FK_4ed6eb1b70354fc6182b9521237    FK CONSTRAINT     �   ALTER TABLE ONLY public."OrderDetails"
    ADD CONSTRAINT "FK_4ed6eb1b70354fc6182b9521237" FOREIGN KEY (product_id) REFERENCES public.products(product_id);
 Y   ALTER TABLE ONLY public."OrderDetails" DROP CONSTRAINT "FK_4ed6eb1b70354fc6182b9521237";
       public          postgres    false    4761    219    236            �           2606    16940 ,   order_details FK_ddb2c034675723bd0455135b33a    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT "FK_ddb2c034675723bd0455135b33a" FOREIGN KEY ("productProductId") REFERENCES public.product(product_id);
 X   ALTER TABLE ONLY public.order_details DROP CONSTRAINT "FK_ddb2c034675723bd0455135b33a";
       public          postgres    false    4773    234    232            �           2606    17901 %   Orders FK_de340eb0aa28b0441d676ec50d5    FK CONSTRAINT     �   ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "FK_de340eb0aa28b0441d676ec50d5" FOREIGN KEY (auth_key) REFERENCES public.users(key);
 S   ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "FK_de340eb0aa28b0441d676ec50d5";
       public          postgres    false    217    238    4759            �           2606    16914 $   order FK_f2118217784d0e73e2b050bd564    FK CONSTRAINT     �   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_f2118217784d0e73e2b050bd564" FOREIGN KEY ("userUserId") REFERENCES public.users(user_id);
 R   ALTER TABLE ONLY public."order" DROP CONSTRAINT "FK_f2118217784d0e73e2b050bd564";
       public          postgres    false    230    217    4757            W      x������ � �      Y      x������ � �      N      x������ � �      G      x������ � �      H      x������ � �      Q   &   x�3�4202�50�54S00�#NCS=����� uQ�      U      x�3�44�445�3 R��\1z\\\ "��      L   K  x�U��q�0EϢ�BHM���_G�$�ff�o =#/�l�3�82�I���w|ŏ�����O�bG��/�F���:�c��p��Hyg64x5lx8
N�,�(�����h� �@��R���	H/�E^�|3�g���@<\Z�d�a1*�b���ee�S,��Gc��7v��r�B�3ȱ��ڎ#��,8�Vw��]���q�:.w���i�}�KXy-�'�	��U��od�Z� p�SM<�&~����,�$l�� ����$��4r�4vbi:��p#�,͇CY��0��H��4ggi��'`iΡ�������� �{��      J   $  x��Ko�0F��_���/)PC������W�_?!F���YU�]�r����1+��Lc���F�"�
CDJ������PL9�"�B��)YU���cQRĥ#��O�p������`HI�(�$	���$��aZḆq�0x�W�S�5h�I?�Z��E���[�Fذ��m&�FW��v�I��d�f�NW�e�A^��x��ܳӬ�����I���l�n�W�ӕ���S@?�V�N���7��_~�L'n�O[�N�s^���[�1����d73n{Sj3\��Vg�W��u��Y�k����&�.��7@�x������4���%dvr��k�tA�\���c!��h���z�5|٦�,E����.���nC�|&U��o�l7[wBfG;����*X|x��=��o��OtD{�v4:��]�=je��G�!/B���?�T?:$)�e�tH�C�o�9M�kȳ����R���q�������m2������o�V���eK�~g&i����O�q�1Rj.�k�"������A�@(/�jPTL�< �J� �_�8�Ep�X��4�
�W$�"5�š�?�I�IU��e��A=VF� -�À��,N;t'Mݹ4�@y.!/�1�L�I}qap{���R^�.�EJ�Gk���\A�=Wnѷ,ׇ�����S���0�I�?L���/��%,(�n+*��E�]KW,��h>�W��1�3�8E4�(@YvQ��RW,�U�Xz�%�W�K��j"̮c5A� � ��ۊ��ԠV�w�Z���+��      S   ;   x�3�-HI,IMQ(�O)M.�tT(����JR�K2��9M�8-8}�b���� nj      F   �  x���]o�0��ͯ�jw16Z*MI
m�hJ��S�����`�4��sò�j���H�s��sd��-�ʼ���IL�F�SU�J_�� B�D�a���@N��v��.�i謅$��� |�;�6������
����ѳ�RB�[V�q�#y�J�V��¨��,���b�U�.��2�w]��?�a�>alg�()%R��\(^����L��}Ut�	�2�wBѬ�K�TD��H�����9f����fAǃ��x_�<�j�����e�O�R��M>�~���O���v��W��ŤY��8�=�c4A��z����<��Vф_6M3�C���ҫ}�n#�QT!op��8���=u�V�dm�4�ǹϯ��`�C�Hv�`ǝd���"�d;X��x�A����BPh��� ���Q�}      M      x������ � �      D      x��{Ys�J��3�W�C��}��ܷ���B���~����ew_���	��DYB���<�dׇ�>:�������r��&4�����v�;n�o�\zq���z=�+����|�3Kw���#����!&�CNz���jOGZ{��8J#d�P����~-�e�����P���<��'>��"%T(�'-�C!�����8"D�H�(G�=s����ۃ�������x4U̠�R�I{,�ƃH�:
#�c6��{������g��}^ٙd�����2���[�BD���cO[J=,��&ı�"ǿ=�b.��Ww���=,�=������蟻�(���z�/��s7��5�Q}+���ryNܪYۥ�°��զ�	I�����e��x>����qL�r�#~I-eH�Ȫ,~+�E���R� Mˇ����\�^]�#=�~�|u�kO���e8�N��A�ާ��U�R��5�}�������x�p�1b�g���p��S��Q��O���pI�Ӑt�n��:����Οm�09���8o��V�������6|O�C�(� M$�'|��z�Ҳ�	��aWf;�7������5y�7ҽ����<���,��g�>���c2�'XR󞰱u�J�=G���z�F؃a�pd�#9��<�~����ϴډ/g��Ԋ�"h�J�=�8����|���S[�Ȯ^���=�+id�L�Lê#$=�e�YHo�$Lbdr�����O���-�W�Ά�B�+WW8$:���P�ٌt�V�t<���C+xO��A�	�b���i!���)��
Ñ69�����1�4��B,��a����M�����|lc~��	7�nAzW�`���P����W�y�Z��F©HK >�~�TخSX�n�H����>�}�JͶ�����dաft�F�-�0�7�IG�P)�<���Xa��N),2�8�����U��ۤ^����x��_���t�֕h9�������G������M}G:�71 p�c�bOY��0�3@T�&����3{S�7������؊�?���b|OY�o�Ƀ�3q8��w1U����3 �Ǡk�r��k#-4"H!� i�z��p���-<v��]Z���h{*UP>\,:��v�J7)�'E~5��  �"�!{���e셐S��ډ0F�26��o t՛���C���;��v1
^tʎ哃
��zڪ�Q,��s_:� �H��&v &�u�3^�h[�0r*�'v�i�܋W�4g����,ż��[�Lv�[�1`���"ߜ�f�7�@Db�ly���4�� �1�/@,���M�tq�n���1����a���r1�-z��`uqjD����<&���x���� *V��\dy�>h@@�Vk�U��_��'���,��d�(�d��Uq�����(v�����@^š�^_��úT<�7�p�-��QO���P�Д2�IE`N� �O ���l�枏�A�I		օ��ܐ���а��E��MgC�	ε� `�����s\�A�=�AW�P�0�J<��-�!MG��e�L2&�lc��G��4yT΅t=�-�n�7Հ5
[N=�b��C�E	�bvI'H�#_0�'�ݸ{xmN�3�ʣŤ٘��J�U��y�75��Ӣ��S��]�����J+@6;)��cf�֓	bx�)�#_0�'�[9�
�5]���?��K7l�� ��^i؜�Q��g��ogG�ʏ��M>y��2
U�8fƠ��CO#*�X�Y�B�`b�ia�9)��� x�[�C}$⪛�
i�0?�x��j�X�O/C�h��]M�o�B1�(ÙgDلA3�?�Lh5d�P�#_0��Tc���W��Й<#�8�G�w�|:���(�pyZ��Gas��o���)�o@c┊B�[p��H�iB�AK�EΑ/���q=��a�|��i�XG�[-H�m����{������N��伞a6O�d~#"lB��3)ǐL��8AH�ę���r�ǂ	�[�҅����
���JV^�ݬ�|�Q)���D�K;v�r���ԛ�� $r�Ijŕ$Q`�� ��e�\��1o��h}˧�g����
�,���E�z�4�ڼTؼ)�8$�����ٺ��1�5ܡ�[���Je�Q���s���<�������I�W�P�?�6��t�i�7���و�x(�s{&��ӆ��QDF�����֕G�{��Tij��<���y���U��:N��EL������
z�s����cN2h@��6!d@s9�=I�|�.E��r&�.^�E?~��4Q�ݡ��%�ɺwW%�=��n03o��űq{`�vC��4��1�Z�ſ�{7Q�ܶ����t5�\�V����iMG���'+�|�������M�!�d�	����/C��va�I��_�ݪ�]/�����s����_��sx��ȱ^���p^Av~�f},���%�ܱ�x���"tkP�Ŕj$7D����{��I�Qʯ����ʃzӟ9_�"��/�B~U�G�n���Ac�ID�T�\�JR'=�@%3
���՞��r��4Gٯ�n��f��q��a�w\m��֣��8m�:Q�.�骐�3���m�&y�����C�x�a�b�8���1l�Q��D��lO�Az[-�mmt�-~�Չ�f����R�;b�O;�i��Z'������4��A�
(��x�	(6�4�9*�#p�������`;�t�#��|{�b֊���aB.�o�I�onA�p ˳^���H���<q�M�F��x"B$��&G�_B�����,O�AI����[��_���xƮ�V�� YWl]��ir�4�s�}�\G2&ò�{G� �8ʌ-���3&rT�~�����0��X���d[�*]9��lj�m���2�������p=���[(�,����t���3DDѡ�	���q�����O�7I4�-n�Š]l��Ŵ������樾z�*_6��,���˛�Z#(A��0[w���"s�������؟<tv��ru�?�������'�,l������z���X(G�� ����ݏT͇s1��Y��v�fo������X!X^ ��/����^��Q�0�('�/����9���ب���h��ig�+�6����,DgZj�U+���ԽM���8�)~�	BLJ/r��A3�;!����s���:q�7��wE���'|.-�m�8V������T��5E$��֞�L����^˽/Q����o���hʭ��^	h�0��/���O]��|N��_��2�6�;��<�ǭ�Of�U��Χ����5C��F]am��n���3��~�]�D8X&�!�i��5�b��9Fr�WI��E����*�]<nI:��� hU��vy0����m�Q��� ZU�&예#+��ivn�5
6���(V!��UaB��k���u�����j}�龜.�h�k��?y�%te�.	'���NW�F��u���4e 0ņ������0�v"rW�l/?�u��i3=���SR�U�蚏��E.�y.�kQ�G�uV�T���1H޴"�0��]"�XP�JO�&��D6T��+?TDlKX�)����]���h?�::D�5�^�e����j�yc�]��߃A�L㡋����$� @�(��E �B�c��-5���sS��h����'�r"�,��:��� jwSխ-���7�#>*��i<�)���t����P��+���o���{�l$���a��{ɰ���ӣ��@�Q1����R��w�M58�����.FVX�"O�����
�m��(�Tf��gj���/�m�-<�^�|)��9���C��i�5I��q��5�R�uH/o:!R��PFj�`v6� �l���c�B*�c���s�*X<�I�tmA;�c(�ߡ��i���v�,�G,��>;�K��&J�9A$A��:�@	
t]�z1ť�p��,G�cd��[c�QϪl�g'�V���:�7������� ��X��jkS��F�Qq&��֋�_�"e�������H��o�����9�?;������Ƙq�6"Ǿ܁ ���9A��j�   ^w ������Я�������]�6].�\�Џ؛� f`wC���~�1C��3��0c4��8��߀�̤i�k��(؝�W����
ߖ�c7�:Pj�L��$^��D��ڻ�!"�+2�΁�p3�������gY�e��CA��(=�c?Y,6�r�����?��|��9����f�|��,�w���MBx��0B�S�<A����bk9WH�0�q�0>�㜿�i�7���iM�������ln��ӆ�ܙ�q�a)�w��]��)�5큓�!�5�Pݖα���8�{�@�4j��_9㱼�UM�f����ƻ�~��n��\=VP���ś8.�����*���.q8O*���X���+���\{�.�V��`����f����0��_�}��j����o�^�`s�o\��F����
6E0��%$�A'�q�[,�~�iԚ��k0}����Š��� �v�h����,:��gI=��Z�Կ�7�XdL��l>����St��j�#�XH�_
��я/��$�O��4|n'��*��������8u�|���5-�q#�&	�B�"��'$����n�	��)c59.�gY�RmRT�L4_� � ���~˯�H�.iXܸ���-�m��dG�����P�h�@�8���d��[����'�N{�6
q�0zl�l��-�>�Uڍ�F�+��P���?�6n���M7B%!���ۡ$�ˆ2ǚ�$	I��_���ړf��ľt����v�m��m�����kI~�Z���mϦ��.Iw�bҞ�7�?D��c�y�q@ @v+F#�
�BJD����g�>�%dڛ�l����"������kPI�J`8k�Ak\�/�;=��k��1�5�f�,E6P �V�H	�9�c�Mo���� �PZϷ���z�b�-�~���[�H��'bw뛠�.�U�#���%��y�b�C��`D�����#�s��yt��G�z��u�c��71���������+$Ɓ'v>��0	�X�E�c��`�%�� ԯ��
�*�q�!��_����!�3ʿ!�t͗Ѣ�[U��|:��|��r�-�%4:w�蜆a��76��D�pqb���ɺN�ɇa�nCD�ԭA���:�?ן~V��9=�c�],���K��qtq����o�6i���7�̂»�0�QvBc�q%�y!�a
#)�C��(���/�����8���X��V��h�F���P]?U��;$�Ԛ���"�r|z�+#ӿl�ɩ��	�L6�C^hC�
돔�갆�����{܃$�uQu�d�
��ݾ���^Ćvf�{�-ƻ�x6�ݡ<Zz�"�&�U�<R,��,o�Q��12�";;�?ۃ�	�,���o��w(-:l���f�Wց>TA%V�/xz��:z:�
M=�_\��KW���~�t-1�
�oZ�i��n�V�p����)�c~:�$���������9�N匮ܫP��@/��Q_k�eX=���N���DY��C*�g�Ak�q0!I�s�G>�6�x�Ug3td�����/׽	��������E7��E�7bg�w�M& *4��"&��*�Xsh���Cb�R��?����N��)����WmoR��n��uZD��H�=y��iΆ��8�V�ߔ�چ�R��X0����\y[��֠����������wDd[)����]O����ʨ����n��l�Rc�t2(�܀���5|"��@�����q��1��E<�����_7�D����`�<�Ut�D=�A�}t�ƭX^��~�<��6@��f4���+ɛT��q�"{�P�8�<P�4�m��#���ϛJ.�i��+�NRF�����xZ�-��J�F���]�X;����]��=xv��~��&RAAP�^Fgo� �0�ެ$�& .ԟ��q��{�����F���z՚�����p_�j|��Yԏ`T���\?�E����7>�|��ys��'q�0C�ֱ����AP,9��Z�q2�A�*��C!����y>�O���ظQ9_����F�=5]݇�z��g���Ž����,�y�y�8B�	�����f2��L����i�rR��2�G��gm�=V��zoǍ�s1o��@��xv�]��fV�j6�C�k�.�,�T �<e�,R�_U�A�n,Q!���/��sP��7�b�<�շQ���G�s�r���� �+լ���+.�{S�����0N +=B3�P�n�)�!d�sЕ(��կ����wl��,��,J��n�b[�tn�5	��^�A�5G�Bs��V���n@ш�:�ǹ��V���
y/s��4[~�E[�,hF�5{�;�M����R�������4���r������*�`�\��]o��l�y�$��p�E,;͉a{B����C�Gia1���ʕܣ���;�k[R��9��r�Y��z>-���n��ś.E��h<�tA	D1�U�
1t`r
�=�}nŃ=���z��)��%�׼캽�qo���e-���Ii]ߣ�rP��޴H�T*��Tl���#�JR��1r����~LI��@����f!}L'�V��m^�C�L�����J�9�%j��������d��MVĭ����e��Ls��>tw����90A�D�l�_]�0]�'8կ�Y��u��sp���?fѸvǧ�+�G�M6��/�C���8�EBH�Xg':�9,��L��%�C�������MG���r��AC�{��8�$�}�5�(�.���$~g�CE������ C����ǀ�3��QH����N�����?��� }B     