#!/bin/bash

for ((c = $1; c < $2; c++)); do

  # if 3..9
  #wget http://www.doe.mass.edu/InfoServices/reports/enroll/0$c/sg.xls
  #mv sg.xls School-Grade--200$c.xls

  # if 10..12
  #wget http://www.doe.mass.edu/InfoServices/reports/enroll/$c/sg.xls
  #mv sg.xls School-Grade--20$c.xls

  # if 13..14
  wget http://www.doe.mass.edu/InfoServices/reports/enroll/$c/sg.xlsx
  mv sg.xlsx School-Grade--20$c.xlsx

  # if 2015..
  wget http://www.doe.mass.edu/InfoServices/reports/enroll/$c/school-grade.xlsx
  mv school-grade.xlsx School-Grade--$c.xlsx

done
