# connect to mysql

import pymysql

class Sql:

    def __init__(self):
        pass

    def conn_db(self, host,port,user,passwd,db):
        db_conn = pymysql.connect(host=host,port=port,user=user,passwd=passwd,db=db,charset='utf8')
        return db_conn

    def exec_sql(self, db_conn, sql, data=[]):
        cur = db_conn.cursor()
        if data:
            cur.executemany(sql, data)
        else:
            for s in sql.split(';'):
                if s == '':
                    continue
                cur.execute(s)
        db_conn.commit()
        cur.close()

        return cur

