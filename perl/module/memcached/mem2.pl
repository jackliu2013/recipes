#!/usr/bin/env perl

use Cache::Memcached;

my $memd = new Cache::Memcached { servers => ['127.0.0.1:11211'] };
my $key = 'test';
$memd->add( $key => 1, 3600 ) or warn 'Alread added';
while (1) {
    print $memd->get($key), "\n";
    $memd->incr($key) or warn 'FAIL!';
}

