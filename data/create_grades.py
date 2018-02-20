#!/usr/bin/python
# -*- coding: utf-8 -*-

import sqlite3 as lite
import sys

try:
    conn = lite.connect('develop.db')

    cur = conn.cursor()
    cur.execute('SELECT SQLITE_VERSION()')

    data = cur.fetchone()

    print "SQLite version: %s" % data

    sql = ''' INSERT INTO grade_dimension (id, sequence, name) VALUES (NULL, :sequence, :name); '''

    my_rows = [
        {'id':1, 'sequence':0, 'name':'PK'},
        {'id':2, 'sequence':1, 'name':'K'},
        {'id':3, 'sequence':2, 'name':'GR1'},
        {'id':4, 'sequence':3, 'name':'GR2'},
        {'id':5, 'sequence':4, 'name':'GR3'},
        {'id':6, 'sequence':5, 'name':'GR4'},
        {'id':7, 'sequence':6, 'name':'GR5'},
        {'id':8, 'sequence':7, 'name':'GR6'},
        {'id':9, 'sequence':8, 'name':'GR7'},
        {'id':10, 'sequence':9, 'name':'GR8'},
        {'id':11, 'sequence':10, 'name':'GR9'},
        {'id':12, 'sequence':11, 'name':'GR10'},
        {'id':13, 'sequence':12, 'name':'GR11'},
        {'id':14, 'sequence':13, 'name':'GR12'},
        {'id':15, 'sequence':14, 'name':'22'}
    ]

    for item in my_rows:
        cur.execute(sql, item)
        conn.commit()
            
except lite.Error, e:
    print "Error %s: " % e
    sys.exit(1)
