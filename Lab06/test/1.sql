.headers on
SELECT
    supplier.s_name AS supplier,
    customer.c_name AS customer,
    orders.o_totalprice AS price
FROM
    orders
JOIN
    customer ON customer.c_custkey = orders.o_custkey,
    lineitem ON lineitem.l_orderkey = orders.o_orderkey,
    supplier ON supplier.s_suppkey = lineitem.l_suppkey
WHERE
    orders.o_orderstatus = 'F' AND
    orders.o_totalprice = (SELECT max(o_totalprice) FROM orders WHERE orders.o_orderstatus = 'F');