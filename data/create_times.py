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

    sql = ''' INSERT INTO time_dimension (id, year) VALUES (NULL, :year); '''

    my_rows = [
        {'id':1, 'year':2003},
        {'id':2, 'year':2004},
        {'id':3, 'year':2005},
        {'id':4, 'year':2006},
        {'id':5, 'year':2007},
        {'id':6, 'year':2008},
        {'id':7, 'year':2009},
        {'id':8, 'year':2010},
        {'id':9, 'year':2011},
        {'id':10, 'year':2012},
        {'id':11, 'year':2013},
        {'id':12, 'year':2014},
        {'id':13, 'year':2015},
        {'id':14, 'year':2016},
        {'id':15, 'year':2017}
    ]

    for item in my_rows:
        cur.execute(sql, item)
        conn.commit()
            
except lite.Error, e:
    print "Error %s: " % e
    sys.exit(1)
