CREATE TABLE adidas.adidas_staging 
(
	staging_id integer identity(1,1) not null,
    retailer varchar(200),
    retailer_id integer,
    invoice_date date,
    region varchar(200),
    state varchar(200),
    city varchar(200),
    product varchar(200),
    price_per_unit varchar(200),
    units_sold varchar(200),
    total_sales varchar(200),
    operating_profit varchar(200),
    operating_margin varchar(200),
    sales_method varchar(200),
    region_id integer,
    state_id integer,
    city_id integer,
    product_id integer,
    sales_method_id integer,
	constraint pk_adidas_staging primary key(staging_id)
);

CREATE TABLE adidas.dim_region
(
    region_id integer identity(1,1) not null,
    region varchar(200),
    constraint pk_region primary key(region_id)
);

CREATE TABLE adidas.dim_state
(
    state_id integer identity(1,1) not null,
    state varchar(200),
    constraint pk_state primary key(state_id)
);

CREATE TABLE adidas.dim_city
(
    city_id integer identity(1,1) not null,
    city varchar(200),
    state_id integer,
    constraint pk_city primary key(city_id),
    constraint fk_city foreign key(state_id) references adidas.dim_state(state_id)
);

CREATE TABLE adidas.dim_product
(
    product_id integer identity(1,1) not null,
    product varchar(200),
    constraint pk_product primary key(product_id)
);

CREATE TABLE adidas.dim_sales_method
(
    sales_method_id integer identity(1,1) not null,
    sales_method varchar(200),
    constraint pk_sales_method primary key(sales_method_id)
);

CREATE TABLE adidas.adidas_fact
(
    retailer_id integer,
    region_id integer,
    state_id integer,
    city_id integer,
    product_id integer,
    sales_method_id integer,
    invoice_date date,
    price_per_unit decimal(10,2),
    units_sold integer,
    total_sales integer,
    operating_profit integer,
    operating_margin_in_percent integer
);