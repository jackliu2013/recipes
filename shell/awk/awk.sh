#
# awk 显示文件中的多列
#
#!/bin/bash
awk -F"|" '{for(i=3;i<=NF;i++) printf $i}{print"\n"}' $1
