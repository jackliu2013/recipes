#!/usr/bin/env perl

use Cache::Memcached;
use Data::Dump;

use strict;
use warnings;

my $memd = new Cache::Memcached {
    'servers'            => [ "127.0.0.1:11211" ],
    'debug'              => 0,
    'compress_threshold' => 10_000,
};

$memd->set( "my_key", "Some value" );
$memd->set( "object_key", { 'complex' => [ "object", 2, 4 ] } );

my $href; # hash ref

Data::Dump->dump($memd->get("my_key"));
Data::Dump->dump($memd->get("object_key"));
$href = $memd->get_multi("object_key");
Data::Dump->dump($href);

Data::Dump->dump($href->{object_key}->{complex}->[0]); 
Data::Dump->dump($href->{object_key}->{complex}->[1]); 
Data::Dump->dump($href->{object_key}->{complex}->[2]); 


my $val = $memd->get("object_key");
print $val->{complex}->[0] . "\n";
print $val->{complex}->[1] . "\n";
print $val->{complex}->[2] . "\n";
