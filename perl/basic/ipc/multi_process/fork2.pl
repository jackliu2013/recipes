#!/usr/bin/env perl

=comment

fork 两个进程 两个进程向延迟刷新的MQT表插入数据并且刷新MQT表

=cut

use strict;
use warnings;

use POSIX ":sys_wait_h";
use DBI;
use Carp;
use Data::Dump;

my $cfg = {
    dsn  => "dbi:DB2:$ENV{DB_NAME}",
    user => "$ENV{DB_USER}",
    pass => "$ENV{DB_PASS}",
};

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

Data::Dump->dump($dbh);

my $pid = fork();
if ( $pid == 0 ) {

    # 子进程
    $dbh = DBI->connect(
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

    while (1) {
        eval {
            my $sth = $dbh->prepare(qq/values nextval for seq_test/);
            $sth->execute();
            my ($id) = $sth->fetchrow_array();
            warn "$id---";
            $dbh->do(
qq/insert into test(id, period, j, d, ys_type, ys_id, jzpz_id, ts_c) values ($id, '2013-11-21', '100', '0', '1000', '1', '1', default)/
            );
            $dbh->commit();
        };
        if ($@) {
            $dbh->rollback();
            confess "insert into failed $@";
        }

        eval {
            my $do_sql = qq/refresh table sum_test/;
            $dbh->do($do_sql);
            $dbh->commit();
        };
        if ($@) {
            $dbh->rollback();
            confess "refresh sum_test failed";
        }
    }
}
elsif ($pid == -1) {
    confess "cannot fork";
}

my $pid2 = fork();
if ( $pid2 == 0 ) {
    # 子进程
    $dbh = DBI->connect(
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

    while (1) {
        eval {
            my $sth = $dbh->prepare(qq/values nextval for seq_test/);
            $sth->execute();
            my ($id) = $sth->fetchrow_array();
            warn "-----$id";
            $dbh->do(
qq/insert into test(id, period, j, d, ys_type, ys_id, jzpz_id, ts_c) values ($id, '2013-11-21', '100', '0', '1000', '1', '1', default)/
            );
            $dbh->commit();
        };
        if ($@) {
            confess "insert fail-------$@";
        }

        eval {
            my $do_sql = qq/refresh table sum_test/;
            $dbh->do($do_sql);
            $dbh->commit();
        };
        if ($@) {
            $dbh->rollback();
            confess "refresh sum_test failed";
        }

    }

}
elsif ($pid2 == -1) {
    confess "-----fork error-------";
}

waitpid($pid,0);
print "first child$?" . "\n";
waitpid($pid2,0);
print "second child$?" . "\n";
