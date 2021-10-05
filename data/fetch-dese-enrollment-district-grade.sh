#!/bin/bash

rm -rf District-Grade
mkdir District-Grade

for ((c = 3; c < 10; c++)); do
  wget https://www.doe.mass.edu/InfoServices/reports/enroll/0$c/dg.xls
  mv dg.xls District-Grade/200$c.xls
done

for ((c = 10; c < 13; c++)); do
  wget https://www.doe.mass.edu/InfoServices/reports/enroll/$c/dg.xls
  mv dg.xls District-Grade/20$c.xls
done

for ((c = 13; c < 15; c++)); do
  wget https://www.doe.mass.edu/InfoServices/reports/enroll/$c/dg.xlsx
  mv dg.xlsx District-Grade/20$c.xlsx
done

for ((c = 15; c < 22; c++)); do
  wget https://www.doe.mass.edu/InfoServices/reports/enroll/20$c/District-Grade.xlsx
  mv District-Grade.xlsx District-Grade/20$c.xlsx
done
