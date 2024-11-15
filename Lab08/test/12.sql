.eqp on
.headers on
.expert

select substr(o_orderdate, 1, 4) as year, count(*) as item_cnt
from orders, nation, supplier, lineitem
where l_orderkey = o_orderkey
    and l_suppkey = s_suppkey
    and n_nationkey = s_nationkey
    and o_orderpriority='3-MEDIUM'
    and (n_name = 'ARGENTINA' or n_name = 'BRAZIL')
group by year;
