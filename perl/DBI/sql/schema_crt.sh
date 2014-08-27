#!/bin/bash

# connect to db
db2 connect to zdb_dev user db2inst using db2inst ;

# create schema 
db2 "create shcema study";


