#!/usr/bin/env perl

use strict;
use warnings;

use DBI;
use Data::Dump;
use Carp;

# connect to db

my $cfg = {
    dsn => "dbi:DB2:$ENV{DB_NAME}",

    #dsn    => "dbi:DB2:zdb_test",
    user   => "$ENV{DB_USER}",
    pass   => "$ENV{DB_PASS}",
    schema => "$ENV{DB_SCHEMA}",
};

Data::Dump->dump( @{$cfg}{qw/dsn user pass/} );

my $dbh1 = DBI->connect(
    @{$cfg}{qw/dsn user pass/},
    {
        AutoCommit => 0,    #默认属性是on , 此处关闭
        PrintError => 0,    #
        RaiseError => 1,    #
    }
);

if ($dbh1) {
    warn "connect to db this is 1st dbh \n";
}
else {
    warn "cannot connect 1st dbh $DBI::errstr\n";
}

  
#     0    1    2      3     4    5     
my ($sec,$min,$hour, $mday, $mon,$year) = (localtime(time))[ 0, 1, 2, 3, 4, 5 ];
my $date = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900 , $mon + 1 , $mday, $hour, $min, $sec);

eval {
    my $sth = $dbh1->do("insert into seq_yspz_ctrl(key) values ('0001')");
    $sth->execute();
    print $date . "\n";
    $dbh1->commit();
    warn $@ if ($@);
};
if($@) {
#    eval {
        $dbh1->rollback();
#    };
    $dbh1->disconnect();
    confess "ERROR: $@";    
}

my $rv = $dbh1->disconnect();
warn "the return value of succeed disconnect is :$rv";

exit;

