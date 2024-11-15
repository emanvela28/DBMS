.eqp on
.headers on
.expert

select substr(l_receiptdate,1,7) as year_month, count(*) as items
from lineitem, orders, customer
where l_orderkey = o_orderkey and o_custkey = c_custkey
    and c_name = 'Customer#000000227'
group by year_month;
