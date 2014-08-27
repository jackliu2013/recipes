cat ab.txt |grep "hello"|awk -F ? '{ print $2 }'|sort -r
