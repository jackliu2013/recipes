#!/usr/bin/perl -w

=comment
a daemon simple
创建daemon守护进程
=cut

use strict;

# become daemon
my $pid = fork();
print $pid, "\n";

if ($pid) {
    #end parent process
    print "#parent process";
    exit(0);
}
else {
    print "#child process";
}

# set new process group
setpgrp;

while (1) {
    sleep(60);
    open( "TEST", ">>/home/jackliu/workspace/recipes/perl/basic/daemon/test.log" );
    my ( $sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst ) =
      localtime(time);
    $year += 1900;
    $mon++;
    print TEST ("Now is $year-$mon-$mday $hour:$min:$sec.\n");
    close(TEST);
}
