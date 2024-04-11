SELECT DISTINCT o.mat_orders_code,
                o.users_code,
                o.orders_date,
                o.mat_total_orders_price,
                o.total_orders_status,
                d.mat_code,
                d.company_code
FROM mat_orders o JOIN mat_orders_detail d
ON o.mat_orders_code = d.mat_orders_code
JOIN (SELECT m.mat_code,
          m.mat_name,
          o.orders_date + m.lead_time "delivery_date"
     FROM mat_orders o JOIN mat_orders_detail d
                        ON o.mat_orders_code=d.mat_orders_code
                       JOIN mat m
                        ON m.mat_code=d.mat_code) s
ON s.mat_code = d.mat_code
       ORDER BY o.mat_orders_code;

SELECT product_code
   , product_name
   , unit_price
   , stock_cnt
   , safe_stock_cnt
FROM product;

SELECT *
  FROM all_tables
WHERE owner = 'DONUT'
ORDER BY 2;

select seq_func('orders') from dual;
