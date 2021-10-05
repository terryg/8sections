#!/bin/bash

rm -rf Average-Salary
mkdir Average-Salary

for ((c = 1998; c < 2020; c++)); do
    curl -X POST -F "ctl00\$ContentPlaceHolder1\$ddYear=$c" -F "ctl00\$ContentPlaceHolder1\$hfExport=ViewReport" https://profiles.doe.mass.edu/statereport/teachersalaries.aspx > Average-Salary/$c.html
done

