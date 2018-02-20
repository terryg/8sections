#!/bin/bash

rm develop.db
./init_db.py
./create_times.py
./create_grades.py
find . -name 'District*' -exec ./create_districts.py {} \;
find . -name 'District*' -exec ./extract.py {} \;
