import psycopg2
import sqlalchemy

dbhost = ''
dbuser = 'mia'
dbpass = ''
dbname = 'db_engine_geocode'
dbport = 5432

conn = psycopg2.connect(host = dbhost,
		user = dbuser,
		password = dbpass,
		database = dbname,
		port = dbport)

print ('Opened Database Successfully')

def engine_sqlalchemy():
	engine = sqlalchemy.create_engine(
		str('postgresql://'+
		dbuser+':'+
		dbpass+'@'+
		dbhost+':'+
		str(dbport)+'/'+
		dbname),
	echo=False)
	return engine

def fetch(sql):
    cursor = conn.cursor()
    rs = None
    try:
        cursor.execute(sql)
        rs = cursor.fetchall()
    except:
        conn.rollback()
        cursor.execute(sql)
        rs = cursor.fetchall()
    cursor.close()
    return rs
    
def fetchone(sql):
	cursor = conn.cursor()
	rs = None
	try:
		cursor.execute(sql)
		rs = cursor.fetcone()
	except:
		conn.rollback()
		cursor.execute(sql)
		rs = cursor.fetchone()
	cursor.close()
	return rs

def execScalar(sql):
	cursor = conn.cursor()
	try:
		cursor.execute(sql)
		conn.commit()
		rowsaffected = cursor.rowcount
	except:
		rowsaffected = -1
		conn.rollback()
	cursor.close()
	return rowsaffected