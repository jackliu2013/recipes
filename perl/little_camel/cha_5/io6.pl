=tell

严重错误和die
die 函数将打印出你给它的消息(利用标准错误流)
,并确保程序退出时为非零(nonzero)的退出状态(exit status)。

警告信息和warn
warn 函数像 die 那样工作,除了最后一步,它不会从程序中退出。
它也能加上程序的名字和行号,并把消息输出到标准错误那里(standard error),
和 die 一样
◆ 警告(warnings)不能通过 eval 来捕捉,但严重错误(fatal error)可以。
但可以在_ _warning_ _(在 perlvar 的帮助手册中有)中找到

=cut

#!/usr/bin/perl

use strict;
use warnings;
