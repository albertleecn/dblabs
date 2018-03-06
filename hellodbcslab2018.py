#!/usr/bin/python
import MySQLdb
db = MySQLdb.connect("localhost","myuser","pwd","dbsclab2018" )
cursor = db.cursor()
cursor.execute('SELECT name,dept_name from instructor')
data = cursor.fetchall()
for row in data:
	print "%s, %s" %row
db.close()
