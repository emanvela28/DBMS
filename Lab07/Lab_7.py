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


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")

    sql = """
        CREATE TABLE IF NOT EXISTS warehouse (
            w_warehousekey decimal(9,0) not null,
            w_name char(100) not null,
            w_capacity decimal(6,0) not null,
            w_suppkey decimal(9,0) not null,
            w_nationkey decimal(2,0) not null
        )
    """
    _conn.cursor().execute(sql)
    _conn.commit()

    print("++++++++++++++++++++++++++++++++++")


def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")

    sql = "DROP TABLE IF EXISTS warehouse"
    _conn.cursor().execute(sql)
    _conn.commit()

    print("++++++++++++++++++++++++++++++++++")


def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")

    warr_dict = {
        "w_warehousekey": 1,
        "w_name": "",
        "w_capacity": 1,
        "w_suppkey": 1,
        "w_nationkey": 1,
    }

    warr_id = 1
    supp_id = 1
    arr = []

    sql = "SELECT s_name FROM supplier"

    cur = _conn.cursor()
    cur.execute(sql)
    rows = cur.fetchall()

    # Stores everything into arr
    for row in rows:
        # Get 3 best number of lineitems supplied by each supplier
        sql1 = f"""SELECT
                n_name,
                COUNT(l_linenumber) AS line_cnt,
                n_nationkey
            FROM
                supplier,
                lineitem,
                customer,
                orders,
                nation
            WHERE
                c_nationkey = n_nationkey
                AND c_custkey = o_custkey
                AND o_orderkey = l_orderkey
                AND s_suppkey = l_suppkey
                AND s_name = '{row[0]}'
            GROUP BY n_name
            ORDER BY line_cnt DESC, n_name ASC
            LIMIT 3
            """

        # Get total total p_size supplied by each supplier
        sql2 = f"""SELECT part_cnt * 3 AS total
                    FROM
                        (SELECT
                            n_name,
                            s_name,
                            SUM(p_size) AS part_cnt
                        FROM
                            part,
                            supplier,
                            customer,
                            nation,
                            lineitem,
                            orders
                        WHERE
                            c_nationkey = n_nationkey
                            AND c_custkey = o_custkey
                            AND o_orderkey = l_orderkey
                            AND s_suppkey = l_suppkey
                            AND p_partkey = l_partkey
                            AND s_name = '{row[0]}'
                        GROUP BY n_name, s_name
                        ORDER BY part_cnt DESC
                        LIMIT 1)
                """

        cur.execute(sql1)
        rows2 = cur.fetchall()

        cur.execute(sql2)
        rows3 = cur.fetchall()

        for row2 in rows2:
            arr.append(warr_dict.copy())
            arr[warr_id - 1]["w_warehousekey"] = warr_id
            arr[warr_id - 1]["w_suppkey"] = supp_id
            arr[warr_id - 1]["w_name"] = row[0] + "___" + row2[0]
            arr[warr_id - 1]["w_nationkey"] = row2[2]
            arr[warr_id - 1]["w_capacity"] = rows3[0][0]
            print(arr[warr_id - 1])
            warr_id += 1
        supp_id += 1

    # Insert data into table
    for row in arr:
        sql = "INSERT INTO warehouse VALUES(?,?,?,?,?)"
        cur.execute(sql, (list(row.values())))

    _conn.commit()

    # sql = "SELECT * FROM warehouse"

    # cur.execute(sql)
    # rows = cur.fetchall()

    # for row in rows:
    #     print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    try:
        output = open("output/1.out", "w")

        header = "{:>10} {:<40} {:>10} {:>10} {:>10}"
        output.write((header.format("wId", "wName", "wCap", "sId", "nId")) + "\n")

        sql = """SELECT
                    w_warehousekey as wId,
                    w_name as wName,
                    w_capacity as wCap,
                    w_suppkey as sId,
                    w_nationkey as nId
                FROM
                    warehouse"""

        cur = _conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()

        for row in rows:
            print(row)
            output.write((header.format(row[0], row[1], row[2], row[3], row[4])) + "\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    try:
        output = open("output/2.out", "w")

        header = "{:<40} {:>10} {:>10}"
        output.write((header.format("nation", "numW", "totCap")) + "\n")

        sql = """
            SELECT
                n_name,
                COUNT(w_warehousekey) AS numW,
                SUM(w_capacity) AS totCap
            FROM
                warehouse,
                nation
            WHERE
                w_nationkey = n_nationkey
            GROUP BY
                n_name
            ORDER BY
                COUNT(w_warehousekey) DESC,
                n_name ASC
        """

        cur = _conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()

        for row in rows:
            print(row)
            output.write((header.format(row[0], row[1], row[2])) + "\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    try:
        # Open and read the nation from the input file
        with open("input/3.in", "r") as input_file:
            nation = input_file.readline().strip()

        # Prepare the output file and header
        with open("output/3.out", "w") as output_file:
            header = "{:<20} {:<20} {:<40}"
            output_file.write(header.format("supplier", "nation", "warehouse") + "\n")

            # Define the SQL query to fetch the supplier, nation, and warehouse information
            sql = """
                SELECT
                    supplier.s_name AS supplier,
                    nation.n_name AS nation,
                    warehouse.w_name AS warehouse
                FROM
                    warehouse
                JOIN
                    supplier ON warehouse.w_suppkey = supplier.s_suppkey
                JOIN
                    nation ON warehouse.w_nationkey = nation.n_nationkey
                WHERE
                    nation.n_name = ?
                ORDER BY
                    supplier.s_name ASC;
            """

            # Execute the query with the given nation as a parameter
            cursor = _conn.cursor()
            cursor.execute(sql, (nation,))
            rows = cursor.fetchall()

            # Write each row to the output file in the specified format
            for row in rows:
                output_file.write(header.format(row[0], row[1], row[2]) + "\n")

    except Error as e:
        print("Error:", e)

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    try:
        input = open("input/4.in", "r")
        region = input.readline().strip()
        cap = input.readline().strip()
        input.close()

        output = open("output/4.out", "w")

        header = "{:<40} {:>10}"
        output.write((header.format("warehouse", "capacity")) + "\n")

        sql = f"""
        SELECT
            w_name,
            MIN(w_capacity) as capacity
        FROM
            warehouse
        WHERE
            w_nationkey in (SELECT n_nationkey FROM nation WHERE n_regionkey in (SELECT r_regionkey FROM region WHERE r_name = '{region}'))
            AND w_capacity > {cap}
        GROUP BY w_name
        ORDER BY capacity DESC
        """
        cur = _conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()

        for row in rows:
            print(row)
            output.write((header.format(row[0], row[1])) + "\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    try:
        input = open("input/5.in", "r")
        nation = input.readline().strip()
        input.close()

        output = open("output/5.out", "w")

        header = "{:<20} {:>20}"
        output.write((header.format("region", "capacity")) + "\n")
        sql = f"""
            SELECT
                r_name,
                CASE WHEN totCap > 0 THEN totCap ELSE 0 END
            FROM
                region,
                (SELECT
                    r_name as name,
                    SUM(w_capacity) as totCap
                FROM
                    supplier,
                    nation as n1,
                    nation as n2,
                    region,
                    warehouse
                WHERE
                    w_nationkey = n1.n_nationkey
                    AND n1.n_regionkey = r_regionkey
                    AND n2.n_name = '{nation}'
                    AND s_nationkey = n2.n_nationkey
                    AND s_suppkey = w_suppkey
                GROUP BY r_name
                ) AS rTotCap
            WHERE
                r_name = name
            GROUP BY r_name
            """

        cur = _conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()

        for row in rows:
            print(row)
            output.write((header.format(row[0], row[1])) + "\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)

    closeConnection(conn, database)


if __name__ == "__main__":
    main()