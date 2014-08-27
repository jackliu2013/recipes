#!/user/bin/env perl

use strict;
use warnings;
use DBI;
use Carp;
use Data::Dump;

my $cfg = {

    # 数据库配置
    db => {
        dsn    => "dbi:DB2:zdb_dev",
        user   => "$ENV{DB_USER}",
        pass   => "$ENV{DB_PASS}",
        schema => "$ENV{DB_SCHEMA}",
    },
};

my $dbh = &dbh();

my $books = $dbh->selectall_arrayref(qq/select id, value from dict_book/);

# Data::Dump->dump( $books );

my %meta_book;
for my $row (@$books) {
    my $name = $row->[1];
    my $sth_nhash = $dbh->prepare("select * from book_$name") or return;
    $sth_nhash->finish();
    my $nhash = $sth_nhash->{NAME_hash};
    Data::Dump->dump( $nhash );

    my %nhash = %{$nhash};
    delete @nhash{qw/ID J D YS_TYPE YS_ID JZPZ_ID TS_C/};
    my $dim = [ map { lc $_ } sort { lc $a cmp lc $b } keys %nhash ];

    # attention: 返回排序好的核算项

    # $meta_book{$name}[BOOK_ID]    = $row->[0];
    # $meta_book{$name}[BOOK_NHASH] = $nhash;
    # $meta_book{$name}[BOOK_FLIST] = $dim;
}




sub dbh {
    my $dbh = DBI->connect(
        @{ $cfg->{db} }{qw/dsn user pass/},
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
        confess "can not connet db[@{$cfg->{db}}{qw/dsn user pass/}], quit";
    }

    # 设置默认schema
    $dbh->do("set current schema $cfg->{db}->{schema}")
      or confess "can not set current schema $cfg->{db}->{schema}";
    return $dbh;
}
