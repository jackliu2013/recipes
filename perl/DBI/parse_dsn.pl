#!/usr/bin/env perl

use strict;
use warnings;
use DBI;
use Data::Dump;


#
# 解析 数据库连接
#
my ( $scheme, $driver, $attr_string, $attr_hash, $driver_dsn ) =
  DBI->parse_dsn("DBI:MyDriver(RaiseError=>1):db=test;port=42");
#$scheme      = 'dbi';
#driver      = 'MyDriver';
#attr_string = 'RaiseError=>1';
#attr_hash   = { 'RaiseError' => '1' };
#driver_dsn  = 'db=test;port=42';
print <<EOF;
scheme		:	$scheme
driver		: 	$driver
attr_string	:	$attr_string
attr_hash	:	$attr_hash
driver_dsn	:	$driver_dsn
EOF

# Data::Dump->dump();
