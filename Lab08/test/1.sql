.eqp on
.headers on
.expert

select count(*) as item_cnt
from lineitem
where l_shipdate < l_commitdate;
