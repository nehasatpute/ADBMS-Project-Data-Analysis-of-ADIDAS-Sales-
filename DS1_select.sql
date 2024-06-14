select state, sum(units_sold) as sales from adidas.adidas_fact as fact
inner join adidas.dim_region as region on fact.region_id = region.region_id
inner join adidas.dim_state as state on fact.state_id = state.state_id
inner join adidas.dim_sales_method as sales_method on fact.sales_method_id = sales_method.sales_method_id
where lower(region) = 'northeast'
and lower(sales_method) = 'online'
and region is not NULL
and state is not NULL
and sales_method is not NULL
group by region, state, sales_method
order by sales desc;