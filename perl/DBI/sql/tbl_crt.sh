#!/bin/bash

# connect to db 
db2 connect to zdb_dev user db2inst using db2inst ;

# set schema study
db2 set current schema study ;

for file in `ls *.sql`
do
    db2 -tvf $file;
done
