#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dump;
use DBI;
use Carp;
use Encode;
use Spreadsheet::WriteExcel;
require 5.008;

my $dbcfg = {
        dsn    => "dbi:DB2:zdb_dev",
        user   => "db2inst",
        pass   => "db2inst",
        schema => "db2inst",
};
my $dbh = &connect_db();
my $sql = "select id, code, value, name, class, set, jd, memo from dict_book where entity = 2";
my $sth = $dbh->prepare($sql);
$sth->execute();
my $aref = $sth->fetchall_arrayref();
Data::Dump->dump($aref);

my $hash = do 'dawei.b';
my $workbook = Spreadsheet::WriteExcel->new('book.xls');
my $worksheet = $workbook->add_worksheet('book');

my $row = 0 ;
my $count = @$aref;
# warn $count;

for (;$row < $count;  $row++) {
    $worksheet->write($row, 0, $aref->[$row]->[0]); 
    $worksheet->write($row, 1, $aref->[$row]->[1]); 
    $worksheet->write($row, 2, $aref->[$row]->[2]); 
    $worksheet->write($row, 3, Encode::decode('utf8',$aref->[$row]->[3])); 
    $worksheet->write($row, 4, $aref->[$row]->[4]); 
    $worksheet->write($row, 5, $aref->[$row]->[5]); 
    $worksheet->write($row, 6, $aref->[$row]->[6]); 
    $worksheet->write($row, 7, Encode::decode('utf8',$aref->[$row]->[7])); 

    if ( exists $hash->{$aref->[$row]->[2]} ) {
        $worksheet->write($row, 8, $hash->{$aref->[$row]->[2]}); 
    }
}


sub connect_db {
    my $dbh = DBI->connect(
        @{$dbcfg}{qw/dsn user pass/},
        {
            RaiseError       => 1,
            PrintError       => 0,
            AutoCommit       => 0,
            FetchHashKeyName => 'NAME_lc',
            ChopBlanks       => 1,
            InactiveDestroy  => 1,
        }
    );
     # 设置默认schema
    $dbh->do("set current schema $dbcfg->{schema}")
        or confess "can not set current schema $dbcfg->{schema}";
    return $dbh;
}
