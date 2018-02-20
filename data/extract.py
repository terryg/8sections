#!/usr/bin/python
# -*- coding: utf-8 -*-

import sqlite3 as lite
import sys
from xlrd import open_workbook

print "EXTRACT", sys.argv[1]

wb_name = sys.argv[1]
year_index = wb_name.find('20')
wb_year = wb_name[year_index:year_index+4]

code_index = 0
pk_index = 4

if '2003' in wb_name:
    code_index = 1
    pk_index = 3

if '2004' in wb_name:
    code_index = 1
    pk_index = 3

try:
    wb = open_workbook(sys.argv[1])

    conn = lite.connect('develop.db')

    cur = conn.cursor()
    cur.execute('SELECT SQLITE_VERSION()')

    data = cur.fetchone()

    print "SQLite version: %s" % data

    cur.execute('SELECT id FROM time_dimension WHERE year = %s' % wb_year)
    data = cur.fetchone()

    time_id = data[0]
    
    sql = ''' INSERT INTO enrollment_facts (id, time_id, district_id, grade_id, size) VALUES (NULL, :time_id, :district_id, :grade_id, :size); '''

    values = []
    for s in wb.sheets():
        for row in range(s.nrows):
            cur.execute('SELECT id FROM district_dimension WHERE code = "%s"' % s.cell_value(row, code_index))
            data = cur.fetchone()
            if data == None:
                cur.execute(''' INSERT INTO district_dimension (id, code, name, county) VALUES (NULL, :code, :name, :county); ''', {'name':s.cell_value(row, code_index+1), 'code':s.cell_value(row, code_index), 'county':s.cell_value(row, code_index+2)})
                data = cur.fetchone()
                
            district_id = data[0]
            for i in range(15):
                cur.execute('SELECT id FROM grade_dimension WHERE sequence = %s' % i)
                data = cur.fetchone()
                grade_id = data[0]
                cur.execute(sql, {'id':row*15+i, 'time_id':time_id, 'district_id':district_id, 'grade_id':grade_id, 'size':s.cell_value(row, pk_index+i)})
                conn.commit()
                
except lite.Error, e:
    print "Error %s: " % e
    sys.exit(1)
