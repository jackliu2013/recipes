#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dump;
use Time::HiRes qw/gettimeofday/ ;

=comment 

Time::HiRes - High resolution alarm, sleep, gettimeofday, interval timers

SYNOPSIS

  use Time::HiRes qw( usleep ualarm gettimeofday tv_interval nanosleep
                      clock_gettime clock_getres clock_nanosleep clock
                      stat lstat );

  usleep ($microseconds);
  nanosleep ($nanoseconds);

  ualarm ($microseconds);
  ualarm ($microseconds, $interval_microseconds);

  $t0 = [gettimeofday];
  ($seconds, $microseconds) = gettimeofday;

  $elapsed = tv_interval ( $t0, [$seconds, $microseconds]);
  $elapsed = tv_interval ( $t0, [gettimeofday]);
  $elapsed = tv_interval ( $t0 );


  use Time::HiRes qw ( time alarm sleep );

  $now_fractions = time;
  sleep ($floating_seconds);
  alarm ($floating_seconds);
  alarm ($floating_seconds, $floating_interval);

  use Time::HiRes qw( setitimer getitimer );
  setitimer ($which, $floating_seconds, $floating_interval );
  getitimer ($which);


  use Time::HiRes qw( clock_gettime clock_getres clock_nanosleep
                    ITIMER_REAL ITIMER_VIRTUAL ITIMER_PROF ITIMER_REALPROF );

  $realtime   = clock_gettime(CLOCK_REALTIME);
  $resolution = clock_getres(CLOCK_REALTIME);
  clock_nanosleep(CLOCK_REALTIME, 1.5e9);
  clock_nanosleep(CLOCK_REALTIME, time()*1e9 + 10e9, TIMER_ABSTIME);
  my $ticktock = clock();


  use Time::HiRes qw( stat lstat );

  my @stat = stat("file");
  my @stat = stat(FH);
  my @stat = lstat("file");

=cut

my   $t0 = [gettimeofday];
Data::Dump->dump( $t0 ) ;

