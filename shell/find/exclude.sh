查找cache目录下不是html的文件

find ./cache ! -name '*.html' -type f

列出当前目录下的目录名,排除includes目录,后面的-print不能少

find . -path './includes' -prune -o -type d -maxdepth 1 -print

排除多个目录,”(“前是带”\”的

find / \( -path /home/ -o -path /root \) -prune -nouser -type f -exec ls -l {} \;
