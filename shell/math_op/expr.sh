#!/bin/bash

# expr命令

a=1
b=2

c=$(expr $b + $a);echo "c = $c";    # 3
c=$(expr $b - $a);echo "c = $c";    # 1
c=$(expr $b \* $a);  echo "c = $c"; # 2
c=$(expr $b \/ $a);  echo "c = $c"; # 2

