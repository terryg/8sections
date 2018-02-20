#!/usr/bin/python
# -*- coding: utf-8 -*-

import sqlite3 as lite
import sys
from xlrd import open_workbook

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
    conn = lite.connect('develop.db')

    cur = conn.cursor()
    cur.execute('SELECT SQLITE_VERSION()')

    data = cur.fetchone()

    print "SQLite version: %s" % data
    
    wb = open_workbook(sys.argv[1])

    check = ''' SELECT id FROM district_dimension WHERE code = "%s"; '''
    
    sql = ''' INSERT INTO district_dimension (id, code, name, county) VALUES (NULL, :code, :name, :county); '''

    my_rows = []
    for s in wb.sheets():
        for row in range(s.nrows):
            cur.execute(check % s.cell_value(row, code_index))
            data = cur.fetchone()
            if data == None:
                district = {'code':s.cell_value(row, 0), 'name':s.cell_value(row, 1), 'county':s.cell_value(row, 2)}
                my_rows.append(district)

    for item in my_rows:
        cur.execute(sql, item)
        conn.commit()
            
except lite.Error, e:
    print "Error %s: " % e
    sys.exit(1)
