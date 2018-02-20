#!/usr/bin/python
# -*- coding: utf-8 -*-

import sqlite3 as lite
import sys

conn = None

try:
    conn = lite.connect('develop.db')

    cur = conn.cursor()
    cur.execute('SELECT SQLITE_VERSION()')

    data = cur.fetchone()

    print "SQLite version: %s" % data

    cur.execute('CREATE TABLE time_dimension(id INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER UNIQUE)')
    cur.execute('CREATE TABLE district_dimension(id INTEGER PRIMARY KEY AUTOINCREMENT, code CHAR(4) UNIQUE, name VARCHAR(80), county VARCHAR(80))')
    cur.execute('CREATE TABLE grade_dimension(id INTEGER PRIMARY KEY AUTOINCREMENT, sequence INTEGER, name VARCHAR(80))')
    cur.execute('CREATE TABLE enrollment_facts(id INTEGER PRIMARY KEY AUTOINCREMENT, time_id INTEGER, district_id INTEGER, grade_id INTEGER, size INTEGER)')
    
except lite.Error, e:

    print "Error %s:" % e.args[0]
    sys.exit(1)

finally:

    if conn:
        conn.close()
