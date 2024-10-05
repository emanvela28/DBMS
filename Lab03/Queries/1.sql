.headers on
SELECT COUNT(*) AS item_cnt
FROM lineitem
WHERE l_shipdate < l_commitdate;
