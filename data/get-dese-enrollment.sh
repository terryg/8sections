#!/bin/bash

for ((c = $1; c < $2; c++)); do
   wget http://www.doe.mass.edu/InfoServices/reports/enroll/$c/District-Grade.xlsx
 
#  wget http://www.doe.mass.edu/InfoServices/reports/enroll/$c/dg.xlsx
  mv District-Grade.xlsx District-Grade--$c.xlsx
done
