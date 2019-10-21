#!/bin/bash

for ((c = $1; c < $2; c++)); do
    curl -X POST -F "ctl00\$ContentPlaceHolder1\$ddYear=$c" -F "ctl00\$ContentPlaceHolder1\$hfExport=ViewReport" http://profiles.doe.mass.edu/statereport/teachersalaries.aspx > $c.html
done

