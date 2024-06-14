
insert into adidas.dim_region(region)
select distinct region from adidas.adidas_staging order by region;


UPDATE adidas.adidas_staging
SET region_id = adidas.dim_region.region_id
FROM adidas.dim_region
WHERE adidas.adidas_staging.region = adidas.dim_region.region;

insert into adidas.dim_state(state)
select distinct state from adidas.adidas_staging order by state;

UPDATE adidas.adidas_staging
SET state_id = adidas.dim_state.state_id
FROM adidas.dim_state
WHERE adidas.adidas_staging.state = adidas.dim_state.state;

insert into adidas.dim_city(city,state_id)
select distinct city, state_id from adidas.adidas_staging order by city;

UPDATE adidas.adidas_staging
SET city_id = adidas.dim_city.city_id
FROM adidas.dim_city
join adidas.dim_state on dim_city.state_id = dim_state.state_id
WHERE adidas.adidas_staging.city = adidas.dim_city.city;

insert into adidas.dim_product(product)
select distinct product from adidas.adidas_staging order by product;

UPDATE adidas.adidas_staging
SET product_id = adidas.dim_product.product_id
FROM adidas.dim_product
WHERE adidas.adidas_staging.product = adidas.dim_product.product;

insert into adidas.dim_sales_method(sales_method)
select distinct sales_method from adidas.adidas_staging order by sales_method;

UPDATE adidas.adidas_staging
SET sales_method_id = adidas.dim_sales_method.sales_method_id
FROM adidas.dim_sales_method
WHERE adidas.adidas_staging.sales_method = adidas.dim_sales_method.sales_method;


insert into adidas.adidas_fact
select 
retailer_id,
region_id,
state_id, 
city_id,
product_id,
sales_method_id,
invoice_date,
convert(decimal(10,2),substring(price_per_unit,2)) price_per_unit,
convert(integer,REPLACE(units_sold,',','')) units_sold,
convert(integer,substring(REPLACE(total_sales,',',''),2)) total_sales,
convert(integer,substring(REPLACE(operating_profit,',',''),2)) operating_profit,
convert(integer,REPLACE(operating_margin,'%','')) operating_margin_in_percent
from adidas.adidas_staging;