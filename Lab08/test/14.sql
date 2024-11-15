.eqp on
.headers on
.expert

select r_name, count(*) as order_cnt
from orders, customer, nation, region
where o_custkey=c_custkey
    and c_nationkey=n_nationkey
    and n_regionkey=r_regionkey
    and o_orderstatus='F'
group by r_name;

