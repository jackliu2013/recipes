#!/usr/bin/env perl

use strict;
use warnings;

use IO::File;
use DBI;
use Data::Dump;

my $cfg = {
    dsn    => "dbi:DB2:zdb_dev",
    user   => "db2inst",
    pass   => "db2inst",
    schema => "db2inst",
};

my $rfh = IO::File->new("<bfjacct");

my $href;

#while (<$rfh>) {
#    s/^\s+//;
#    s/\s+$//;
#
#    if (/(\d+)\s+(.+)/) {
#        $hash1->{$1} = $2;
#    }
#
#    # Data::Dump->dump($hash1);
#}
#close $rfh;

#while (<*.lob>) {
#    my $file = $_;
#
#    while (<$rfh>) {
#        my $line = $_;
#        $line =~ s/^\s+//;
#        $line =~ s/\s+$//;
#
#        if ($line =~ /(\d+)\s+(.+)/) {
#            if (`grep $2 $file`) {
#                print $2 . "\t" . $file . "\n";
#            }
#        }
#
#    } #}
my $dbh = &connect();
unless ($dbh) {
    warn "cannot connect to db";
    exit -1;
}

my $sql = "select dept_bi from dept_bi where bi = ?";
my $sth = $dbh->prepare($sql);

while (<$rfh>) {
    my $line = $_;
    $line =~ s/^\s+//;
    $line =~ s/\s+$//;

    while (<*.lob>) {
        my $file = $_;
        if ( $line =~ /(\d+)\s+(.+)/ ) {
            if (`grep $2 $file`) {

                # print $2 . "\t" . $file . "\n";
                my $acct = $2;
                if ( $file =~ /\w+\_(\d+)\.*/ ) {
                    my $bi;
                    $sth->execute($1);
                    while ( ($bi) = $sth->fetchrow_array() ) {
                        # print $acct . "\t" . "\t" . $1 . "\n";
                        $bi =~ s/^\s+//;
                        $bi =~ s/\s+$//;
                        if ( exists $href->{$acct} ) {
                            $href->{$acct} = $href->{$acct} . ":$bi";
                        }
                        else {
                            $href->{$acct} = $bi;
                        }
                    }
                    $sth->finish();
                }
            }
        }

    }
}

Data::Dump->dump($href);

sub connect {
    my $dbh =
      DBI->connect( $cfg->{dsn}, $cfg->{user}, $cfg->{pass},
        { RaiseError => 1, AutoCommit => 0 },
      );

    $dbh->do("set current schema $cfg->{schema}")
      or die "can not set current schema $cfg->{schema}";
    return $dbh;
}

