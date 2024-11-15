.eqp on
.headers on
.expert

select count(o_orderkey) as order_cnt
from orders, customer, nation
where c_custkey=o_custkey
    and c_nationkey=n_nationkey
    and n_name='ROMANIA'
    and o_orderpriority='1-URGENT'
    and o_orderdate >= '1993-01-01' and o_orderdate <= '1997-12-31';
