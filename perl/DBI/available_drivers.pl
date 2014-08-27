#!/usr/bin/perl

use strict;
use warnings;
use DBI;
use Data::Dump;

#####$dbconfig 哈希引用####
# my $dbconfig = {
#     dsn    => "dbi:DB2:zdb_dev",
#     dbuser => "ypinst",
#     dbpass => "ypinst"
# };

# # 连接数据库 通过读取哈希引用dbconfig的values
# my $dbh = DBI->connect(
#     @{$dbconfig}{qw/dsn dbuser dbpass/},
#     {
#         RaiseError       => 0,
#         PrintError       => 0,
#         AutoCommit       => 0,
#         FetchHashKeyName => 'NAME_lc',
#         ChopBlanks       => 1,
#     }
# );

=comment

available_drivers

  @ary = DBI->available_drivers;
  @ary = DBI->available_drivers($quiet);

Returns a list of all available drivers by searching for DBD::* modules through the directories in @INC. 
By default, a warning is given if some drivers are hidden by others of the same name in earlier directories. 
Passing a true value for $quiet will inhibit the warning.

installed_drivers

  %drivers = DBI->installed_drivers();

Returns a list of driver name and driver handle pairs for all drivers 'installed' (loaded) into the current process. 
The driver name does not include the 'DBD::' prefix.

To get a list of all drivers available in your perl installation you can use "available_drivers".

Added in DBI 1.49.

=cut

my @ary = DBI->available_drivers ;
printf "@ary\n";

my $quiet = 1 ;
@ary = DBI->available_drivers($quiet);
printf "@ary\n";

my %drivers = DBI->installed_drivers();
Data::Dump->dump( %drivers );
