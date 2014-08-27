#!/usr/bin/perl

use strict;
use Data::Dump;
use DBI;
use Cache::Memcached;
my $host     = '127.0.0.1';
my $dbuser   = 'db2inst';
my $dbpasswd = 'db2inst';
my $db       = 'zdb_dev';
my $dsn      = "dbi:DB2:$db";

my $dbh = DBI->connect(
    $dsn, $dbuser, $dbpasswd,
    {
        PrintError => 1,
        RaiseError => 0
    }
);

my $test_id = 4;

my $memd = new Cache::Memcached {
    'servers'            => [ "127.0.0.1:11211" ],
    'debug'              => 0,
    'compress_threshold' => 10_000,
};

my $val;
$val = init_object($test_id);
print "init " . Data::Dump->dump($val) . "\n";

$val = repl_object($test_id);
print "repl  " . Data::Dump->dump($val) . "\n";

$val = get_object($test_id);
print "get value " . Data::Dump->dump($val) . "\n";

# $val = incr_object($test_id);
# print "incr1 " . Data::Dump->dump($val) . "\n";
# 
# $val = incr_object($test_id);
# print "incr2 " . Data::Dump->dump($val) . "\n";

if ( del_object($test_id) ) {
    my $val = get_object($test_id);
    print "del " . Data::Dump->dump($val) . "\n";
}
print "stats " . Data::Dump->dump( $memd->stats('misc') ) . "\n";
$memd->disconnect_all;

#----------------
# test subroutines
#
sub init_object {
    my $foo_id = shift;
    my $obj    = $memd->get("foo:$foo_id");
    return $obj if $obj;
    my $query = "select id,name from test where id=$foo_id";
    $obj = $dbh->selectrow_hashref($query);
    $memd->set( "foo:$foo_id", $obj );
    return $obj;
}

sub get_object {
    my $foo_id = shift;
    my $obj    = $memd->get("foo:$foo_id");
    return $obj;
}

sub del_object {
    my $foo_id = shift;
    $memd->delete("foo:$foo_id");
}

sub repl_object {
    my $foo_id = shift;
    my $query  = "select id, name from test where id=$foo_id";
    my $obj    = $dbh->selectrow_hashref($query);
    $memd->replace( "foo:$foo_id", $obj );
    return $obj;
}

sub incr_object {
    my $foo_id = shift;
    $memd->incr("foo:$foo_id");
}
