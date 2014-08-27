#!/usr/bin/env perl

#use strict;
use warnings;

use DBI;
use Data::Dump;
use Carp;

my $cfg = {
    dsn  => "dbi:DB2:$ENV{DB_NAME}",
    user => "$ENV{DB_USER}",
    pass => "$ENV{DB_PASS}",
};

my $dbh = &connect($cfg);

my $sth = $dbh->prepare(qq/select * from bip where id = 60/);
$sth->execute();
while ( my $row = $sth->fetchrow_hashref() ) {

    my %ref = $row->{content};
    # Data::Dump->dump(%ref);

    while ( my ( $idx, $grp ) = each %{$ref{gset}} ) {
        Data::Dump->dump($idx);
    }
    #     Data::Dump->dump($grp);
    #     for my $rule ( @{ $grp->{rules} } ) {
    #         for my $sect ( @{ $rule->{sect} } ) {

    #             # print $idx . "\t" . $sect->{begin} . "\n";
    #             if ( $sect->{mode} eq '比例' ) {
    #                 unless ( defined $sect->{ratio} ) {
    #                     print "协议id: $row->{id} 规则组id:$idx 规则条目 mode 比列 need match ratio\n";
    #                     return;
    #                 }
    #             }
    #             elsif ( $sect->{mode} eq '定额' ) {
    #                 unless ( defined $sect->{quota} ) {
    #                     print "协议id: $row->{id} 规则组id:$idx 规则条目 mode 定额 need match quota\n";
    #                     return;
    #                 }
    #             }
    #             else {
    #                 print "mode 为未知类型\n";
    #                     return;
    #             }
    #         }
    #     }
    # }
}

# connect to db
sub connect {
    my $cfg = shift;

    my $dbh = DBI->connect(
        @$cfg{qw/dsn user pass/},
        {
            RaiseError       => 1,
            PrintError       => 0,
            AutoCommit       => 0,
            FetchHashKeyName => 'NAME_lc',
            ChopBlanks       => 1,
            InactiveDestroy  => 1,
        }
    );

    unless ($dbh) {
        confess "connect to db fail";
        return;
    }

    return $dbh;
}
