#!/bin/bash

db2 connect to zdb_dev user db2inst using db2inst;
db2 set current schema db2inst;

# db2 "import from bip.del of del lobs from . insert_update into bip"
for id in `seq 1 133`
do
    db2 "import from bip_$id.del of del lobs from ./lob/ insert_update into bip"
done
