#!/bin/bash

:<<comment
1. lsof简介
lsof（list open files）是一个列出当前系统打开文件的工具. 在linux环境下，任何事物都以文件的形式存在， 通过文件不仅仅可以访问常规数据，还可以访问网络连接和硬件。

2. lsof常见用法
lsof 常见的用法是查找应用程序打开的文件的名称和数目。 可用于查找出某个特定应用程序将日志数据记录到何处，或者正在跟踪某个问题。 例如，linux限制了进程能够打开文件的数目。通常这个数值很大，所以不会产生问题， 并且在需要时，应用程序可以请求更大的值（直到某个上限）。 如果你怀疑应用程序耗尽了文件描述符，那么可以使用 lsof 统计打开的文件数目，以进行验证。

在终端下输入lsof即可显示系统打开的文件，因为 lsof 需要访问核心内存和各种文件，所以必须以 root 用户的身份运行它才能够充分地发挥其功能。

COMMAND    PID      USER   FD      TYPE     DEVICE     SIZE       NODE      NAME
init       1         root  cwd      DIR       3,3       1024       2         /
init       1         root  rtd      DIR       3,3       1024       2         /
init       1         root  txt      REG       3,3       38432      1763452  /sbin/init
init       1         root  mem      REG       3,3       106114     1091620  /lib/libdl-2.6.so
init       1         root  mem      REG       3,3       7560696    1091614  /lib/libc-2.6.so
init       1         root  mem      REG       3,3       79460      1091669  /lib/libselinux.so.1
init       1         root  mem      REG       3,3       223280     1091668  /lib/libsepol.so.1
init       1         root  mem      REG       3,3       564136     1091607  /lib/ld-2.6.so
init       1         root  10u      FIFO      0,15                  1309     /dev/initctl


每行显示一个打开的文件，若不指定条件默认将显示所有进程打开的所有文件。lsof输出各列信息的意义如下：

COMMAND：进程的名称
PID：进程标识符
USER：进程所有者
FD：文件描述符，应用程序通过文件描述符识别该文件。如cwd、txt等
TYPE：文件类型，如DIR、REG等
DEVICE：指定磁盘的名称
SIZE：文件的大小
NODE：索引节点（文件在磁盘上的标识）
NAME：打开文件的确切名称

其中FD 列中的文件描述符cwd 值表示应用程序的当前工作目录，这是该应用程序启动的目录，除非它本身对这个目录进行更改。
txt 类型的文件是程序代码，如应用程序二进制文件本身或共享库，如上列表中显示的 /sbin/init 程序。其次数值表示应用程序的文件描述符，这是打开该文件时返回的一个整数。如上的最后一行文件/dev/initctl，其文件描述符为 10。
u 表示该文件被打开并处于读取/写入模式，而不是只读 (r) 或只写 (w) 模式。同时还有大写 的W 表示该应用程序具有对整个文件的写锁。该文件描述符用于确保每次只能打开一个应用程序实例。
初始打开每个应用程序时，都具有三个文件描述符，从 0 到 2，分别表示标准输入、输出和错误流。所以大多数应用程序所打开的文件的 FD 都是从 3 开始。

与 FD 列相比，Type 列则比较直观。文件和目录分别称为 REG 和 DIR。而CHR 和 BLK，分别表示字符和块设备；或者 UNIX、FIFO 和 IPv4，分别表示 UNIX 域套接字、先进先出 (FIFO) 队列和网际协议 (IP) 套接字。


1.  `lsof filename`     : 显示打开指定文件的所有进程
2.  `lsof -a`           : 表示两个参数都必须满足时才显示结果
3.  `lsof -c string`    : 显示COMMAND列中包含指定字符的进程所有打开的文件
4.  `lsof -u username`  : 显示所属user进程打开的文件
5.  `lsof -g`           : gid 显示归属gid的进程情况
6.  `lsof +d /DIR/`     : 显示目录下被进程打开的文件
7.  `lsof +D /DIR/`     : 同上，但是会搜索目录下的所有目录，时间相对较长
8.  `lsof -d FD`        : 显示指定文件描述符的进程
9.  `lsof -n`           : 不将IP转换为hostname，缺省是不加上-n参数
10. `lsof -U`           : Unix Domain套接字
11. `lsof -i[46] [protocol][@hostname|hostaddr][:service|port]
        46       --> IPv4 or IPv6
        protocol --> TCP or UDP
        hostname --> Internet host name
        hostaddr --> IPv4地址
        service  --> /etc/service中的 service name (可以不只一个)
        port     --> 端口号 (可以不只一个)`
comment

# 1.查看22号端口运行情况
lsof -i :22 


# 2.查看所属root用户进程所打开的文件类型为txt的文件
lsof -a -u hary -d txt

# 3.谁在使用文件系统或目录
lsof /home/liutailin

# 4.显示所有unix domain套接字
lsof -i -U

# 5.显示所有IPV4套接字被进程8566打开的
lsof -i 4 -a -p 8566


# 6.显示所有连接到www.sohu.com的80,81,82端口的文件
lsof -i @www.sohu.com:80-82

# 7.所有连接到remote host的文件(任何端口)
lsof -i @www.sohu.com
lsof -i @128.210.15.17

# 8.进程456,123或者是789, 或者是uid为1234或者是用户abe的文件
lsof -p 456,123,789 -u 1234,abe

# 9.当前目录下运行满足指定正则表达式的命令行的程序
lsof -c /^..o.$/i -a -d cwd

# 10.分析下面例子
# -r 2     : 每2秒
# -c lsof  : 使用lsof命令
# -a       : 并且
# -d 1     : 文件描述符1
lsof -c lsof -a -d 1 -d 3 -u hary -r 2
COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
lsof    13225 hary    1u   CHR  136,1      0t0    4 /dev/pts/1
lsof    13225 hary    3r   DIR    0,3        0    1 /proc
=======
COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
lsof    13225 hary    1u   CHR  136,1      0t0    4 /dev/pts/1
lsof    13225 hary    3r   DIR    0,3        0    1 /proc






