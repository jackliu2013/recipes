#!/usr/bin/perl

use strict;
use warnings;
use DBI;

#####$dbconfig 哈希引用####
my $dbconfig = {
    dsn => "dbi:DB2:zdb_dev",
	dbuser => "ypinst",
	dbpass => "ypinst" };
    # 连接数据库 通过读取哈希引用dbconfig的values
    my $dbh = DBI->connect(
        @{$dbconfig}{qw/dsn dbuser dbpass/},
        {
            RaiseError       => 0,
            PrintError       => 0,
            AutoCommit       => 0,
            FetchHashKeyName => 'NAME_lc',
            ChopBlanks       => 1,
        }
    );
	
#####执行建表语句#####
	$dbh->do(<<EOF);
create table test (
    fa int,
    fb int,
    fc int
);
EOF
####提交####
    $dbh->commit();
	my $sth = $dbh->prepare(<<EOF);
insert into test ( fa, fb, fc ) values (?, ?, ?)
EOF
	my $href = {
				fa => [ 1, 2, 3, 4, 5, 6 ],
				fb => [ 1, 2, 3, 4, 5, 6 ],
				fc => [ 1, 2, 3, 4, 5, 6 ]
			   };
	
	print @{$href->{fa}},"\n";
	my @arr = (undef,undef,1);
	####执行SQL####
	$sth->execute(@arr);
	####提交####
	$dbh->commit();	

    my $all = $dbh->selectall_arrayref(<<EOF, { Slice => {} } );
select * from test 
EOF

    use Data::Dump;
    Data::Dump->dump($all);

$dbh->do("drop table test");
$dbh->commit();
exit 0;


