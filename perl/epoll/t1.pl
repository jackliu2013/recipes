#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dump;
use IO::Epoll;

my $epfd = epoll_create(10);

epoll_ctl( $epfd, EPOLL_CTL_ADD, fileno STDIN, EPOLLIN) >=0 
 || die "epoll_ctl: $!\n";

my $events = epoll_wait( $epfd, 10, 10000 );

Data::Dump->dump($events);
