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
        AutoCommit => 0,    #默认属性是on , 此处关闭 当自动提交关闭的时候，使用begin_work会报错
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

my $rc = $dbh1->do("update job_dz set type = 2 where id = 2 ") or confess $dbh1->errstr ;

# $dbh1->do("update job_dz set type = 2 where id = 1 ") or confess $dbh1->errstr ;
# $dbh1->commit() or confess $dbh1->errstr ;
# $dbh1->do("update job_dz set type = 2 where id = 2 ") or confess $dbh1->errstr ;

my $rv = $dbh1->disconnect() or confess $dbh1->errstr ;
warn "the return value of succeed disconnect is :$rv";

exit;

sub commit1 {
    my $rc =  $dbh1->do("update job_dz set type = 2 where id = 1 ") or confess $dbh1->errstr ;
    $dbh1->commit() or confess $dbh1->errstr ;
    return $rc;
}

sub commit2 {
    my $rc = $dbh1->do("update job_dz set type = 2 where id = 2 ") or confess $dbh1->errstr ;
    $dbh1->commit() or confess $dbh1->errstr ;
    return $rc;
}
