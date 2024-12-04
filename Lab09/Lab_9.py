import sqlite3
from sqlite3 import Error

def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V1")
    cur = _conn.cursor()
    cur.execute("DROP VIEW IF EXISTS V1")
    cur.execute("CREATE VIEW V1 AS "
                "SELECT c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name AS c_nation,r_name AS c_region "
                "FROM customer, nation, region "
                "WHERE c_nationkey = n_nationkey "
                "AND n_regionkey = r_regionkey")
    _conn.commit()
    cur.close()

    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    try:
        output = open('output/1.out', 'w')

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT c_nation AS country, count(*) AS cnt
                    FROM orders, V1
                    WHERE c_custkey = o_custkey
                        AND c_region = 'MIDDLE EAST'
                    GROUP BY c_nation
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

def create_View2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V2")
    
    cur = _conn.cursor()
    cur.execute("DROP VIEW IF EXISTS V2")
    cur.execute('''
                CREATE VIEW V2 AS
                SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, strftime('%Y', o_orderdate) AS o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment
                FROM orders''')
    _conn.commit()
    cur.close()
    
    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    try:
        output = open('output/2.out', 'w')

        header = "{}|{}"
        output.write((header.format("customer", "cnt")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT c_name AS customer, count(*) AS cnt
                    FROM V2, V1
                    WHERE o_custkey = c_custkey
                        AND c_nation = 'MOZAMBIQUE'
                        AND o_orderyear = '1997'
                    GROUP BY c_name
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    try:
        output = open('output/3.out', 'w')

        header = "{}|{}"
        output.write((header.format("customer", "total_price")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT c_name AS customer, sum(o_totalprice) AS total_price
                    FROM V2, V1
                    WHERE o_custkey = c_custkey
                        AND c_nation = 'GERMANY'
                        AND o_orderyear = '1992'
                    GROUP BY c_name
                    ''')
        rows = cur.fetchall()
        for row in rows:
            formatted_price = "{:.2f}".format(row[1])
            output.write((header.format(row[0], formatted_price)) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V4")
    cur = _conn.cursor()
    cur.execute("DROP VIEW IF EXISTS V4")
    cur.execute('''
                CREATE VIEW V4 AS
                SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name AS s_nation, r_name AS s_region
                FROM supplier, nation, region
                WHERE s_nationkey = n_nationkey
                    AND n_regionkey = r_regionkey''')
    _conn.commit()
    cur.close()
    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    try:
        output = open('output/4.out', 'w')

        header = "{}|{}"
        output.write((header.format("supplier", "cnt")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT s_name AS supplier, count(*) AS cnt
                    FROM partsupp, V4, part
                    WHERE ps_partkey = p_partkey
                        AND ps_suppkey = s_suppkey
                        AND s_nation = 'RUSSIA'
                        AND p_container LIKE '%CAN%'
                    GROUP BY s_name
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    try:
        output = open('output/5.out', 'w')

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT s_nation AS country, count(*) AS cnt
                    FROM V4
                    WHERE s_nation = 'JAPAN' OR s_nation = 'CHINA'
                    GROUP BY s_nation
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q6(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q6")

    try:
        output = open('output/6.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("supplier", "priority", "parts")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT s_name AS supplier, o_orderpriority AS priority, count(distinct ps_partkey) AS parts
                    FROM partsupp, V2, V4, lineitem
                    WHERE l_orderkey = o_orderkey
                        AND l_partkey = ps_partkey
                        AND l_suppkey = ps_suppkey
                        AND ps_suppkey = s_suppkey
                        AND s_nation = 'ARGENTINA'
                    GROUP BY s_name, o_orderpriority
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1], row[2])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q7(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q7")

    try:
        output = open('output/7.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("country", "status", "orders")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT c_nation AS country, o_orderstatus AS status, count(*) AS orders
                    FROM V1, V2
                    WHERE c_custkey = o_custkey
                        AND c_region = 'ASIA'
                    GROUP BY c_nation, o_orderstatus
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1], row[2])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q8(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q8")

    try:
        output = open('output/8.out', 'w')

        header = "{}"
        output.write((header.format("clerks")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT count(distinct o_clerk) AS clerks
                    FROM V2, V4, lineitem
                    WHERE l_orderkey = o_orderkey
                        AND l_suppkey = s_suppkey
                        AND s_nation = 'IRAQ'
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q9(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q9")

    try:
        output = open('output/9.out', 'w')

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT s_nation AS country, count(distinct o_orderkey) AS cnt
                    FROM V2, V4, lineitem
                    WHERE l_orderkey = o_orderkey
                        AND l_suppkey = s_suppkey
                        AND s_region = 'AMERICA'
                        AND o_orderstatus = 'F'
                        AND o_orderyear = '1994'
                    GROUP BY s_nation
                    HAVING cnt >= 250
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

def create_View10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V10")
    cur = _conn.cursor()
    cur.execute("DROP VIEW IF EXISTS V10")
    cur.execute('''
                CREATE VIEW V10 AS
                SELECT p_type, min(l_discount) AS min_discount, max(l_discount) AS max_discount
                FROM lineitem, part
                WHERE l_partkey = p_partkey
                GROUP BY p_type''')
    _conn.commit()
    cur.close()
    print("++++++++++++++++++++++++++++++++++")


def Q10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q10")

    try:
        output = open('output/10.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("part_type", "min_disc", "max_disc")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT p_type AS part_type, min_discount, max_discount
                    FROM V10
                    WHERE p_type LIKE '%MEDIUM%'
                        OR p_type LIKE '%TIN%'
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1], row[2])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

def create_View111(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V111")
    cur = _conn.cursor()
    cur.execute("DROP VIEW IF EXISTS V111")
    cur.execute('''
                CREATE VIEW V111 AS
                SELECT c_custkey, c_name, c_nationkey, c_acctbal
                FROM customer
                WHERE c_acctbal < 0''')
    _conn.commit()
    cur.close()
    print("++++++++++++++++++++++++++++++++++")


def create_View112(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V112")
    cur = _conn.cursor()
    cur.execute("DROP VIEW IF EXISTS V112")
    cur.execute('''
                CREATE VIEW V112 AS
                SELECT s_suppkey, s_name, s_nationkey, s_acctbal
                FROM supplier
                WHERE s_acctbal > 0''')
    _conn.commit()
    cur.close()
    print("++++++++++++++++++++++++++++++++++")


def Q11(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q11")

    try:
        output = open('output/11.out', 'w')

        header = "{}"
        output.write((header.format("order_cnt")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT count(distinct o_orderkey) AS order_cnt
                    FROM V2, V111, V112, lineitem
                    WHERE l_suppkey = s_suppkey
                        AND o_custkey = c_custkey
                        AND o_orderkey = l_orderkey
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q12(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q12")

    try:
        output = open('output/12.out', 'w')

        header = "{}|{}"
        output.write((header.format("region", "max_bal")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT s_region AS region, max(s_acctbal) AS max_bal
                    FROM V4
                    GROUP BY s_region
                    HAVING max_bal > 9000
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q13(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q13")
    try:
        cursor = _conn.cursor()
        output = open('output/13.out', 'w')

        query = """
        SELECT V4.s_region AS supp_region, V1.c_region AS cust_region, MIN(V2.o_totalprice) AS min_price
        FROM V2
        JOIN lineitem l ON V2.o_orderkey = l.l_orderkey
        JOIN V4 ON l.l_suppkey = V4.s_suppkey
        JOIN V1 ON V2.o_custkey = V1.c_custkey
        GROUP BY V4.s_region, V1.c_region;
        """

        rows = cursor.execute(query).fetchall()

        header = "{}|{}|{}"
        output.write(header.format("supp_region", "cust_region", "min_price") + '\n')

        for row in rows:
            output.write("|".join(map(str, row)) + '\n')
            
        output.close()

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")



def Q14(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q14")

    try:
        output = open('output/14.out', 'w')

        header = "{}"
        output.write((header.format("items")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT count(*) AS items
                    FROM V1, V4, lineitem, orders
                    WHERE o_orderkey = l_orderkey
                        AND o_custkey = c_custkey
                        AND l_suppkey = s_suppkey
                        AND s_region = 'EUROPE'
                        AND c_nation = 'INDIA'
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q15(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q15")

    try:
        output = open('output/15.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("region", "supplier", "acct_bal")) + '\n')
        cur = _conn.cursor()
        cur.execute('''
                    SELECT s_region AS region, s_name AS supplier, s_acctbal AS acct_bal
                    FROM V4
                    WHERE s_acctbal = (
                        SELECT max(s1.s_acctbal)
                        FROM V4 s1
                        WHERE s1.s_region = V4.s_region
                    )
                    ''')
        rows = cur.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1], row[2])) + '\n')
        cur.close()

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"


    conn = openConnection(database)
    with conn:
        create_View1(conn)
        create_View2(conn)
        create_View4(conn)
        create_View10(conn)
        create_View111(conn)
        create_View112(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)
        Q6(conn)
        Q7(conn)
        Q8(conn)
        Q9(conn)
        Q10(conn)
        Q11(conn)
        Q12(conn)
        Q13(conn)
        Q14(conn)
        Q15(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
